using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntranetFNCv18._1.Vistas
{
    public partial class PoliticasCorporativas : System.Web.UI.Page
    {
        GestionDocumentos gestionDocumentos = new GestionDocumentos();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["NombreMenu"] = "Políticas Corporativas";
        }

        protected void GridView_Documento_Corporativas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd")
            {
                string filename = e.CommandArgument.ToString();
                if (filename != "")
                {
                    string path = Server.MapPath(@"~/Documentos/PoliticasCorporativas/" + filename + ".pdf");
                    byte[] bts = System.IO.File.ReadAllBytes(path);
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.AddHeader("Content-Type", "Application/octet-stream");
                    Response.AddHeader("Content-Length", bts.Length.ToString());

                    Response.AddHeader("Content-Disposition", "attachment;   filename=" + filename + ".pdf");

                    Response.BinaryWrite(bts);

                    Response.Flush();
                    gestionDocumentos.contador_descargas(filename);
                    Response.End();
                }
            }
        }

        protected void GridView_Documento_Corporativas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            lblDocumentos.Text = this.GridView_Documento_Corporativas.Rows.Count.ToString();
        }

        protected void BtnBuscarDocumento_Corporativas_Click(object sender, EventArgs e)
        {
            GridView_Documento_Corporativas.DataSourceID = "";
            GridView_Documento_Corporativas.DataSource = SqlDataSource_BuscarDocumento_Corporativas;
            GridView_Documento_Corporativas.DataBind();
        }

        protected void BtnRestablecerDocumento_Manual_Click(object sender, EventArgs e)
        {
            txtBuscar_GridView_Documentos_Corporativas.Text = "";
            GridView_Documento_Corporativas.DataSourceID = "";
            GridView_Documento_Corporativas.DataSource = SqlDataSource_Documentos_Corporativas;
            GridView_Documento_Corporativas.DataBind();
        }
    }
}