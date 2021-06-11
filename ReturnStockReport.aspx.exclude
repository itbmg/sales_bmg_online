<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ReturnStockReport.aspx.cs" Inherits="ReturnStockReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
 <script src="js/jquery-1.4.4.js?v=3004" type="text/javascript"></script>
    <style type="text/css">
        .container
        {
            max-width: 100%;
        }
        th
        {
            text-align: center;
        }
        #content
        {
            position: absolute;
            z-index: 1;
        }
        #bg-text
        {
            position: absolute;
            opacity: 0.1;
            color: lightgrey;
            font-size: 120px; /*transform:rotate(300deg);
        -webkit-transform:rotate(300deg);*/
        }
    </style>
    <script type="text/javascript">
        function CallPrint(strid) {
            document.getElementById("tbl_return_print").style.borderCollapse = "collapse";
            var divToPrint = document.getElementById(strid);
            var newWin = window.open('', 'Print-Window', 'width=400,height=400,top=100,left=100');
            newWin.document.open();
            newWin.document.write('<html><body   onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
            newWin.document.close();
        }
        $(function () {
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            today = year + "-" + month + "-" + day;
            $('#txtfromdate').val(today);
            $('#txttodate').val(today);
        });
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
        function get_return_stock_Report_details() {
            var fromdate = document.getElementById('txtfromdate').value;
            var todate = document.getElementById('txttodate').value
            if (fromdate == "") {
                alert("Please select from date");
                return false;
            }
            if (todate == "") {
                alert("Please select to date");
                return false;
            }
            var data = { 'operation': 'get_return_stock_Report_details', 'fromdate': fromdate, 'todate': todate };
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
            //}
        }
        function filldetails(msg) {

            var results = '<div  style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer">';
            results += '<thead><tr><th scope="col"></th><th scope="col">Ref No</th><th scope="col">Name</th><th scope="col">Date</th><th scope="col">Remarks</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr>';
                results += '<tr><th><button id="btn_Print" type="button"   onclick="printclick(this);"  name="Edit" class="btn btn-primary" ><i class="fa fa-print"></i> Print</button></th>'
                results += '<td th scope="row" class="1"  style="text-align:center;">' + msg[i].sno + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center;" class="3">' + msg[i].AgentName + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center;" class="2">' + msg[i].ReturnDate + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center;" class="2">' + msg[i].status + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center;" class="5">' + msg[i].remarks + '</td></tr>';
                // results += '<td data-title="brandstatus"  style="display:none;">' + msg[i].vehicleno + '</td>';
                // results += '<td data-title="brandstatus"  style="display:none;" class="6">' + msg[i].transportname + '</td>';

                // }
            }
            results += '</table></div>';
            $("#divPOdata").html(results);
        }
        function printclick(thisid) {
            var refno = $(thisid).parent().parent().children('.1').html();
            //            if (refno == "") {
            //                alert("Please enter ref dc no");
            //                return false;
            //            }
            var data = { 'operation': 'getReturn_StockDetails', 'refno': refno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        $('#divPrint').css('display', 'block');
                        var ReturnStocDetails = msg[0].ReturnStocDetails;
                        var ReturnStockSubDetails = msg[0].ReturnStockSubDetails;
                        document.getElementById('spnfromstate').innerHTML = ReturnStocDetails[0].fromstatename;
                        document.getElementById('spnfromgstn').innerHTML = ReturnStocDetails[0].fromgstin;
                        document.getElementById('spncompanyname').innerHTML = ReturnStocDetails[0].Title;
                        document.getElementById('spnfromaddress').innerHTML = ReturnStocDetails[0].address;
                        document.getElementById('spnAddress').innerHTML = ReturnStocDetails[0].address;
                        document.getElementById('spn_toaddress').innerHTML = ReturnStocDetails[0].AgentAddress;
                        document.getElementById('spnfromname').innerHTML = ReturnStocDetails[0].Title;
                        document.getElementById('lblpartyname').innerHTML = ReturnStocDetails[0].AgentName;
                        document.getElementById('lbl_companymobno').innerHTML = ReturnStocDetails[0].companyphone;
                        document.getElementById('lbl_companyemail').innerHTML = ReturnStocDetails[0].companyemail;
                        document.getElementById('lbl_fromstate_code').innerHTML = ReturnStocDetails[0].fromstatecode;
                        document.getElementById('lbl_fromstate').innerHTML = ReturnStocDetails[0].fromstatename;
                        document.getElementById('lblsignname').innerHTML = ReturnStocDetails[0].Title;
                        document.getElementById('lblassigndate').innerHTML = ReturnStocDetails[0].ReturnDate;
                        document.getElementById('lblRefdcno').innerHTML = ReturnStocDetails[0].sno;
                        fill_Sub_ReturnStock_Report_details(ReturnStockSubDetails);
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
        function fill_Sub_ReturnStock_Report_details(msg) {
            var tot_qty = 0;var tot_supplyqty = 0;
            var results = '<div  style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" border="2" style="width:100%;" id="tbl_return_print">';
            results += '<thead><tr><th scope="col">Sno</th><th scope="col">Product Name</th><th scope="col">Quantity</th><th scope="col">SupplyQty</th></tr></thead></tbody>';
            var j = 1;
            $('#Button2').css('display', 'block');
            for (var i = 0; i < msg.length; i++) {
                var qty = 0; var Amount = 0; var tax = 0;
                qty = parseFloat(msg[i].qty);
//                price = parseFloat(msg[i].rate).toFixed(2);
//                Amount = qty * price;
                results += '<tr><th scope="row" class="1">' + j + '</th>';
                results += '<td data-title="brandstatus" style = "font-size: 12px;text-align:center;" class="2">' + msg[i].productname + '</td>';
                results += '<td data-title="brandstatus" style = "font-size: 12px;text-align:center;" class="2">' + qty + '</td>';
                results += '<td data-title="brandstatus" style = "font-size: 12px;text-align:center;" class="qtycls">' + msg[i].supplyqty + '</td></tr>';
                j++;
                tot_qty += qty;
                tot_supplyqty += parseFloat(msg[i].supplyqty);
            }
            var tot = "";
            var tqty = "Total"
            results += '<tr><th scope="row" class="1"></th>';
            results += '<td data-title="brandstatus" style = "font-size: 12px;text-align:center;" class="2">' + tqty + '</td>';
            results += '<td data-title="brandstatus" style = "font-size: 12px;text-align:center;" class="2">' + parseFloat(tot_qty).toFixed(2) + '</td>';
            results += '<td data-title="brandstatus" style = "font-size: 12px;text-align:center;"  class="3">' + parseFloat(tot_supplyqty).toFixed(2) + '</td></tr>';
            results += '</table></div>';
            $("#div_products").html(results);
        }
        var a = ['', 'one ', 'two ', 'three ', 'four ', 'five ', 'six ', 'seven ', 'eight ', 'nine ', 'ten ', 'eleven ', 'twelve ', 'thirteen ', 'fourteen ', 'fifteen ', 'sixteen ', 'seventeen ', 'eighteen ', 'nineteen '];
        var b = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];
        function inWords(num) {
            if ((num = num.toString()).length > 9) return 'overflow';
            n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
            if (!n) return; var str = '';
            str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'crore ' : '';
            str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'lakh ' : '';ssss
            str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'thousand ' : '';
            str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'hundred ' : '';
            str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'only ' : '';
            return str;
        }
    </script>   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
        <h1>
            Return Stock Report<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Reports</a></li>
            <li><a href="#">Return Stock Report</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Return Stock Report
                </h3>
            </div>
            <div class="box-body">
                <div runat="server" id="d">
                    <table>
                        <tr>
                            <td>
                                <label>
                                    From Date:</label>
                            </td>
                            <td>
                                <input type="date" id="txtfromdate" class="form-control" />
                            </td>
                            <td>
                                <label>
                                    To Date:</label>
                            </td>
                            <td>
                                <input type="date" id="txttodate" class="form-control" />
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td>
                             <button type="button" class="btn btn-primary" style="margin-right: 5px;" onclick="get_return_stock_Report_details()"><i class="fa fa-refresh"></i> Get DC Details </button>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <div id="divPOdata" style="height: 300px; overflow-y: scroll;">
                    </div>
                    <br />
                </div>
                <div>
                </div>
              <div id="divPrint" class="watermark">
              <div class="content">
                <p id="bg-text" style="opacity: 0.1; width: 85%; position: absolute; padding: 12% 8% 8%;"><image width="100%;" src="Images/Vyshnavilogo.png"></image> </p>
                <div style="border: 2px solid gray;" class="col-md-12">
                    <div style="width: 17%; float: right;padding-top: 12px;">
                        <img src="Images/Vyshnavilogo.png" alt=BMG width="100px" height="72px" />
                        <br />
                    </div>
                    <div style="border: 1px solid gray;">
                        <div style="font-family: Arial; font-size: 20pt; font-weight: bold; color: Black; text-align:center;">
                            <span id="spncompanyname" style="font-size: 20px;"></span>
                            <br />
                        </div>
                        <div style="width:73%; padding-left:12%; text-align:center;">
                        <span id="spnAddress" style="font-size: 11px;font-weight: bold;"></span>
                        <br />
                       <span id="Span1" style="font-size: 11px;font-weight: bold;"> Website: www.vyshnavi.in</span>
                        <br />
                        </div>

                          <div style="width:73%; padding-left:31%;display:none;">
                        <label style="font-size: 12px;font-weight: bold !important;">   GSTIN.</label> <span id="lblgstin" style="font-size: 12px;"></span>
                        </div>
                         <div style="width:73%;padding-left:27%;">
                         <br />
                          <div style="display:none;">
                          <label style="font-size: 12px;"> State Name.</label> <span id="lbl_fromstate" style="font-size: 12px;"></span>
                          <label style="font-size: 12px;"> State Code.</label> <span id="lbl_fromstate_code" style="font-size: 12px;"></span>
                          </div>
                        </div>
                    </div>
                    <div align="center" style="border-bottom: 2px solid gray; border-top: 1px solid gray;background: antiquewhite;">
                        <span style="font-size: 18px; font-weight: bold;padding-left: 4%;" id="lbldcType">ReturnStock</span>
                    </div>
                    <div style="width: 100%;">
                      <div style="width: 100%;">
                       
                            <table style="width: 100%;">
                            <tr>
                            <td style="width: 60%;border: 2px solid gray;padding-left: 2%;">
                             <label style="font-size: 14px;font-weight: bold;">
                                         From </label>
                                        <br />
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                        Name :</label>
                                    <span id="spnfromname" style="font-size: 11px;"></span>
                                    <br />
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                        Address :</label>
                                    <span id="spnfromaddress" style="font-size: 11px;"></span>
                                    <br />
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                         GSTIN :</label>
                                    <span id="spnfromgstn" style="font-size: 11px;font-weight: bold !important;"></span>
                                    <br />
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                        Telephone no :</label>
                                    <span id="lbl_companymobno" style="font-size: 11px;"></span>
                                     &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                        Email Id :</label>
                                    <span id="lbl_companyemail" style="font-size: 11px;"></span>
                                    <br />
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                        State Name :</label>
                                    <span id="spnfromstate" style="font-size: 11px;"></span>
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                       State Code :</label>
                                    <span id="spnfromstatecode" style="font-size: 11px;"></span>
                                    <br />
                                </td>
                                <td style="width: 39%;border: 2px solid gray;padding-left: 2%;">
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                        Ref NO :</label>
                                    <span id="lblRefdcno" style="font-size: 11px;"></span>
                                    <br />
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                         Date :</label>
                                    <span id="lblassigndate" style="font-size: 11px;"></span>
                                    <br />
                                 
                                </td>
                               
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 60%;border: 2px solid gray;padding-left: 2%;">
                                  <label style="font-size: 14px;font-weight: bold;">
                                        Bill To </label>
                                        <br />
                                <label style="font-size: 12px;font-weight: bold !important;">
                                        Name :</label>
                                    <span id="lblpartyname" style="font-size: 11px;"></span>
                                    <input type="hidden" id="hdnDespsno"/>
                                    <br />
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                        Address :</label>
                                    <span id="spn_toaddress" style="font-size: 11px;"></span>
                                    <br />
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                        Telephone no :</label>
                                    <span id="lblvendorphoneno" style="font-size: 11px;"></span>
                                     &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    <label style="font-size: 12px;font-weight: bold !important;">
                                        Email Id :</label>
                                    <span id="lblvendoremail" style="font-size: 11px;"></span>
                                    <br />
                                     <label style="font-size: 12px;font-weight: bold !important;">
                                        State Name :</label>
                                    <span id="lbl_tostate" style="font-size: 11px;"></span>
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                </td>
                                 <td style="width: 39%;border: 2px solid gray;padding-left: 2%;padding-bottom: 5%;">
                                </td>
                                
                            </tr>
                        </table>
                    </div>
                      <div style="font-family: Arial; font-weight: bold; color: Black; text-align:center; border:2px solid gray;">
                      <br />
                      </div>
                           <div id="div_products" >
                    </div>
                    <br />

                     <br />
                                    <table style="width: 100%;">
                                    <tr> 
                                     <td  colspan="3"></td>
                                       <td style="width: 50%;" >
                                            For <span id="lblsignname" style="font-weight: bold; font-size: 11px;"></span>
                                       <br />
                                       <br />
                                       <br />
                                       </td>
                                    </tr>
                                        <tr>
                                            <td style="width: 20%;">
                                                <span style="font-weight: bold; font-size: 12px;">RECEIVER'S SIGNATURE</span>
                                            </td>
                                            <td style="width: 15%;">
                                                <span style="font-weight: bold; font-size: 12px;">SECURITY</span>
                                            </td>
                                            <td style="width: 25%;">
                                                <span id="lbldispat" style="font-weight: bold; font-size: 12px;"></span>
                                            </td>
                                            <td style="width: 50%;">
                                                <span style="font-weight: bold; font-size: 12px;">AUTHORISED SIGNATURE</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <br />
                                    <div>
                        <span style="font-weight: bold; font-size: 13px;">Decleration:</span>
                        <br />
                                    <span style="font-size: 11px;">We declare that this invioce shows the actual price of the goods decribe and that all particulars are ture and correct</span>
                                    <br />
                                    </div>

                        </div>
                        </div>
                        </div>
                        </div>

                             <button type="button" class="btn btn-primary" style="margin-right: 5px;" onclick="javascript:CallPrint('divPrint');"><i class="fa fa-print"></i> Print </button>

                        </div>
                        </div>
                        </section>
</asp:Content>


