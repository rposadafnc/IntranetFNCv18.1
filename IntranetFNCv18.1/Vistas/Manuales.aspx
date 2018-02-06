<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Manuales.aspx.cs" Inherits="IntranetFNCv18._1.Vistas.Manuales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Inhead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <form id="form1" runat="server">
        <div class="col-md-12">
            <!-- general form elements -->
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Documentación - Manuales</h3>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <div class="box-body">
                    <h5>Buscar Documentos:
            <asp:TextBox ID="txtBuscar_GridView_Documentos_Manual" runat="server" Height="25px" Width="20%"></asp:TextBox>
                        <asp:Button ID="BtnBuscarDocumento_Manual" CssClass="btn btn-default" runat="server" Text="Buscar" OnClick="BtnBuscarDocumento_Manual_Click" />&nbsp;&nbsp;
        <asp:Button ID="BtnRestablecerDocumento_Manual" CssClass="btn btn-default" runat="server" Text="Restablecer" OnClick="BtnRestablecerDocumento_Manual_Click" />
                    </h5>
                    <span style="float: right;"><small>Total Documentos:</small>
                        <asp:Label ID="lblDocumentos" runat="server" CssClass="label label-warning" /></span>
                    <p>&nbsp;</p>
                    <asp:GridView ID="GridView_Documento_Manual" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Documentos_Manual" OnRowCommand="GridView_Documento_Manual_RowCommand" OnRowDataBound="GridView_Documento_Manual_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="Titulo" HeaderText="Título" SortExpression="Titulo">
                             <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="25%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Descripcion" HeaderText="Descripción" SortExpression="Descripcion" >
                             <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FechaRegistro" HeaderText="Fecha Registro" SortExpression="FechaRegistro" DataFormatString="{0:d}">
                             <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Descargar">
                                <ItemTemplate>                                  
                                    <asp:LinkButton ID="lnkDownload" runat="server" CommandArgument='<%# Eval("NombreDocumento") %>' CommandName="cmd">Descargar</asp:LinkButton>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                </ItemTemplate>
                            </asp:TemplateField>                            
                        </Columns>
                        <EmptyDataTemplate>
                            -> No se encontraron Documentos <-
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource_BuscarDocumento_Manual" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT * FROM [View_BuscarDocumento] WHERE (([Titulo] LIKE '%' + ? + '%') AND ([IdTipoDocumento] = ?))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtBuscar_GridView_Documentos_Manual" DefaultValue="%%" Name="Titulo" PropertyName="Text" Type="String" />
                            <asp:Parameter DefaultValue="3" Name="IdTipoDocumento" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_Documentos_Manual" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT * FROM [View_BuscarDocumento] WHERE ([IdTipoDocumento] = ?)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="3" Name="IdTipoDocumento" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
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
