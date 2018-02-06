<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginFNC1.aspx.cs" Inherits="IntranetFNCv18._1.LoginFNC1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login FNC</title>
    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500" />
    <link rel="stylesheet" href="Content/assets/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="Content/assets/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="Content/assets/css/form-elements.css" />
    <link rel="stylesheet" href="Content/assets/css/style.css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    <!-- Favicon and touch icons -->
    <link rel="shortcut icon" href="assets/ico/favicon.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png" />

</head>
<body onload="nobackbutton();">
    <!-- Top content -->
    <div class="top-content">
        <div class="inner-bg">
            <div class="container">
                <div class="row">
                    <div class="col-sm-8 col-sm-offset-2 text">
                        <h1 style="color: #484848"><strong>INTRANET</strong></h1>
                        <div class="description" style="color: #484848">
                            <img src="Imagenes/logo-dark.png" style="width: 50%; height: 50%" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-3 form-box">
                        <div class="form-bottom">
                            <form role="form" method="post" class="login-form" runat="server">
                                <asp:ScriptManager ID="ScriptManagerLogin" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true" AsyncPostBackTimeout="360000 "></asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div class="form-group">
                                            <label class="sr-only" for="form-username">Username</label>
                                            <input id="Username" type="text" runat="server" name="form-username" placeholder="Usuario FENOCO..." class="form-username form-control" />
                                        </div>
                                        <div class="form-group">
                                            <label class="sr-only" for="form-password">Password</label>
                                            <input id="Password" type="password" runat="server" name="form-password" placeholder="Contraseña..." class="form-password form-control" />
                                        </div>
                                        <center>
                                        <div style="text-align: center;">
                                            <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                                <ProgressTemplate>
                                                    <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                                                        <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="../Imagenes/Loading_v7.gif" AlternateText="Cargando por favor espere ..." ToolTip="Cargando por favor espere ..." Style="position: fixed;bottom:50%; top: 50%; left: 50%; right: 50%" Width="110px" Height="110px" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </div>
                                            </center>
                                        <asp:Button ID="btnLogin" runat="server" Text="INICIO DE SESSIÓN" class="btn btn-block" OnClick="btnLogin_Click" />
                                        <asp:Label ID="errorLabel" runat="server" ForeColor="#ff3300" Visible="false"></asp:Label>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnLogin" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="row">
                </div>
                <footer>
                    <p>
                        Dirección de Tecnología - Ferrocarriles del Norte de Colombia S.A.<br />
                        V1.<%: DateTime.Now.Year %>
                    </p>
                </footer>
            </div>
        </div>
    </div>
    <!-- Javascript -->
    <script src="Content/assets/js/jquery-1.11.1.min.js"></script>
    <script src="Content/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="Content/assets/js/jquery.backstretch.min.js"></script>
    <script src="Content/assets/js/scripts.js"></script>
    <script src="Content/assets/js/blockUI.js"></script>

    <!--[if lt IE 10]>
            <script src="assets/js/placeholder.js"></script>
        <![endif]-->
    <script>
        function nobackbutton() {
            window.location.hash = "no-back-button";
            window.location.hash = "Again-No-back-button" //chrome
            window.onhashchange = function () { window.location.hash = "no-back-button"; }
        }
    </script>
</body>

</html>

