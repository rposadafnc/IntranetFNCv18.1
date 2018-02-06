<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="GestionDocumentos.aspx.cs" Inherits="IntranetFNCv18._1.Vistas.GestionDocumentos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Inhead" runat="server">    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <form id="form1" runat="server">
        <div class="col-md-6">
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
                    <h3 class="box-title">Agregar nuevos Documentos</h3>
                </div>
                <!-- /.box-header -->
                <!-- form start -->

                <div class="box-body">
                    <div class="form-group">
                        <label>Titulo:</label>
                        <asp:TextBox ID="TxtTitulo" runat="server" class="form-control" Width="100%" CausesValidation="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="El campo nombre es obligatorio." ControlToValidate="TxtTitulo" ForeColor="Red" ValidationGroup="PersonalInfoGroup"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label>Descripción:</label>
                        <asp:TextBox ID="TxtDescripcion" runat="server" class="form-control" Width="100%" Height="75px" CausesValidation="true"></asp:TextBox>
                        <p class="help-block">Máximo de caracteres 200.</p>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El campo Descripción es obligatorio." ControlToValidate="TxtDescripcion" ForeColor="Red" ValidationGroup="PersonalInfoGroup"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label>Tipo Documento:</label>
                        <asp:DropDownList ID="ddlTipoDocumento" runat="server" AutoPostBack="true" class="form-control">
                            <asp:ListItem Selected="True" Value="1">Política Corporativa</asp:ListItem>
                            <asp:ListItem Value="2">Política Operativa</asp:ListItem>
                            <asp:ListItem Value="3">Manual</asp:ListItem>
                            <asp:ListItem Value="4">Procedimiento</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Direcciones:</label>
                        <asp:DropDownList ID="dllDireccionFNC" runat="server" AutoPostBack="True" class="form-control" DataSourceID="SqlDataSource_DireccionesFNC" DataTextField="Nombre" DataValueField="IdDireccion">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_DireccionesFNC" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT * FROM [DireccionFNC]"></asp:SqlDataSource>
                    </div>
                    <div class="form-group">
                        <label>Agregar Documento:</label>
                        <asp:FileUpload ID="FileUpload_Documento" runat="server" />
                        <p class="help-block">Peso maximo de documento 2MB en formato PDF.</p>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="El documento es obligatorio." ControlToValidate="FileUpload_Documento" ForeColor="Red" ValidationGroup="PersonalInfoGroup"></asp:RequiredFieldValidator>
                        <div style="text-align:center"> <strong><asp:Label ID="LblFile" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label></strong></div>
                    </div>
                </div>
                <!-- /.box-body -->
                <div class="modal-footer">
                    <asp:Button ID="btnGuardarDocumento" runat="server" class="btn btn-prmimary pull-right" Text="Guardar" OnClick="btnGuardarDocumento_Click" ValidationGroup="PersonalInfoGroup" />
                </div>
            </div>
        </div>
        <div class="col-md-6">
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
•	Todos los Campos son obligatorios<br />
•	El documento quedara guardado con el nombre de titulo en Mayúscula y sin espació.<br />
•	El campo "Descripción" solo permitirá 200 caracteres, incluyendo espacios.<br />
•	Los documentos debe ser en formato PDF, con un peso máximo de 2MB.<br />
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
        <hr />     
        <div class="col-md-12">
            <asp:Panel ID="PnlEliminarOk" runat="server" Visible="false">
                <div class="alert alert-success alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-check"></i>Confirmación !</h4>
                    Se ha eliminado el documento exitosamente.
                </div>
            </asp:Panel>
            <asp:Panel ID="PnlEliminarError" runat="server" Visible="false">
                <div class="alert alert-danger alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-ban"></i>Error !</h4>
                    Se ha presentado un error en el sistema, por favor contantarse con el Administrador en Dirección TI.             
                    <br />
                    Error:<asp:Label ID="LblTipoerror" runat="server" Font-Bold="True"></asp:Label>
                </div>
            </asp:Panel>
            <!-- general form elements -->
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Documentos</h3>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <div class="box-body">
             <%--       <asp:ScriptManager runat="server" ID="ScriptManager1" />--%>
                    <h5>Buscar Documentos:
            <asp:TextBox ID="txtBuscar_GridView_Documentos" runat="server" Height="25px" Width="20%"></asp:TextBox>
                        <asp:Button ID="BtnBuscarDocumento" CssClass="btn btn-default" runat="server" Text="Buscar" OnClick="BtnBuscarDocumento_Click" />&nbsp;&nbsp;
        <asp:Button ID="BtnRestablecerDocumento" CssClass="btn btn-default" runat="server" Text="Restablecer" OnClick="BtnRestablecerDocumento_Click" />
                    </h5>
                    <span style="float: right;"><small>Total Documentos:</small>
                        <asp:Label ID="lblDocumentos" runat="server" CssClass="label label-warning" /></span>
                    <p>&nbsp;</p>
                   <%-- <asp:UpdatePanel ID="upGridDocumentos" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>--%>
                            <asp:GridView ID="GridView_Documentos" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Documentos" OnRowDataBound="GridView_Documentos_RowDataBound" OnRowCommand="GridView_Documentos_RowCommand" OnRowDeleting="GridView_Documentos_RowDeleting">
                                <Columns>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" HeaderText="Eliminar">
                                        <ItemTemplate>
                                            <%--Botones editar usuarios... CommandName="Edit" --%>
                                            <asp:Button ID="btnEliminarDocumento" runat="server" Text="Eliminar" CommandArgument='<%#Eval("IdGestionDocumental")%>' CssClass="btn btn-darget" CommandName="Delete" />
                                        </ItemTemplate>
                                        <%--<EditItemTemplate>
                               Botones de grabar y cancelar la edición de registro...--%>
                                        <%--  <asp:Button ID="btnUpdate" runat="server" Text="Grabar" CssClass="btn btn-success" CommandName="Update" OnClientClick="return confirm('¿Seguro que quiere modificar los datos del usuario?');" OnClick="btnUpdate_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancelar" CssClass="btn btn-default" CommandName="Cancel" OnClick="btnCancel_Click" />
                            </EditItemTemplate>--%>

                                        <HeaderStyle Width="200px"></HeaderStyle>

                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="IdGestionDocumental" HeaderText="IdGestionDocumental" InsertVisible="False" ReadOnly="True" SortExpression="IdGestionDocumental" Visible="False" />
                                    <asp:BoundField DataField="NombreDocumento" HeaderText="Documento" SortExpression="NombreDocumento">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Titulo" HeaderText="Titulo" SortExpression="Titulo">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="18px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Descripcion" HeaderText="Descripción" SortExpression="Descripcion">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="18px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="TipoDocumento" HeaderText="Tipo Documento" SortExpression="TipoDocumento">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="18px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NombreCompleto" HeaderText="Usuario de Registro" SortExpression="NombreCompleto">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="18px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FechaRegistro" HeaderText="Fecha de Registro" SortExpression="FechaRegistro">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="18px" />
                                    </asp:BoundField>
                                </Columns>
                                <EmptyDataTemplate>
                                    -> No se encontraron Documentos <-
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_BuscarDocumento" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT * FROM [View_BuscarDocumento] WHERE ([Titulo] LIKE '%' + ? + '%')">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtBuscar_GridView_Documentos" DefaultValue="%%" Name="Titulo" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource_Documentos" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT dbo.DireccionFNC.Nombre, dbo.GestionDocumental.IdGestionDocumental, dbo.GestionDocumental.NombreDocumento, dbo.GestionDocumental.Titulo, dbo.GestionDocumental.Descripcion, dbo.GestionDocumental.Ruta, dbo.GestionDocumental.FechaRegistro, dbo.GestionDocumental.IdUsuario, dbo.GestionDocumental.IdTipoDocumento, dbo.GestionDocumental.IdDireccion, dbo.GestionDocumental.TipoDocumento, dbo.Usuario.NombreCompleto FROM dbo.GestionDocumental INNER JOIN dbo.DireccionFNC ON dbo.GestionDocumental.IdDireccion = dbo.DireccionFNC.IdDireccion INNER JOIN dbo.Usuario ON dbo.GestionDocumental.IdUsuario = dbo.Usuario.IdUsuario"></asp:SqlDataSource>
                      <%--  </ContentTemplate>
                        <Triggers>                            
                        </Triggers>
                    </asp:UpdatePanel>--%>
                </div>
                <!-- /.box-body -->
                <div class="box-footer">
                </div>
            </div>
        </div>
    </form>   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="InFooter" runat="server">
</asp:Content>
