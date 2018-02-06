using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntranetFNCv18._1.Vistas
{
    public partial class Accesos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Session["NombreMenu"] = "Accesos";
        }

        protected void ddlModulos_SelectedIndexChanged(object sender, EventArgs e)
        {

            IEnumerable<int> allChecked = (from ListItem item in chbAccesosModulos.Items.OfType<ListItem>()
                                           where item.Selected
                                           select int.Parse(item.Value));
        }
    }
}