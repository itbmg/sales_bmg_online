
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Drawing;
using System.IO;

public partial class TimingReport : System.Web.UI.Page
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
                lblTitle.Text = Session["TitleName"].ToString();
                FillRouteName();
                txtdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
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
                cmd = new MySqlCommand("SELECT DispName, sno FROM dispatch WHERE (Branch_Id = @BranchD) and (flag=@flag)");
                cmd.Parameters.AddWithValue("@BranchD", Session["branch"].ToString());
                cmd.Parameters.AddWithValue("@flag", "1");
                DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                ddlRouteName.DataSource = dtRoutedata;
                ddlRouteName.DataTextField = "DispName";
                ddlRouteName.DataValueField = "sno";
                ddlRouteName.DataBind();
            }
            else
            {
                cmd = new MySqlCommand("SELECT dispatch.DispName, dispatch.sno FROM dispatch INNER JOIN branchdata ON dispatch.Branch_Id = branchdata.sno INNER JOIN branchdata branchdata_1 ON dispatch.Branch_Id = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) and (dispatch.flag=@flag)) OR ((branchdata_1.SalesOfficeID = @SOID) and (dispatch.flag=@flag))");
                //cmd = new MySqlCommand("SELECT DispName, sno FROM dispatch WHERE (Branch_Id = @BranchD)");
                cmd.Parameters.AddWithValue("@BranchID", Session["branch"].ToString());
                cmd.Parameters.AddWithValue("@SOID", Session["branch"].ToString());
                cmd.Parameters.AddWithValue("@flag", "1");
                DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                ddlRouteName.DataSource = dtRoutedata;
                ddlRouteName.DataTextField = "DispName";
                ddlRouteName.DataValueField = "sno";
                ddlRouteName.DataBind();
            }


            //if (Session["salestype"].ToString() == "Plant")
            //{
            //    cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType)");
            //    cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
            //    cmd.Parameters.AddWithValue("@SalesType", "21");
            //    DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
            //    //if (ddlSalesOffice.SelectedIndex == -1)
            //    //{
            //    //    ddlSalesOffice.SelectedItem.Text = "Select";
            //    //}
            //    ddlRouteName.DataSource = dtRoutedata;
            //    ddlRouteName.DataTextField = "BranchName";
            //    ddlRouteName.DataValueField = "sno";
            //    ddlRouteName.DataBind();
            //    ddlRouteName.Items.Insert(0, new ListItem("Select", "0"));
            //}
            //else
            //{
            //    cmd = new MySqlCommand("SELECT dispatch.DispName, dispatch.sno FROM dispatch INNER JOIN branchdata ON dispatch.Branch_Id = branchdata.sno INNER JOIN branchdata branchdata_1 ON dispatch.Branch_Id = branchdata_1.sno WHERE (branchdata.sno = @BranchID) OR (branchdata_1.SalesOfficeID = @SOID)");
            //    //cmd = new MySqlCommand("SELECT DispName, sno FROM dispatch WHERE (Branch_Id = @BranchD)");
            //    cmd.Parameters.AddWithValue("@BranchID", Session["branch"].ToString());
            //    cmd.Parameters.AddWithValue("@SOID", Session["branch"].ToString());
            //    DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
            //    ddlRouteName.DataSource = dtRoutedata;
            //    ddlRouteName.DataTextField = "DispName";
            //    ddlRouteName.DataValueField = "sno";
            //    ddlRouteName.DataBind();
            //}
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
    void GetReport()
    {
        try
        {
            lblmsg.Text = "";
            pnlHide.Visible = true;
            vdm = new VehicleDBMgr();
            Session["RouteName"] = ddlRouteName.SelectedItem.Text;
            Session["IDate"] = DateTime.Now.AddDays(1).ToString("dd/MM/yyyy");
            string[] datestrig = txtdate.Text.Split(' ');
            DateTime MyDateTime = new DateTime();
            DateTime CollectionDateTime = new DateTime();
            if (datestrig.Length > 1)
            {
                if (datestrig[0].Split('-').Length > 0)
                {
                    string[] dates = datestrig[0].Split('-');
                    string[] times = datestrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            Session["filename"] = "TIMING REPORT";
            lblDate.Text = fromdate.ToString("dd/MMM/yyyy");
            if (Session["salestype"].ToString() == "Plant")
            {
                if (ddlStatus.SelectedValue == "Direct")
                {
                    lblRouteName.Text = ddlRouteName.SelectedItem.Text;
                    DataTable Report = new DataTable();
                    Report.Columns.Add("Sno");
                    Report.Columns.Add("Agent Name");
                    Report.Columns.Add("Product Delivery Time");
                    Report.Columns.Add("Amount Collection Time");
                    //Report.Columns.Add("Inventory Delivery Time");
                    //Report.Columns.Add("Inventory Collection Time");

                    cmd = new MySqlCommand("SELECT branchdata.BranchName, indents_subtable.DelTime as DateTime FROM dispatch_sub INNER JOIN dispatch ON dispatch_sub.dispatch_sno = dispatch.sno INNER JOIN branchroutes ON dispatch_sub.Route_id = branchroutes.Sno INNER JOIN branchroutesubtable ON branchroutes.Sno = branchroutesubtable.RefNo INNER JOIN branchdata ON branchroutesubtable.BranchID = branchdata.sno INNER JOIN indents ON branchdata.sno = indents.Branch_id INNER JOIN indents_subtable ON indents.IndentNo = indents_subtable.IndentNo WHERE (dispatch.sno = @dispatchSno) AND (indents.I_date between @starttime AND  @endtime) GROUP BY branchdata.BranchName ORDER BY DateTime");
                    cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
                    cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
                    cmd.Parameters.AddWithValue("@dispatchSno", ddlRouteName.SelectedValue);
                    DataTable dtTime = vdm.SelectQuery(cmd).Tables[0];
                    cmd = new MySqlCommand("SELECT collections.PayTime, tripdata.Sno, triproutes.Tripdata_sno, collections.Branchid, branchdata.BranchName FROM collections INNER JOIN tripdata ON collections.tripId = tripdata.Sno INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno INNER JOIN branchdata ON collections.Branchid = branchdata.sno WHERE (tripdata.I_Date BETWEEN @d1 AND @d2) AND (dispatch.sno = @dispatchSno) GROUP BY branchdata.BranchName");
                    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                    cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                    cmd.Parameters.AddWithValue("@dispatchSno", ddlRouteName.SelectedValue);
                    DataTable dtPayTime = vdm.SelectQuery(cmd).Tables[0];

                    if (dtTime.Rows.Count > 0)
                    {
                        int i = 1;
                        foreach (DataRow dr in dtTime.Rows)
                        {
                            DataRow newrow = Report.NewRow();
                            foreach (DataRow drp in dtPayTime.Rows)
                            {
                                if (dr["BranchName"].ToString() == drp["BranchName"].ToString())
                                {
                                    newrow["Sno"] = i;
                                    newrow["Agent Name"] = dr["BranchName"].ToString();
                                    MyDateTime = Convert.ToDateTime(dr["DateTime"].ToString());
                                    string MyString;
                                    MyString = MyDateTime.ToString("HH:mm");
                                    newrow["Product Delivery Time"] = MyString;
                                    CollectionDateTime = Convert.ToDateTime(drp["PayTime"].ToString());
                                    string colldate;
                                    colldate = CollectionDateTime.ToString("HH:mm");
                                    newrow["Amount Collection Time"] = colldate;
                                    i++;
                                    Report.Rows.Add(newrow);
                                }
                            }

                        }

                        grdReports.DataSource = Report;
                        grdReports.DataBind();
                        Session["xportdata"] = Report;
                    }
                    else
                    {
                        pnlHide.Visible = false;
                        grdReports.DataSource = Report;
                        grdReports.DataBind();
                        lblmsg.Text = "No Data Were found";
                    }
                }
                else if (ddlStatus.SelectedValue == "Sales Office")
                {
                    lblRouteName.Text = ddlRouteName.SelectedItem.Text;
                    cmd = new MySqlCommand("SELECT  dispatch_1.DispName , tripdata_1.AssignDate FROM dispatch INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno INNER JOIN tripdata tripdata_1 ON tripdata.Sno = tripdata_1.ATripid INNER JOIN triproutes triproutes_1 ON tripdata_1.Sno = triproutes_1.Tripdata_sno INNER JOIN dispatch dispatch_1 ON triproutes_1.RouteID = dispatch_1.sno WHERE (dispatch.sno = @dispatchSno) and(tripdata_1.I_Date between @starttime and @endtime) group by dispatch_1.DispName , tripdata_1.I_Date");
                    cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
                    cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
                    cmd.Parameters.AddWithValue("@dispatchSno", ddlRouteName.SelectedValue);
                    DataTable dtTime = vdm.SelectQuery(cmd).Tables[0];
                    if (dtTime.Rows.Count > 0)
                    {
                        grdReports.DataSource = dtTime;
                        grdReports.DataBind();
                        Session["xportdata"] = dtTime;

                    }
                    else
                    {
                        pnlHide.Visible = false;
                        grdReports.DataSource = dtTime;
                        grdReports.DataBind();
                        lblmsg.Text = "No Data Were found";
                    }
                }
                else
                {
                    DataTable TimeReport = new DataTable();
                    TimeReport.Columns.Add("Sno");
                    TimeReport.Columns.Add("Branch Name");
                    TimeReport.Columns.Add("Indent Time");
                    TimeReport.Columns.Add("Despatch Time");
                    TimeReport.Columns.Add("Closing Time");
                    TimeReport.Columns.Add("Despatcher Name");
                    cmd = new MySqlCommand("SELECT branchdata.BranchName, tripdata.Plantime AS IndentTime, tripdata.DispTime, clotrans.IndDate AS ClosingTime, empmanage.EmpName FROM empmanage INNER JOIN clotrans ON empmanage.Sno = clotrans.EmpId RIGHT OUTER JOIN tripdata INNER JOIN branchmappingtable ON tripdata.BranchID = branchmappingtable.SuperBranch INNER JOIN branchdata ON branchmappingtable.SubBranch = branchdata.sno ON clotrans.BranchId = branchdata.sno WHERE (tripdata.I_Date BETWEEN @d1 AND @d2) AND (tripdata.BranchID = 172) AND (branchdata.SalesType = 21) AND (clotrans.IndDate BETWEEN @a1 AND @a2) GROUP BY branchdata.BranchName, empmanage.EmpName");
                    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                    cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                    cmd.Parameters.AddWithValue("@a1", GetLowDate(fromdate.AddDays(-1)));
                    cmd.Parameters.AddWithValue("@a2", GetHighDate(fromdate.AddDays(-1)));
                    DataTable dtTime = vdm.SelectQuery(cmd).Tables[0];
                    if (dtTime.Rows.Count > 0)
                    {
                         int i = 1;
                         foreach (DataRow dr in dtTime.Rows)
                         {
                             DataRow newrow = TimeReport.NewRow();
                             newrow["Sno"] = i++.ToString();
                             newrow["Branch Name"] = dr["BranchName"].ToString();
                             newrow["Indent Time"] = dr["IndentTime"].ToString();
                             newrow["Despatch Time"] = dr["DispTime"].ToString();
                             DateTime closingtime = Convert.ToDateTime(dr["ClosingTime"].ToString());
                             closingtime = closingtime.AddDays(1);
                             newrow["Closing Time"] = closingtime;
                             newrow["Despatcher Name"] = dr["EmpName"].ToString();
                             TimeReport.Rows.Add(newrow);
                         }
                         grdReports.DataSource = TimeReport;
                        grdReports.DataBind();
                        Session["xportdata"] = TimeReport;

                    }
                    else
                    {
                        pnlHide.Visible = false;
                        grdReports.DataSource = TimeReport;
                        grdReports.DataBind();
                        lblmsg.Text = "No Data Were found";
                    }
                }
            }
            else
            {
                DataTable TimeReport = new DataTable();
                TimeReport.Columns.Add("Sno");
                TimeReport.Columns.Add("Agent Name");
                TimeReport.Columns.Add("Product Delivery Time");
               // TimeReport.Columns.Add("Inventory Delivery Time");
                TimeReport.Columns.Add("Amount Collection Time");
                TimeReport.Columns.Add("Inventory Collection Time");
                TimeReport.Columns.Add("Indent Time");

                cmd = new MySqlCommand("SELECT branchdata.BranchName,indents.I_Date, indents_subtable.DelTime as DateTime FROM dispatch_sub INNER JOIN dispatch ON dispatch_sub.dispatch_sno = dispatch.sno INNER JOIN branchroutes ON dispatch_sub.Route_id = branchroutes.Sno INNER JOIN branchroutesubtable ON branchroutes.Sno = branchroutesubtable.RefNo INNER JOIN branchdata ON branchroutesubtable.BranchID = branchdata.sno INNER JOIN indents ON branchdata.sno = indents.Branch_id INNER JOIN indents_subtable ON indents.IndentNo = indents_subtable.IndentNo WHERE (dispatch.sno = @dispatchSno) AND (indents.I_date between @starttime AND  @endtime) AND (indents_subtable.DelTime IS NOT NULL) GROUP BY branchdata.BranchName ORDER BY DateTime");
                cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@dispatchSno", ddlRouteName.SelectedValue);
                DataTable dtTime = vdm.SelectQuery(cmd).Tables[0];
                cmd = new MySqlCommand("SELECT collections.PayTime, tripdata.Sno, triproutes.Tripdata_sno, collections.Branchid, branchdata.BranchName FROM collections INNER JOIN tripdata ON collections.tripId = tripdata.Sno INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno INNER JOIN branchdata ON collections.Branchid = branchdata.sno WHERE (tripdata.I_Date BETWEEN @d1 AND @d2) AND (dispatch.sno = @dispatchSno) GROUP BY branchdata.BranchName");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@dispatchSno", ddlRouteName.SelectedValue);
                DataTable dtPayTime = vdm.SelectQuery(cmd).Tables[0];
                cmd = new MySqlCommand("SELECT tripdata.Sno, triproutes.Tripdata_sno, tripdata.AssignDate FROM tripdata INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno WHERE (tripdata.I_Date BETWEEN @d1 AND @d2) AND (dispatch.sno = @dispatchSno)");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@dispatchSno", ddlRouteName.SelectedValue);
                DataTable dt_dispTime = vdm.SelectQuery(cmd).Tables[0];
                cmd = new MySqlCommand("SELECT invtransactions12.DeliveryTime, invtransactions12.ToTran, branchdata.BranchName FROM dispatch INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN (SELECT Sno, I_Date FROM tripdata WHERE (I_Date BETWEEN @d1 AND @d2)) tripdat ON triproutes.Tripdata_sno = tripdat.Sno INNER JOIN invtransactions12 ON tripdat.Sno = invtransactions12.FromTran INNER JOIN branchdata ON invtransactions12.ToTran = branchdata.sno WHERE (dispatch.sno = @dispatchSno) AND (invtransactions12.DeliveryTime IS NOT NULL)");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@dispatchSno", ddlRouteName.SelectedValue);
                DataTable dtDeltime = vdm.SelectQuery(cmd).Tables[0];
                cmd = new MySqlCommand("SELECT invtransactions12.CollectionTime, branchdata.BranchName FROM dispatch INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN (SELECT Sno, I_Date FROM tripdata WHERE (I_Date BETWEEN @d1 AND @d2)) tripdat ON triproutes.Tripdata_sno = tripdat.Sno INNER JOIN invtransactions12 ON tripdat.Sno = invtransactions12.ToTran INNER JOIN branchdata ON invtransactions12.FromTran = branchdata.sno WHERE (dispatch.sno = @dispatchSno)");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@dispatchSno", ddlRouteName.SelectedValue);
                DataTable dtColtime = vdm.SelectQuery(cmd).Tables[0];
                if(dt_dispTime.Rows.Count>0)
                {
                    //lbldisptime.Text = dt_dispTime.Rows[0]["AssignDate"].ToString();
                    DateTime disptime = Convert.ToDateTime(dt_dispTime.Rows[0]["AssignDate"].ToString());
                    lbldisptime.Text = disptime.ToString("HH:mm");
                }
                if (dtTime.Rows.Count > 0)
                {
                    int i = 1;
                    foreach (DataRow dr in dtTime.Rows)
                    {
                        DataRow newrow = TimeReport.NewRow();
                        foreach (DataRow drp in dtPayTime.Rows)
                        {
                            if (dr["BranchName"].ToString() == drp["BranchName"].ToString())
                            {
                                newrow["Sno"] = i;
                                newrow["Agent Name"] = dr["BranchName"].ToString();
                                String MyString = "";
                                string Inddate;

                                if (dr["I_Date"].ToString() == "")
                                {
                                    Inddate = "";

                                }
                                else
                                {
                                    DateTime IndTime = Convert.ToDateTime(dr["I_Date"].ToString());
                                    Inddate = IndTime.ToString("HH:mm");
                                }
                                
                                if (Inddate == "00:00")
                                {
                                    if (dr["DateTime"].ToString() != "")
                                    {
                                        MyDateTime = Convert.ToDateTime(dr["DateTime"].ToString());
                                        MyString = MyDateTime.ToString("HH:mm");
                                        newrow["Indent Time"] = MyString;

                                    }
                                    else
                                    {
                                        newrow["Indent Time"] = MyString;
                                    }
                                    //MyDateTime = Convert.ToDateTime(dr["DateTime"].ToString());
                                    //MyString = MyDateTime.ToString("HH:mm");
                                    //newrow["Indent Time"] = MyString;
                                }
                                if(Inddate != "00:00")
                                {
                                    newrow["Indent Time"] = Inddate;
                                }
                                if (dr["DateTime"].ToString() == "")
                                {
                                    MyString = "";

                                }
                                if (dr["DateTime"].ToString() != "")
                                {
                                    MyDateTime = Convert.ToDateTime(dr["DateTime"].ToString());
                                    MyString = MyDateTime.ToString("HH:mm");
                                }

                                newrow["Product Delivery Time"] = MyString;
                                CollectionDateTime = Convert.ToDateTime(drp["PayTime"].ToString());
                                string colldate;
                                colldate = CollectionDateTime.ToString("HH:mm");
                                newrow["Amount Collection Time"] = colldate;
                                i++;
                                TimeReport.Rows.Add(newrow);
                            }
                        }

                    }
                    //foreach (DataRow drreport in TimeReport.Rows)
                    //{
                    //    foreach (DataRow drinvd in dtDeltime.Rows)
                    //    {

                    //        if (drreport[1].ToString() == drinvd["BranchName"].ToString())
                    //        {
                    //            string MyString;

                    //            if (drinvd["DeliveryTime"].ToString() == "")
                    //            {
                    //                MyString = "";

                    //            }
                    //            else
                    //            {
                    //                MyDateTime = Convert.ToDateTime(drinvd["DeliveryTime"].ToString());
                    //                MyString = MyDateTime.ToString("HH:mm");
                    //            }
                    //            // MyDateTime = Convert.ToDateTime(drinvd["DeliveryTime"].ToString());
                    //            //MyString = MyDateTime.ToString("HH:mm:ss dd-MMMM-yyyy");
                    //            drreport[3] = MyString;
                    //        }

                    //    }

                    //}
                    foreach (DataRow drCreport in TimeReport.Rows)
                    {
                        foreach (DataRow drCinvd in dtColtime.Rows)
                        {

                            if (drCreport[1].ToString() == drCinvd["BranchName"].ToString())
                            {
                                string MyString;

                                if (drCinvd["CollectionTime"].ToString() == "")
                                {
                                    MyString = "";

                                }
                                else
                                {
                                    MyDateTime = Convert.ToDateTime(drCinvd["CollectionTime"].ToString());
                                    MyString = MyDateTime.ToString("HH:mm");
                                }
                                //MyDateTime = Convert.ToDateTime(drCinvd["CollectionTime"].ToString());
                                //MyString = MyDateTime.ToString("HH:mm:ss dd-MMMM-yyyy");
                                drCreport[4] = MyString;
                            }

                        }

                    }
                    grdReports.DataSource = TimeReport;
                    grdReports.DataBind();
                    Session["xportdata"] = TimeReport;
                    for (int ii = 0; ii < grdReports.Rows.Count; ii++)
                    {
                        GridViewRow dgvr = grdReports.Rows[ii];
                        if (dgvr.Cells[2].Text != dgvr.Cells[3].Text)
                        {
                            //GridViewRow compare = grdReports.Rows[ii + 1];
                            DateTime dtmydatetime2 = DateTime.Now;
                            string dt1 = dgvr.Cells[2].Text;
                            string dt2 = dgvr.Cells[3].Text;
                            if (dt1 != "&nbsp;")
                            {
                                MyDateTime = Convert.ToDateTime(dt1);
                            }
                            if (dt2 != "&nbsp;")
                            {
                                dtmydatetime2 = Convert.ToDateTime(dt2);

                            }
                            DateTime dtcell2=DateTime.Now;
                            DateTime dtcell3=DateTime.Now;
                            dt1 = MyDateTime.ToString("HH:mm");
                            dt2 = dtmydatetime2.ToString("HH:mm");
                            dtcell2 = Convert.ToDateTime(dt1);
                            dtcell3 = Convert.ToDateTime(dt2);

                            var hours = (dtcell3 - dtcell2).TotalMinutes;
                            if (hours > 15)
                            {
                                dgvr.Cells[2].BackColor = Color.LawnGreen;
                                dgvr.Cells[3].BackColor = Color.SandyBrown;
                            }
                            //for (int rowcnt = 2; rowcnt < dgvr.Cells.Count; rowcnt++)
                            //{
                            //    if (dgvr.Cells[rowcnt].Text != compare.Cells[rowcnt].Text)
                            //    {
                            //        compare.Cells[rowcnt].BackColor = Color.SandyBrown;
                            //    }

                            //}


                        }
                    }
                    
                }
                else
                {
                    pnlHide.Visible = false;
                    grdReports.DataSource = TimeReport;
                    grdReports.DataBind();
                    lblmsg.Text = "No Data Were found";
                }
            }

        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
        }

    }
}