using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
public partial class Freezer_Details_Report : System.Web.UI.Page
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
        if (!this.IsPostBack)
        {
            if (!Page.IsCallback)
            {
                FillRouteName();
                txtFromdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                txtTodate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                lblTitle.Text = Session["TitleName"].ToString();
            }
        }


    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GetReport();
    }
    void FillRouteName()
    {
        try
        {
            vdm = new VehicleDBMgr();
            if (Session["salestype"].ToString() == "Plant")
            {
                PBranch.Visible = true;
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType)");
                cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
                cmd.Parameters.AddWithValue("@SalesType", "21");
                DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                //if (ddlSalesOffice.SelectedIndex == -1)
                //{
                //    ddlSalesOffice.SelectedItem.Text = "Select";
                //}
                ddlSalesOffice.DataSource = dtRoutedata;
                ddlSalesOffice.DataTextField = "BranchName";
                ddlSalesOffice.DataValueField = "sno";
                ddlSalesOffice.DataBind();
                ddlSalesOffice.Items.Insert(0, new ListItem("Select", "0"));
            }
            else
            {
                PBranch.Visible = false;

                cmd = new MySqlCommand("SELECT dispatch.DispName, dispatch.sno FROM dispatch INNER JOIN branchdata ON dispatch.Branch_Id = branchdata.sno INNER JOIN branchdata branchdata_1 ON dispatch.Branch_Id = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) and (dispatch.flag=@flag)) OR ((branchdata_1.SalesOfficeID = @SOID) and (dispatch.flag=@flag))");
                cmd.Parameters.AddWithValue("@BranchID", Session["branch"].ToString());
                cmd.Parameters.AddWithValue("@SOID", Session["branch"].ToString());
                cmd.Parameters.AddWithValue("@flag", "1");
                DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                ddlDispName.DataSource = dtRoutedata;
                ddlDispName.DataTextField = "DispName";
                ddlDispName.DataValueField = "sno";
                ddlDispName.DataBind();
            }
        }
        catch
        {
        }
    }
    protected void ddlSalesOffice_SelectedIndexChanged(object sender, EventArgs e)
    {
        vdm = new VehicleDBMgr();
        cmd = new MySqlCommand("SELECT dispatch.DispName, dispatch.sno FROM dispatch INNER JOIN branchdata ON dispatch.Branch_Id = branchdata.sno INNER JOIN branchdata branchdata_1 ON dispatch.Branch_Id = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) and (dispatch.flag=@flag)) OR ((branchdata_1.SalesOfficeID = @SOID) and (dispatch.flag=@flag))");
        cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
        cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
        cmd.Parameters.AddWithValue("@flag", "1");
        DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
        ddlDispName.DataSource = dtRoutedata;
        ddlDispName.DataTextField = "DispName";
        ddlDispName.DataValueField = "sno";
        ddlDispName.DataBind();
    }
     protected void ddlDispName_SelectedIndexChanged(object sender, EventArgs e)
    {
        vdm = new VehicleDBMgr();
        //cmd = new MySqlCommand("SELECT branchdata.sno, branchdata.BranchName FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch)");
        cmd = new MySqlCommand("SELECT branchdata.sno, branchdata.BranchName FROM dispatch INNER JOIN dispatch_sub ON dispatch.sno = dispatch_sub.dispatch_sno INNER JOIN branchroutes ON dispatch_sub.Route_id = branchroutes.Sno INNER JOIN branchroutesubtable ON branchroutes.Sno = branchroutesubtable.RefNo INNER JOIN branchdata ON branchroutesubtable.BranchID = branchdata.sno WHERE (dispatch.sno = @dispsno)");
        cmd.Parameters.AddWithValue("@dispsno", ddlDispName.SelectedValue);
        DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
        ddlAgentName.DataSource = dtRoutedata;
        ddlAgentName.DataTextField = "BranchName";
        ddlAgentName.DataValueField = "sno";
        ddlAgentName.DataBind();
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
    DateTime fromdate = DateTime.Now;

    string routeid = "";
    string routeitype = "";
    DataTable Report = new DataTable();
    DataTable productsReport = new DataTable();
    DataTable FinalReport = new DataTable();
    void GetReport()
    {
        try
        {
            lblmsg.Text = "";
            pnlHide.Visible = true;
            lblAgent.Text = ddlAgentName.SelectedItem.Text;
            Session["IDate"] = DateTime.Now.AddDays(1).ToString("dd/MM/yyyy");
            vdm = new VehicleDBMgr();
            Report = new DataTable();
            string[] datestrig = txtFromdate.Text.Split(' ');
            if (datestrig.Length > 1)
            {
                if (datestrig[0].Split('-').Length > 0)
                {
                    string[] dates = datestrig[0].Split('-');
                    string[] times = datestrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            DateTime todate = DateTime.Now;
            string[] todatestrig = txtTodate.Text.Split(' ');
            if (todatestrig.Length > 1)
            {
                if (todatestrig[0].Split('-').Length > 0)
                {
                    string[] dates = todatestrig[0].Split('-');
                    string[] times = todatestrig[1].Split(':');
                    todate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            todate = todate.AddMonths(1);
            Session["filename"] = "Freezer Details Report ->" + ddlDispName.SelectedItem.Text;
            lblAgent.Text = ddlDispName.SelectedItem.Text;
            lblDate.Text = txtFromdate.Text;
            Report = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("Date");
            Report.Columns.Add("Freezer Type");
            Report.Columns.Add("Credit").DataType = typeof(Double);
            Report.Columns.Add("Debit").DataType = typeof(Double);
            double credit = 0;
            double debit = 0;
            cmd = new MySqlCommand("SELECT DOE, freezertype, TransType, Amount FROM cashcollections WHERE (Agentid = @BranchID)");
            cmd.Parameters.AddWithValue("@BranchID", ddlAgentName.SelectedValue);
            DataTable dtFreezer = vdm.SelectQuery(cmd).Tables[0];
            if (dtFreezer.Rows.Count > 0)
            {
                int i = 1;
                foreach (DataRow dr in dtFreezer.Rows)
                {
                    string TransType = dr["TransType"].ToString();

                    DataRow newrow = Report.NewRow();
                    newrow["Sno"] = i++.ToString();
                    string dtdate1 = dr["DOE"].ToString();
                    DateTime dtDOE1 = Convert.ToDateTime(dtdate1).AddDays(1);
                    string ChangedTime1 = dtDOE1.ToString("dd/MMM/yy");
                    newrow["Date"] = ChangedTime1;
                    newrow["Freezer Type"] = dr["freezertype"].ToString();
                    if (TransType == "Debit")
                    {
                        double Amount = 0;
                        double.TryParse(dr["Amount"].ToString(), out Amount);
                        newrow["Debit"] = Amount;
                       debit  += Amount;
                    }
                    if (TransType == "Credit")
                    {
                        double Amount = 0;
                        double.TryParse(dr["Amount"].ToString(), out Amount);
                        newrow["Credit"] = Amount;
                        credit += Amount;
                    }
                    Report.Rows.Add(newrow);
                }
                double total = 0;
                total = credit - debit;
                total = Math.Round(total, 2);
                Label1C.Text = total.ToString();
                DataRow totalinventory = Report.NewRow();
                totalinventory["Freezer Type"] = "TOTAL";
                double val = 0.0;
                foreach (DataColumn dc in Report.Columns)
                {
                    if (dc.DataType == typeof(Double))
                    {
                        val = 0.0;
                        double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                        totalinventory[dc.ToString()] = val;
                    }
                }
                Report.Rows.Add(totalinventory);
                grdReports.DataSource = Report;
                grdReports.DataBind();
            }
            else
            {
                lblmsg.Text = "No Data were found;";
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
        }
    }
}