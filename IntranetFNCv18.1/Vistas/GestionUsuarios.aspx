<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="GestionUsuarios.aspx.cs" Inherits="IntranetFNCv18._1.GestionUsuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Inhead" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <script type="text/javascript">         
        function successalert(title, type) {
            swal({
                title: title,
                type: type
            },
                function () {
                    window.location.href = '../Vistas/GestionUsuarios';
                }
            );
        }
    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="ScriptManager1" />
        <h3>Roles de Usuarios</h3>
        <h5>Buscar usuarios:
            <asp:TextBox ID="txtBuscar_GridView_Usuarios" runat="server" Height="25px" Width="155px"></asp:TextBox>
            <asp:Button ID="BtnBuscar" CssClass="btn btn-default" runat="server" Text="Buscar" OnClick="BtnBuscar_Click" />&nbsp;&nbsp;
        <asp:Button ID="BtnResrablecer" CssClass="btn btn-default" runat="server" Text="Restablecer" OnClick="BtnResrablecer_Click" />
        </h5>
        <span style="float: right;"><small>Total Usuarios:</small>
            <asp:Label ID="lblTotalUsuarios" runat="server" CssClass="label label-warning" /></span>
        <p>&nbsp;</p>
        <asp:UpdatePanel ID="upCrudGrid" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView_Usuarios" runat="server" DataSourceID="SqlDataSource_Usuarios"
                    AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover"
                    SelectedIndex="1"
                    DataKeyNames="IdUsuario"
                    OnDataBound="GridView_Usuarios_DataBound" OnRowCommand="GridView_Usuarios_RowCommand" OnRowEditing="GridView_Usuarios_RowEditing">
                    <EmptyDataRowStyle ForeColor="Red" CssClass="table table-bordered" />
                    <EmptyDataTemplate>
                        -> No se encontraron Usuarios con esas caracteristicas <-
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" HeaderText="Editar">
                            <ItemTemplate>
                                <%--Botones editar usuarios... CommandName="Edit" --%>
                                <asp:Button ID="btnEdit" runat="server" Text="Editar" CommandArgument='<%#Eval("IdUsuario")%>' CssClass="btn btn-info" CommandName="Edit" />
                            </ItemTemplate>
                            <%--<EditItemTemplate>
                               Botones de grabar y cancelar la edición de registro...--%>
                            <%--  <asp:Button ID="btnUpdate" runat="server" Text="Grabar" CssClass="btn btn-success" CommandName="Update" OnClientClick="return confirm('¿Seguro que quiere modificar los datos del usuario?');" OnClick="btnUpdate_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancelar" CssClass="btn btn-default" CommandName="Cancel" OnClick="btnCancel_Click" />
                            </EditItemTemplate>--%>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        </asp:TemplateField>
                        <asp:BoundField DataField="IdUsuario" InsertVisible="false" ReadOnly="True" HeaderText="UsuarioID" SortExpression="IdUsuario"></asp:BoundField>
                        <asp:BoundField DataField="NombreCompleto" InsertVisible="false" ReadOnly="True" HeaderText="Nombre Usuario" SortExpression="NombreCompleto"></asp:BoundField>
                        <asp:BoundField DataField="Titulo" InsertVisible="false" HeaderText="Cargo" ReadOnly="True" SortExpression="Titulo"></asp:BoundField>
                        <asp:BoundField DataField="NombreRol" InsertVisible="false" HeaderText="Rol" ReadOnly="True" SortExpression="NombreRol"></asp:BoundField>
                        <%--      <asp:TemplateField HeaderText="Rol">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlRol" runat="server" DataSourceID="SqlDataSource_Rol" DataTextField="NombreRol" DataValueField="IdTipoRol" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:HiddenField ID="hfDepartmentId" runat="server" Value='<%# Bind("IdTipoRol") %>' />
                                <asp:SqlDataSource ID="SqlDataSource_Rol" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT * FROM [TipoRol]"></asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblNombreRol" runat="server" Text='<%# Eval("NombreRol") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:BoundField DataField="Descripcion" InsertVisible="false" HeaderText="Descripción" ReadOnly="True" SortExpression="Descripcion"></asp:BoundField>
                        <asp:BoundField DataField="FechaRegistro" InsertVisible="false" HeaderText="Fecha de Registro" ReadOnly="True" SortExpression="FechaRegistro" DataFormatString="{0:d}"></asp:BoundField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
        <asp:SqlDataSource ID="SqlDataSource_Usuarios" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT Usuario.IdUsuario, UsuarioRol.IdUsuarioRol, UsuarioRol.IdTipoRol, TipoRol.NombreRol, TipoRol.Descripcion, Usuario.NombreCompleto, Usuario.NombreUsuario, Usuario.Titulo, UsuarioRol.FechaRegistro FROM dbo.TipoRol INNER JOIN dbo.UsuarioRol ON TipoRol.IdTipoRol = UsuarioRol.IdTipoRol INNER JOIN dbo.Usuario ON UsuarioRol.IdUsuario = Usuario.IdUsuario"></asp:SqlDataSource>
        <%--campos no editables...--%>
        <asp:SqlDataSource ID="SqlDataSource_Usuarios_Buscar" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT * FROM [View_BuscarUsuario] WHERE ([NombreCompleto] LIKE '%' + ? + '%')">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtBuscar_GridView_Usuarios" DefaultValue="%%" Name="NombreCompleto" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <!-- Bootstrap Modal Dialog -->
        <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">
                                    <asp:Label ID="lblModalTitle" runat="server" Text="Gestión de Usuarios"></asp:Label></h4>
                            </div>
                            <div class="modal-body" style="height: auto">
                                <label>Nombre de Usuario:</label><asp:TextBox ID="NombreUsuario" runat="server" class="form-control" Width="100%"></asp:TextBox><p>&nbsp;</p>
                                <label>Tipo Rol:</label><asp:DropDownList ID="ddlRol" runat="server" AutoPostBack="true" class="form-control" OnSelectedIndexChanged="ddlRolDropDown_Change"></asp:DropDownList><p>&nbsp;</p>
                                <label>Observaciones:</label><asp:TextBox ID="TxtObservaciones" runat="server" Width="100%"></asp:TextBox><p>&nbsp;</p>
                                <label>Modulos:</label>
                                <div class="form-group" style="padding-left:20px">
                                    <div class="checkbox">
                                        <asp:CheckBoxList ID="ChK_Modulos" runat="server" TextAlign="Right" AutoPostBack="true" ClientIDMode="AutoID"></asp:CheckBoxList>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="btnCerrar" runat="server" class="btn btn-danger pull-left" Text="Cerrar" OnClick="btnCerrar_Click" />
                                    <asp:Button ID="btnUpdate" runat="server" class="btn btn-default pull-right" Text="Actualizar" OnClick="btnUpdate_Click" />
                                </div>
                            </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlRol"
                            EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </form>
    <%--campos no editables...--%>
    <!-- Edit Modal Starts here -->
    <!-- Edit Modal Ends here -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="InFooter" runat="server">
</asp:Content>
