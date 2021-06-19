﻿using MySql.Data.MySqlClient;
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
            lblDate.Text = fromdate.AddDays(-1).ToString("dd/MMM/yyyy");
            string BranchID = ddlSalesOffice.SelectedValue;
            cmd = new MySqlCommand("SELECT  modifiedroutes.RouteName, modifiedroutes.sno as routeid,  modifiedroutesubtable.BranchID,       branchdata.BranchName  FROM    modifiedroutes        INNER JOIN    modifiedroutesubtable ON modifiedroutes.Sno = modifiedroutesubtable.RefNo        INNER JOIN    branchdata ON modifiedroutesubtable.BranchID = branchdata.sno  WHERE      (modifiedroutes.BranchID = @BranchID)         AND(modifiedroutesubtable.EDate IS NULL)         AND(modifiedroutesubtable.CDate <= @starttime) AND (branchdata.flag=@flag) OR (modifiedroutes.BranchID = @BranchID)AND(modifiedroutesubtable.EDate > @starttime)         AND(modifiedroutesubtable.CDate <= @starttime) AND (branchdata.flag=@flag) GROUP BY branchdata.BranchName  ORDER BY modifiedroutes.RouteName");
            cmd.Parameters.AddWithValue("@branchid", BranchID);
            cmd.Parameters.AddWithValue("@flag", "1");
            cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
            cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
            DataTable dtble = vdm.SelectQuery(cmd).Tables[0];

            cmd = new MySqlCommand("SELECT * FROM agent_bal_trans WHERE inddate between @d1 and @d2");
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
            DataTable dtagenttrans = vdm.SelectQuery(cmd).Tables[0];

            cmd = new MySqlCommand("SELECT sum(AmountPaid) as AmountPaid,Branchid FROM collections WHERE PaidDate between @d1 and @d2 AND PaymentType <> 'Cash' group by Branchid");
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            DataTable dtcollections = vdm.SelectQuery(cmd).Tables[0];

            DataTable dtrouteamount = new DataTable();
            DataTable dtsalescollection = new DataTable();
            Report = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("Route Name");
            Report.Columns.Add("Agent Code");
            Report.Columns.Add("Agent Name");
            Report.Columns.Add("Oppening Balance");
            Report.Columns.Add("Sale Value").DataType = typeof(Double);
            Report.Columns.Add("Paid Amount").DataType = typeof(Double);
            Report.Columns.Add("Bank Transfer").DataType = typeof(Double);
            Report.Columns.Add("Closing Amount").DataType = typeof(Double);
            int Totalcount = 1;
            string RouteName = "";
            int i = 1;
            DataView view = new DataView(dtble);
            string routeid = "";
            string finalrouteid = "";
            DataTable distincttable = view.ToTable(true, "BranchName", "BranchID", "RouteName", "routeid");
            double ftotalsalesvalue = 0;
            double ftotalpaidamount = 0;
            double ftotalbankTransfer = 0;
            foreach (DataRow branch in distincttable.Rows)
            {
                DataRow newrow = Report.NewRow();
                newrow["SNo"] = i;
                finalrouteid = branch["routeid"].ToString();
                if (RouteName != branch["RouteName"].ToString())
                {
                    if (Totalcount == 1)
                    {
                        newrow["Route Name"] = branch["RouteName"].ToString();
                        Totalcount++;
                    }
                    else
                    {
                        DataRow newvar = Report.NewRow();
                        newvar["Agent Name"] = "Total";
                        int route = 0;
                        int.TryParse(routeid, out route);
                        foreach (DataRow dr in dtble.Select("RouteID='" + route + "'"))
                        {
                            if (branch["BranchName"].ToString() == dr["BranchName"].ToString())
                            {
                                foreach (DataRow drcollections in dtcollections.Select("Branchid='" + dr["BranchID"].ToString() + "'"))
                                {
                                    double banktransfervalue = 0;
                                    double.TryParse(drcollections["AmountPaid"].ToString(), out banktransfervalue);
                                    newrow["Bank Transfer"] = banktransfervalue;
                                    ftotalbankTransfer += banktransfervalue;
                                }
                                foreach (DataRow drtrans in dtagenttrans.Select("agentid='" + dr["BranchID"].ToString() + "'"))
                                {
                                    double salesvalue = 0;
                                    double.TryParse(drtrans["salesvalue"].ToString(), out salesvalue);
                                    ftotalsalesvalue += salesvalue;
                                    double paidamount = 0;
                                    double.TryParse(drtrans["paidamount"].ToString(), out paidamount);
                                    ftotalpaidamount += paidamount;
                                }


                            }
                        }
                        newvar["Sale Value"] = Math.Round(ftotalsalesvalue, 2);
                        newvar["Paid Amount"] = Math.Round(ftotalpaidamount, 2);
                        newvar["Bank Transfer"] = Math.Round(ftotalbankTransfer, 2);


                        double totCurdavg = 0;
                        totCurdavg = Math.Round(totCurdavg, 2);
                        Report.Rows.Add(newvar);
                        ftotalsalesvalue = 0;
                        ftotalpaidamount = 0;
                        ftotalbankTransfer = 0;
                        newrow["Route Name"] = branch["RouteName"].ToString();
                        Totalcount++;
                        DataRow space = Report.NewRow();
                        space["Agent Name"] = "";
                        Report.Rows.Add(space);
                        routeid = branch["routeid"].ToString();
                    }
                }
                else
                {
                    newrow["Route Name"] = "";
                    routeid = branch["routeid"].ToString();
                }
                RouteName = branch["RouteName"].ToString();
                newrow["Agent Code"] = branch["BranchID"].ToString();
                newrow["Agent Name"] = branch["BranchName"].ToString();
                double totalmilkSale = 0;
                foreach (DataRow dr in dtble.Rows)
                {
                    if (branch["BranchName"].ToString() == dr["BranchName"].ToString())
                    {
                        DataRow[] dragenttrans = dtagenttrans.Select("agentid='" + dr["BranchID"].ToString() + "'");
                        if (dragenttrans.Length <= 0) 
                        {
                            cmd = new MySqlCommand("SELECT MAX(sno) as sno FROM agent_bal_trans WHERE agentid=@Branchid");
                            cmd.Parameters.AddWithValue("@Branchid", dr["BranchID"].ToString());
                            DataTable dtPrev_trans = vdm.SelectQuery(cmd).Tables[0];
                            if (dtPrev_trans.Rows.Count > 0)
                            {
                                string sno = dtPrev_trans.Rows[0]["sno"].ToString();
                                if (sno == "")
                                {
                                    double closingbalance = 0;
                                    newrow["Oppening Balance"] = closingbalance;
                                    newrow["Closing Amount"] = closingbalance;
                                    newrow["Sale Value"] = closingbalance;
                                    newrow["Paid Amount"] = closingbalance;
                                }
                                else
                                {
                                    cmd = new MySqlCommand("SELECT agentid, opp_balance, inddate, salesvalue, clo_balance FROM agent_bal_trans WHERE sno=@sno");
                                    cmd.Parameters.AddWithValue("@sno", dtPrev_trans.Rows[0]["sno"].ToString());
                                    DataTable dtagent_value = vdm.SelectQuery(cmd).Tables[0];
                                    if (dtagent_value.Rows.Count > 0)
                                    {
                                        double closingbalance = 0;
                                        double.TryParse(dtagent_value.Rows[0]["clo_balance"].ToString(), out closingbalance);
                                        closingbalance = Math.Round(closingbalance, 2);
                                        newrow["Oppening Balance"] = closingbalance;
                                        newrow["Closing Amount"] = closingbalance;
                                        newrow["Sale Value"] = 0;
                                        newrow["Paid Amount"] = 0;
                                    }
                                }
                            }
                            else
                            {
                                double closingbalance = 0;
                                newrow["Oppening Balance"] = closingbalance;
                                newrow["Closing Amount"] = closingbalance;
                                newrow["Sale Value"] = closingbalance;
                                newrow["Paid Amount"] = closingbalance;
                            }
                        }
                        foreach (DataRow drcollections in dtcollections.Select("Branchid='" + dr["BranchID"].ToString() + "'"))
                        {
                            double banktransfervalue = 0;
                            double.TryParse(drcollections["AmountPaid"].ToString(), out banktransfervalue);
                            newrow["Bank Transfer"] = banktransfervalue;
                            ftotalbankTransfer += banktransfervalue;
                        }
                        foreach (DataRow drtrans in dtagenttrans.Select("agentid='" + dr["BranchID"].ToString() + "'"))
                        {
                            newrow["Oppening Balance"] = drtrans["opp_balance"].ToString();
                            double salesvalue = 0;
                            double.TryParse(drtrans["salesvalue"].ToString(), out salesvalue);
                            newrow["Sale Value"] = salesvalue;
                            ftotalsalesvalue += salesvalue;
                            double paidamount = 0;
                            double.TryParse(drtrans["paidamount"].ToString(), out paidamount);
                            newrow["Paid Amount"] = paidamount;
                            ftotalpaidamount += paidamount;
                            newrow["Closing Amount"] = drtrans["clo_balance"].ToString();
                        }
                    }
                }
                Report.Rows.Add(newrow);
                routeid = branch["routeid"].ToString();
                i++;
            }
            DataRow newrow2 = Report.NewRow();
            Report.Rows.Add(newrow2);
            DataRow TotRow = Report.NewRow();
            TotRow["Agent Name"] = "Total";
            TotRow["Sale Value"] = ftotalsalesvalue;
            TotRow["Paid Amount"] = ftotalpaidamount;
            TotRow["Bank Transfer"] = ftotalbankTransfer;
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