<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EditBalance.aspx.cs" Inherits="EditBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="js/jquery-1.4.4.js" type="text/javascript"></script>
    <script src="Js/JTemplate.js?v=3000" type="text/javascript"></script>
    <script src="Js/jquery.blockUI.js?v=3005" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="Css/VyshnaviStyles.css" />
    <script src="js/jquery.json-2.4.js" type="text/javascript"></script>
    <script src="src/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <link href="js/DateStyles.css?v=3003" rel="stylesheet" type="text/css" />
    <script src="js/1.8.6.jquery.ui.min.js" type="text/javascript"></script>
    <link href="Css/VyshnaviStyles.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">


        $(function () {
            FillSalesOffice()
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            today = year + "-" + month + "-" + day;
            $('#txtFrom_date').val(today);
            $('#txtTo_date').val(today);
        });

        function FillSalesOffice() {
            var data = { 'operation': 'GetPlantSalesOffice' };
            var s = function (msg) {
                if (msg) {
                    if (msg == "Session Expired") {
                        alert(msg);
                        window.location = "Login.aspx";
                    }
                    BindSalesOffice(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function BindSalesOffice(msg) {
            var ddlsalesOffice = document.getElementById('ddlSalesOffice');
            var length = ddlsalesOffice.options.length;
            ddlsalesOffice.options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "select";
            ddlsalesOffice.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].BranchName != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].BranchName;
                    opt.value = msg[i].Sno;
                    ddlsalesOffice.appendChild(opt);
                }
            }
        }
        function ddlSalesOfficeChanged(ID) {
            var BranchID = ID.value;
            var data = { 'operation': 'GetSalesRoutes', 'BranchID': BranchID };
            var s = function (msg) {
                if (msg) {
                    if (msg == "Session Expired") {
                        alert(msg);
                        window.location = "Login.aspx";
                    }
                    BindRouteName(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function BindRouteName(msg) {
            document.getElementById('ddlDispName').options.length = "";
            var veh = document.getElementById('ddlDispName');
            var length = veh.options.length;
            for (i = length - 1; i >= 0; i--) {
                veh.options[i] = null;
            }
            var opt = document.createElement('option');
            opt.innerHTML = "Select Route Name";
            opt.value = "";
            veh.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i] != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].RouteName;
                    opt.value = msg[i].rid;
                    veh.appendChild(opt);
                }
            }
        }
        function ddlDispNameChanged(id) {
            FillAgentName(id.value);
        }
        function FillAgentName(RouteID) {
            var data = { 'operation': 'GetAgents', 'RouteID': RouteID };
            var s = function (msg) {
                if (msg) {
                    BindAgentName(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function BindAgentName(msg) {
            document.getElementById('ddlAgentName').options.length = "";
            var ddlAgentName = document.getElementById('ddlAgentName');
            var length = ddlAgentName.options.length;
            for (i = length - 1; i >= 0; i--) {
                ddlAgentName.options[i] = null;
            }
            var opt = document.createElement('option');
            opt.innerHTML = "Select Agent Name";
            opt.value = "";
            ddlAgentName.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i] != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].BranchName;
                    opt.value = msg[i].Sno;
                    ddlAgentName.appendChild(opt);
                }
            }
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


        function btn_Get_AgentBal_Details() {
            var fromdate = document.getElementById('txtFrom_date').value;
            var AgentId = document.getElementById('ddlAgentName').value;
            var ddlSalesOffice = document.getElementById('ddlSalesOffice').value;
            var todate = document.getElementById('txtTo_date').value;
            if (fromdate == "") {
                alert("Please select from date");
                return false;
            }
            if (todate == "") {
                alert("Please select from date");
                return false;
            }
            var data = { 'operation': 'get_Agent_Bal_Trans', 'AgentId': AgentId, 'ddlSalesOffice': ddlSalesOffice, 'fromdate': fromdate, 'todate': todate };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        filldetails(msg);
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
        function filldetails(msg) {
            var results = '<div  style="overflow:auto;"><table id="myTable" class="table table-bordered table-hover dataTable no-footer">';
            results += '<thead><tr><th scope="col"></th><th scope="col" >Sno</th><th scope="col" >Agentid</th><th scope="col">Date</th><th scope="col">AgentName</th><th scope="col">Op_Balance</th><th scope="col">SaleValue</th><th scope="col">PaidAmount</th><th scope="col">ClosingValue</th><th scope="col"></th></tr></thead></tbody>';
            var k = 1;
            for (var i = 0; i < msg.length; i++) {
                results += '<tr><td><input id="btn_poplate" type="button"  name="submit" class="btn btn-primary" value="Update" /></td>';
                //k++;
                results += '<td scope="row"  style="text-align:center;">' + k + '</td>';
                results += '<th scope="row" class="1" style="text-align:center;">' + msg[i].AgentId + '</th>';
                results += '<td class="2">' + msg[i].inddate + '</td>';
                results += '<td class="3">' + msg[i].AgentName + '</td>';
                results += '<td class="4">' + msg[i].opp_balance + '</td>';
                //results += '<td><input id="txt_OpBal" data-title="Code" style="width:65px;" onkeyup="CLChange(this);" class="4"  value="' + msg[i].opp_balance + '"/></td>';
                results += '<td><input  id="txt_SaleValue" class="5" style="width:65px;" value="' + msg[i].salesvalue + '"/></td>';
                results += '<td><input id="txt_PaidAmount" class="6" style="width:65px;" value="' + msg[i].paidamount + '"/></td>';
                results += '<td><input  id="txt_CloBal" class="7" style="width:65px;" value="' + msg[i].clo_balance + '"/></td>';
                results += '<td><input  id="txt_Sno" class="8" style="width:65px;display:none;"  value="' + msg[i].sno + '"/></td></tr >';
                k++;
            }
            results += '</table></div>';
            $("#div_BrandData").html(results);
        }

        $('#btn_poplate').click(function () {
            var Clo_Bal = $(this).closest("tr").find('.7').val();
        });

        //function getme(thisid) {
        //    //var Date = $(thisid).parent().parent().children('.2').html();
        //    //var Op_Bal = $(thisid).parent().parent().children('.4').html();
        //    //var SaleValue = $(thisid).parent().parent().children('.5').val();
        //    //var PaidAmount = $(thisid).parent().parent().children('.6').html();
        //    //var Clo_Bal = $(thisid).parent().parent().children('.7').html();
        //    //var sno = $(thisid).parent().parent().children('.8').html();
        //    var Clo_Bal =$(this).closest("tr").find('.7').val();
        //    var Date = $(thisid).parent().parent().children('.2').html();
        //    var Op_Bal = $(thisid).parent().parent().children('.4').html();
        //    var SaleValue = $(thisid).parent().parent().children('.5').val();
        //    var PaidAmount = $(thisid).parent().parent().children('.6').html();
        //    var Clo_Bal = $(thisid).parent().parent().children('.7').html();
        //    var sno = $(thisid).parent().parent().children('.8').html();

        //            var data1 = $(thisid).find("td:eq(0) input[type='text']").val();
        //            var data2 = $(thisid).find("td:eq(1) input[type='text']").val();


        //    var Op_Bal = document.getElementById('txt_PaidAmount');
        //    var data = { 'operation': 'Edit_Agent_Bal_Trans', 'Op_Bal': Op_Bal, 'SaleValue': SaleValue, 'PaidAmount': PaidAmount, 'Clo_Bal': Clo_Bal, 'sno': sno, 'Date': Date };
        //    var s = function (msg) {
        //        if (msg) {
        //            if (msg.length > 0) {
        //                alert(msg);
        //                btn_Get_AgentBal_Details();
        //            }
        //        }
        //        else {
        //        }
        //    };
        //    var e = function (x, h, e) {
        //    };
        //    $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
        //    callHandler(data, s, e);
        //}

       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
        <h1>AgentEditBalance<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">AgentEditBalance</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>AgentEditBalance
                </h3>
            </div>
            <div class="box-body">
                <table>
                    <tr>
                        <td>
                            <select id="ddlSalesOffice" class="form-control" onchange="ddlSalesOfficeChanged(this);">
                            </select>
                        </td>
                        <td style="width: 5px;"></td>
                        <td>
                            <select id="ddlDispName" class="form-control" onchange="ddlDispNameChanged(this);">
                            </select>
                        </td>
                        <td style="width: 5px;"></td>
                        <td>
                            <select id="ddlAgentName" class="form-control">
                            </select>
                        </td>
                        <td style="width: 5px;"></td>
                        <td>
                            <input type="date" id="txtFrom_date" class="form-control" />
                             </td>
                        <td style="width: 5px;"></td>
                        <td>
                            <input type="date" id="txtTo_date" class="form-control" />
                        </td>
                        <td style="width: 5px;"></td>
                        <td>
                            <button type="button" class="btn btn-primary" style="margin-right: 5px;" onclick="btn_Get_AgentBal_Details()">
                                <i class="fa fa-refresh"></i>Get Details
                            </button>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
                <div id="div_BrandData">
                </div>
            </div>
        </div>
    </section>
</asp:Content>

