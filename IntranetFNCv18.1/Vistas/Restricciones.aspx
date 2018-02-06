<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Restricciones.aspx.cs" Inherits="IntranetFNCv18._1.Vistas.Restricciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Inhead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <form id="form1" runat="server">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no" />
        <link rel="stylesheet" href="https://js.arcgis.com/3.23/esri/css/esri.css">
        <link rel="stylesheet" href="https://js.arcgis.com/3.23compact/dijit/themes/claro/claro.css" />
        <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
        <style>
            /*
           * --------------------------------------------------------------------
        * The code within this style block would ideally go into an external
        * stylesheet such as:
        * <link rel="stylesheet" href="./css/app.css" />
        * --------------------------------------------------------------------
        */
            html, body {
                width: 100%;
                height: 100%;
                margin: 0;
                padding: 0;
            }

            #HomeButton {
                position: absolute;
                top: 135px;
                left: 20px;
                z-index: 50;
            }

            #ui-map-page, #ui-map-content, #ui-map {
                width: 100%;
                height: 100%;
                margin: 0;
                padding: 0;
            }

            #ui-settings-page {
                width: 100%;
                height: 100%;
                padding: 0;
            }

            #ui-settings-content {
                margin: 1.25em;
            }
        </style>

        <script src="https://js.arcgis.com/3.23/"></script>
        <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
        <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
        <script>

            var map;
            require([
                "esri/map",
                "esri/dijit/HomeButton",
                "esri/InfoTemplate",
                "esri/layers/FeatureLayer",
                "esri/dijit/Legend",
                "esri/dijit/LayerList",
                "dojo/_base/array",
                "dojo/parser",
                "dojo/domReady!"
            ], function (
                Map,
                HomeButton,
                InfoTemplate,
                FeatureLayer,
                Legend,
                LayerList,
                arrayUtils,
                parser
            ) {
                    parser.parse();

                    map = new Map("ui-map", {
                        basemap: "dark-gray",
                        center: [-73.9, 10.3],
                        zoom: 9
                    });

                    var home = new HomeButton({
                        map: map
                    }, "HomeButton");
                    home.startup();

                    var Fecha = new Date();

                    var roceria = new FeatureLayer("http://181.225.66.37:13875/ArcGIS/rest/services/Incidenciasdevia/FeatureServer/9", {
                        infoTemplate: new InfoTemplate(
                            "Rocería y Derhierbe manual:",
                            "Pk inicial: ${PKINI}<br>" +
                            "Pk final:   ${PKFIN}<br>" +
                            "Ancho total:   ${ANCHO_TOTAL} m<br>" +
                            "Area:        ${Fenoco10.DBO.EJECUTADOROCERIA.AREA} m2<br>"
                        ),
                        mode: FeatureLayer.MODE_AUTO,
                        outFields: ["*"]
                    });
                    var railstatus = new FeatureLayer("http://181.225.66.37:13875/ArcGIS/rest/services/RestriccionesdeVelocidad/FeatureServer/2", {
                        infoTemplate: new InfoTemplate(
                            "Rail Status:<br>Perfil: ${PERFIL} lb/yd",
                            "Pk inicial: ${PKINI}<br>" +
                            "Pk final:   ${PKFIN}<br>" +
                            "Longitud:   ${LONGITUD}<br>" +
                            "Vía:        ${VIA}<br>"
                        ),
                        mode: FeatureLayer.MODE_AUTO,
                        outFields: ["*"]
                    });
                    var programa = new FeatureLayer("http://181.225.66.37:13875/ArcGIS/rest/services/RestriccionesdeVelocidad/FeatureServer/1", {
                        infoTemplate: new InfoTemplate(
                            "Programación Semanal:<br>${Actividad}",
                            "OT:         ${OT}<br>" +
                            "Pk inicial: ${PkInicial}<br>" +
                            "Pk final:   ${PkFinal}<br>" +
                            "Vía:        ${Via}<br>" +
                            "Comienzo:   ${Comienzo:DateFormat(selector: 'date', datePattern: 'd/MM/yyyy HH:mm', fullYear: true)}<br>" +
                            "Final:      ${Final:DateFormat(selector: 'date', datePattern: 'dd/MM/yyyy HH:mm', fullYear: true)}<br>" +
                            "Duración:   ${Duracion} hrs<br>" +
                            "Supervisor: ${Supervisor}<br>" +
                            "Recurso:    ${Recurso}"
                        ),
                        mode: FeatureLayer.MODE_AUTO,
                        outFields: ["*"]
                    });
                    programa.setDefinitionExpression("Comienzo >= '" + Fecha.getFullYear() + "-" + (Fecha.getMonth() + 1) + "-" + Fecha.getDate() + " 06:00:00' AND Comienzo <= '" + Fecha.getFullYear() + "-" + (Fecha.getMonth() + 1) + "-" + Fecha.getDate() + " 23:30:00'");
                    var restricciones = new FeatureLayer("http://181.225.66.37:13875/ArcGIS/rest/services/RestriccionesdeVelocidad/FeatureServer/0", {
                        infoTemplate: new InfoTemplate(
                            "Restricciones de Velocidad:<br>${JUSTIFICACION}",
                            "BOD:           ${BOD}<br>" +
                            "IOG:           ${IOG}<br>" +
                            "Pk inicial:    ${PKINI}<br>" +
                            "Pk final:      ${PKFIN}<br>" +
                            "Vía:           ${VIA}<br>" +
                            "Velocidad:     ${VELOCIDAD}<br>" +
                            "Fecha:         ${FECHA:DateFormat(selector: 'date', datePattern: 'dd/MM/yyyy HH:mm', fullYear: true)}"
                        ),
                        mode: FeatureLayer.MODE_AUTO,
                        outFields: ["*"]
                    });
                    restricciones.setDefinitionExpression("Fecha = '" + Fecha.getFullYear() + "-" + (Fecha.getMonth() + 1) + "-" + Fecha.getDate() + " 06:00:00'");
                    //add the legend
                    //map.on("layers-add-result", function (evt) {
                    //    var layerInfo = arrayUtils.map(evt.layers, function (layer, index) {
                    //    return {layer:layer.layer, title:layer.layer.name};
                    //    });
                    //    if (layerInfo.length > 0) {
                    //    var legendDijit = new Legend({
                    //        map: map,
                    //        layerInfos: layerInfo
                    //    }, "legendDiv");
                    //    legendDijit.startup();
                    //    };
                    //    layerList.refresh
                    //});

                    var layerList = new LayerList({
                        map: map,
                        showLegend: true,
                        showSubLayers: true,
                        layers: []
                    }, "layerListDom");

                    map.addLayers([railstatus, roceria, programa, restricciones]);

                    layerList.startup();

                });

        </script>
        </head>

        <body>
            <div data-role="page" id="ui-map-page" data-theme="b">

                <div data-role="header" data-position="fixed">
                    <h1>Mantenimiento de Vía</h1>
                    <a href="#nav-panel" data-icon="bars" data-iconpos="notext">Menu</a>
                </div>
                <!-- /header -->

                <div id="ui-map-content" data-theme="b">
                    <div id="ui-map">
                        <div id="HomeButton"></div>
                    </div>
                </div>

                <div data-role="footer" data-position="fixed">
                    <h6>Ferrocarriles del Norte de Colombia S.A.</h6>
                </div>

                <div data-role="panel" data-position-fixed="true" data-display="push" data-theme="b" id="nav-panel">
                    <!--<ul data-role="listview">
                <li data-icon="delete"><a href="#" data-rel="close">Cerrar menu</a></li>
                <li><a href="#leyenda">Leyenda</a></li>
                <li data-role="collapsible">Capas<div id="layerListDom"></div></li>
                <li><a href="#acerca">Acerca del mapa</a></li>

            </ul>-->
                    <div data-role="collapsible" data-theme="b">
                        <h4>Capas</h4>
                        <div id="layerListDom" data-theme="b"></div>
                    </div>


                </div>

            </div>

        </body>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="InFooter" runat="server">
</asp:Content>
