<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Cashexchange.aspx.cs" Inherits="Cashexchange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="js/jquery-1.4.4.js" type="text/javascript"></script>
    <script src="Js/JTemplate.js?v=3000" type="text/javascript"></script>
    <script src="Js/jquery.blockUI.js?v=3005" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="Css/VyshnaviStyles.css" />
    <script src="js/jquery.json-2.4.js" type="text/javascript"></script>
    <script src="src/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <link href="js/DateStyles.css?v=3003" rel="stylesheet" type="text/css" />
    <script src="js/1.8.6.jquery.ui.min.js" type="text/javascript"></script>
    <style type="text/css">
        .ddlsize
        {
            width: 196px;
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
    </style>
    <script type="text/javascript">
    function ColCountChange(count) {
        var TotalCash = 0;
        var Total = 0;
        if (count.value == "") {
            $(count).closest("tr").find(".TotalClass").text(Total);
            $('.TotalClass').each(function (i, obj) {
                var Amount = $(this).text();
                if (Amount == "") {
                    Amount = 0.0;
                }
                TotalCash += parseFloat(Amount);
            });
            document.getElementById('txtAmont').innerHTML = parseFloat(TotalCash).toFixed(2);
            var Amount = document.getElementById('txtAmont').innerHTML;
            var ReturnAmount = document.getElementById('txtreturnAmount').innerHTML;
            var Total = parseFloat(Amount) - parseFloat(ReturnAmount);
            document.getElementById('txtCTotAmount').innerHTML = Total;
            return false;
        }
        else {
            var Cash = $(count).closest("tr").find(".CashClass").text();
            Total = parseFloat(count.value) * parseFloat(Cash);
            $(count).closest("tr").find(".TotalClass").text(Total);
            $('.TotalClass').each(function (i, obj) {
                var Amount = $(this).text();
                if (Amount == "") {
                    Amount = 0.0;
                }
                TotalCash += parseFloat(Amount);
            });
            document.getElementById('txtAmont').innerHTML = parseFloat(TotalCash).toFixed(2);
            var Amount = document.getElementById('txtAmont').innerHTML;
            var ReturnAmount = document.getElementById('txtreturnAmount').innerHTML;
            var Total = parseFloat(Amount) - parseFloat(ReturnAmount);
            document.getElementById('txtCTotAmount').innerHTML = Total;
        }
    }

    function ReturnCountChange(count) {
        var TotalCash = 0;
        var Total = 0;
        if (count.value == "") {
            $(count).closest("tr").find(".ReturnAmountClass").text(Total);
            $('.ReturnAmountClass').each(function (i, obj) {
                var Amount = $(this).text();
                if (Amount == "") {
                    Amount = 0.0;
                }
                TotalCash += parseFloat(Amount);
            });
            document.getElementById('txtreturnAmount').innerHTML = parseFloat(TotalCash).toFixed(2);
            var Amount = document.getElementById('txtAmont').innerHTML;
            var ReturnAmount = document.getElementById('txtreturnAmount').innerHTML;
            var Total = parseFloat(Amount) - parseFloat(ReturnAmount);
            document.getElementById('txtCTotAmount').innerHTML = Total;
            return false;
        }
        else {
            var Cash = $(count).closest("tr").find(".CashClass").text();
            Total = parseFloat(count.value) * parseFloat(Cash);
            $(count).closest("tr").find(".ReturnAmountClass").text(Total);
            $('.ReturnAmountClass').each(function (i, obj) {
                var Amount = $(this).text();
                if (Amount == "") {
                    Amount = 0.0;
                }
                TotalCash += parseFloat(Amount);
            });
            document.getElementById('txtreturnAmount').innerHTML = parseFloat(TotalCash).toFixed(2);
            var Amount = document.getElementById('txtAmont').innerHTML;
            var ReturnAmount = document.getElementById('txtreturnAmount').innerHTML;
            var Total = parseFloat(Amount) - parseFloat(ReturnAmount);
            document.getElementById('txtCTotAmount').innerHTML = Total;
        }
    }
    function BtnCashexchangesaveClick() {
        var rowsdenominations = $("#tableCollectionDetails tr:gt(0)");
        var DenominationString = "";
        var ReturnDenominationString = "";
        $(rowsdenominations).each(function (i, obj) {
            if ($(this).closest("tr").find(".CashClass").text() == "") {
            }
            else {
                var str = $(this).closest("tr").find(".CashClass").text();
                DenominationString += str.trim() + 'x' + $(this).closest("tr").find(".AmountClass").val() + "+";
                ReturnDenominationString += str.trim() + 'x' + $(this).closest("tr").find(".RAmountClass").val() + "+";
            }
        });
        var txtAmount = document.getElementById('txtCTotAmount').innerHTML;
        if (txtAmount == 0) {
        }
        else {
            alert("Please fill denomination amount");
            return false;
        }
        var data = { 'operation': 'BtnCashexchangesaveClick', 'DenominationString': DenominationString, 'ReturnDenominationString': ReturnDenominationString };
        var s = function (msg) {
            if (msg) {
                alert(msg);
                Denominationzero();
            }
            else {
            }
        };
        var e = function (x, h, e) {
        };
        $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
        callHandler(data, s, e);
    }
    function Denominationzero() {
        var Total = 0;
        $('.qtyclass').val(Total);
        $('.TotalClass').text(Total);
        document.getElementById('txtAmont').innerHTML = Total;
        document.getElementById('txtreturnAmount').innerHTML = Total;
        document.getElementById('txtCTotAmount').innerHTML = Total;
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
            Cash Exchange<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Cash Exchange</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Cash Exchange Details
                </h3>
            </div>
            <div class="box-body">
                <table align="left" cellpadding="0" cellspacing="0" style="float: left; width: 100%;"
                    id="tableCollectionDetails" class="mainText2" border="1">
                    <thead>
                        <tr>
                            <td style="width: 25%; height: 20px; color: #2f3293; font-size: 18px; font-weight: bold;
                                text-align: center;">
                                Cash
                                <br />
                            </td>
                            <td style="width: 25%; text-align: center; height: 20px; font-size: 18px; font-weight: bold;
                                color: #2f3293;">
                                Received Amount
                                <br />
                            </td>
                            <td style="width: 25%; text-align: center; height: 20px; font-size: 18px; font-weight: bold;
                                color: #2f3293;">
                                Return Amount
                                <br />
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="tblrowcolor">
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span id="Span2" class="CashClass" style="font-size: 14px; color: Red; font-weight: bold;">
                                    2000</span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <b style="font-size: 11px; font-weight: bold;">X</b>
                                <input type="number" id="Number18" onkeyup="ColCountChange(this);" class="AmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Count" />
                                <input type="hidden" class="TotalClass" id="Hidden18" value="0" />
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <input type="number" id="Number19" onkeyup="ReturnCountChange(this);" class="RAmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Return" />
                                <input type="hidden" class="ReturnAmountClass" id="Hidden19" value="0" />
                            </td>
                        </tr>
                        <tr class="tblrowcolor">
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span id="Span16" class="CashClass" style="font-size: 14px; color: Red; font-weight: bold;">
                                    1000</span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <b style="font-size: 11px; font-weight: bold;">X</b>
                                <input type="number" id="Number8" onkeyup="ColCountChange(this);" class="AmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Count" />
                                <input type="hidden" class="TotalClass" id="hdnTotal" value="0" />
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <input type="number" id="Number9" onkeyup="ReturnCountChange(this);" class="RAmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Return" />
                                <input type="hidden" class="ReturnAmountClass" id="Hidden9" value="0" />
                            </td>
                        </tr>
                        <tr class="tblrowcolor">
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span id="txtsno" class="CashClass" style="font-size: 14px; color: Red; font-weight: bold;">
                                    <b>500</b></span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <b style="font-size: 11px; font-weight: bold;">X</b>
                                <input type="number" id="txtCount" onkeyup="ColCountChange(this);" class="AmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Count" />
                                <input type="hidden" class="TotalClass" id="Hidden1" value="0" />
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <input type="number" id="Number10" onkeyup="ReturnCountChange(this);" class="RAmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Return" />
                                <input type="hidden" class="ReturnAmountClass" id="Hidden10" value="0" />
                            </td>
                        </tr>
                        <tr class="tblrowcolor">
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span id="Span1" class="CashClass" style="font-size: 14px; color: Red; font-weight: bold;">
                                    <b>100</b></span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <b style="font-size: 11px; font-weight: bold;">X</b>
                                <input type="number" id="Number1" onkeyup="ColCountChange(this);" class="AmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Count" />
                                <input type="hidden" class="TotalClass" id="Hidden2" value="0" />
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <input type="number" id="Number11" onkeyup="ReturnCountChange(this);" class="RAmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Return" />
                                <input type="hidden" class="ReturnAmountClass" id="Hidden11" value="0" />
                            </td>
                        </tr>
                        <tr class="tblrowcolor">
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span id="Span4" class="CashClass" style="font-size: 14px; color: Red; font-weight: bold;">
                                    <b>50</b></span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <b style="font-size: 11px; font-weight: bold;">X</b>
                                <input type="number" id="Number2" onkeyup="ColCountChange(this);" class="AmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Count" />
                                <input type="hidden" class="TotalClass" id="Hidden3" value="0" />
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <input type="number" id="Number12" onkeyup="ReturnCountChange(this);" class="RAmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Return" />
                                <input type="hidden" class="ReturnAmountClass" id="Hidden12" value="0" />
                            </td>
                        </tr>
                        <tr class="tblrowcolor">
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span id="Span6" class="CashClass" style="font-size: 14px; color: Red; font-weight: bold;">
                                    <b>20</b></span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <b style="font-size: 11px; font-weight: bold;">X</b>
                                <input type="number" id="Number3" onkeyup="ColCountChange(this);" class="AmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Count" />
                                <input type="hidden" class="TotalClass" id="Hidden4" value="0" />
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <input type="number" id="Number13" onkeyup="ReturnCountChange(this);" class="RAmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Return" />
                                <input type="hidden" class="ReturnAmountClass" id="Hidden13" value="0" />
                            </td>
                        </tr>
                        <tr class="tblrowcolor">
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span id="Span8" class="CashClass" style="font-size: 14px; color: Red; font-weight: bold;">
                                    <b>10</b></span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <b style="font-size: 11px; font-weight: bold;">X</b>
                                <input type="number" id="Number4" onkeyup="ColCountChange(this);" class="AmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Count" />
                                <input type="hidden" class="TotalClass" id="Hidden5" value="0" />
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <input type="number" id="Number14" onkeyup="ReturnCountChange(this);" class="RAmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Return" />
                                <input type="hidden" class="ReturnAmountClass" id="Hidden14" value="0" />
                            </td>
                        </tr>
                        <tr class="tblrowcolor">
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span id="Span10" class="CashClass" style="font-size: 14px; color: Red; font-weight: bold;">
                                    <b>5</b></span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <b style="font-size: 11px; font-weight: bold;">X</b>
                                <input type="number" id="Number5" onkeyup="ColCountChange(this);" class="AmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Count" />
                                <input type="hidden" class="TotalClass" id="Hidden6" value="0" />
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <input type="number" id="Number15" onkeyup="ReturnCountChange(this);" class="RAmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Return" />
                                <input type="hidden" class="ReturnAmountClass" id="Hidden15" value="0" />
                            </td>
                        </tr>
                        <tr class="tblrowcolor">
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span id="Span12" class="CashClass" style="font-size: 14px; color: Red; font-weight: bold;">
                                    <b>2</b></span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <b style="font-size: 11px; font-weight: bold;">X</b>
                                <input type="number" id="Number6" onkeyup="ColCountChange(this);" class="AmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Count" />
                                <input type="hidden" class="TotalClass" id="Hidden7" value="0" />
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <input type="number" id="Number16" onkeyup="ReturnCountChange(this);" class="RAmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Return" />
                                <input type="hidden" class="ReturnAmountClass" id="Hidden16" value="0" />
                            </td>
                        </tr>
                        <tr class="tblrowcolor">
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span id="Span14" class="CashClass" style="font-size: 14px; color: Red; font-weight: bold;">
                                    <b>1</b></span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <b style="font-size: 11px; font-weight: bold;">X</b>
                                <input type="number" id="Number7" onkeyup="ColCountChange(this);" class="AmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Count" />
                                <input type="hidden" class="TotalClass" id="Hidden8" value="0" />
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: middle; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <input type="number" id="Number17" onkeyup="ReturnCountChange(this);" class="RAmountClass"
                                    onkeypress="return numberOnlyExample();" style="width: 80%; height: 24px; border: 1px solid gray;
                                    border-radius: 6px 6px 6px 6px;" placeholder="Enter Return" />
                                <input type="hidden" class="ReturnAmountClass" id="Hidden17" value="0" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%; height: 30px; vertical-align: middle; text-align: center;
                                color: Gray;">
                                <span style="font-size: 18px; color: Blue;">Total:</span>
                            </td>
                            <td style="width: 20%; height: 30px; vertical-align: top; font-size: 12px; font-weight: 500;
                                text-align: center; padding: 0px 0px 0px 3px">
                                <span style="font-size: 16px; color: Red; font-weight: bold;" id="txtAmont">0</span>
                            </td>
                            <td style="width: 20%; height: 30px; font-size: 11px; vertical-align: middle; text-align: center;
                                color: Gray;" align="center">
                                <span style="font-size: 16px; color: Red; font-weight: bold;" id="txtreturnAmount">0</span>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%; height: 30px; vertical-align: middle; text-align: center;
                                color: Gray;">
                                <span style="font-size: 18px; color: Blue;">Total Amount:</span>
                            </td>
                            <td style="width: 20%; height: 30px; font-size: 11px; vertical-align: middle; text-align: center;
                                color: Gray;" align="center" colspan="2">
                                <span id="txtCTotAmount" style="font-size: 16px; color: Red; font-weight: bold;">0
                                </span>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table align="center">
                    <tr>
                        <td>
                        </td>
                        <td style="height: 40px;">
                            <input type="button" id="btnSave" value="Save" class="btn btn-primary" onclick="BtnCashexchangesaveClick();" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </section>
</asp:Content>
