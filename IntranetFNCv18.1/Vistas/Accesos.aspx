<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Accesos.aspx.cs" Inherits="IntranetFNCv18._1.Vistas.Accesos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Inhead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div class="col-md-6">
        <!-- general form elements -->
        <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title">Gestión de Accesos</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="form1" runat="server" role="form">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <div class="box-body">
                    <div class="form-group">
                        <h5><strong>Roles:</strong></h5>
                        <asp:DropDownList ID="ddlModulos" runat="server" CssClass="form-control" DataSourceID="SqlDataSource_TipoRol" DataTextField="NombreRol" DataValueField="IdTipoRol" OnSelectedIndexChanged="ddlModulos_SelectedIndexChanged" Width="30%"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_TipoRol" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringBD %>" ProviderName="<%$ ConnectionStrings:ConnectionStringBD.ProviderName %>" SelectCommand="SELECT * FROM [TipoRol]"></asp:SqlDataSource>
                    </div>
                    <div class="form-group">
                        <asp:CheckBoxList ID="chbAccesosModulos" CssClass="form-control" runat="server" Width="30%"></asp:CheckBoxList>

                    </div>
                </div>
                <div class="box-footer">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
                <!-- /.box-body -->
                <div class="container">
                    <div class="row">
                        <h1>Hello, world! Hello, world!</h1>
                        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
                        <!-- Include all compiled plugins (below), or include individual files as needed -->
                        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
                        <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                            Launch demo modal
                        </button>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <!-- Modal -->
                                <asp:Label ID="Label1" runat="server" Text=""></asp:Label><br />
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                                    aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                            </div>
                                            <div class="modal-body">
                                                <asp:TextBox ID="TextBox1" runat="server" placeholder="First Name" class="form-control"></asp:TextBox><br />
                                                <asp:TextBox ID="TextBox2" runat="server" placeholder="Middle Name" class="form-control"></asp:TextBox><br />
                                                <asp:TextBox ID="TextBox3" runat="server" placeholder="Last Name" class="form-control"></asp:TextBox><br />
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">
                                                    Close</button>
                                                <%--<button type="button"  class="btn btn-primary">
                                        Save changes</button>--%>
                                                <asp:Button Text="Save" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- /.box -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="InFooter" runat="server">
</asp:Content>
