using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using ClosedXML.Excel;
using System.IO;
public partial class Agent_Due_Details : System.Web.UI.Page
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
                FillSalesOffice();
                txtdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                // txtTodate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                lblTitle.Text = Session["TitleName"].ToString();
            }
        }
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GetReport();
    }
    void FillSalesOffice()
    {
        try
        {
            vdm = new VehicleDBMgr();
            if (Session["salestype"].ToString() == "Plant")
            {
                PBranch.Visible = true;
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType) or (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType1) ");
                cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
                cmd.Parameters.AddWithValue("@SalesType", "21");
                cmd.Parameters.AddWithValue("@SalesType1", "26");
                DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                ddlSalesOffice.DataSource = dtRoutedata;
                ddlSalesOffice.DataTextField = "BranchName";
                ddlSalesOffice.DataValueField = "sno";
                ddlSalesOffice.DataBind();
            }
            else
            {
                PBranch.Visible = true;
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM  branchdata INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE (branchdata_1.SalesOfficeID = @SOID) AND (branchdata.SalesType IS NOT NULL) OR (branchdata.sno = @BranchID)");
                cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
                cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                ddlSalesOffice.DataSource = dtRoutedata;
                ddlSalesOffice.DataTextField = "BranchName";
                ddlSalesOffice.DataValueField = "sno";
                ddlSalesOffice.DataBind();
            }
        }
        catch
        {
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
    DateTime fromdate = DateTime.Now;
    DateTime Prevdate = DateTime.Now;
    void GetReport()
    {
        try
        {
            lblmsg.Text = "";
            lblmessage.Text = "";
            Session["RouteName"] = ddlSalesOffice.SelectedItem.Text;
            lblRouteName.Text = ddlSalesOffice.SelectedItem.Text;
            vdm = new VehicleDBMgr();
            DataTable Report = new DataTable();
            string[] datestrig = txtdate.Text.Split(' ');
            if (datestrig.Length > 1)
            {
                if (datestrig[0].Split('-').Length > 0)
                {
                    string[] dates = datestrig[0].Split('-');
                    string[] times = datestrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            lblDate.Text = fromdate.ToString("dd/MMM/yyyy");
            string BranchID = ddlSalesOffice.SelectedValue;
            cmd = new MySqlCommand("select branchdata.branchname,branchroutes.sno as branchid,branchroutes.routename,branchroutesubtable.branchid As Agentid from branchroutes inner join branchroutesubtable ON branchroutes.sno = branchroutesubtable.refno inner join branchdata on branchdata.sno =branchroutesubtable.branchid where  branchroutes.branchid=@branchid");
            cmd.Parameters.AddWithValue("@branchid", BranchID);
            DataTable dtroutes = vdm.SelectQuery(cmd).Tables[0];
            cmd = new MySqlCommand("select agentid,inddate,opp_balance,salesvalue,paidamount,clo_balance from agent_bal_trans  where inddate=@inddate");
            cmd.Parameters.AddWithValue("@inddate", GetLowDate(fromdate));
            DataTable dtagent_trans = vdm.SelectQuery(cmd).Tables[0];
            DataTable dtrouteamount = new DataTable();
            DataTable dtsalescollection = new DataTable();
            Report = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("Route Name");
            Report.Columns.Add("Agent Name");
            Report.Columns.Add("Oppening Balance");
            Report.Columns.Add("Sale Value").DataType = typeof(Double);
            Report.Columns.Add("Paid Amount").DataType = typeof(Double);
            Report.Columns.Add("Closing Amount").DataType = typeof(Double);
            double totalsalevalue = 0;
            double totalamountpaid = 0;
            int Totalcount = 1;
            string RouteName = "";
            int i = 1;
            DataView view = new DataView(dtroutes);
            DataTable dtdistinct = view.ToTable(true, "RouteName", "branchid");
            foreach (DataRow drroutes in dtroutes.Rows)
            {
                DataRow newrow = Report.NewRow();
                newrow["Agent Name"] = drroutes["branchname"].ToString();
                newrow["Sno"] = i++;
                foreach (DataRow drroute in dtdistinct.Select("branchid='" + drroutes["branchid"].ToString() + "'"))
                {
                    if (RouteName != drroute["RouteName"].ToString())
                    {
                        if (Totalcount == 1)
                        {
                            newrow["Route Name"] = drroute["RouteName"].ToString();
                            Totalcount++;
                        }
                        else
                        {
                            newrow["Route Name"] = "";
                        }
                        RouteName = drroute["RouteName"].ToString();
                    }
                    else
                    {
                        Totalcount = 1;
                    }
                }
                foreach (DataRow drsale in dtagent_trans.Select("agentid='" + drroutes["Agentid"].ToString() + "'"))
                {
                    
                    double salevalue = 0;
                    double amountpaid = 0;
                    double oppbalance = 0;
                    double.TryParse(drsale["salesvalue"].ToString(), out salevalue);
                    newrow["Sale Value"] = Math.Round(salevalue, 2);
                    totalsalevalue += Math.Round(salevalue, 2);
                    double.TryParse(drsale["paidamount"].ToString(), out amountpaid);
                    newrow["Paid Amount"] = Math.Round(amountpaid, 2);
                    totalamountpaid += Math.Round(amountpaid, 2);
                    double.TryParse(drsale["opp_balance"].ToString(), out oppbalance);
                    newrow["Oppening Balance"] = Math.Round(oppbalance, 2);
                    newrow["Closing Amount"] = drsale["clo_balance"].ToString();
                    Report.Rows.Add(newrow);
                }
            }
            DataRow newrow2 = Report.NewRow();
            Report.Rows.Add(newrow2);
            DataRow TotRow = Report.NewRow();
            TotRow["Agent Name"] = "Total";
            TotRow["Sale Value"] = totalsalevalue;
            TotRow["Paid Amount"] = totalamountpaid;
            Report.Rows.Add(TotRow);
            DataRow newbreak1 = Report.NewRow();
            newbreak1["Agent Name"] = "";
            Report.Rows.Add(newbreak1);
            grdReports.DataSource = Report;
            grdReports.DataBind();
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
            lblmessage.Text = ex.Message;
        }
    }
}