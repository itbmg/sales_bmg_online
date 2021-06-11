<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="FreezarIssue.aspx.cs" Inherits="FreezarIssue" %>

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
            window.history.forward(1);

        });
    </script>
    <style type="text/css">
        th
        {
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            FillSalesOffice();
            get_FreezarIssue_details();
            FillApprovalEmploye();
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            today = year + "-" + month + "-" + day;
            $('#txt_date').val(today);
        });
        function CallHandlerUsingJson(d, s, e) {
            $.ajax({
                type: "GET",
                url: "DairyFleet.axd?json=",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(d),
                async: true,
                cache: true,
                success: s,
                error: e
            });
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

        function FillApprovalEmploye() {
            var data = { 'operation': 'GetApproveEmployeeNames' };
            var s = function (msg) {
                if (msg) {
                    if (msg == "Session Expired") {
                        alert(msg);
                        window.location = "Login.aspx";
                    }
                    BindApprovalEmploye(msg);

                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function BindApprovalEmploye(msg) {
            var ddlEmpApprove = document.getElementById('ddlEmpApprove');
            var length = ddlEmpApprove.options.length;
            ddlEmpApprove.options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "select";
            ddlEmpApprove.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].UserName != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].UserName;
                    opt.value = msg[i].Sno;
                    ddlEmpApprove.appendChild(opt);
                }
            }
        }


        //SalesOffice ,Routename,Agentname dropdown.
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

        function SaveFreezarIssuedeatils() {
            var TypeofIssue = document.getElementById("ddlissue").value;
            if (TypeofIssue == "") {
                alert("Please enter TypeofIssue");
                return false;
            }
            var SalesOffice = document.getElementById("ddlSalesOffice").value;
            if (SalesOffice == "") {
                alert("Please select SalesOffice");
                return false;
            }
            var RouteName = "";
            var AgentName = "";
            var ddlType = document.getElementById('ddlissue').value;
            if (ddlType == "Agent Wise") {
                RouteName = document.getElementById("ddlRouteName").value;
                if (RouteName == "") {
                    alert("Please enter RouteName");
                    return false;
                }
                AgentName = document.getElementById("ddlAgentName").value;
                if (AgentName == "") {
                    alert("Please enter AgentName");
                    return false;
                }
            }
            var CompanyName = document.getElementById("ddlcom").value;
            if (CompanyName == "") {
                alert("Please select CompanyName");
                return false;
            }
            var FreezarType = document.getElementById("ddlfreezar").value;
            if (FreezarType == "" || FreezarType == "Select FreezerType") {
                alert("Please select FreezerType");
                return false;
            }
            var TotalAmount = document.getElementById("txt_totalamt").value;
            if (TotalAmount == "") {
                alert("Please select TotalAmount");
                return false;
            }
            var InstallmentAmount = document.getElementById("txt_insamt").value;
            if (InstallmentAmount == "") {
                alert("Please select InstallmentAmount");
                return false;
            }
            var DateofIssue = document.getElementById("txt_date").value;
            if (DateofIssue == "") {
                alert("Please select DateofIssue");
                return false;
            }
            var ApprovedBy = document.getElementById("ddlEmpApprove").value;
            if (ApprovedBy == "") {
                alert("Please select ApprovedBy");
                return false;
            }
            var Status = document.getElementById("ddl_status").value;
            if (Status == "") {
                alert("Please select Status");
                return false;
            }
            var Remarks = document.getElementById("txtRemarks").value;
            if (Remarks == "") {
                alert("Please enter Remarks");
                return false;
            }

            var sno = document.getElementById('lbl_sno').value;
            var btnval = document.getElementById('btn_save').value;
            var data = { 'operation': 'SaveFreezarIssuedeatils', 'TypeofIssue': TypeofIssue, 'SalesOffice': SalesOffice, 'RouteName': RouteName, 'AgentName': AgentName, 'CompanyName': CompanyName, 'FreezarType': FreezarType, 'TotalAmount': TotalAmount, 'InstallmentAmount': InstallmentAmount, 'DateofIssue': DateofIssue, 'ApprovedBy': ApprovedBy, 'Status': Status, 'Remarks': Remarks, 'btnVal': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        CloseFreezarIssuedeatils();
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
        function get_FreezarIssue_details() {
            var data = { 'operation': 'get_FreezarIssue_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillFreezarIssuedetails(msg);
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
        function fillFreezarIssuedetails(msg) {

            var results = '<div class="divcontainer" style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr><th scope="col">Receiver Name</th><th scope="col">Total Amount</th><th scope="col">Install Amount</th><th scope="col">Freezer Type</th><th scope="col">Issue Date</th></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr>';
                results += '<th scope="row" class="2" >' + msg[i].ReceiverName + '</th>';
                results += '<th scope="row" class="2" >' + msg[i].TotalAmount + '</th>';
                results += '<th scope="row" class="2" >' + msg[i].InstallmentAmount + '</th>';
                results += '<th scope="row" class="2" >' + msg[i].freezer_type + '</th>';
                results += '<th scope="row" class="2" >' + msg[i].issue_date + '</th></tr>';
            }
            results += '</table></div>';
            $("#div_FreezarData").html(results);
        }
        function getme(thisid) {
            var TypeofIssue = $(thisid).parent().parent().children('.1').html();
            var SalesOffice = $(thisid).parent().parent().children('.2').html();
            var RouteName = $(thisid).parent().parent().children('.3').html();
            var AgentName = $(thisid).parent().parent().children('.4').html();
            var CompanyName = $(thisid).parent().parent().children('.5').html();
            var FreezarType = $(thisid).parent().parent().children('.6').html();
            var TotalAmount = $(thisid).parent().parent().children('.7').html();
            var InstallmentAmount = $(thisid).parent().parent().children('.8').html();
            var DateofIssue = $(thisid).parent().parent().children('.9').html();
            var ApprovedBy = $(thisid).parent().parent().children('.10').html();
            var Remarks = $(thisid).parent().parent().children('.11').html();
            var sno = $(thisid).parent().parent().children('.12').html();
            var status = $(thisid).parent().parent().children('.13').html();

            document.getElementById('ddlissue').value = TypeofIssue;
            document.getElementById('ddlSalesOffice').value = SalesOffice;
            document.getElementById('ddlRouteName').value = RouteName;
            document.getElementById('ddlAgentName').value = AgentName;
            document.getElementById('ddlcom').value = CompanyName;
            document.getElementById('ddlfreezar').value = FreezarType;
            document.getElementById('txt_totalamt').value = TotalAmount;
            document.getElementById('txt_insamt').value = InstallmentAmount
            document.getElementById('txt_date').value = DateofIssue;
            document.getElementById('ddlEmpApprove').value = ApprovedBy;
            document.getElementById('ddl_status').selectedIndex = status;
            document.getElementById('txtRemarks').value = Remarks;
            document.getElementById('lbl_sno').value = sno;
            document.getElementById('btn_save').value = "Modify";
            $("#div_FreezarData").show();
        }
        function CloseFreezarIssuedeatils() {
            document.getElementById('ddlissue').selectedIndex = 0;
            document.getElementById('ddlSalesOffice').selectedIndex = 0;
            document.getElementById('ddlRouteName').selectedIndex = 0;
            document.getElementById('ddlAgentName').selectedIndex = 0;
            document.getElementById('ddlcom').selectedIndex = 0;
            document.getElementById('ddlfreezar').selectedIndex = 0;
            document.getElementById('txt_totalamt').value = "";
            document.getElementById('txt_insamt').value = "";
            document.getElementById('txt_date').value = "";
            document.getElementById('ddlEmpApprove').selectedIndex = 0;
            document.getElementById('ddl_status').selectedIndex = 0;
            document.getElementById('txtRemarks').value = "";
            document.getElementById('btn_save').value = "SAVE";
        }
        function ddlTypeChange() {
            var ddlType = document.getElementById('ddlissue').value;
            if (ddlType == "Agent Wise") {
                $('#divagent').css('display', 'table-row');
                $('#divroute').css('display', 'table-row');
            }
            if (ddlType == "Sales Office Wise") {
                $('#divagent').css('display', 'none');
                $('#divroute').css('display', 'none');
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
        <h1>
            Freezer Issue Details<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Freezer Issue Details</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Freezer Issue Details
                </h3>
            </div>
            <div class="box-body">
                <table align="center">
                    <tr>
                        <td>
                        <label>    Type of Issue</label>
                        </td>
                        <td style="height: 40px;">
                            <select id="ddlissue" type="text" class="form-control" onchange="ddlTypeChange();">
                                <option>Agent Wise</option>
                                <option>Sales Office Wise</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Sales Office</label>
                        </td>
                        <td style="height: 40px;">
                            <select id="ddlSalesOffice" class="form-control" onchange="ddlSalesOfficeChange(this);">
                            </select>
                        </td>
                    </tr>
                    <tr id="divroute">
                        <td>
                            <label>Route Name</label>
                        </td>
                        <td style="height: 40px;">
                            <select id="ddlRouteName" class="form-control" onchange="ddlRouteNameChange(this);">
                            </select>
                        </td>
                    </tr>
                    <tr id="divagent">
                        <td>
                            <label>Agent Name</label>
                        </td>
                        <td style="height: 40px;">
                            <select id="ddlAgentName" class="form-control">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Company Name</label>
                        </td>
                        <td style="height: 40px;">
                            <select id="ddlcom" type="text" class="form-control">
                               <option>BLUE STAR</option>
                                <option>WESTERN</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                          <label>  Freezer Type</label>
                        </td>
                        <td style="height: 40px;">
                            <select id="ddlfreezar" type="text" class="form-control">
                            <option>Select FreezerType</option>
                                <option>100 ltrs</option>
                                <option>200 ltrs</option>
                                <option>220 visi ltrs</option>
                                <option>300 ltrs</option>
                                <option>320 visi ltrs</option>
                                <option>400 ltrs</option>
                                <option>420 visi ltrs</option>
                                <option>500 ltrs</option>
                                <option>1000 ltrs</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                          <label>  TotalAmount</label>
                        </td>
                        <td style="height: 40px;">
                            <input id="txt_totalamt" type="text" class="form-control" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                          <label>  Installment Amount</label>
                        </td>
                        <td style="height: 40px;">
                            <input id="txt_insamt" type="text" class="form-control" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                           <label> Date of Issue</label>
                        </td>
                        <td style="height: 40px;">
                            <input id="txt_date" type="date" class="form-control" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Approved By</label>
                        </td>
                        <td style="height: 40px;">
                            <select id="ddlEmpApprove" class="form-control">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                           <label> Status</label>
                        </td>
                        <td style="height: 40px;">
                            <select id="ddl_status" class="form-control">
                                <option>Active</option>
                                <option>InActive</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                           <label>Remarks</label>
                        </td>
                        <td style="height: 40px;">
                            <textarea rows="3" cols="45" id="txtRemarks" class="form-control" maxlength="2000"
                                placeholder="Enter Remarks"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <input type="button" id="btn_save" value="SAVE" class="btn btn-primary" onclick="SaveFreezarIssuedeatils();" />
                            <input type="button" id="btn_close" value="Close" class="btn btn-danger" onclick="CloseFreezarIssuedeatils();" />
                        </td>
                    </tr>
                    <tr hidden>
                        <td>
                            <label id="lbl_sno">
                            </label>
                        </td>
                    </tr>
                </table>
                <div id="div_FreezarData">
                </div>
            </div>
        </div>
    </section>
    <br />
</asp:Content>
