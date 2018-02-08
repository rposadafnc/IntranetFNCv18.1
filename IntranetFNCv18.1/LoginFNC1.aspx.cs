using IntranetFNCv18._1.Auxiliares;
using IntranetFNCv18._1.Modelos;
using System;
using System.Collections;
using System.Collections.Generic;
using System.DirectoryServices;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntranetFNCv18._1
{
    public partial class LoginFNC1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["idUsuario"] != null) {
                    Auxiliar1 auxiliar = new Auxiliar1();
                    auxiliar.CerrarSession();
                }
            }
            errorLabel.Visible = false;
            errorLabel.Text = "";
            System.Threading.Thread.Sleep(1000);
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {

            String adPath = "LDAP://fenoco.local"; //Fully-qualified Domain Name
            LdapAuthentication adAuth = new LdapAuthentication(adPath);
            int i = 0;
            string User = Request.Form["Username"];
            string Pass = Request.Form["Password"];
            try
            {
                if (true == adAuth.IsAuthenticated("Fenoco.local", User, Pass))
                {

                    String groups = adAuth.GetGroups();
                    DirectoryEntry myLdapConnection = createDirectoryEntry(adPath, User, Pass);

                    DirectorySearcher search = new DirectorySearcher(myLdapConnection);
                    search.Filter = "(samaccountname=" + User + ")";

                    SearchResult result = search.FindOne();

                    if (result != null)
                    {
                        DirectoryEntry usuario = result.GetDirectoryEntry();
                        string Guid = usuario.Guid.ToString();

                        Intranet_FNCEntities ModelBD_Usuario = new Intranet_FNCEntities();
                        UsuarioRol Rol = (from u in ModelBD_Usuario.Usuario
                                          join r in ModelBD_Usuario.UsuarioRol on u.IdUsuario equals r.IdUsuario
                                          join q in ModelBD_Usuario.TipoRol on r.IdTipoRol equals q.IdTipoRol
                                          where u.IdRegistro_AD == Guid
                                          select r).First();

                        List<int> ModulosRol = (from r in ModelBD_Usuario.Acceso
                                                where r.IdUsuario == Rol.IdUsuario
                                                select r.IdModulo.Value).ToList();

                        int Rolac = Rol.IdTipoRol;
                        Session["idUsuario"] = Rol.IdUsuario;
                        Session["Rol"] = Rolac;
                        Session["Modulos"] = ModulosRol;
                        Session["NombreCompleto"] = usuario.Properties["displayname"].Value.ToString();
                        Session["Nombre"] = usuario.Properties["givenName"].Value.ToString();
                        Session["Titulo"] = usuario.Properties["title"].Value.ToString();
                        Session["Unidad"] = usuario.Properties["department"].Value.ToString();
                        Session["Compañia"] = usuario.Properties["company"].Value.ToString();                        
                        
                        Log_Acceso_Usuario log_ = new Log_Acceso_Usuario();
                        log_.IdUsuario = Rol.IdUsuario;
                        log_.FechaInicioSession = DateTime.Now;                        
                        ModelBD_Usuario.Log_Acceso_Usuario.Add(log_);
                        ModelBD_Usuario.SaveChanges();

                        //Create the ticket, and add the groups.
                        //bool isCookiePersistent = chkPersist.Checked;
                        FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1, User,
                             DateTime.Now, DateTime.Now.AddMinutes(0), false, groups);

                        //Encrypt the ticket.
                        String encryptedTicket = FormsAuthentication.Encrypt(authTicket);

                        //Create a cookie, and then add the encrypted ticket to the cookie as data.
                        HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);

                        //if (true == isCookiePersistent)
                        //    authCookie.Expires = authTicket.Expiration;

                        //Add the cookie to the outgoing cookies collection.
                        Response.Cookies.Add(authCookie);

                        //You can redirect now.
                        Response.Redirect(FormsAuthentication.GetRedirectUrl(User, false));

                    }
                }
                else
                {
                    i++;
                }
            }
            catch (Exception ex)
            {
                if (i != 0)
                {
                    errorLabel.Visible = true;
                    errorLabel.Text = "Error: " + ex;
                }
                else
                {
                    if (User == "")
                    {
                        errorLabel.Visible = true;
                        errorLabel.Text = "Se requiere un Usuario";
                    }
                    else if (Pass == "")
                    {
                        errorLabel.Visible = true;
                        errorLabel.Text = "Se requiere una Contraseña.";
                    }
                    else
                    {
                        errorLabel.Visible = true;
                        errorLabel.Text = "Error de autenticación, por favor verifique su nombre de Usuario y Contraseña. Si el error persiste por favor contactarse con Dirección de Tecnología.";
                    }
                }
            }
        }
        private DirectoryEntry createDirectoryEntry(string path, string User, string Pass)
        {
            DirectoryEntry ldapConnection = new DirectoryEntry(path, User, Pass, AuthenticationTypes.Secure);

            return ldapConnection;
        }        
    }
}
