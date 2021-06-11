<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Print_freezer_Report.aspx.cs" Inherits="Print_freezer_Report" %>

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

        function CallPrint(strid) {
            var divToPrint = document.getElementById(strid);
            var newWin = window.open('', 'Print-Window', 'width=400,height=400,top=100,left=100');
            newWin.document.open();
            newWin.document.write('<html><body   onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
            newWin.document.close();
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
        function btnFreezer_issue_details_click() {
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
            var data = { 'operation': 'get_FreezarIssue_details' };
            var s = function (msg) {
                if (msg) {
                    BindFreezerDetails(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function BindFreezerDetails(msg) {
            var COLORUE = ["AntiqueWhite", "#b3ffe6", "#daffff", "MistyRose", "Bisque"];
            var k = 0;
            var results = '<div class="divcontainer" style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr><th scope="col"></th><th scope="col">Receiver Name</th><th scope="col">Total Amount</th><th scope="col">Install Amount</th><th scope="col">Freezer Type</th><th scope="col">Issue Date</th></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr style="background-color:' + COLORUE[k] + '"><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-primary" value="Print" /></td>';
                results += '<th scope="row" class="2" >' + msg[i].ReceiverName + '</th>';
                results += '<th scope="row" class="2" >' + msg[i].TotalAmount + '</th>';
                results += '<th scope="row" class="2" >' + msg[i].InstallmentAmount + '</th>';
                results += '<th scope="row" class="2" >' + msg[i].freezer_type + '</th>';
                results += '<th scope="row" class="6" >' + msg[i].sno + '</th>';
                results += '<th scope="row" class="2" >' + msg[i].issue_date + '</th></tr>';
                k = k + 1;
                if (k == 4) {
                    k = 0;
                }
            }
            results += '</table></div>';
            $("#div_FreezarData").html(results);
        }
        function getme(thisid) {
            var sno = $(thisid).parent().parent().children('.6').html();
            var data = { 'operation': 'get_printFreezer_Report', 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        $('#div_Print').css('display', 'block');
                        document.getElementById('spnaddress_agentname').innerHTML = msg[0].ReceiverName;
                        document.getElementById('spn_liters').innerHTML = msg[0].freezer_type;
                        document.getElementById('spn_machineno').innerHTML = msg[0].MachineNo;
                        document.getElementById('spn_svdsassetno').innerHTML = msg[0].AssetNo;

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

       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
        <h1>
            Freezer's Report<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Freezer Details</a></li>
            <li><a href="#">Freezer's Report</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Freezer's Report
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
                                <input id="btn_save" type="button" class="btn btn-primary" name="submit" value='Get Details'
                                    onclick="btnFreezer_issue_details_click()" />
                            </td>
                        </tr>
                    </table>
                    <div id="div_FreezarData">
                    </div>
                </div>
                <div>
                    <table>
                        <tr>
                            <td style="width: 5px;">
                            </td>
                        </tr>
                        <tr hidden>
                            <td>
                                <label id="lbl_sno">
                                </label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="div_Print" style="display: none;">
                    <div id="divPrint" onclick="getme(thisid);">
                        <div style="width: 13%; float: left;">
                            <img src="Images/Vyshnavilogo.png" alt=BMG width="100px" height="72px" />
                            <br />
                        </div>
                        <div style="border-bottom: 1px solid gray; font-size: 15pt; font-weight: bold; color: Black;">
                            <div align="center" style="border-bottom: 1px solid gray; font-size: 20pt; font-weight: bold;
                                color: Black;">
                                <span>BMG Milk Dairy Farm </span>
                                <br />
                            </div>
                            <div align="right" style="border-bottom: 1px solid gray; font-size: 13pt; color: Black;">
                                PLACE:<br />
                                DATE:
                                <br />
                            </div>
                            <p>
                                AGREEMENT FOR USE OF DEEP FREEZER OWNED BY BMG Milk Dairy Farm SPECIALITIES PVT LTD.
                            </p>
                        </div>
                        <div>
                            <p>
                                THIS AGREEMENT made and entered in to this &#8230;&#8230; day of December,2015,between
                                BMG Milk Dairy Farm SPECIALITIES PVT LTD,a Company Incorporated and Registered under
                                the provisions of the Companies Act,1956,having its Registered Office at :VYSHNAVI
                                HOUSE,1st Floor,No:25,2nd Street,Periyar Nagar,TNHB Colony, Korattur - 600080,represented
                                by its Directors and authorized signatory hereinafter referred to as &#8220;SVDSPL&#8221;
                                which expression shall mean and includes its authorized representatives, legal attorney
                                and assigns of &#8220;ONE PART&#8221;
                            </p>
                            <br />
                            AND
                            <br />
                            <p>
                                M/s / Mr <strong><span id="spnaddress_agentname"></span></strong> Mr <strong><span
                                    id="spnadd_empcode"></span></strong>Age<span id="spn_age"></span> Pan no<span id="spn_panno1"></span>a
                                Company/Proprietor/Partner, having its registered office/residence at<span id="spn_company"></span>represented
                                through its Director / Proprietor / Partner, herein after referred to as &#8220;Dealer&#8221;
                                which expression shall mean and include its representative and assigns of &#8220;the
                                OTHER PART&#8221;
                            </p>
                            <p>
                                Mr<span id="spn_agentname"></span>S/o<span id="spn_so"></span>aged<span id="spn_aged"></span>
                                residing at <span id="spn_residingat"></span>,representing on behalf of dealer herein
                                after referred to as &#8220;Guarantor&#8221; for Dealer,
                            </p>
                        </div>
                        <div style="font-size: 15pt; font-weight: bold;">
                            <p>
                                NOW IT IS AGREED BY AND BETWEEN HERE TO AS FOLLOWS:
                            </p>
                        </div>
                        <div>
                            <p>
                                1. That this agreement dated <span class="datecls" id="spn_agreementdt"></span>day
                                of <span id="spn_day"></span>2015, executed between SVDSPL, Dealer and Guarantor
                                and Dealer agreed to sell the &#8220;VYSHNAVI&#8221; Brand Milk & Milk Products
                                marketed by SVDSPL.
                            </p>
                            <p>
                                2. That in order to store Milk at a required temperature stipulatedas per milk statutory
                                to preserve the quality standard and taste, Dealer has requested SVDSPL, to provide
                                Deep Freezer repayable by the Dealer to SVDSPL in equated monthlyincentive payable
                                adjustment towards the total cost of deep freezer.
                            </p>
                            <p>
                                3. SVDSPL has agreed to provide a Deep Freezer to the Dealer, as per the Dealer&#8217;s
                                request, by recovering the total cost of Deep freezer in equated monthly incentive
                                payable adjustment detailed in the schedule. with the conditions set herein to be
                                installed and commissioned at the Dealer premises.
                            </p>
                            <p>
                                4. The time duration from the date of installation of Deep freezer at Dealer premises
                                to till the final payment obtained by SVDSPL, in respect of the total Value of the
                                deep freezer, herein after referred to as &#8220;LOCK IN PERIOD&#8221;.
                            </p>
                            <p>
                                5. The SVDSPL being the sole owner has provided Deep Freezer having the Specification
                                & Locations given here under to stock and store the VYSHNAVI range of Milk and Milk
                                Products exclusively, which is hereby acknowledged by Dealer,admits for possession
                                in his premises.
                            </p>
                            <div class="table table-bordered table-hover dataTable no-footer">
                                <table>
                                    <tr>
                                        <td>
                                            <label style="border-bottom: 1px solid gray;">
                                                A) Specification:
                                            </label>
                                            <strong><span id="spn_capa"></span></strong>
                                            <br />
                                            <label>
                                                Capacity:
                                            </label>
                                            <strong><span id="spn_liters"></span></strong>
                                            <br />
                                            <label>
                                                Machine Sl NO:
                                            </label>
                                            <strong><span id="spn_machineno"></span></strong>
                                            <br />
                                            <label>
                                                SVDSPL Asset No:
                                            </label>
                                            <strong><span id="spn_svdsassetno"></span></strong>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <p>
                                6. Dealer will provide adequate frontage neat clean and hygienic space for Deep
                                freezer and will also ensure proper electric power connections installations in
                                order to operate the deep freezer for 24 hours in normal conditions. The expenses
                                as regard the consumption of electricity power connection will be borne by the dealer
                            </p>
                            <p>
                                7. The Dealer agrees to return the Deep freezer to SVDSPL during the lock in period
                                and as when the SVDSPL so directs to return the same in proper working condition,
                            </p>
                            <p>
                                8. The SVDSPL reserves the right to take back the deep freezer upon termination
                                of Dealership without assigning any other reasons what so ever and Dealer will not
                                interfere in any manner whatsoever.SVDSPL reserves its absolute right to enter into
                                the premises of dealer for taking back deep freezer.
                            </p>
                            <p>
                                9. The Dealer shall isolate the deep freezer from any other capital equipment which
                                may pose short circuit while installing or while on usage of the same in his premises.
                                Any electrical short circuit which hampers the function of the Deep freezer what
                                so ever shall be rectified by the Dealer.
                            </p>
                            <p>
                                10. The Deep freezer under possession duly acknowledged here with the dealer which
                                is not functioning either by Dealer negligence, tamper or short circuit or improper
                                care by the Dealer, the dealer is still liable to pay the equated monthly incentive
                                payable adjustment to SVDSPL towards its total cost as per the conditions stipulated
                                here in this agreement.
                            </p>
                            <p>
                                11. The Dealer shall bear the total cost of maintenance charges / AMC charges as
                                per the procedure after the warranty period. However the maintenance of Deep freezer
                                shall be done by the manufacturer during warranty period which is normally of 1
                                ( one ) year.
                            </p>
                            <p>
                                12. The SVDSPL shall paint the deep freezer with &#8220;VYSHNAVI&#8221; Logo and
                                the Dealer will provide space for painting and other advertisement material.The
                                expenditure of such advertisement and painting at Dealer premises will be at the
                                sole discretion of SVDSPL,depending on the factor of SOPD(Sales Output Per Dealer)
                                basis.
                            </p>
                            <p>
                                13. Dealer shall store only the &#8220;VYSHNAVI&#8221; products of the SVDSPL as
                                agreed.
                            </p>
                            <p>
                                14. In the event of Dealers non compliance or violation of any nature with regard
                                to payment of equated monthly recoverable payment to SVDSPL,the guarantor has to
                                either recover the Deep freezer total cost from Dealer or take back deep freezer
                                or compensate total cost to SVDSPL,
                            </p>
                            <p>
                                15. SVDSPL upon completion of recovery of total cost of Deep freezer from Dealer
                                shall issue clearance letter to the Dealer by removing from their asset list and
                                transfer ownership on Dealers Name.
                            </p>
                            <p>
                                15. For the purpose of this agreement the court of Chennai only will have jurisdiction.
                            </p>
                            <div style="border-bottom: 1px solid gray;">
                                SCHEDULE
                            </div>
                            <div>
                                <table border="2" style="width: 100%;">
                                    <tr>
                                        <td style="width: 50%; float: left;">
                                            <label>
                                                Dealer Name:
                                            </label>
                                        </td>
                                        <td style="width: 50%; float: right;">
                                            <span id="spn_dealerrname"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50%; float: left;">
                                            <label>
                                                Dealer PAN No:
                                            </label>
                                        </td>
                                        <td style="width: 50%; float: right;">
                                            <span id="spn_panno"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50%; float: left;">
                                            <label>
                                                Dealer Address
                                            </label>
                                        </td>
                                        <td style="width: 50%; float: right;">
                                            <span id="spn_dealeradd"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50%; float: left;">
                                            <label>
                                                Deep Freezer Asset Code as per SVDSPL / Warranty Period
                                            </label>
                                        </td>
                                        <td style="width: 50%; float: right;">
                                            <span id="spn_warrentyperiod"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50%; float: left;">
                                            <label>
                                                Date of Installation of Deep Freezer
                                            </label>
                                        </td>
                                        <td style="width: 50%; float: right;">
                                            <span id="spn_dtinstallation"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50%; float: left;">
                                            <label>
                                                Total Value of Deep Freezer
                                            </label>
                                        </td>
                                        <td style="width: 50%; float: right;">
                                            <span id="spn_ttlvalue"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50%; float: left;">
                                            <label>
                                                Equated Monthly incentive Payable adjustment &#8211; Start Date
                                            </label>
                                        </td>
                                        <td style="width: 50%; float: right;">
                                            <span class="datecls" id="spn_incentive"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50%; float: left;">
                                            <label>
                                                Close Date of Recovery of Total value of Deep freezer
                                            </label>
                                        </td>
                                        <td style="width: 50%; float: right;">
                                            <span class="datecls" id="spn_closedt"></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div>
                                <p>
                                <br />
                                <br />
                                    IN WITNESS WHERE OF THE PARTIES HERE TO HAVE EXECUTED THIS AGREEMENT ON THE DAY
                                    AND YEAR FIRST WRITTEN ABOVE.
                                <br />
                                </p>
                            </div>
                        </div>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 25%;">
                                    <span style="font-weight: bold; font-size: 12px;">SIGNATURE for and on behalf of SVDSPL
                                        by:</span>
                                    <br />
                                    <br />
                                <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 25%;">
                                    <span style="font-weight: bold; font-size: 12px;">Authorized Representative</span>
                                    <br />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 25%;">
                                    <span style="font-weight: bold; font-size: 12px;">SIGNED by the Dealer </span>
                                    <br />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 25%;">
                                    <span style="font-weight: bold; font-size: 12px;">SIGNED by the Guarantor </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <button type="button" class="btn btn-primary" style="margin-right: 5px;" onclick="javascript:CallPrint('divPrint');">
                        <i class="fa fa-print"></i>Print
                    </button>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
