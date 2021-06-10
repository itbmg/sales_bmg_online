<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SapSaleQuantity.aspx.cs" Inherits="SapSaleQuantity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="js/jquery-1.4.4.js?v=3004" type="text/javascript"></script>
    <script src="js/newjs/jquery.js?v=3004" type="text/javascript"></script>
    <script src="Js/JTemplate.js?v=3004" type="text/javascript"></script>
    <link href="jquery.jqGrid-4.5.2/js/i18n/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <script src="jquery.jqGrid-4.5.2/src/i18n/grid.locale-en.js" type="text/javascript"></script>
    <script src="jquery.jqGrid-4.5.2/js/jquery.jqGrid.min.js" type="text/javascript"></script>
    <script src="jquery-ui-1.10.3.custom/js/jquery-ui.js" type="text/javascript"></script>
    <script src="js/jquery.blockUI.js?v=3005" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="Css/VyshnaviStyles.css" />
    <script src="js/jquery.json-2.4.js?v=3004" type="text/javascript"></script>
    <script src="js/newjs/jquery-ui.js?v=3004" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            today = year + "-" + month + "-" + day;
            $('#txtFromDate').val(today);
            $('#txtTodate').val(today);
        });
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        function ValidateAlpha(evt) {
            var keyCode = (evt.which) ? evt.which : evt.keyCode
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32)

                return false;
            return true;
        }
        function callHandler(d, s, e) {
            $.ajax({
                url: 'DairyFleet.axd',
                data: d,
                type: 'GET',
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                async: true,
                cache: true,
                success: s,
                error: e
            });
        }
        function get_disp_sale_qty_productwise() {
            var fromdate = document.getElementById('txtFromDate').value;
            var data = { 'operation': 'get_disp_sale_qty_productwise', 'fromdate': fromdate};
            var s = function (msg) {
                if (msg) {
                    if (msg == "Time Out Expired") {
                        alert(msg);
                        return false;
                    }
                    else {
                        pichartdataroutewise(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function pichartdataroutewise(msg) {
            var results = '<div  style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr><th scope="col">ItemCode</th><th scope="col">ItemName</th><th scope="col">OpQty Qty</th><th scope="col">Production Qty</th><th scope="col">DispatchQty</th><th scope="col">diff</th><th scope="col">SaleQty</th></tr></thead></tbody>';
            var k = 1;
            var l = 0;
            var COLOR = ["#b3ffe6", "AntiqueWhite", "#daffff", "MistyRose", "Bisque"];
            for (var i = 0; i < msg.length; i++) {
                results += '<tr style="background-color:' + COLOR[l] + '">';
                results += '<th scope="row"  class="1" >' + msg[i].ProductCode + '</th>';
                results += '<td scope="row" class="2" >' + msg[i].ProductName + '</th>';
                results += '<td data-title="brandstatus"  class="3">' + msg[i].OpeningQty + '</td>'

                results += '<td data-title="brandstatus"  class="3">' + msg[i].productionqty + '</td>'
                results += '<td data-title="brandstatus"  class="3">' + msg[i].DispatchQty + '</td>'
                results += '<td data-title="brandstatus"  class="3">' + msg[i].diff + '</td>'
                results += '<td data-title="brandstatus"  class="3">' + msg[i].SaleQty + '</td></tr>';
                l = l + 1;
                if (l == 4) {
                    l = 0;
                }
            }
            results += '</table></div>';
            $("#divPieChartdata").html(results);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
        <h1>
            Sap Production Disp Sale Quantity 
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operation</a></li>
            <li><a href="#">Sap Production Disp Sale Quantity</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Sap Production Disp Sale Quantity
                </h3>
            </div>
            <div class="box-body">
             <div id="ProductLineChartTab">
                         <table>
                                <tr>
                                    <td>
                                        <label>
                                            Date:</label>
                                    </td>
                                    <td style="height: 40px;">
                                    <input type="date" id="txtFromDate" class="form-control" />
                                    </td>
                                 <%--   <td>
                                        <label>
                                            ToDate:</label>
                                    </td>
                                    <td style="height: 40px;">
                                     <input type="date" id="txtTodate" class="form-control" />
                                    </td>--%>
                                     <td style="height: 40px;">
                                        <input type="button" id="btnGenarate" value="Generate" onclick="get_disp_sale_qty_productwise();"
                                            class="btn btn-primary" />
                                    </td>
                                </tr>
                            </table>
                        <div>
                         <div id="divPieChartdata">
                      </div>
            </div>
        </div>
    </section>
</asp:Content>


