using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntranetFNCv18._1.Vistas.TI
{
    public partial class FGUsuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RvFechaInicio.MinimumValue = DateTime.Today.AddYears(-15).ToString("dd-MM-yyyy");
            RvFechaInicio.MaximumValue = DateTime.Today.AddYears(1).ToString("dd-MM-yyyy");
            Session["NombreMenu"] = "Creación y Gestión de Usuarios";
        }
    }
}