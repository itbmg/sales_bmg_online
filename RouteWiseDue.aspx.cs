using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using ClosedXML.Excel;
using System.IO;
public partial class RouteWiseDue : System.Web.UI.Page
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
                //txtdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
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
                DataTable dtBranch = new DataTable();
                dtBranch.Columns.Add("BranchName");
                dtBranch.Columns.Add("sno");
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType) and (branchdata.flag<>0) ");
                cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
                cmd.Parameters.AddWithValue("@SalesType", "4");
                cmd.Parameters.AddWithValue("@SalesType1", "26");
                DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                foreach (DataRow dr in dtRoutedata.Rows)
                {
                    DataRow newrow = dtBranch.NewRow();
                    newrow["BranchName"] = dr["BranchName"].ToString();
                    newrow["sno"] = dr["sno"].ToString();
                    dtBranch.Rows.Add(newrow);
                }
                cmd = new MySqlCommand("SELECT BranchName, sno FROM  branchdata WHERE (sno = @BranchID) and branchdata.flag<>0");
                cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                DataTable dtPlant = vdm.SelectQuery(cmd).Tables[0];
                foreach (DataRow dr in dtPlant.Rows)
                {
                    DataRow newrow = dtBranch.NewRow();
                    newrow["BranchName"] = dr["BranchName"].ToString();
                    newrow["sno"] = dr["sno"].ToString();
                    dtBranch.Rows.Add(newrow);
                }
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType and branchdata.flag<>0)");
                cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
                cmd.Parameters.AddWithValue("@SalesType", "6");
                DataTable dtNewPlant = vdm.SelectQuery(cmd).Tables[0];
                foreach (DataRow dr in dtNewPlant.Rows)
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
                PBranch.Visible = false;

                cmd = new MySqlCommand("SELECT dispatch.DispName, dispatch.sno FROM dispatch INNER JOIN branchdata ON dispatch.Branch_Id = branchdata.sno INNER JOIN branchdata branchdata_1 ON dispatch.Branch_Id = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) AND (dispatch.flag=@flag)) OR ((branchdata_1.SalesOfficeID = @SOID) AND (dispatch.flag=@flag))");
                cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
                cmd.Parameters.AddWithValue("@flag", "1");
                DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                ddlRouteName.DataSource = dtRoutedata;
                ddlRouteName.DataTextField = "DispName";
                ddlRouteName.DataValueField = "sno";
                ddlRouteName.DataBind();
            }
        }
        catch
        {
        }
    }
    protected void ddlSalesOffice_SelectedIndexChanged(object sender, EventArgs e)
    {
        vdm = new VehicleDBMgr();
        cmd = new MySqlCommand("SELECT dispatch.DispName, dispatch.sno FROM dispatch INNER JOIN branchdata ON dispatch.Branch_Id = branchdata.sno INNER JOIN branchdata branchdata_1 ON dispatch.Branch_Id = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) AND (dispatch.flag=@flag)) OR ((branchdata_1.SalesOfficeID = @SOID) AND (dispatch.flag=@flag))");
        cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
        cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
        cmd.Parameters.AddWithValue("@flag", "1");
        DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
        ddlRouteName.DataSource = dtRoutedata;
        ddlRouteName.DataTextField = "DispName";
        ddlRouteName.DataValueField = "sno";
        ddlRouteName.DataBind();
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
    void GetReport()
    {
        try
        {
            lblmsg.Text = "";
            pnlHide.Visible = true;
            Session["RouteName"] = ddlRouteName.SelectedItem.Text;
            lblRouteName.Text = ddlRouteName.SelectedItem.Text;
            vdm = new VehicleDBMgr();
            DateTime ServerDateCurrentdate = VehicleDBMgr.GetTime(vdm.conn);

            DataTable Report = new DataTable();

            //string[] datestrig = txtdate.Text.Split(' ');
            //if (datestrig.Length > 1)
            //{
            //    if (datestrig[0].Split('-').Length > 0)
            //    {
            //        string[] dates = datestrig[0].Split('-');
            //        string[] times = datestrig[1].Split(':');
            //        fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
            //    }
            //}
            //lblDate.Text = ServerDateCurrentdate.ToString("dd/MMM/yyyy");
            Session["filename"] = ddlRouteName.SelectedItem.Text + "-> DUE REPORT";
            // cmd.Parameters.AddWithValue("SELECT branchdata.sno, branchdata.BranchName, branchaccounts.Amount FROM dispatch INNER JOIN branchroutes ON dispatch.Route_id = branchroutes.Sno INNER JOIN branchroutesubtable ON branchroutes.Sno = branchroutesubtable.RefNo INNER JOIN branchdata ON branchroutesubtable.BranchID = branchdata.sno INNER JOIN branchaccounts ON branchdata.sno = branchaccounts.BranchId WHERE (dispatch.sno = 5)");
            cmd = new MySqlCommand("SELECT branchdata.sno, branchdata.BranchName,branchdata.flag FROM dispatch INNER JOIN branchroutes ON dispatch.Route_id = branchroutes.Sno INNER JOIN branchroutesubtable ON branchroutes.Sno = branchroutesubtable.RefNo INNER JOIN branchdata ON branchroutesubtable.BranchID = branchdata.sno  WHERE (dispatch.sno = @dispatchsno)");
            cmd.Parameters.AddWithValue("@dispatchsno", ddlRouteName.SelectedValue);
            DataTable dtroutedue = vdm.SelectQuery(cmd).Tables[0];
            //cmd = new MySqlCommand("SELECT branchroutesubtable.BranchID, branchdata.BranchName, branchdata.flag, indents_subtable.DeliveryQty, indents_subtable.UnitCost,SUM(indents_subtable.DeliveryQty * indents_subtable.UnitCost) AS salevalue FROM dispatch INNER JOIN branchroutesubtable ON dispatch.Route_id = branchroutesubtable.RefNo INNER JOIN branchdata ON branchroutesubtable.BranchID = branchdata.sno INNER JOIN (SELECT IndentNo, Branch_id, I_date FROM indents WHERE (I_date BETWEEN @d1 AND @d2)) indent ON branchdata.sno = indent.Branch_id INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo WHERE (dispatch.sno = @dispatchsno) GROUP BY indent.Branch_id");
            //cmd.
            cmd = new MySqlCommand("SELECT branchdata.sno, branchdata.BranchName, branchdata.flag, inventory_monitor.Inv_Sno, inventory_monitor.Qty FROM dispatch INNER JOIN branchroutes ON dispatch.Route_id = branchroutes.Sno INNER JOIN branchroutesubtable ON branchroutes.Sno = branchroutesubtable.RefNo INNER JOIN branchdata ON branchroutesubtable.BranchID = branchdata.sno LEFT OUTER JOIN inventory_monitor ON branchdata.sno = inventory_monitor.BranchId WHERE (dispatch.sno = @dispatchsno)");
            cmd.Parameters.AddWithValue("@dispatchsno", ddlRouteName.SelectedValue);
            DataTable dtrouteinventory = vdm.SelectQuery(cmd).Tables[0];
            Report = new DataTable();
            Report.Columns.Add("Agent Code");
            Report.Columns.Add("Agent Name");
            Report.Columns.Add("Status");
            Report.Columns.Add("Due Amount");
            Report.Columns.Add("Crates Bal");
            Report.Columns.Add("Can40 Bal");
            Report.Columns.Add("Can20 Bal");
            Report.Columns.Add("Can10 Bal");
            double dueamount = 0;
            float cratesbal = 0;
            float can40 = 0;
            float can20 = 0;
            float can10 = 0;

            foreach (DataRow branch in dtroutedue.Rows)
            {
                DataRow newrow = Report.NewRow();
                newrow["Agent Code"] = branch["sno"].ToString();
                newrow["Agent Name"] = branch["BranchName"].ToString();

                cmd = new MySqlCommand("SELECT opp_balance,salesvalue,paidamount,clo_balance,DATE_FORMAT(inddate, '%d %b %y') AS PDate,agentid FROM agent_bal_trans WHERE agentid=@agentid and inddate between @d1 and @d2 GROUP BY PDate order by inddate");
                cmd.Parameters.AddWithValue("@agentid", branch["sno"].ToString());
                cmd.Parameters.AddWithValue("@d1", GetLowDate(ServerDateCurrentdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(ServerDateCurrentdate.AddDays(-1)));
                DataTable dtagenttrans = vdm.SelectQuery(cmd).Tables[0];
                if (dtagenttrans.Rows.Count == 0)
                {
                    cmd = new MySqlCommand("SELECT MAX(sno) as sno FROM agent_bal_trans WHERE agentid=@Branchid AND (inddate < @d1)");
                    cmd.Parameters.AddWithValue("@Branchid", branch["sno"].ToString());
                    cmd.Parameters.AddWithValue("@d1", ServerDateCurrentdate.AddDays(-1));
                    DataTable dtPrev_trans = vdm.SelectQuery(cmd).Tables[0];
                    if (dtPrev_trans.Rows.Count > 0)
                    {
                        string sno = dtPrev_trans.Rows[0]["sno"].ToString();
                        if (sno == "")
                        {
                            double closingbalance = 0;
                            newrow["Due Amount"] = closingbalance;
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
                                string inddate = dtagent_value.Rows[0]["inddate"].ToString();
                                DateTime dtinddate = Convert.ToDateTime(inddate);
                                if (dtinddate < fromdate)
                                {
                                    closingbalance = Math.Round(closingbalance, 2);
                                    newrow["Due Amount"] = closingbalance;
                                    dueamount += closingbalance;
                                }
                                else
                                {
                                    newrow["Due Amount"] = 0;
                                }
                            }
                        }
                    }
                }
                else
                {
                    newrow["Due Amount"] = dtagenttrans.Rows[0]["clo_balance"].ToString();
                    double damt = 0;
                    double.TryParse(dtagenttrans.Rows[0]["clo_balance"].ToString(), out damt);
                    dueamount += damt;
                }
                if (branch["flag"].ToString() == "0")
                {
                    newrow["Status"] = "InActive";
                }
                else
                {
                    newrow["Status"] = "Active";
                }
                foreach (DataRow dr in dtrouteinventory.Select("sno='" + branch["sno"].ToString() + "'"))
                {
                    if (dr["Inv_Sno"].ToString() == "1")
                    {
                        newrow["Crates Bal"] = dr["Qty"].ToString();
                        float crates = 0;
                        float.TryParse(dr["Qty"].ToString(), out crates);
                        cratesbal += crates;
                    }
                    if (dr["Inv_Sno"].ToString() == "2")
                    {
                        newrow["Can10 Bal"] = dr["Qty"].ToString();
                        float can = 0;
                        float.TryParse(dr["Qty"].ToString(), out can);
                        can10 += can;
                    }
                    if (dr["Inv_Sno"].ToString() == "3")
                    {
                        newrow["Can20 Bal"] = dr["Qty"].ToString();
                        float can = 0;
                        float.TryParse(dr["Qty"].ToString(), out can);
                        can20 += can;
                    }
                    if (dr["Inv_Sno"].ToString() == "4")
                    {
                        newrow["Can40 Bal"] = dr["Qty"].ToString();
                        float can = 0;
                        float.TryParse(dr["Qty"].ToString(), out can);
                        can40 += can;
                    }
                }

                Report.Rows.Add(newrow);
            }
            DataRow total = Report.NewRow();
            total["Agent Name"] = "TOTAL DUE";
            total["Due Amount"] = dueamount;
            total["Crates Bal"] = cratesbal;
            total["Can10 Bal"] = can10;
            total["Can20 Bal"] = can20;
            total["Can40 Bal"] = can40;
            Report.Rows.Add(total);
            grdReports.DataSource = Report;
            grdReports.DataBind();
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
        }
    }
    protected void btn_Export_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = new DataTable("GridView_Data");
            foreach (TableCell cell in grdReports.HeaderRow.Cells)
            {
                dt.Columns.Add(cell.Text);
            }
            foreach (GridViewRow row in grdReports.Rows)
            {
                dt.Rows.Add();
                for (int i = 0; i < row.Cells.Count; i++)
                {
                    if (row.Cells[i].Text == "&nbsp;")
                    {
                        row.Cells[i].Text = "0";
                    }
                    dt.Rows[dt.Rows.Count - 1][i] = row.Cells[i].Text;
                }
            }
            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(dt);

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                string FileName = Session["filename"].ToString();
                Response.AddHeader("content-disposition", "attachment;filename=" + FileName + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
        }
    }
}