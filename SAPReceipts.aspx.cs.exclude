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
public partial class SapReceipts : System.Web.UI.Page
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
            Report.Columns.Add("whcode");
            Report.Columns.Add("Receipt");
            Report.Columns.Add("Type");
            Report.Columns.Add("Customer Code");
            Report.Columns.Add("Name");
            Report.Columns.Add("PaidDate");
            Report.Columns.Add("Amount").DataType = typeof(Double);
            lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
            lblRoutName.Text = ddlSalesOffice.SelectedItem.Text;
            Session["xporttype"] = "TallyReceipts";

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
            string ledger = "";
            string whcode = "";
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
            Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Sap Receipts" + fromdate.ToString("dd/MM/yyyy");
            DataTable dtAgent = vdm.SelectQuery(cmd).Tables[0];
            if (ddlSalesOffice.SelectedValue == "306" || ddlSalesOffice.SelectedValue == "2909")
            {
                DateTime dtfromdate = GetLowDate(fromdate).AddDays(-2);
                cmd = new MySqlCommand("SELECT branchdata.tbranchname,branchdata.customercode,cashreceipts.Remarks, cashreceipts.Receipt AS ReceiptNo, DATE_FORMAT(tripdata.I_Date, '%d %b %y') AS DOE, cashreceipts.AmountPaid, cashreceipts.PaymentStatus AS PaymentType,branchdata.whcode, tripdata.Sno FROM branchmappingtable INNER JOIN branchdata ON branchmappingtable.SubBranch = branchdata.sno INNER JOIN cashreceipts ON branchdata.sno = cashreceipts.AgentID INNER JOIN tripdata ON cashreceipts.Tripid = tripdata.Sno WHERE (tripdata.I_Date BETWEEN @d1 AND @d2) AND (branchmappingtable.SuperBranch = @BranchID) AND (cashreceipts.PaymentStatus = 'Cash') AND (cashreceipts.AmountPaid > 0)");
                
               // cmd = new MySqlCommand("SELECT   branchdata.tbranchname,branchdata.customercode, collections.Sno AS ReceiptNo, DATE_FORMAT(collections.PaidDate, '%d %b %y') AS DOE, collections.AmountPaid, collections.PaymentType, tripdata.Sno, branchdata.whcode, collections.PaidDate FROM collections INNER JOIN branchdata ON collections.Branchid = branchdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno INNER JOIN tripdata ON collections.tripId = tripdata.Sno WHERE (branchmappingtable.SuperBranch = @BranchID) AND (collections.PaymentType = 'Cash') AND (collections.AmountPaid > 0) AND (tripdata.I_Date BETWEEN @d1 AND @d2) OR (collections.PaymentType = 'Cash') AND (collections.AmountPaid > 0) AND (tripdata.I_Date BETWEEN @d1 AND @d2) AND (branchdata_1.SalesOfficeID = @SOID)");
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(dtfromdate));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(dtfromdate));
                cmd.Parameters.AddWithValue("@Type", "Agent");
                dtAgent = vdm.SelectQuery(cmd).Tables[0];
                cmd = new MySqlCommand("SELECT branchdata.tBranchName,branchdata.customercode,collections.receiptno as rec,collections.Remarks, collections.Sno as ReceiptNo,DATE_FORMAT(collections.PaidDate, '%d %b %y') AS DOE , collections.AmountPaid, collections.PaymentType, branchdata.whcode FROM collections INNER JOIN branchdata ON collections.Branchid = branchdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno WHERE (collections.PaidDate BETWEEN @d1 AND @d2) AND (branchmappingtable.SuperBranch = @BranchID) AND (collections.PaymentType = 'Cash') AND (collections.AmountPaid > 0) AND (collections.tripid is NULL) OR (collections.PaidDate BETWEEN @d1 AND @d2) AND (collections.PaymentType = 'Cash') AND (branchdata_1.SalesOfficeID = @SOID) AND (collections.tripid is NULL) AND (collections.AmountPaid > 0)");

                //cmd = new MySqlCommand("SELECT branchdata.tBranchName,branchdata.customercode,collections.Sno as ReceiptNo,DATE_FORMAT(collections.PaidDate, '%d %b %y') AS DOE , collections.AmountPaid, collections.PaymentType, branchdata.whcode, collections.PaidDate FROM collections INNER JOIN branchdata ON collections.Branchid = branchdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno WHERE (collections.PaidDate BETWEEN @d1 AND @d2) AND (branchmappingtable.SuperBranch = @BranchID) AND (collections.PaymentType = 'Cash') AND (collections.AmountPaid > 0) AND (collections.tripid is NULL) OR (collections.PaidDate BETWEEN @d1 AND @d2) AND (collections.PaymentType = 'Cash') AND (branchdata_1.SalesOfficeID = @SOID) AND (collections.tripid is NULL) AND (collections.AmountPaid > 0)");
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
                cmd.Parameters.AddWithValue("@Type", "Agent");
                DataTable dtsalescollection = vdm.SelectQuery(cmd).Tables[0];
                foreach (DataRow dr in dtsalescollection.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["DOE"] = dr["DOE"].ToString();
                    newrow["Receipt"] = dr["ReceiptNo"].ToString();
                    newrow["whcode"] = dr["whcode"].ToString();
                    newrow["Name"] = dr["tBranchName"].ToString();
                    newrow["Customer Code"] = dr["customercode"].ToString();
                    string paid_date = dr["DOE"].ToString();
                    DateTime paiddate = Convert.ToDateTime(paid_date);
                    newrow["PaidDate"] = paiddate.ToString(("dd/MM/yyyy"));
                    newrow["Name"] = dr["tBranchName"].ToString();
                    double AmountPaid = 0;
                    double.TryParse(dr["AmountPaid"].ToString(), out AmountPaid);
                    newrow["Amount"] = AmountPaid;
                    Report.Rows.Add(newrow);
                }
                foreach (DataRow dr in dtAgent.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["DOE"] = dr["DOE"].ToString();
                    newrow["Receipt"] = dr["ReceiptNo"].ToString();
                    newrow["whcode"] = dr["whcode"].ToString();
                    string paid_date = dr["DOE"].ToString();
                    DateTime paiddate = Convert.ToDateTime(paid_date);
                    newrow["PaidDate"] = paiddate.ToString(("dd/MM/yyyy"));
                    newrow["Name"] = dr["tBranchName"].ToString();
                    newrow["Customer Code"] = dr["customercode"].ToString();
                    double AmountPaid = 0;
                    double.TryParse(dr["AmountPaid"].ToString(), out AmountPaid);
                    newrow["Amount"] = AmountPaid;
                    Report.Rows.Add(newrow);
                }
            }
            else
            {
                if (ddlSalesOffice.SelectedValue == "172")
                {
                }
                else
                {
                    cmd = new MySqlCommand("SELECT branchdata.SalesType, branchdata.tbranchname,cashreceipts.Remarks, cashreceipts.AmountPaid ,cashreceipts.Receipt AS ReceiptNo,cashreceipts.DOE as PaidDate,DATE_FORMAT(cashreceipts.DOE, '%d %b %y') AS DOE, branchdata.whcode, branchdata.customercode, cashreceipts.PaymentStatus FROM branchmappingtable INNER JOIN branchdata ON branchmappingtable.SubBranch = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno INNER JOIN cashreceipts ON branchdata.sno = cashreceipts.AgentID WHERE (branchmappingtable.SuperBranch = @BranchID) AND (cashreceipts.DOE BETWEEN @d1 AND @d2) AND (cashreceipts.AmountPaid > 0) AND (cashreceipts.PaymentStatus = 'Cash')   OR (branchdata_1.SalesOfficeID = @SOID) AND (cashreceipts.DOE BETWEEN @d1 AND @d2) AND (cashreceipts.AmountPaid > 0) AND (cashreceipts.PaymentStatus = 'Cash')  ");
                   // cmd = new MySqlCommand("SELECT  branchdata.SalesType, branchdata.tbranchname, cashreceipts.AmountPaid, cashreceipts.Receipt AS ReceiptNo,cashreceipts.DOE as PaidDate,  DATE_FORMAT(cashreceipts.DOE, '%d %b %y') AS DOE, branchdata.whcode, branchdata.customercode, cashreceipts.PaymentStatus FROM  branchmappingtable INNER JOIN branchdata ON branchmappingtable.SubBranch = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno INNER JOIN cashreceipts ON branchdata.sno = cashreceipts.AgentID WHERE (branchmappingtable.SuperBranch = @BranchID) AND (cashreceipts.DOE BETWEEN @d1 AND @d2) AND (cashreceipts.AmountPaid > 0) AND (cashreceipts.PaymentStatus = 'Cash') OR (cashreceipts.DOE BETWEEN @d1 AND @d2) AND (cashreceipts.AmountPaid > 0) AND (cashreceipts.PaymentStatus = 'Cash') AND  (branchdata_1.SalesOfficeID = @SOID)");
                    cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                    cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
                    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                    cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
                    cmd.Parameters.AddWithValue("@Type", "Agent");
                    DataTable Agent = vdm.SelectQuery(cmd).Tables[0];
                    foreach (DataRow dr in Agent.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        string salestype = dr["salestype"].ToString();
                        newrow["DOE"] = dr["DOE"].ToString();
                        newrow["Receipt"] = dr["ReceiptNo"].ToString();
                        newrow["whcode"] = dr["whcode"].ToString();
                        string paid_date = dr["PaidDate"].ToString();
                        DateTime paiddate = Convert.ToDateTime(paid_date);
                        newrow["PaidDate"] = paiddate.ToString(("dd/MM/yyyy"));
                        newrow["Customer Code"] = dr["customercode"].ToString();
                        newrow["Name"] = dr["tbranchname"].ToString();
                        double AmountPaid = 0;
                        double.TryParse(dr["AmountPaid"].ToString(), out AmountPaid);
                        newrow["Amount"] = AmountPaid;
                        Report.Rows.Add(newrow);
                    }
                }
            }
            //cmd = new MySqlCommand("SELECT Sno,DATE_FORMAT(DOE, '%d %b %y') AS DOE,Receiptno,PaymentType as Type, Name, Amount  FROM cashcollections WHERE (Branchid = @BranchID) AND (DOE BETWEEN @d1 AND @d2) AND  (PaymentType = 'Others') ORDER BY DOE");
            cmd = new MySqlCommand("SELECT cashcollections.collectiontype,  cashcollections.ledger_code,cashcollections.DOE as PaidDate,branchdata.customercode,cashcollections.Sno, DATE_FORMAT(cashcollections.DOE, '%d %b %y') AS DOE, cashcollections.Receiptno, cashcollections.PaymentType AS Type, cashcollections.Name, cashcollections.Amount, cashcollections.Branchid, branchdata.BranchName, branchdata.whcode FROM cashcollections INNER JOIN branchdata ON cashcollections.Branchid = branchdata.sno WHERE (cashcollections.Branchid = @BranchID) AND (cashcollections.DOE BETWEEN @d1 AND @d2) AND (cashcollections.PaymentType = 'Others') ORDER BY DOE");
            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            cmd.Parameters.AddWithValue("@Type", "Others");
            DataTable dtOthers = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dtOthers.Rows)
            {
                DataRow newrow = Report.NewRow();
                newrow["DOE"] = dr["DOE"].ToString();
                newrow["Receipt"] = dr["Receiptno"].ToString();
                newrow["Type"] = dr["Type"].ToString();
                newrow["Name"] = dr["Name"].ToString();
                string paid_date = dr["PaidDate"].ToString();
                DateTime paiddate = Convert.ToDateTime(paid_date);
                newrow["PaidDate"] = paiddate.ToString(("dd/MM/yyyy"));
                newrow["whcode"] = dr["whcode"].ToString();
                newrow["Customer Code"] = dr["ledger_code"].ToString();
                double AmountPaid = 0;
                double.TryParse(dr["Amount"].ToString(), out AmountPaid);
                newrow["Amount"] = AmountPaid;
                if (dr["collectiontype"].ToString() == "Cash")
                {
                    Report.Rows.Add(newrow);
                }
                else
                {
                }
            }
            string Receiptno = "";
            Receiptno = dtapril.ToString("yy") + dtmarch.ToString("yy");
            if (Report.Rows.Count > 0)
            {
                DataView view = new DataView(Report);
                dtReport = new DataTable();
                dtReport.Columns.Add("Voucher Date");
                dtReport.Columns.Add("Voucher No");
                dtReport.Columns.Add("whcode");
                dtReport.Columns.Add("Voucher Type");
                dtReport.Columns.Add("Ledger Code");
                dtReport.Columns.Add("Ledger (Dr)");
                dtReport.Columns.Add("PaidDate");
                dtReport.Columns.Add("Customer Code");
                dtReport.Columns.Add("Ledger (Cr)");
                dtReport.Columns.Add("Amount");
                dtReport.Columns.Add("Narration");
                //DataTable distincttable = view.ToTable(true, "BranchName", "BSno");
                int i = 1;
                foreach (DataRow branch in Report.Rows)
                {
                    DataRow newrow = dtReport.NewRow();
                    string newreceipt = "0";
                    int countdc = 0;
                    newrow["Voucher Date"] = fromdate.ToString("dd-MMM-yyyy");
                    int.TryParse(branch["Receipt"].ToString(), out countdc);
                    if (countdc < 10)
                    {
                        newreceipt = "000" + countdc;
                    }
                    if (countdc >= 10 && countdc <= 99)
                    {
                        newreceipt = "00" + countdc;
                    }
                    if (countdc >= 99 && countdc <= 999)
                    {
                        newreceipt = "0" + countdc;
                    }
                    if (countdc > 999)
                    {
                        newreceipt = "" + countdc;
                    }
                    newrow["Voucher No"] = Receiptno + newreceipt;
                    //newrow["Voucher No"] = branch["Receipt"].ToString();
                    newrow["whcode"] = whcode;
                    newrow["PaidDate"] = branch["PaidDate"].ToString();
                    newrow["Voucher Type"] = "CASH";
                    newrow["Ledger Code"] = ladger_dr_code;
                    newrow["Ledger (Dr)"] = ledger;
                    if (branch["Name"].ToString() == "")
                    {
                    }
                    else
                    {
                        newrow["Customer Code"] = branch["Customer Code"].ToString();
                        newrow["Ledger (Cr)"] = branch["Name"].ToString();
                        newrow["Amount"] = branch["Amount"].ToString();
                        double invval = 0;
                        newrow["Narration"] = "Being the cash receipt to  " + branch["Name"].ToString() + " vide Receipt No " + branch["Receipt"].ToString() + ",Receipt Date " + fromdate.ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                        dtReport.Rows.Add(newrow);
                        i++;
                    }
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

                        string sno = row.Cells[0].Text;
                        string VoucherDate = row.Cells[1].Text;
                        string VoucherNo = row.Cells[2].Text;
                        string whcode = row.Cells[3].Text;
                        string VoucherType = row.Cells[4].Text;
                        string Ledgercode = row.Cells[5].Text;
                        string LedgerDr = row.Cells[6].Text;;
                        //string CreatedBy = row.Cells[5].Text;
                        string PaidDate = row.Cells[7].Text;
                        string customercode = row.Cells[8].Text;
                        string LedgerCr = row.Cells[9].Text;
                        string Amount = row.Cells[10].Text;
                        string Narration = row.Cells[11].Text;
                        double amount = 0;
                        double.TryParse(Amount, out amount);
                        //string customercode = dr["Customer Code"].ToString();
                        double num;
                        if (double.TryParse(customercode, out num))
                        {
                            string Customercode = row.Cells[8].Text;
                            if (Ledgercode == "" || Customercode == "")
                            {
                            }
                            else
                            {
                                sqlcmd = new SqlCommand("Insert into EMROJDTP (CreateDate, RefDate, DocDate, TransNo, TransCode, AcctCode, AcctName, Debit, Credit, B1Upload, Processed,Ref1,OcrCode,Remarks,series) values (@CreateDate, @RefDate, @DocDate,@TransNo,@TransCode, @AcctCode, @AcctName, @Debit, @Credit, @B1Upload, @Processed,@Ref1,@OcrCode,@Remarks,@series)");
                                sqlcmd.Parameters.Add("@CreateDate", CreateDate);
                                sqlcmd.Parameters.Add("@RefDate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@docdate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@Ref1", VoucherNo);
                                string TransCode = "T1";
                                sqlcmd.Parameters.Add("@TransNo", VoucherNo);
                                sqlcmd.Parameters.Add("@TransCode", TransCode);
                                sqlcmd.Parameters.Add("@AcctCode", Ledgercode);
                                sqlcmd.Parameters.Add("@AcctName", LedgerDr);
                                sqlcmd.Parameters.Add("@Debit", Amount);
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
                                sqlcmd.Parameters.Add("@CreateDate", CreateDate);
                                sqlcmd.Parameters.Add("@RefDate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@docdate", GetLowDate(fromdate));
                                sqlcmd.Parameters.Add("@Ref1", VoucherNo);
                                sqlcmd.Parameters.Add("@TransNo", VoucherNo);
                                sqlcmd.Parameters.Add("@TransCode", TransCode);
                                sqlcmd.Parameters.Add("@AcctCode", Customercode);
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
                        }
                        else
                        {
                            sqlcmd = new SqlCommand("Insert into EMRORCT (CreateDate,PaymentDate,DOE,ReferenceNo,CardCode,Remarks,PaymentMode,PaymentSum,OcrCode,B1Upload,Processed,AcctNo,series) values(@CreateDate,@PaymentDate,@DOE,@ReferenceNo,@CardCode,@Remarks,@PaymentMode,@PaymentSum,@OcrCode,@B1Upload,@Processed,@AcctNo,@series)");
                            sqlcmd.Parameters.Add("@CreateDate", GetLowDate(fromdate));
                            sqlcmd.Parameters.Add("@PaymentDate", GetLowDate(fromdate));
                            sqlcmd.Parameters.Add("@DOE", GetLowDate(fromdate));
                            sqlcmd.Parameters.Add("@ReferenceNo", VoucherNo);
                            sqlcmd.Parameters.Add("@CardCode", VoucherNo);
                            sqlcmd.Parameters.Add("@Remarks", Narration);
                            //sqlcmd.Parameters.Add("@InvoiceNo", dr["Voucher No"].ToString());
                            sqlcmd.Parameters.Add("@PaymentMode", PaymentMode);
                            sqlcmd.Parameters.Add("@PaymentSum", amount);
                            sqlcmd.Parameters.Add("@OcrCode", whcode);
                            sqlcmd.Parameters.Add("@B1Upload", B1Upload);
                            sqlcmd.Parameters.Add("@Processed", Processed);
                            sqlcmd.Parameters.Add("@AcctNo", Ledgercode);
                            string series = "15";
                            sqlcmd.Parameters.Add("@series", series);
                            SAPvdm.insert(sqlcmd);
                        }
                    }
                }
            }
            pnlHide.Visible = false;
            DataTable dtempty = new DataTable();
            grdReports.DataSource = dtempty;
            grdReports.DataBind();
            lblmsg.Text = "Successfully Saved";
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.ToString();
        }
    }
}