using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Data.SqlClient;

public partial class SAPIncentives : System.Web.UI.Page
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
                txtTodate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
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
    DataTable Report = new DataTable();
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
            DateTime todate = DateTime.Now;
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
            string[] datetostrig = txtTodate.Text.Split(' ');
            if (datetostrig.Length > 1)
            {
                if (datetostrig[0].Split('-').Length > 0)
                {
                    string[] dates = datetostrig[0].Split('-');
                    string[] times = datetostrig[1].Split(':');
                    todate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
            lblRoutName.Text = ddlSalesOffice.SelectedItem.Text;
            Session["xporttype"] = "TallyIncentive";
            string DCNO = "";
            if (ddlSalesOffice.SelectedValue == "174")
            {
                DCNO = "CHNJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "271")
            {
                DCNO = "NLRJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "285")
            {
                DCNO = "TPTJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "306")
            {
                DCNO = "KANCHIJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "2749")
            {
                DCNO = "MDPLJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "2909")
            {
                DCNO = "VLRJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "538")
            {
                DCNO = "BANGJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "159")
            {
                DCNO = "HYDJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "570")
            {
                DCNO = "VJDJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "457")
            {
                DCNO = "WNGLJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "158" || ddlSalesOffice.SelectedValue == "572")
            {
                DCNO = "WYRAJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "282")
            {
                DCNO = "KLHJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "458")
            {
                DCNO = "KMMJV" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "3559")
            {
                DCNO = "CTRJV" + DCNO;
            }
            Report.Columns.Add("JV No");
            Report.Columns.Add("JV Date");
            Report.Columns.Add("WH Code");
            Report.Columns.Add("Series");
            Report.Columns.Add("Account Code");
            Report.Columns.Add("Customer Code");
            Report.Columns.Add("Customer Name");
            Report.Columns.Add("Amount");
            Report.Columns.Add("Narration");
            cmd = new MySqlCommand("SELECT sno, BranchName,whcode, incentivename FROM branchdata WHERE (sno = @BranchID)");
            if (Session["salestype"].ToString() == "Plant")
            {
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            }
            else
            {
                cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
            }
            DataTable dtincetivename = vdm.SelectQuery(cmd).Tables[0];
            Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Tally Incentive" + fromdate.ToString("dd/MM/yyyy");
            cmd = new MySqlCommand("SELECT branchdata.tbranchname,branchdata.customercode, branchmappingtable.SuperBranch, incentivetransactions.TotalDiscount, incentivetransactions.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN incentivetransactions ON branchdata.sno = incentivetransactions.BranchId INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno WHERE (branchmappingtable.SuperBranch = @BranchID) AND (incentivetransactions.EntryDate BETWEEN @d1 AND @d2) OR (branchdata_1.SalesOfficeID = @SOID) AND (incentivetransactions.EntryDate BETWEEN @d1 AND @d2)");
            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(todate));
            DataTable dtble = vdm.SelectQuery(cmd).Tables[0];
            double totamount = 0;
            fromdate = fromdate.AddDays(-1);
            string frmdate = fromdate.ToString("dd-MM-yyyy");
            string[] strjv = frmdate.Split('-');
            foreach (DataRow branch in dtble.Rows)
            {

                DataRow newrow = Report.NewRow();
                newrow["JV No"] = DCNO + strjv[1];
                newrow["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                newrow["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                newrow["Customer Code"] = branch["customercode"].ToString();
                newrow["Customer Name"] = branch["tbranchname"].ToString();
                string AcctCode = "5134006";
                string Series = "5";
                newrow["Series"] = Series;
                newrow["Account Code"] = AcctCode;
                double amount = 0;
                double.TryParse(branch["TotalDiscount"].ToString(), out amount);
                newrow["Amount"] = amount;
                newrow["Narration"] = "Being the incentive for the month of " + fromdate.ToString("MMM-yyyy") + " Total Amount " + branch["TotalDiscount"].ToString() + ",Emp Name  " + Session["EmpName"].ToString();
                Report.Rows.Add(newrow);
            }
            //DataRow newrow1 = Report.NewRow();
            //newrow1["JV No"] = DCNO + strjv[1];
            //newrow1["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
            //newrow1["Customer Name"] = "Sales Discount-" + dtincetivename.Rows[0]["incentivename"].ToString();
            //newrow1["Amount"] = totamount;
            //newrow1["Narration"] = "Being the amount credited to  " + ddlSalesOffice.SelectedItem.Text + " for the month of " + fromdate.ToString("MMM-yyyy") + " Total Amount " + totamount + ",Emp Name  " + Session["EmpName"].ToString();
            //Report.Rows.Add(newrow1);
            grdReports.DataSource = Report;
            grdReports.DataBind();
            Session["xportdata"] = Report;
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
            grdReports.DataSource = Report;
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
          
            cmd = new MySqlCommand("SELECT sno, BranchName, whcode, ladger_dr_code, tax, ntax, ledger_jv_code FROM branchdata WHERE (sno = @BranchID)");
            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            DataTable dtwhscode = vdm.SelectQuery(cmd).Tables[0];
            sqlcmd = new SqlCommand("SELECT CreateDate, PostingDate, DocDate, CardCode, Cardname FROM  EMRORIN WHERE  (PostingDate BETWEEN @d1 AND @d2) AND (OcrCode = @whscode)");
            sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
            sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
            sqlcmd.Parameters.Add("@whscode", dtwhscode.Rows[0]["whcode"].ToString());
            DataTable dtGI = SAPvdm.SelectQuery(sqlcmd).Tables[0];
            if (dtGI.Rows.Count > 0)
            {
                lblmsg.Text = "This Transaction already saved";
            }
            else
            {
                foreach (DataRow dr in dt.Rows)
                {
                    string CardCode = dr["Customer Code"].ToString();
                    if (CardCode == "")
                    {
                    }
                    else
                    {
                        sqlcmd = new SqlCommand("SELECT CreateDate, PostingDate, DocDate, CardCode, Cardname , Series FROM EMRORIN WHERE (PostingDate BETWEEN @d1 AND @d2) AND (ReferenceNo = @ReferenceNo) and (CardCode=@CardCode)");
                        sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
                        sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
                        sqlcmd.Parameters.Add("@ReferenceNo", dr["JV No"].ToString());
                        sqlcmd.Parameters.Add("@CardCode", dr["Customer Code"].ToString());
                        DataTable dtIncentives = SAPvdm.SelectQuery(sqlcmd).Tables[0];
                        if (dtIncentives.Rows.Count > 0)
                        {
                        }
                        else
                        {
                            sqlcmd = new SqlCommand("Insert into EMRORIN (CreateDate,PostingDate,DocDate,CardCode,Cardname,ReferenceNo,Description,AcctCode,Price,TaxCode,LocCode,OcrCode,Remarks,B1Upload,Processed,Series) values (@CreateDate,@PostingDate,@DocDate,@CardCode,@Cardname,@ReferenceNo,@Description,@AcctCode,@Price,@TaxCode,@LocCode,@OcrCode,@Remarks,@B1Upload,@Processed,@Series)");
                            sqlcmd.Parameters.Add("@CreateDate", GetLowDate(fromdate));
                            sqlcmd.Parameters.Add("@PostingDate", GetLowDate(fromdate));
                            sqlcmd.Parameters.Add("@DocDate", GetLowDate(fromdate));
                            sqlcmd.Parameters.Add("@CardCode", dr["Customer Code"].ToString());
                            sqlcmd.Parameters.Add("@Cardname", dr["Customer Name"].ToString());
                            sqlcmd.Parameters.Add("@ReferenceNo", dr["JV No"].ToString());
                            string Description = "Incentive";
                            sqlcmd.Parameters.Add("@Description", Description);
                            string AcctCode = "5134006";
                            sqlcmd.Parameters.Add("@AcctCode", dr["Account Code"].ToString());
                            double Price = 0;
                            double.TryParse(dr["Amount"].ToString(), out Price);
                            sqlcmd.Parameters.Add("@Price", Price);
                            string TaxCode = "EXEMPT";
                            int TransNo = 1;
                            sqlcmd.Parameters.Add("@TaxCode", TaxCode);
                            sqlcmd.Parameters.Add("@LocCode", TransNo);
                            sqlcmd.Parameters.Add("@OcrCode", dr["WH Code"].ToString());
                            string B1Upload = "N";
                            string Processed = "N";
                            sqlcmd.Parameters.Add("@Remarks", dr["Narration"].ToString());
                            sqlcmd.Parameters.Add("@B1Upload", B1Upload);
                            sqlcmd.Parameters.Add("@Processed", Processed);
                            sqlcmd.Parameters.Add("@Series", dr["Series"].ToString());
                            SAPvdm.insert(sqlcmd);
                        }
                    }
                }
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