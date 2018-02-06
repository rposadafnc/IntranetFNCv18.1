using IntranetFNCv18._1.Modelos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntranetFNCv18._1.Vistas
{
    public partial class GestionDocumentos : System.Web.UI.Page
    {
        Intranet_FNCEntities ModelBD_GestionDocumentos = new Intranet_FNCEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            LblFile.Visible = false;
            LblFile.Text = "";
            PanelConfirmacion.Visible = false;
            PanelError.Visible = false;
            PnlEliminarError.Visible = false;
            PnlEliminarOk.Visible = false;
            Session["NombreMenu"] = "Gestión de Documentos - Politicas Corporativas";
        }
        protected void btnGuardarDocumento_Click(object sender, EventArgs e)
        {
            PanelError.Visible = false;
            PanelConfirmacion.Visible = false;
            int idTDoc = int.Parse(ddlTipoDocumento.SelectedValue.ToString());
            string NombreTipoDocumento = ddlTipoDocumento.SelectedItem.Text;
            string Titulo = TxtTitulo.Text;
            String Descripcion = TxtDescripcion.Text;
            int idDireccionFNC = int.Parse(dllDireccionFNC.SelectedValue.ToString());
            DateTime fecha_actual = DateTime.Now;
            int idUsuario = int.Parse(Session["idUsuario"].ToString());

            GestionDocumental gd = new GestionDocumental();

            Boolean fileOK = false;
            Boolean tamañoOK = false;
            Boolean tamañoOK2 = false;
            

            if (idTDoc == 1)
            {
                ViewState["ruta"] = "~/Documentos/PoliticasCorporativas/";
                ViewState["NombreArchivo"] = "PoliticaCorporativa";
            }
            else
            if (idTDoc == 2)
            {
                ViewState["ruta"] = "~/Documentos/PoliticasOperativas/";
                ViewState["NombreArchivo"] = "PoliticaOperativa";
            }
            else
            if (idTDoc == 3)
            {
                ViewState["ruta"] = "~/Documentos/Manuales/";
                ViewState["NombreArchivo"] = "Manual";
            }
            else
            if (idTDoc == 4)
            {
                ViewState["ruta"] = "~/Documentos/Procedimientos-Instructivos/";
                ViewState["NombreArchivo"] = "Procedimiento-Instructivo";
            }
            String path = Server.MapPath(ViewState["ruta"].ToString());

            if (FileUpload_Documento.HasFile)
            {
                String fileExtension =
                    System.IO.Path.GetExtension(FileUpload_Documento.FileName).ToLower();
                String[] allowedExtensions =
                    {".pdf"};
                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        fileOK = true;
                    }
                }
                int tamanoarchivo = FileUpload_Documento.PostedFile.ContentLength;
                if (tamanoarchivo < 2000000)
                {
                    tamañoOK = true;
                }
                int ta_descripcion = Descripcion.Length;
                if (ta_descripcion < 200)
                {
                    tamañoOK2 = true;
                }
            }
            else if (!fileOK)
            {
                LblFile.Text = "Se requiere un archivo!";
                LblFile.Visible = true;
            }
            if (fileOK && tamañoOK && tamañoOK2)
            {
                try
                {
                    string result = string.Empty;
                    string nombrearchivo = Titulo.Replace(" ", "_").ToUpper();
                    string rutaarchivo = path + nombrearchivo;
                    gd.Ruta = rutaarchivo;
                    gd.NombreDocumento = nombrearchivo;
                    FileUpload_Documento.PostedFile.SaveAs(path + nombrearchivo + ".pdf");
                    gd.Titulo = Titulo;
                    gd.Descripcion = Descripcion;
                    gd.FechaRegistro = fecha_actual;
                    gd.IdUsuario = idUsuario;
                    gd.IdTipoDocumento = idTDoc;
                    gd.TipoDocumento = NombreTipoDocumento;
                    gd.IdDireccion = idDireccionFNC;
                    gd.NoDescargas = 0;
                    ModelBD_GestionDocumentos.GestionDocumental.Add(gd);
                    ModelBD_GestionDocumentos.SaveChanges();
                    PanelConfirmacion.Visible = true;
                    PanelConfirmacion.Focus();
                    TxtTitulo.Text = string.Empty;
                    TxtDescripcion.Text = string.Empty;
                    GridView_Documentos.DataSourceID = "";
                    GridView_Documentos.DataSource = SqlDataSource_Documentos;
                    GridView_Documentos.DataBind();
                }
                catch (Exception ex)
                {
                    PanelError.Visible = true;
                    PanelError.Focus();
                    TxtTitulo.Text = string.Empty;
                    TxtDescripcion.Text = string.Empty;
                    LblTipoerror2.Text = ex.ToString();
                }
            }
            else
            {
                if (!fileOK)
                {
                    LblFile.Text = "Tipo de archivo no aceptado.";
                    LblFile.Visible = true;
                }
                else if (!tamañoOK)
                {
                    Double t2 = FileUpload_Documento.PostedFile.ContentLength / 1048576.0;
                    Double t3 = Math.Truncate(t2);
                    LblFile.Text = "El tamaño del archivo es: " + t3 + "MB, superando los 2MB permitidos.";
                    LblFile.Visible = true;
                }
                else if (!tamañoOK2)
                {                    
                    LblFile.Text = "El numero de caracteres de la descripción es: " + Descripcion.Length + ", superando los 200 caracteres permitidos.";
                    LblFile.Visible = true;
                }
            }

        }

        protected void GridView_Documentos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            lblDocumentos.Text = this.GridView_Documentos.Rows.Count.ToString();
        }

        protected void BtnBuscarDocumento_Click(object sender, EventArgs e)
        {
            GridView_Documentos.DataSourceID = "";
            GridView_Documentos.DataSource = SqlDataSource_BuscarDocumento;
            GridView_Documentos.DataBind();
        }

        protected void BtnRestablecerDocumento_Click(object sender, EventArgs e)
        {
            txtBuscar_GridView_Documentos.Text = "";
            GridView_Documentos.DataSourceID = "";
            GridView_Documentos.DataSource = SqlDataSource_Documentos;
            GridView_Documentos.DataBind();
        }
        protected void GridView_Documentos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    int idDocumento = Convert.ToInt32(e.CommandArgument);
                    GestionDocumental gde = (from g in ModelBD_GestionDocumentos.GestionDocumental
                                             where g.IdGestionDocumental == idDocumento
                                             select g).First();

                    var file = gde.Ruta + ".pdf";
                    if (System.IO.File.Exists(file))
                    {
                        System.IO.File.Delete(file);
                    }
                    else
                    {
                        PnlEliminarError.Visible = true;
                        PnlEliminarError.Focus();
                        LblTipoerror.Text = "Archivo no encontrado, se eliminara de la Base de Datos pero no el servidor. - Por favor contactarse con Dirección de Tecnología.";
                    }
                    ModelBD_GestionDocumentos.GestionDocumental.Remove(gde);
                    ModelBD_GestionDocumentos.SaveChanges();
                    PnlEliminarOk.Visible = true;
                    PnlEliminarOk.Focus();
                    GridView_Documentos.DataSourceID = "";
                    GridView_Documentos.DataSource = SqlDataSource_Documentos;
                    GridView_Documentos.DataBind();
                }
                catch (Exception ex)
                {
                    PnlEliminarError.Visible = true;
                    PnlEliminarError.Focus();
                    LblTipoerror.Text = ex.ToString();
                }

            }
        }
        protected void GridView_Documentos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
        public void contador_descargas(string NombreArchivo)
        {
            long con = 0;
            GestionDocumental gde = (from g in ModelBD_GestionDocumentos.GestionDocumental
                                     where g.NombreDocumento.Equals(NombreArchivo)
                                     select g).First();
            con = gde.NoDescargas.Value;
            gde.NoDescargas = con + 1;
            ModelBD_GestionDocumentos.SaveChanges();
        }
    }
}