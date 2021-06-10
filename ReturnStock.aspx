<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReturnStock.aspx.cs" Inherits="ReturnStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="js/jquery-1.4.4.js" type="text/javascript"></script>
    <script src="Js/JTemplate.js?v=3000" type="text/javascript"></script>
    <script src="Js/jquery.blockUI.js?v=3005" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="Css/VyshnaviStyles.css" />
    <script src="js/jquery.json-2.4.js" type="text/javascript"></script>
    <link href="Css/style.css" rel="stylesheet" type="text/css" />
    <script src="src/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <link href="js/DateStyles.css?v=3004" rel="stylesheet" type="text/css" />
    <script src="js/1.8.6.jquery.ui.min.js" type="text/javascript"></script>
    <style type="text/css">
        .ddlsize
        {
            width: 280px;
            height: 30px;
            font-size: 16px;
            border: 1px solid gray;
            border-radius: 7px 7px 7px 7px;
        }
        .datepicker
        {
            border: 1px solid gray;
            background: url("Images/CalBig.png") no-repeat scroll 99%;
            width: 70%;
            top: 0;
            left: 0;
            height: 20px;
            font-weight: 700;
            font-size: 12px;
            cursor: pointer;
            border: 1px solid gray;
            margin: .5em 0;
            padding: .6em 20px;
            border-radius: 10px 10px 10px 10px;
            filter: Alpha(Opacity=0);
            box-shadow: 3px 3px 3px #ccc;
        }
        .chkclass
        {
            height: 20px;
            width: 20px;
        }
        .btn
        {
            padding: 6px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            FillSalesOffices();
            $("#datepicker").datepicker({ dateFormat: 'yy-mm-dd', numberOfMonths: 1, showButtonPanel: false, maxDate: '+13M +0D',
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
        });
        function FillSalesOffices() {
            var data = { 'operation': 'GetSalesOffice' };
            var s = function (msg) {
                if (msg) {
                    BindSalesOfficeNames(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function BindSalesOfficeNames(msg) {
            document.getElementById('ddlSalesOffice').options.length = "";
            var ddlSalesOffice = document.getElementById('ddlSalesOffice');
            var length = ddlSalesOffice.options.length;
            for (i = length - 1; i >= 0; i--) {
                ddlSalesOffice.options[i] = null;
            }
            var opt = document.createElement('option');
            opt.innerHTML = "Select Sales Office";
            opt.value = "";
            ddlSalesOffice.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i] != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].BranchName;
                    opt.value = msg[i].Sno;
                    ddlSalesOffice.appendChild(opt);
                }
            }
        }
        function ddlddlSalesOfficeChange(Id) {
            var data = { 'operation': 'GetSalesOfficeChange', 'BranchID': Id.value };
            var s = function (msg) {
                if (msg) {
                    BindSoRouteName(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function BindSoRouteName(msg) {
            document.getElementById('ddlRouteName').options.length = "";
            var ddlRouteName = document.getElementById('ddlRouteName');
            var length = ddlRouteName.options.length;
            for (i = length - 1; i >= 0; i--) {
                ddlRouteName.options[i] = null;
            }
            var opt = document.createElement('option');
            opt.innerHTML = "Select Route Name";
            opt.value = "";
            ddlRouteName.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i] != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].routename;
                    opt.value = msg[i].routesno;
                    ddlRouteName.appendChild(opt);
                }
            }
        }
        function ddlRouteNameChange(Id) {
            var data = { 'operation': 'GetRouteNameChange', 'RouteID': Id.value };
            var s = function (msg) {
                if (msg) {
                    BindBranchName(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function BindBranchName(msg) {
            document.getElementById('ddlBranchName').options.length = "";
            var ddlBranchName = document.getElementById('ddlBranchName');
            var length = ddlBranchName.options.length;
            for (i = length - 1; i >= 0; i--) {
                ddlBranchName.options[i] = null;
            }
            var opt = document.createElement('option');
            opt.innerHTML = "Select Agent Name";
            opt.value = "";
            ddlBranchName.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i] != null || msg[i].BranchName != "" || msg[i].BranchName != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].BranchName;
                    opt.value = msg[i].b_id;
                    ddlBranchName.appendChild(opt);
                }
            }
        }
        function Get_ProductsForReturnStock() {
            var ddlSalesOffice = document.getElementById('ddlSalesOffice').value;
            if (ddlSalesOffice == "Select Sales Office" || ddlSalesOffice == "") {
                alert("Please Select Sales Office");
                return false;
            }
            var ddlRouteName = document.getElementById('ddlRouteName').value;
            if (ddlRouteName == "Select Route Name" || ddlRouteName == "") {
                alert("Please Select Route Name");
                return false;
            }
            var ddlBranchName = document.getElementById('ddlBranchName').value;
            if (ddlBranchName == "Select Agent Name" || ddlBranchName == "") {
                alert("Please Select Agent Name");
                return false;
            }
            GetBranchProducts(ddlSalesOffice);
        }
        function GetBranchProducts(ddlBranchName) {
            var data = { 'operation': 'GetAgetntsaleProducts', 'BranchID': ddlBranchName };
            var s = function (msg) {
                if (msg) {
                    GetProducts(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function GetProducts(msg) {
            $('#divFillProducts').removeTemplate();
            $('#divFillProducts').setTemplateURL('ReturnStock.htm');
            $('#divFillProducts').processTemplate(msg);
        }

        function btnReturnStockSaveclick() {
            var SalesOfficeID = document.getElementById('ddlSalesOffice').value;
            var BranchID = document.getElementById('ddlBranchName').value;
            if (BranchID == "Select Agent Name" || BranchID == "") {
                alert("Please Select Agent Name");
                return false;
            }
            var ReturnDate = document.getElementById('datepicker').value;
            if (ReturnDate == "") {
                alert("Please Select ReturnDate");
                return false;
            }
            var remarks = document.getElementById('txt_remarks').value;
            var BranchName = document.getElementById('ddlBranchName');
            var BranchSno = BranchName.options[BranchName.selectedIndex].value;
            var BName = BranchName.options[BranchName.selectedIndex].text;
            var rows = $("#tabledetails tr:gt(0)");
            var Returnstockarr = new Array();
            var Offerdetails = new Array();
            $(rows).each(function (i, obj) {
                if ($(this).find('#txtProductQty').val() != "") {
                    var Product = 0;
                    var qty = $(this).find('#txtProductQty').val();
                    qty = parseFloat(qty).toFixed(2);
                    if (qty > 0) {
                        Returnstockarr.push({ productid: $(this).find('#hdnProductSno').val(), Product: Product, Qty: $(this).find('#txtProductQty').val() });
                    }
                }
            });
            var Data = { 'operation': 'btnReturnStock_Saveclick', 'Returnstockarr': Returnstockarr, 'BranchID': BranchID, 'Remarks': remarks, 'ReturnDate': ReturnDate, 'routename': BName, 'SalesOfficeID': SalesOfficeID };
            var s = function (msg) {
                if (msg) {
                    if (msg == "Session Expired") {
                        alert(msg);
                        window.location.assign("Login.aspx");
                    }
                    $('#divFillProducts').removeTemplate();
                    $('#divFillProducts').setTemplateURL('ReturnStock.htm');
                    $('#divFillProducts').processTemplate();
                    alert(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            CallHandlerUsingJson(Data, s, e);
        }
        function numberOnlyExample() {
            if ((event.keyCode < 48) || (event.keyCode > 57))
                return false;
        }
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
        <h1>
            Return Stock Details<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Return Stock</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Return Stock Details
                </h3>
            </div>
            <div class="box-body">
                <div style="width: 100%;">
                    <div style="width: 100%;padding-left:29%;" >
                                <table align="center">
                                    <tr>
                                        <td>
                                            <label>Sales Office Name</label>
                                        </td>
                                        <td style="height: 40px;">
                                            <select id="ddlSalesOffice" class="form-control" onchange="ddlddlSalesOfficeChange(this);">
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label>Route Name</label>
                                        </td>
                                        <td style="height: 40px;">
                                            <select id="ddlRouteName" class="form-control" onchange="ddlRouteNameChange(this);">
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                         <label>   Agent Name</label>
                                        </td>
                                        <td style="height: 40px;">
                                            <select id="ddlBranchName" class="form-control" ">
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                         <label>Remarks</label>
                                        </td>
                                        <td style="height: 40px;">
                                         <textarea id="txt_remarks" class="form-control" type="text" rows="3" cols="35" placeholder="Enter Remarks"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label>
                                                Date</label>
                                        </td>
                                        <td style="height: 40px;">
                                        <input type="date" id="datepicker" placeholder="DD-MM-YYYY" class="form-control" />
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
                                            <input type="button" id="Button1" value="GetProducts" class="btn btn-primary" onclick="Get_ProductsForReturnStock();" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                    <br />
                    <div id="divFillProducts">
                    </div>
                    <br />
                    <br />
                    <br />
                </div>
            </div>
        </div>
    </section>
    <br />
</asp:Content>
