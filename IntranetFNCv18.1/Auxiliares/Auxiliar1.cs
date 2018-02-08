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

namespace IntranetFNCv18._1.Auxiliares
{
    public class Auxiliar1
    {
        public void CerrarSession()
        {
            int idUsuario = int.Parse(HttpContext.Current.Session["idUsuario"].ToString());
            Intranet_FNCEntities ModelBD_Usuario = new Intranet_FNCEntities();
            Log_Acceso_Usuario log = (from rt in ModelBD_Usuario.Log_Acceso_Usuario
                                      where rt.IdUsuario == idUsuario
                                      orderby rt.IdLog descending
                                      select rt).First();

            TimeSpan hi = TimeSpan.Parse((log.FechaInicioSession).ToString("HH:mm:ss"));
            TimeSpan hf = TimeSpan.Parse(DateTime.Now.ToString("HH:mm:ss"));
            TimeSpan time = hf - hi;
            log.FechaFinalizoSession = DateTime.Now;
            log.TiempoSession = time;
            ModelBD_Usuario.SaveChanges();
            if (HttpContext.Current.Request.Cookies["idUsuario"] != null)
            {
                HttpContext.Current.Response.Cookies["idUsuario"].Expires = DateTime.Now.AddDays(-1);
            }
            HttpContext.Current.Session.Abandon();
            HttpContext.Current.Session.Clear();
        }
    }

}