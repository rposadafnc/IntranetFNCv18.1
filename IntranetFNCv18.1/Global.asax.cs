using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Security.Principal;
using System.Configuration;

namespace IntranetFNCv18._1
{
    public class Global : HttpApplication
    {
        private static int totalNumberOfUsers = 0;
        private static int currentNumberOfUsers = 0;
        public static int CurrentNumberOfUsers
        {
            get
            {
                return currentNumberOfUsers;
            }
        }
        public static int TotalNumberOfUsers
        {
            get
            {
                return totalNumberOfUsers;
            }
        }
        void Application_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta al iniciar la aplicación            
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        void Session_Start(object sender, EventArgs e)
        { // Codigo que se ejectura cuando se inicia la sesion.

            totalNumberOfUsers += 1;
            currentNumberOfUsers += 1;
        }
        protected void Session_End(Object sender, EventArgs e)
        {
            currentNumberOfUsers -= 1;
        }
        void Application_AuthenticateRequest(Object sender, EventArgs e)
        {
            String cookieName = FormsAuthentication.FormsCookieName;
            HttpCookie authCookie = Context.Request.Cookies[cookieName];

            if (null == authCookie)
            {//There is no authentication cookie.
                return;
            }

            FormsAuthenticationTicket authTicket = null;

            try
            {
                authTicket = FormsAuthentication.Decrypt(authCookie.Value);
            }
            catch (Exception ex)
            {
                //Write the exception to the Event Log.
                return;
            }

            if (null == authTicket)
            {//Cookie failed to decrypt.
                return;
            }

            //When the ticket was created, the UserData property was assigned a
            //pipe-delimited string of group names.
            String[] groups = authTicket.UserData.Split(new char[] { '|' });

            //Create an Identity.
            GenericIdentity id = new GenericIdentity(authTicket.Name, "LdapAuthentication");

            //This principal flows throughout the request.
            GenericPrincipal principal = new GenericPrincipal(id, groups);

            Context.User = principal;

        }
        protected void Application_End(Object sender, EventArgs e)
        {

        }
      
    }
}