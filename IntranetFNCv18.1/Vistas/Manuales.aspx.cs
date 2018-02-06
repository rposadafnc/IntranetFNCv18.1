using IntranetFNCv18._1.Modelos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntranetFNCv18._1.Vistas
{
    public partial class Manuales : System.Web.UI.Page
    {   
        GestionDocumentos gestionDocumentos = new GestionDocumentos();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["NombreMenu"] = "Manuales";
        }

        protected void GridView_Documento_Manual_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd")
            {
                string filename = e.CommandArgument.ToString();
                
                if (filename != "")
                {
                    string path = Server.MapPath(@"~/Documentos/Manuales/" + filename + ".pdf");
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

        protected void GridView_Documento_Manual_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            lblDocumentos.Text = this.GridView_Documento_Manual.Rows.Count.ToString();
        }

        protected void BtnBuscarDocumento_Manual_Click(object sender, EventArgs e)
        {
            GridView_Documento_Manual.DataSourceID = "";
            GridView_Documento_Manual.DataSource = SqlDataSource_BuscarDocumento_Manual;
            GridView_Documento_Manual.DataBind();
        }

        protected void BtnRestablecerDocumento_Manual_Click(object sender, EventArgs e)
        {
            txtBuscar_GridView_Documentos_Manual.Text = "";
            GridView_Documento_Manual.DataSourceID = "";
            GridView_Documento_Manual.DataSource = SqlDataSource_Documentos_Manual;
            GridView_Documento_Manual.DataBind();
        }
    }
}