using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;
using System.Security;
using System.Runtime.Serialization;
using System.Configuration;
using IntranetFNCv18._1.Modelos;
using System.Text;

namespace IntranetFNCv18._1
{
    public partial class GestionUsuarios : System.Web.UI.Page
    {
        Intranet_FNCEntities ModelBD_Usuario = new Intranet_FNCEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ChK_Modulos.DataSource = "";
                ChK_Modulos.DataBind();

            }
            Session["NombreMenu"] = "Gestión de Usuarios";
        }

        protected void GridView_Usuarios_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // this.GridView_Usuarios.EditIndex = e.NewEditIndex;
            //GridView_Usuarios.Rows[e.NewEditIndex].FindControl("lblNombreRol").Focus();
            //DataTable dt = new DataTable();
            //dt = (DataTable)ViewState["Data"];

            //this.GridView_Usuarios.DataSource = dt;
            //this.GridView_Usuarios.DataBind();
        }
        //protected void PageDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    GridViewRow pagerRow = GridView_Usuarios.BottomPagerRow;
        //    DropDownList pageList = (DropDownList)pagerRow.Cells[0].FindControl("PageDropDownList");
        //    GridView_Usuarios.PageIndex = pageList.SelectedIndex;
        //    lblInfo.Text = "";
        //}

        protected void GridView_Usuarios_DataBound(object sender, EventArgs e)
        {
            lblTotalUsuarios.Text = this.GridView_Usuarios.Rows.Count.ToString();

        }

        //public override void VerifyRenderingInServerForm(Control control)
        //{
        //    /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
        //       server control at run time. */
        //}
        protected void SSqlDataSource_Usuarios_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblTotalUsuarios.Text = e.AffectedRows.ToString();
        }
        protected void BtnBuscar_Click(object sender, EventArgs e)
        {
            GridView_Usuarios.DataSourceID = "";
            GridView_Usuarios.DataSource = SqlDataSource_Usuarios_Buscar;
            GridView_Usuarios.DataBind();
        }

        protected void BtnResrablecer_Click(object sender, EventArgs e)
        {
            txtBuscar_GridView_Usuarios.Text = "";
            GridView_Usuarios.DataSourceID = "";
            GridView_Usuarios.DataSource = SqlDataSource_Usuarios;
            GridView_Usuarios.DataBind();

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            var title = "";
            var type = "";            
            try
            {
                DateTime fecha_actual = DateTime.Now;
                //GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
                //int index = gvRow.RowIndex;
                //DropDownList ddl = (DropDownList)GridView_Usuarios.Rows[index].FindControl("ddlRol");
                //int idRol = int.Parse(ddl.SelectedValue);
                List<ListItem> selectedChK_Modulos = new List<ListItem>();
                foreach (ListItem item in ChK_Modulos.Items)
                    if (item.Selected) selectedChK_Modulos.Add(item);
                List<int> idmodulos = new List<int>();
                foreach (ListItem r in selectedChK_Modulos)
                {
                    List<int> modulos = (from l in ModelBD_Usuario.Modulo
                                         where l.Nombre.ToString().Contains(r.Text)
                                         select l.IdModulo).ToList();
                    idmodulos.AddRange(modulos);

                }

                int idRol = int.Parse(ddlRol.SelectedValue.ToString());
                int idUsuario = int.Parse(ViewState["idUsuario"].ToString());

                List<Acceso> acceso = (from w in ModelBD_Usuario.Acceso
                                       where w.IdUsuario == idUsuario
                                       select w).ToList();
                acceso.ForEach(p => ModelBD_Usuario.Acceso.Remove(p));
                Acceso NewAcceso = new Acceso();
                foreach (int idR in idmodulos)
                {
                    NewAcceso.IdTipoRol = idRol;
                    NewAcceso.IdUsuario = idUsuario;
                    NewAcceso.IdModulo = idR;
                    NewAcceso.FechaRegistro = fecha_actual;
                    NewAcceso.Descripcion = TxtObservaciones.Text;
                    ModelBD_Usuario.Acceso.Add(NewAcceso);
                }

                UsuarioRol usuariorol = (from x in ModelBD_Usuario.UsuarioRol
                                         where x.IdUsuario == idUsuario
                                         select x).First();
                usuariorol.IdTipoRol = idRol;
                usuariorol.Descripcion = "Actualización por Gestión de Usuario.";
                usuariorol.FechaRegistro = fecha_actual;
                ModelBD_Usuario.SaveChanges();

                GridView_Usuarios.DataSourceID = "";
                GridView_Usuarios.DataSource = SqlDataSource_Usuarios;
                GridView_Usuarios.DataBind();
                title = "Actualización exitosa";
                type = "success";
            }
            catch (Exception ex)
            {
                title = "Error";
                type = "warning";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "myModal", "$('#myModal').modal('hide');", true);
                upModal.Update();
                ScriptManager.RegisterStartupScript(this, typeof(string), "Popup", String.Format("successalert('{0}','{1}');", title, type), true);
            }
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "myModal", "$('#myModal').modal('hide');", true);
            upModal.Update();
            ScriptManager.RegisterStartupScript(this, typeof(string), "Popup", String.Format("successalert('{0}','{1}');", title, type), true);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Vistas/GestionUsuarios");
        }
        protected void GridView_Usuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                int idUsuario = Convert.ToInt32(e.CommandArgument);
                ViewState["idUsuario"] = idUsuario;
                UsuarioRol c = (from x in ModelBD_Usuario.UsuarioRol
                                where x.IdUsuario == idUsuario
                                select x).First();
                NombreUsuario.Text = c.Usuario.NombreCompleto;
                NombreUsuario.Enabled = false;
                
                ddlRol.DataSource = (from p in ModelBD_Usuario.TipoRol                                     
                                     orderby p.FechaRegistro descending
                                     select new { p.IdTipoRol, p.NombreRol }).ToList();
                ddlRol.DataTextField = "NombreRol";
                ddlRol.DataValueField = "IdTipoRol";
                ddlRol.DataBind();

                ChK_Modulos.DataSource = (from p in ModelBD_Usuario.Modulo
                                          where p.IdModulo==1
                                          select new { p.IdModulo, p.Nombre}).ToList();
                ChK_Modulos.DataTextField = "Nombre";
                ChK_Modulos.DataValueField = "IdModulo";
                ChK_Modulos.DataBind();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
                upModal.Update();
            }
        }
        protected void ddlRolDropDown_Change(object sender, EventArgs e)
        {            
            int idRol = int.Parse(ddlRol.SelectedValue.ToString());
            List<int> mo = new List<int>();
            List<string> mo2 = new List<string>();
            var te = (from r in ModelBD_Usuario.TipoRol_Modulo
                      where r.IdTipoRol == idRol
                      select r.IdModulo).ToList();
            ChK_Modulos.DataSource = (from mt in ModelBD_Usuario.Modulo
                                     where te.Contains(mt.IdModulo)
                                     select new { mt.IdModulo, mt.Nombre }).ToList();
            ChK_Modulos.DataTextField = "Nombre";
            ChK_Modulos.DataValueField = "IdModulo";
            ChK_Modulos.DataBind();
        }
        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal('hide');", true);
        }

    }
}