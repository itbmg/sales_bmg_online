using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using ClosedXML.Excel;
using System.IO;
using System.Data.SqlClient;
public partial class SapPayments : System.Web.UI.Page
{
    MySqlCommand cmd;
    string UserName = "";
    VehicleDBMgr vdm;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["salestype"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        //UserName = Session["field1"].ToString();
        //vdm = new VehicleDBMgr();
        if (!this.IsPostBack)
        {
            if (!Page.IsCallback)
            {
                txtFromdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                lblTitle.Text = Session["TitleName"].ToString();
                FillRouteName();
            }
        }


    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GetReport();
    }
    void FillRouteName()
    {
        vdm = new VehicleDBMgr();
        if (Session["salestype"].ToString() == "Plant")
        {
            PBranch.Visible = true;
            DataTable dtBranch = new DataTable();
            dtBranch.Columns.Add("BranchName");
            dtBranch.Columns.Add("sno");
            cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType) or (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType1) ");
            cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
            cmd.Parameters.AddWithValue("@SalesType", "21");
            cmd.Parameters.AddWithValue("@SalesType1", "26");
            DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dtRoutedata.Rows)
            {
                DataRow newrow = dtBranch.NewRow();
                newrow["BranchName"] = dr["BranchName"].ToString();
                newrow["sno"] = dr["sno"].ToString();
                dtBranch.Rows.Add(newrow);
            }
            cmd = new MySqlCommand("SELECT BranchName, sno FROM  branchdata WHERE (sno = @BranchID)");
            cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
            DataTable dtPlant = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dtPlant.Rows)
            {
                DataRow newrow = dtBranch.NewRow();
                newrow["BranchName"] = dr["BranchName"].ToString();
                newrow["sno"] = dr["sno"].ToString();
                dtBranch.Rows.Add(newrow);
            }
            ddlSalesOffice.DataSource = dtBranch;
            ddlSalesOffice.DataTextField = "BranchName";
            ddlSalesOffice.DataValueField = "sno";
            ddlSalesOffice.DataBind();
        }
        else
        {
            PBranch.Visible = true;
            cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM  branchdata INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE (branchdata_1.SalesOfficeID = @SOID) AND (branchdata.SalesType IS NOT NULL) OR (branchdata.sno = @BranchID) AND (branchdata.SalesType IS NOT NULL)");
            cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
            cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
            DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
            ddlSalesOffice.DataSource = dtRoutedata;
            ddlSalesOffice.DataTextField = "BranchName";
            ddlSalesOffice.DataValueField = "sno";
            ddlSalesOffice.DataBind();
        }
    }
    private DateTime GetLowDate(DateTime dt)
    {
        double Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        DT = dt;
        Hour = -dt.Hour;
        Min = -dt.Minute;
        Sec = -dt.Second;
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        return DT;
    }
    private DateTime GetHighDate(DateTime dt)
    {
        double Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        Hour = 23 - dt.Hour;
        Min = 59 - dt.Minute;
        Sec = 59 - dt.Second;
        DT = dt;
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        return DT;
    }
    DataTable dtReport = new DataTable();
    void GetReport()
    {
        try
        {
            lblmsg.Text = "";
            pnlHide.Visible = true;
            Session["RouteName"] = ddlSalesOffice.SelectedItem.Text;
            Session["IDate"] = DateTime.Now.AddDays(1).ToString("dd/MM/yyyy");
            vdm = new VehicleDBMgr();
            DateTime fromdate = DateTime.Now;
            string[] dateFromstrig = txtFromdate.Text.Split(' ');
            if (dateFromstrig.Length > 1)
            {
                if (dateFromstrig[0].Split('-').Length > 0)
                {
                    string[] dates = dateFromstrig[0].Split('-');
                    string[] times = dateFromstrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            DataTable Report = new DataTable();
            Report.Columns.Add("DOE");
            Report.Columns.Add("Ref Receipt");
            Report.Columns.Add("Receipt");
            Report.Columns.Add("Type");
            Report.Columns.Add("Name");
            Report.Columns.Add("Amount").DataType = typeof(Double);
            lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
            lblRoutName.Text = ddlSalesOffice.SelectedItem.Text;
            DateTime ReportDate = VehicleDBMgr.GetTime(vdm.conn);
            DateTime dtapril = new DateTime();
            DateTime dtmarch = new DateTime();
            int currentyear = ReportDate.Year;
            int nextyear = ReportDate.Year + 1;
            if (ReportDate.Month > 3)
            {
                string apr = "4/1/" + currentyear;
                dtapril = DateTime.Parse(apr);
                string march = "3/31/" + nextyear;
                dtmarch = DateTime.Parse(march);
            }
            if (ReportDate.Month <= 3)
            {
                string apr = "4/1/" + (currentyear - 1);
                dtapril = DateTime.Parse(apr);
                string march = "3/31/" + (nextyear - 1);
                dtmarch = DateTime.Parse(march);
            }
            Session["xporttype"] = "SapPayments";
            string ledger = ""; string whcode = "";
            string ladger_dr_code = "";
            cmd = new MySqlCommand("SELECT tbranchname, ladger_dr,whcode,ladger_dr_code FROM branchdata WHERE (sno = @BranchID)");
            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            DataTable dtledger = vdm.SelectQuery(cmd).Tables[0];
            if (dtledger.Rows.Count > 0)
            {
                ledger = dtledger.Rows[0]["ladger_dr"].ToString();
                whcode = dtledger.Rows[0]["whcode"].ToString();
                ladger_dr_code = dtledger.Rows[0]["ladger_dr_code"].ToString();
            }
            Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Sap Payments" + fromdate.ToString("dd/MM/yyyy");
            //cmd = new MySqlCommand("SELECT cashpayables.VocherID, cashpayables.Remarks,subpayable.sno, subpayable.Amount, accountheads.HeadName FROM cashpayables INNER JOIN subpayable ON cashpayables.Sno = subpayable.RefNo INNER JOIN accountheads ON subpayable.HeadSno = accountheads.Sno WHERE (cashpayables.BranchID = @BranchID) AND (cashpayables.DOE BETWEEN @d1 AND @d2) AND (cashpayables.VoucherType = 'Debit') AND (cashpayables.Status = 'P')");
            cmd = new MySqlCommand("SELECT  cashpayables.VocherID, cashpayables.Remarks, subpayable.sno, subpayable.Amount,accountheads.accountcode,subpayable.HeadSno, accountheads.HeadName, cashpayables.Approvedby, cashpayables.Status,empmanage.EmpName, cashpayables.VoucherType, cashpayables.DOE, empmanage_1.EmpName AS createdby, empmanage_1.Sno AS createemp,empmanage.Sno AS approvedemp FROM  cashpayables INNER JOIN subpayable ON cashpayables.Sno = subpayable.RefNo INNER JOIN accountheads ON subpayable.HeadSno = accountheads.Sno INNER JOIN empmanage ON cashpayables.Approvedby = empmanage.Sno INNER JOIN empmanage empmanage_1 ON cashpayables.Created_by = empmanage_1.Sno WHERE (cashpayables.BranchID = @BranchID) AND (cashpayables.DOE BETWEEN @d1 AND @d2) AND (cashpayables.VoucherType = 'Debit') AND (cashpayables.Status = 'P')");

            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            DataTable dtAgent = vdm.SelectQuery(cmd).Tables[0];
            if (dtAgent.Rows.Count > 0)
            {
                DataView view = new DataView(dtAgent);
                dtReport = new DataTable();
                dtReport.Columns.Add("Sno");
                dtReport.Columns.Add("Voucher Date");
                dtReport.Columns.Add("Voucher No");
                dtReport.Columns.Add("Voucher Type");
                dtReport.Columns.Add("whcode");
                Report.Columns.Add("Series");
                dtReport.Columns.Add("CreatedBy");
                dtReport.Columns.Add("ApprovedBy");
                dtReport.Columns.Add("Credit Code");
                dtReport.Columns.Add("Ledger (Cr)");
                dtReport.Columns.Add("Debit Code");
                dtReport.Columns.Add("Ledger (Dr)");
                dtReport.Columns.Add("Amount");
                dtReport.Columns.Add("Narration");
                //DataTable distincttable = view.ToTable(true, "BranchName", "BSno");
                int i = 1;


                foreach (DataRow branch in dtAgent.Rows)
                {
                    string VoucherNo = "";
                    cmd = new MySqlCommand("SELECT  vouchercode,RefNo, HeadDesc, Amount, HeadSno, sno, branchid, paiddate FROM subpayable  WHERE (branchid = @BranchID) AND (paiddate BETWEEN @d1 AND @d2)");
                    cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                    cmd.Parameters.AddWithValue("@d2", GetLowDate(fromdate));
                    DataTable dtVoucher = vdm.SelectQuery(cmd).Tables[0];
                    if (dtVoucher.Rows.Count > 0)
                    {
                        DataRow[] drvoucher = dtVoucher.Select("branchid='" + ddlSalesOffice.SelectedValue + "' and sno='" + branch["sno"].ToString() + "' and HeadSno='" + branch["HeadSno"].ToString() + "'");
                        if (drvoucher.Length > 0)
                        {
                            foreach (DataRow drv in drvoucher)
                            {
                                VoucherNo = drv.ItemArray[0].ToString();
                            }
                        }
                        else
                        {
                            cmd = new MySqlCommand("SELECT IFNULL(MAX(vouchercode), 0) + 1 AS Sno FROM subpayable WHERE (branchid = @branchid)  AND (paiddate BETWEEN @d1 AND @d2)");
                            cmd.Parameters.AddWithValue("@branchid", ddlSalesOffice.SelectedValue);
                            cmd.Parameters.AddWithValue("@HeadSno", branch["HeadSno"].ToString());
                            cmd.Parameters.AddWithValue("@d1", GetLowDate(dtapril.AddDays(-1)));
                            cmd.Parameters.AddWithValue("@d2", GetHighDate(dtmarch.AddDays(-1)));
                            DataTable dtvoucherno = vdm.SelectQuery(cmd).Tables[0];
                            VoucherNo = dtvoucherno.Rows[0]["Sno"].ToString();
                            cmd = new MySqlCommand("update  subpayable set vouchercode=@vouchercode, paiddate=@paiddate,branchid=@branchid  where (sno=@sno) AND (HeadSno = @HeadSno)"); ;
                            cmd.Parameters.AddWithValue("@vouchercode", VoucherNo);
                            cmd.Parameters.AddWithValue("@paiddate", fromdate);
                            cmd.Parameters.AddWithValue("@branchid", ddlSalesOffice.SelectedValue);
                            cmd.Parameters.AddWithValue("@sno", branch["sno"].ToString());
                            cmd.Parameters.AddWithValue("@HeadSno", branch["HeadSno"].ToString());
                            vdm.Update(cmd);
                        }
                    }
                    else
                    {
                        cmd = new MySqlCommand("SELECT IFNULL(MAX(vouchercode), 0) + 1 AS Sno FROM subpayable WHERE (branchid = @branchid)  AND (paiddate BETWEEN @d1 AND @d2)");
                        cmd.Parameters.AddWithValue("@branchid", ddlSalesOffice.SelectedValue);
                        cmd.Parameters.AddWithValue("@HeadSno", branch["HeadSno"].ToString());
                        cmd.Parameters.AddWithValue("@d1", GetLowDate(dtapril.AddDays(-1)));
                        cmd.Parameters.AddWithValue("@d2", GetHighDate(dtmarch.AddDays(-1)));
                        DataTable dtvoucherno = vdm.SelectQuery(cmd).Tables[0];
                        VoucherNo = dtvoucherno.Rows[0]["Sno"].ToString();
                        cmd = new MySqlCommand("update  subpayable set vouchercode=@vouchercode, paiddate=@paiddate,branchid=@branchid  where  (sno=@sno) AND (HeadSno = @HeadSno)"); ;
                        cmd.Parameters.AddWithValue("@vouchercode", VoucherNo);
                        cmd.Parameters.AddWithValue("@paiddate", fromdate);
                        cmd.Parameters.AddWithValue("@branchid", ddlSalesOffice.SelectedValue);
                        cmd.Parameters.AddWithValue("@sno", branch["sno"].ToString());
                        cmd.Parameters.AddWithValue("@HeadSno", branch["HeadSno"].ToString());
                        vdm.Update(cmd);
                    }
                    if (VoucherNo == "0")
                    {
                        cmd = new MySqlCommand("SELECT IFNULL(MAX(vouchercode), 0) + 1 AS Sno FROM subpayable WHERE (branchid = @branchid)  AND (paiddate BETWEEN @d1 AND @d2)");
                        cmd.Parameters.AddWithValue("@branchid", ddlSalesOffice.SelectedValue);
                        cmd.Parameters.AddWithValue("@HeadSno", branch["HeadSno"].ToString());
                        cmd.Parameters.AddWithValue("@d1", GetLowDate(dtapril.AddDays(-1)));
                        cmd.Parameters.AddWithValue("@d2", GetHighDate(dtmarch.AddDays(-1)));
                        DataTable dtvoucherno = vdm.SelectQuery(cmd).Tables[0];
                        VoucherNo = dtvoucherno.Rows[0]["Sno"].ToString();
                        cmd = new MySqlCommand("update  subpayable set vouchercode=@vouchercode, paiddate=@paiddate,branchid=@branchid  where  (RefNo=@RefNo) AND (HeadSno = @HeadSno)"); ;
                        cmd.Parameters.AddWithValue("@vouchercode", VoucherNo);
                        cmd.Parameters.AddWithValue("@paiddate", fromdate);
                        cmd.Parameters.AddWithValue("@branchid", ddlSalesOffice.SelectedValue);
                        cmd.Parameters.AddWithValue("@RefNo", branch["sno"].ToString());
                        cmd.Parameters.AddWithValue("@HeadSno", branch["HeadSno"].ToString());
                        vdm.Update(cmd);
                    }
                    string NewVoucherNo = "0";
                    int countdc = 0;
                    int.TryParse(VoucherNo, out countdc);
                    if (countdc <= 10)
                    {
                        NewVoucherNo = "0000" + countdc;
                    }
                    if (countdc >= 10 && countdc <= 99)
                    {
                        NewVoucherNo = "000" + countdc;
                    }
                    if (countdc >= 99 && countdc <= 999)
                    {
                        NewVoucherNo = "00" + countdc;
                    }
                    if (countdc >= 999)
                    {
                        NewVoucherNo = "0" + countdc;
                    }
                    DataRow newrow = dtReport.NewRow();

                    newrow["Sno"] = i++;
                    newrow["Voucher Date"] = fromdate.ToString("dd-MMM-yyyy");
                    newrow["Voucher No"] = ddlSalesOffice.SelectedValue + dtapril.ToString("yy") + dtmarch.ToString("yy") + NewVoucherNo;
                    newrow["Voucher Type"] = "Cash Payment Import";
                    newrow["Credit Code"] = ladger_dr_code;
                    newrow["Ledger (Cr)"] = ledger;
                    newrow["Debit Code"] = branch["accountcode"].ToString();
                    newrow["Ledger (Dr)"] = branch["HeadName"].ToString();
                    newrow["Amount"] = branch["Amount"].ToString();
                    newrow["CreatedBy"] = branch["createdby"].ToString();
                    newrow["ApprovedBy"] = branch["EmpName"].ToString();
                    newrow["whcode"] = whcode;
                    newrow["Narration"] = branch["Remarks"].ToString() + ",VoucherID  " + branch["VocherID"].ToString() + ",Emp Name  " + Session["EmpName"].ToString();
                    dtReport.Rows.Add(newrow);

                }
                grdReports.DataSource = dtReport;
                grdReports.DataBind();
                Session["xportdata"] = dtReport;
            }
            else
            {
                pnlHide.Visible = false;
                lblmsg.Text = "No Indent Found";
                grdReports.DataSource = dtReport;
                grdReports.DataBind();
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
            grdReports.DataSource = dtReport;
            grdReports.DataBind();
        }
    }
    private string GetSpace(string p)
    {
        int i = 0;
        for (; i < p.Length; i++)
        {
            if (char.IsNumber(p[i]))
            {
                break;
            }
        }
        return p.Substring(0, i) + " " + p.Substring(i, p.Length - i);
    }
    SqlCommand sqlcmd;
    protected void BtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            vdm = new VehicleDBMgr();
            DateTime CreateDate = VehicleDBMgr.GetTime(vdm.conn);
            SAPdbmanger SAPvdm = new SAPdbmanger();
            DateTime fromdate = DateTime.Now;
            DataTable dt = (DataTable)Session["xportdata"];
            string[] dateFromstrig = txtFromdate.Text.Split(' ');
            if (dateFromstrig.Length > 1)
            {
                if (dateFromstrig[0].Split('-').Length > 0)
                {
                    string[] dates = dateFromstrig[0].Split('-');
                    string[] times = dateFromstrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            DataTable dtJournelPay = new DataTable();

            ////sqlcmd = new SqlCommand("Insert into EMROVPM (CreateDate,PaymentDate,DOE,ReferenceNo,CardCode,Remarks,AcctNo,PaymentMode,PaymentSum,OcrCode,B1Upload,Processed) values(@CreateDate,@PaymentDate,@DOE,@ReferenceNo,@CardCode,@Remarks,@AcctNo,@PaymentMode,@PaymentSum,@OcrCode,@B1Upload,@Processed)");
            ////sqlcmd.Parameters.Add("@CreateDate", GetLowDate(fromdate));
            ////sqlcmd.Parameters.Add("@PaymentDate", GetLowDate(fromdate));
            ////sqlcmd.Parameters.Add("@DOE", GetLowDate(fromdate));
            ////sqlcmd.Parameters.Add("@ReferenceNo", dr["Voucher No"].ToString());
            ////sqlcmd.Parameters.Add("@CardCode", dr["Debit Code"].ToString());
            ////sqlcmd.Parameters.Add("@Remarks", dr["Narration"].ToString());
            ////sqlcmd.Parameters.Add("@AcctNo", dr["Credit Code"].ToString());
            ////sqlcmd.Parameters.Add("@PaymentMode", PaymentMode);
            ////sqlcmd.Parameters.Add("@PaymentSum", amount);
            ////sqlcmd.Parameters.Add("@OcrCode", dr["whcode"].ToString());
            ////sqlcmd.Parameters.Add("@B1Upload", B1Upload);
            ////sqlcmd.Parameters.Add("@Processed", Processed);
            ////SAPvdm.insert(sqlcmd);

            foreach (GridViewRow row in grdReports.Rows)
            {
                string PaymentMode = "CASH";
                string B1Upload = "N";
                string Processed = "N";
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                    if (chkRow.Checked)
                    {

                        string sno = row.Cells[1].Text;
                        string VoucherDate = row.Cells[2].Text;
                        string VoucherNo = row.Cells[3].Text;
                        string VoucherType = row.Cells[4].Text;
                        string whcode = row.Cells[5].Text;
                        string CreatedBy = row.Cells[6].Text;
                        string ApprovedBy = row.Cells[7].Text;
                        string CreditCode = row.Cells[8].Text;
                        string LedgerCr = row.Cells[9].Text;
                        string DebitCode = row.Cells[10].Text;
                        string LedgerDr = row.Cells[11].Text;
                        string Amount = row.Cells[12].Text;
                        string Narration = row.Cells[13].Text;
                        double amount = 0;
                        double.TryParse(Amount, out amount);

                        sqlcmd = new SqlCommand("SELECT CreateDate, RefDate, DocDate, Ref1, Ref2, Ref3 FROM EMROJDTP WHERE (RefDate BETWEEN @d1 AND @d2) AND (Ref1 = @Refno) AND (AcctCode=@AcctCode) AND (OcrCode = @OcrCode)");
                        sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
                        sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
                        sqlcmd.Parameters.Add("@Refno", VoucherNo);
                        sqlcmd.Parameters.Add("@OcrCode", whcode);
                        sqlcmd.Parameters.Add("@AcctCode", DebitCode);
                        dtJournelPay = SAPvdm.SelectQuery(sqlcmd).Tables[0];
                        if (dtJournelPay.Rows.Count > 0)
                        {
                            lblmsg.Text = "This Transaction already saved";
                            break;
                        }
                        else
                        {
                            double num;
                            if (double.TryParse(DebitCode, out num))
                            {
                                sqlcmd = new SqlCommand("Insert into EMROJDTP (CreateDate, RefDate, DocDate, TransNo,TransCode, AcctCode, AcctName, Debit, Credit, B1Upload, Processed,Ref1,OcrCode,Remarks,series) values (@CreateDate, @RefDate, @DocDate,@TransNo,@TransCode, @AcctCode, @AcctName, @Debit, @Credit, @B1Upload, @Processed,@Ref1,@OcrCode,@Remarks,@series)");
                                sqlcmd.Parameters.Add("@CreateDate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@RefDate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@docdate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@Ref1", VoucherNo);
                                string TransCode = "T1";
                                sqlcmd.Parameters.Add("@TransNo", VoucherNo);
                                sqlcmd.Parameters.Add("@TransCode", TransCode);
                                sqlcmd.Parameters.Add("@AcctCode", DebitCode);
                                sqlcmd.Parameters.Add("@AcctName", LedgerDr);
                                double.TryParse(Amount, out amount);
                                sqlcmd.Parameters.Add("@Debit", amount);
                                string Creditamount = "0";
                                sqlcmd.Parameters.Add("@Credit", Creditamount);
                                sqlcmd.Parameters.Add("@B1Upload", B1Upload);
                                sqlcmd.Parameters.Add("@Processed", Processed);
                                sqlcmd.Parameters.Add("@OcrCode", whcode);
                                sqlcmd.Parameters.Add("@Remarks", Narration);
                                string series = "134";
                                sqlcmd.Parameters.Add("@series", series);
                                SAPvdm.insert(sqlcmd);

                                sqlcmd = new SqlCommand("Insert into EMROJDTP (CreateDate, RefDate, DocDate, TransNo,TransCode, AcctCode, AcctName, Debit, Credit, B1Upload, Processed,Ref1,OcrCode,Remarks,series) values (@CreateDate, @RefDate, @DocDate,@TransNo,@TransCode, @AcctCode, @AcctName, @Debit, @Credit, @B1Upload, @Processed,@Ref1,@OcrCode,@Remarks,@series)");
                                sqlcmd.Parameters.Add("@CreateDate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@RefDate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@docdate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@Ref1", VoucherNo);
                                sqlcmd.Parameters.Add("@TransNo", VoucherNo);
                                sqlcmd.Parameters.Add("@TransCode", TransCode);
                                sqlcmd.Parameters.Add("@AcctCode", CreditCode);
                                sqlcmd.Parameters.Add("@AcctName", LedgerCr);
                                string Debitamount = "0";
                                sqlcmd.Parameters.Add("@Debit", Debitamount);
                                sqlcmd.Parameters.Add("@Credit", amount);
                                sqlcmd.Parameters.Add("@B1Upload", B1Upload);
                                sqlcmd.Parameters.Add("@Processed", Processed);
                                sqlcmd.Parameters.Add("@OcrCode", whcode);
                                sqlcmd.Parameters.Add("@Remarks", Narration);
                                sqlcmd.Parameters.Add("@series", series);
                                SAPvdm.insert(sqlcmd);
                            }
                            else
                            {
                                sqlcmd = new SqlCommand("Insert into EMROVPM (CreateDate, PaymentDate, DOE, ReferenceNo, CardCode, Remarks, AcctNo,  PaymentMode, PaymentSum, OcrCode, B1Upload, Processed, Series) values (@CreateDate, @RefDate, @docdate,@VoucherNo, @CardCode, @Remarks, @AcctCode, @PaymentMode, @PaymentSum, @OcrCode, @B1Upload, @Processed, @Series)");
                                sqlcmd.Parameters.Add("@CreateDate", CreateDate);
                                sqlcmd.Parameters.Add("@RefDate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@docdate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@VoucherNo", VoucherNo);
                                sqlcmd.Parameters.Add("@OcrCode", whcode);
                                sqlcmd.Parameters.Add("@CardCode", DebitCode);
                                sqlcmd.Parameters.Add("@AcctCode", CreditCode);
                                sqlcmd.Parameters.Add("@AcctName", LedgerCr);
                                sqlcmd.Parameters.Add("@Series", "137");
                                sqlcmd.Parameters.Add("@Remarks", Narration);
                                sqlcmd.Parameters.Add("@PaymentMode", "Invoice");
                                sqlcmd.Parameters.Add("@PaymentSum", Amount);
                                sqlcmd.Parameters.Add("@B1Upload", B1Upload);
                                sqlcmd.Parameters.Add("@Processed", Processed);
                                SAPvdm.insert(sqlcmd);
                            }
                        }
                    }
                }
            }
            if (dtJournelPay.Rows.Count > 0)
            {
                pnlHide.Visible = false;
                DataTable dtempty = new DataTable();
                grdReports.DataSource = dtempty;
                grdReports.DataBind();
                lblmsg.Text = "This Transaction already saved";
            }
            else
            {
                pnlHide.Visible = false;
                DataTable dtempty = new DataTable();
                grdReports.DataSource = dtempty;
                grdReports.DataBind();
                lblmsg.Text = "Successfully Saved";
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.ToString();
        }
    }
}