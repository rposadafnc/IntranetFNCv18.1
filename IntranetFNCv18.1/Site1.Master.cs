using IntranetFNCv18._1.Modelos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using IntranetFNCv18._1.Auxiliares;

namespace IntranetFNCv18._1
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int currentNumberOfUsers = Global.CurrentNumberOfUsers;
            lblCurrentNumberOfUsers.Text = currentNumberOfUsers.ToString();
            Response.AddHeader("Refresh", Convert.ToString((Session.Timeout * 60) + 5));
            if (Session["Nombre"] == null)
            {
                if (Session["NombreMenu"].ToString() == "")
                {
                    Response.Redirect("LoginFNC1.aspx");
                    Auxiliar1 auxiliar = new Auxiliar1();
                    auxiliar.CerrarSession();
                }
                else
                {
                    Response.Redirect("~/LoginFNC1.aspx");
                    Auxiliar1 auxiliar = new Auxiliar1();
                    auxiliar.CerrarSession();
                }
              
            }
        }
    }
}