<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FGUsuarios.aspx.cs" Inherits="IntranetFNCv18._1.Vistas.TI.FGUsuarios" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Inhead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <script type="text/javascript">     
        function show() {

            document.write("<head runat='server'></head>");
        }
    </script>
    <link href="../../Content2/Styles/CalendarCSS.css" rel="stylesheet" />
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="col-md-8">
            <asp:Panel ID="PanelConfirmacion" runat="server" Visible="false">
                <div class="alert alert-success alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-check"></i>Confirmación !</h4>
                    Se ha agregado el documento exitosamente.
                </div>
            </asp:Panel>
            <asp:Panel ID="PanelError" runat="server" Visible="false">
                <div class="alert alert-danger alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-ban"></i>Error !</h4>
                    Se ha presentado un error en el sistema, por favor contantarse con el Administrador en Dirección TI.
              <br />
                    Error:<asp:Label ID="LblTipoerror2" runat="server" Font-Bold="True"></asp:Label>
                </div>
            </asp:Panel>
            <!-- general form elements -->
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title" style="color:#225DA6">CREACIÓN Y GESTIÓN DE USUARIOS</h3>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <div class="box-body">
                    <strong>
                        <label style="color:#3C8DBC">DATOS DE USUARIO</label></strong>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group">
                                <label>Fecha de Inicio:</label><br />
                                <asp:TextBox ID="TxtFechaInicio" runat="server" CssClass="form-control" Width="80%"></asp:TextBox>
                                <asp:ImageButton ID="IncidentDate_edit_ibtn" runat="server" ImageUrl="~/Imagenes/Calendar-icon.ico" Height="20px" Width="20px" />
                                <asp:RangeValidator runat="server" ID="RvFechaInicio" Type="Date" ControlToValidate="TxtFechaInicio" Display="Dynamic" MaximumValue="" />
                                <ajaxToolkit:CalendarExtender ID="CeFechaInicio" runat="server" TargetControlID="TxtFechaInicio" EnabledOnClient="true" Format="dd-MM-yyyy" PopupButtonID="IncidentDate_edit_ibtn" CssClass="CalendarCSS" />
                            </div>
                            <br />                            
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Nombre Completo:</label>
                                <asp:TextBox ID="TtxNombreUsuario" runat="server" class="form-control" Width="100%" CausesValidation="true"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Numero de Identificación:</label>
                                <asp:TextBox ID="TxtNoIdentificacion" runat="server" class="form-control" Width="100%" CausesValidation="true"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Cargo:</label>
                                <asp:TextBox ID="TxtCargo" runat="server" class="form-control" Width="100%" CausesValidation="true"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Área:</label><br />
                                <asp:DropDownList ID="DrdAreas" runat="server" DataSourceID="SqlDataSource_Ar" DataTextField="NombreArea" DataValueField="IdArea" Width="100%" class="form-control"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Ar" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT [IdArea], [NombreArea], [IdGerencia] FROM [Area]"></asp:SqlDataSource>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Gerencia:</label><br />
                                <asp:DropDownList ID="DrdGerencias" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Gerencias" DataTextField="NombreGerencia" DataValueField="IdGerencia" Width="100%" class="form-control"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Gerencias" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT [IdGerencia], [NombreGerencia] FROM [Gerencia]"></asp:SqlDataSource>
                            </div>
                            <div class="form-group">
                                <label>Jefe Inmediato:</label><br />
                                <asp:DropDownList ID="DrdJefes" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Usuarios" DataTextField="NombreCompleto" DataValueField="IdUsuario" Width="100%" class="form-control"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Usuarios" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT [IdUsuario], [NombreCompleto] FROM [Usuario]"></asp:SqlDataSource>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-body">
                    <label style="color:#3C8DBC">DESCRIPCIÓN</label>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Sistemas de Información:</label>
                                <asp:CheckBoxList ID="ChbSistemas" runat="server" DataSourceID="SqlDataSource_SI" DataTextField="NombreSistema" DataValueField="IdSistemaI" class="checkbox" RepeatDirection="Vertical"></asp:CheckBoxList>
                                <asp:SqlDataSource ID="SqlDataSource_SI" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT [IdSistemaI], [NombreSistema] FROM [SistemaInformacion]"></asp:SqlDataSource>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Modulos de Sistemas:</label><br />
                                <asp:CheckBoxList ID="ChbModulos" runat="server" class="checkbox" RepeatDirection="Vertical"></asp:CheckBoxList>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Descripción de otros permisos:</label><br />
                                <asp:TextBox ID="TxtOtrosPermisos" runat="server" Width="100%" Height="75px"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Justificación:</label><br />
                                <asp:TextBox ID="TxtJustificacion" runat="server" Width="100%" Height="75px"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-body">
                    <label style="color:#3C8DBC">OBSERVACIONES</label>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Notas:</label>
                                <asp:TextBox ID="TxtNotas" runat="server" class="form-control" Width="100%" Height="75px" CausesValidation="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.box-body -->
                <div class="modal-footer">
                    <asp:Button ID="btnGuardarUsuario" runat="server" class="btn btn-prmimary pull-right" Text="Guardar" ValidationGroup="PersonalInfoGroup" />
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="box box-warning box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">Información Importante</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                    <!-- /.box-tools -->
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <strong>Para tener en cuenta:</strong><br />
                    •
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="InFooter" runat="server">
</asp:Content>
