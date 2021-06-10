<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ReturnStockApproval.aspx.cs" Inherits="ReturnStockApproval" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="js/jquery-1.4.4.js" type="text/javascript"></script>
    <script src="Js/JTemplate.js?v=3000" type="text/javascript"></script>
    <script src="Js/jquery.blockUI.js?v=3005" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="Css/VyshnaviStyles.css" />
    <script src="js/jquery.json-2.4.js" type="text/javascript"></script>
    <link href="Css/style.css" rel="stylesheet" type="text/css" />
    <script src="src/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <link href="js/DateStyles.css?v=3004" rel="stylesheet" type="text/css" />
    <script src="js/1.8.6.jquery.ui.min.js" type="text/javascript"></script>

<script type="text/javascript">

    $(function () {
        getReturn_StockDetails();
        scrollTo(0, 0);
    });

    function isFloat(evt) {
        var charCode = (event.which) ? event.which : event.keyCode;
        if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        else {
            //if dot sign entered more than once then don't allow to enter dot sign again. 46 is the code for dot sign
            var parts = evt.srcElement.value.split('.');
            if (parts.length > 1 && charCode == 46)
                return false;
            return true;
        }
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

    function getReturn_StockDetails() {
        var data = { 'operation': 'getReturn_StockDetails' };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    fillStockTransfer(msg);
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
    var ReturnStockSubDetails = [];
    function fillStockTransfer(msg) {
        var results = '<div  style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info" ID="tabledetails">';
        results += '<thead><tr class="trbgclrcls"><th scope="col">AgentName</th><th scope="col">ReturnDate</th><th scope="col">Remarks</th><th scope="col"></th></tr></thead></tbody>';
        var ReturnStocDetails = msg[0].ReturnStocDetails;
        ReturnStockSubDetails = msg[0].ReturnStockSubDetails;
        var k = 1;
        var l = 0;
        var COLOR = ["#f3f5f7", "#cfe2e0", "", "#cfe2e0"];
        for (var i = 0; i < ReturnStocDetails.length; i++) {
            results += '<tr style="background-color:' + COLOR[l] + '">'; //<td><input id="btn_poplate" type="button"  onclick="getme(this)" name="Approval" class="btn btn-primary" value="Approval" /></td>
            results += '<th scope="row" class="1" style="display:none;" >' + ReturnStocDetails[i].Branchid + '</th>';
            results += '<td data-title="sectionstatus"  style="display:none;" class="2">' + ReturnStocDetails[i].Agentid + '</td>';
            results += '<td data-title="sectionstatus"  class="3">' + ReturnStocDetails[i].AgentName + '</td>';
            results += '<td data-title="sectionstatus" class="4">' + ReturnStocDetails[i].ReturnDate + '</td>';
            results += '<td data-title="sectionstatus"  style="display:none;" class="5">' + ReturnStocDetails[i].status + '</td>';
            results += '<td data-title="sectionstatus" style="display:none;" class="6">' + ReturnStocDetails[i].entry_by + '</td>';
            results += '<td data-title="sectionstatus" style="display:none;" class="7">' + ReturnStocDetails[i].Approvdby + '</td>';
            results += '<td data-title="sectionstatus"  style="display:none;" class="8">' + ReturnStocDetails[i].ApproveDate + '</td>';
            results += '<td data-title="sectionstatus"  class="9">' + ReturnStocDetails[i].remarks + '</td>';
            results += '<td data-title="brandstatus"><button type="button" title="Click Here To Approve!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 apprvcls"  onclick="getme(this)"><span class="glyphicon glyphicon-thumbs-up" style="top: 0px !important;"></span></button></td>';
            results += '<td data-title="sno" class="10" style="display:none;">' + ReturnStocDetails[i].sno + '</td></tr>';
            l = l + 1;
            if (l == 4) {
                l = 0;
            }
        }
        results += '</table></div>';
        $("#div_ReturnStockData").html(results);
    }
    var returnstocksno = 0;
    function getme(thisid) {
        scrollTo(0, 0);
        $('#divMainAddNewRow').css('display', 'block');
        var Branchid = $(thisid).parent().parent().children('.1').html();
        var Agentid = $(thisid).parent().parent().children('.2').html();
        var AgentName = $(thisid).parent().parent().children('.3').html();
        var ReturnDate = $(thisid).parent().parent().children('.4').html();
        var status = $(thisid).parent().parent().children('.5').html();
        var entry_by = $(thisid).parent().parent().children('.6').html();
        var Approvdby = $(thisid).parent().parent().children('.7').html();

        var ApproveDate = $(thisid).parent().parent().children('.8').html();
        var remarks = $(thisid).parent().parent().children('.9').html();
        var sno = $(thisid).parent().parent().children('.10').html();
        document.getElementById('lbl_sno').value = sno;

        returnstocksno = sno;
        var table = document.getElementById("tabledetails");
        var results = '<div  style="overflow:initial;"><table id="tabledetails" class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
        results += '<thead><tr><th scope="col">Sno</th><th scope="col">Product Name</th><th scope="col">Quantity</th></tr></thead></tbody>';
        var k = 1;
        for (var i = 0; i < ReturnStockSubDetails.length; i++) {
            if (sno == ReturnStockSubDetails[i].return_stock_refno) {
                results += '<tr><td scope="row"  class="1">' + k + '</td>';
                results += '<td  data-title="sectionstatus" style="display:none" class="2">' + ReturnStockSubDetails[i].stock_refno + '</td>';
                results += '<td data-title="From" style="display:none"><input  id="subsno" readonly type="hidden" name="subsno" value="' + ReturnStockSubDetails[i].subsno + '"></input>';
                results += '<td  data-title="sectionstatus" class="2">' + ReturnStockSubDetails[i].productname + '</td>';
                results += '<td data-title="From"><span id="spn_quantity" style="display:none;">' + ReturnStockSubDetails[i].qty + '</span><input id="txt_quantity"  class="quantity"  name="quantity" onkeypress="return isFloat(event)"  value="' + ReturnStockSubDetails[i].qty + '" style="width:100%; font-size:12px;padding: 0px 5px;height:30px;"></input></td>';
                results += '<td data-title="From"><input class="6" id="hdnproductsno" readonly type="hidden" name="hdnproductsno" value="' + ReturnStockSubDetails[i].productid + '" style="width:100%; font-size:12px;padding: 0px 5px;height:30px;"></input>';
                results += '</tr>';
                k++
            }
        }
        results += '</table></div>';
        $("#btn_StockProductData").html(results);
    }
    function CloseClick() {
        $('#divMainAddNewRow').css('display', 'none');
        scrollTo(0, 0);
    }
    function save_approve_Return_Stock_click() {
        var Returnstockarr = [];
        $('#tabledetails> tbody > tr').each(function () {
            var subsno = $(this).find('#subsno').val();
            var quantity = $(this).find('#txt_quantity').val();
            var hdnproductsno = $(this).find('#hdnproductsno').val();
            if (hdnproductsno == "" || hdnproductsno == "0") {
            }
            else {
                Returnstockarr.push({ 'qty': quantity, 'productid': hdnproductsno, 'subsno': subsno });
            }
        });
        
        var data = { 'operation': 'save_approve_Return_Stock_click', 'sno': returnstocksno, 'Returnstockarr': Returnstockarr };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    alert(msg);
                    $('#divMainAddNewRow').css('display', 'none');
                    getReturn_StockDetails();
                    scrollTo(0, 0);
                }
            }
            else {
            }
        };
        var e = function (x, h, e) {
        };
        $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
        CallHandlerUsingJson(data, s, e);
    }
 </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <section class="content-header">
        <h1>
            Return Stock Approval Details<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Return Stock Approval </a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Return Stock Approval Details
                </h3>
            </div>
            <div class="box-body">
                <table>
                    <tr style="display: none;">
                        <td>
                            <label id="lbl_sno">
                            </label>
                        </td>
                    </tr>
                </table>
                <div id="div_ReturnStockData">
                </div>
            </div>
            <div id="divMainAddNewRow" class="pickupclass" style="text-align: center; height: 100%;
                width: 100%; position: absolute; display: none; left: 0%; top: 0%; z-index: 99999;
                background: rgba(192, 192, 192, 0.7);">
                <div id="divAddNewRow" style="border: 5px solid #A0A0A0; position: absolute; top: 8%;
                    background-color: White; left: 10%; right: 10%; width: 80%; -webkit-box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65);
                    -moz-box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65); box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65);
                    border-radius: 10px 10px 10px 10px;">
                    <table align="left" cellpadding="0" cellspacing="0" style="float: left; width: 100%;"
                        id="tableCollectionDetails" class="mainText2" border="1">
                        <tr>
                            <td colspan="2">
                                <div id="btn_StockProductData">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table align="center">
                                   <tr>
                                    <td>
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            <span class="glyphicon glyphicon-ok" id="btn_RetunStock1" onclick="save_approve_Return_Stock_click()"></span> <span id="btn_RetunStock" onclick="save_approve_Return_Stock_click()">Approve</span>
                                        </div>
                                    </div>
                                    </td>
                                    </tr>
                               </table>
                            </td>
                            <td>
                                <table align="center">
                                   <tr>
                                    <td>
                                     <div class="input-group">
                                        <div class="input-group-close">
                                            <span class="glyphicon glyphicon-remove" id='close_vehmaster1' onclick="CloseClick()"></span> <span id='close_vehmaster' onclick="CloseClick()">Close</span>
                                        </div>
                                    </div>
                                    </td>
                                    </tr>
                               </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divclose" style="width: 35px; top: 7.5%; right: 10%; position: absolute;
                    z-index: 99999; cursor: pointer;">
                    <img src="Images/Close.png" height="100%" width="100%" alt="close" onclick="CloseClick();" />
                </div>
            </div>
        </div>
    </section>
</asp:Content>


