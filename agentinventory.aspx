<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="agentinventory.aspx.cs" Inherits="agentinventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="js/jquery-1.4.4.js" type="text/javascript"></script>
    <script src="Js/JTemplate.js?v=3000" type="text/javascript"></script>
    <script src="Js/jquery.blockUI.js?v=3005" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="Css/VyshnaviStyles.css" />
    <script src="js/jquery.json-2.4.js" type="text/javascript"></script>
    <script src="src/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <link href="js/DateStyles.css?v=3003" rel="stylesheet" type="text/css" />
    <script src="js/1.8.6.jquery.ui.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#datepicker").datepicker({ dateFormat: 'yy-mm-dd', numberOfMonths: 1, showButtonPanel: false, maxDate: '+13M +0D',
                onSelect: function (selectedDate) {
                }
            });
            $("#dtchequedate").datepicker({ dateFormat: 'yy-mm-dd', numberOfMonths: 1, showButtonPanel: false, maxDate: '+13M +0D',
                onSelect: function (selectedDate) {
                }
            });
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            today = year + "-" + month + "-" + day;
            $('#datepicker').val(today);
            FillSalesOffice();
            var Level = '<%=Session["LevelType"] %>';
            if (Level == "AccountsOfficer") {
                $('.divTransactionclass').css('display', 'table-row');
            }
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
        function ddlSalesOfficeChange(ID) {
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
            document.getElementById('ddlRouteName').options.length = "";
            var veh = document.getElementById('ddlRouteName');
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
        function ddlRouteNameChange(id) {
            FillAgentName(id.value);
        }
        function ddlAgentNameChange(id) {
            BtnGetAmountDeatailsClick();
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
        function bindinvname(msg) {
            document.getElementById('ddlinventoryname').options.length = "";
            var ddlAgentName = document.getElementById('ddlinventoryname');
            var length = ddlAgentName.options.length;
            for (i = length - 1; i >= 0; i--) {
                ddlAgentName.options[i] = null;
            }
            var opt = document.createElement('option');
            opt.innerHTML = "Select Inventory Name";
            opt.value = "";
            ddlAgentName.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i] != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].RouteName;
                    opt.value = msg[i].rid;
                    ddlAgentName.appendChild(opt);
                }
            }
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
        function AmountReceivingChange(Amount) {
            var ddltransactiontype = document.getElementById('ddltransactiontype').value;
            if (ddltransactiontype == "Credit") {
                if (Amount.value == "") {
                    var TotAmount = document.getElementById('txtTotAmount').innerHTML;
                    var paidAmount = 0;
                    var CloBal = parseFloat(TotAmount) - parseFloat(paidAmount);
                    document.getElementById('txtCloBal').innerHTML = CloBal;
                }
                else {
                    var TotAmount = document.getElementById('txtTotAmount').innerHTML;
                    var paidAmount = Amount.value;
                    var CloBal = parseFloat(TotAmount) - parseFloat(paidAmount);
                    document.getElementById('txtCloBal').innerHTML = CloBal;
                }
            }
            if (ddltransactiontype == "Debit") {
                if (Amount.value == "") {
                    var TotAmount = document.getElementById('txtTotAmount').innerHTML;
                    var paidAmount = 0;
                    var CloBal = parseFloat(TotAmount) + parseFloat(paidAmount);
                    document.getElementById('txtCloBal').innerHTML = CloBal;
                }
                else {
                    var TotAmount = document.getElementById('txtTotAmount').innerHTML;
                    var paidAmount = Amount.value;
                    var CloBal = parseFloat(TotAmount) + parseFloat(paidAmount);
                    document.getElementById('txtCloBal').innerHTML = CloBal;
                }
            }

        }
        function ddlinventoryNameChange() {
            var ddlRouteName = document.getElementById('ddlinventoryname').value;
            if (ddlRouteName == "Select Inventory Name" || ddlRouteName == "") {
                alert("Select Inventory Name");
                return false;
            }
            var ddlAgentName = document.getElementById('ddlAgentName').value;
            if (ddlAgentName == "Select Agent Name" || ddlAgentName == "") {
                alert("Select Agent Name");
                return false;
            }
            var data = { 'operation': 'GetAgentInvBal', 'BranchID': ddlAgentName, 'Invid': ddlRouteName };
            var s = function (msg) {
                if (msg) {
                    document.getElementById('txtOppBal').innerHTML = msg[0].RouteName;
                    //                   document.getElementById('txtTodayAmount').innerHTML = msg[0].TodayAmount;
                    var TotAmount = parseFloat(msg[0].RouteName);
                    document.getElementById('txtTotAmount').innerHTML = TotAmount;
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function BtnGetAmountDeatailsClick() {
            var ddlRouteName = document.getElementById('ddlRouteName').value;
            if (ddlRouteName == "Select Route Name" || ddlRouteName == "") {
                alert("Select Route Name");
                return false;
            }
            var ddlAgentName = document.getElementById('ddlAgentName').value;
            if (ddlAgentName == "Select Agent Name" || ddlAgentName == "") {
                alert("Select Agent Name");
                return false;
            }

            var data = { 'operation': 'GetInventoryDeatails', 'BranchID': ddlAgentName };
            var s = function (msg) {
                if (msg) {
                    bindinvname(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function btnCDinvsaveclick() {
            var AmountReceived = document.getElementById('txtAmountReceiving').value;
            if (AmountReceived == "") {
                alert("Enter Inventory qty");
                return false;
            }
            var ddlAgentName = document.getElementById('ddlAgentName').value;
            var invid = document.getElementById('ddlinventoryname').value;
            var soid = document.getElementById('ddlSalesOffice').value;
            var Remarks = document.getElementById('txtRemarks').value;
            if (Remarks == "") {
                alert("Enter Remarks");
                return false;
            }
            var ddltransactiontype = document.getElementById('ddltransactiontype').value;
            var PaidDate = document.getElementById('datepicker').value;

            if (!confirm("Do you want to save this transaction")) {
                return false;
            }
            var data = { 'operation': 'btnAgentInventoryCDTransaction', 'BranchID': ddlAgentName, 'Amount': AmountReceived, 'Remarks': Remarks, 'PaidDate': PaidDate, 'ddltransactiontype': ddltransactiontype, 'invid': invid, 'soid': soid };
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                    document.getElementById('txtAmountReceiving').value = "";
                    document.getElementById('txtRemarks').value = "";
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
        <h1>
            Inventory Credit/Debit<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Masters</a></li>
            <li><a href="#">Inventory Credit/Debit</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Inventory Credit/Debit Details
                </h3>
            </div>
            <div class="box-body">
                <br />
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 50%;">
                            <table align="center" >
                                <tr>
                                    <td style="height: 40px;">
                                        <label>Sales Office</label>
                                        <select id="ddlSalesOffice" class="form-control" onchange="ddlSalesOfficeChange(this);">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px;">
                                        <label>Route Name</label>
                                        <select id="ddlRouteName" class="form-control" onchange="ddlRouteNameChange(this);">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px;">
                                        <label>Agent Name</label>
                                        <select id="ddlAgentName" class="form-control" onchange="ddlAgentNameChange(this);">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    
                                    <td style="height: 40px;">
                                        <label>Inventory Name</label>
                                        <select id="ddlinventoryname" class="form-control" onchange="ddlinventoryNameChange(this);">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    
                                    <td style="height: 40px;">
                                        <label>
                                            Date:</label>
                                        <input type="date" id="datepicker" placeholder="DD-MM-YYYY" class="form-control" />
                                    </td>
                                </tr>
                                <tr>
                                    
                                    <td style="height: 40px;">
                                        <label>Inventory Balance Credit/Debit</label>
                                        <span id="txtOppBal" style="font-size: 22px; color:Red; font-weight: bold;"></span>
                                    </td>
                                </tr>
                                <tr>
                                    
                                    <td style="height: 40px;">
                                        <label>Inventory To Be Collected</label>
                                        <span id="txtTotAmount" style="font-size: 22px; color: Red; font-weight: bold;">
                                        </span>
                                    </td>
                                </tr>
                                <tr class="divTransactionclass" style="display: none;">
                                    <td style="height: 40px;">
                                        <label>Transaction Type</label>
                                        <select id="ddltransactiontype" class="form-control">
                                            <option selected="selected">Credit</option>
                                            <option>Debit</option>
                                        </select>
                                    </td>
                                </tr>
                               
                                <tr>
                                    
                                    <td style="height: 40px;">
                                        <label>Inventory Credit/Debit</label>
                                        <input type="text" id="txtAmountReceiving" class="form-control" onkeyup="AmountReceivingChange(this);"
                                            placeholder="Enter Qty" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px;">
                                        <label>Closing Balance Credit/Debit</label>
                                        <span id="txtCloBal" style="font-size: 22px; color: Red; font-weight: bold;"></span>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="height: 40px;">
                                        <label>Remarks</label>
                                        <textarea rows="3" cols="45" id="txtRemarks" class="form-control" maxlength="2000"
                                            placeholder="Enter Remarks"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px;">
                                    <div class="input-group">
                                                <div class="input-group-addon">
                                                    <span class="glyphicon glyphicon-ok" id="btnSave1" onclick="btnCDinvsaveclick()">
                                                    </span><span id="btnSave" onclick="btnCDinvsaveclick()">Save</span>
                                                </div>
                                            </div>
                                        <%--<input type="button" id="btnSave" value="Save" class="btn btn-primary" onclick="btnCDinvsaveclick();" />--%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </section>
</asp:Content>
