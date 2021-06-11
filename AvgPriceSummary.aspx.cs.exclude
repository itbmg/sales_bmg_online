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


public partial class AvgPriceSummary : System.Web.UI.Page
{
    MySqlCommand cmd;
    string BranchID = "";
    VehicleDBMgr vdm;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["branch"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            BranchID = Session["branch"].ToString();
        }
        //vdm = new VehicleDBMgr();
        if (!this.IsPostBack)
        {
            if (!Page.IsCallback)
            {
                txtFromdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                txtTodate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                //FillAgentName();
                lblTitle.Text = Session["TitleName"].ToString();
            }
        }
    }
    //void FillAgentName()
    //{
    //    try
    //    {
    //        vdm = new VehicleDBMgr();
    //        if (Session["salestype"].ToString() == "Plant")
    //        {
    //            PBranch.Visible = true;
    //            DataTable dtBranch = new DataTable();
    //            dtBranch.Columns.Add("BranchName");
    //            dtBranch.Columns.Add("sno");
    //            cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType)  ");
    //            cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
    //            cmd.Parameters.AddWithValue("@SalesType", "21");
    //            cmd.Parameters.AddWithValue("@SalesType1", "26");
    //            DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
    //            foreach (DataRow dr in dtRoutedata.Rows)
    //            {
    //                DataRow newrow = dtBranch.NewRow();
    //                newrow["BranchName"] = dr["BranchName"].ToString();
    //                newrow["sno"] = dr["sno"].ToString();
    //                dtBranch.Rows.Add(newrow);
    //            }
    //            cmd = new MySqlCommand("SELECT BranchName, sno FROM  branchdata WHERE (sno = @BranchID)");
    //            cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
    //            DataTable dtPlant = vdm.SelectQuery(cmd).Tables[0];
    //            foreach (DataRow dr in dtPlant.Rows)
    //            {
    //                DataRow newrow = dtBranch.NewRow();
    //                newrow["BranchName"] = dr["BranchName"].ToString();
    //                newrow["sno"] = dr["sno"].ToString();
    //                dtBranch.Rows.Add(newrow);
    //            }
    //            cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType)  ");
    //            cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
    //            cmd.Parameters.AddWithValue("@SalesType", "23");
    //            DataTable dtNewPlant = vdm.SelectQuery(cmd).Tables[0];
    //            foreach (DataRow dr in dtNewPlant.Rows)
    //            {
    //                DataRow newrow = dtBranch.NewRow();
    //                newrow["BranchName"] = dr["BranchName"].ToString();
    //                newrow["sno"] = dr["sno"].ToString();
    //                dtBranch.Rows.Add(newrow);
    //            }
    //            ddlSalesOffice.DataSource = dtBranch;
    //            ddlSalesOffice.DataTextField = "BranchName";
    //            ddlSalesOffice.DataValueField = "sno";
    //            ddlSalesOffice.DataBind();
    //        }
    //        else
    //        {
    //            PBranch.Visible = false;

    //            ddlDispName.Visible = false;

    //            //cmd = new MySqlCommand("SELECT dispatch.DispName, dispatch.sno FROM dispatch INNER JOIN branchdata ON dispatch.Branch_Id = branchdata.sno INNER JOIN branchdata branchdata_1 ON dispatch.Branch_Id = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) and (dispatch.flag=@flag)) OR ((branchdata_1.SalesOfficeID = @SOID) and (dispatch.flag=@flag))");

    //            cmd = new MySqlCommand("SELECT    branchroutes.flag, branchroutes.RouteName, branchroutes.Sno FROM  branchroutes INNER JOIN branchdata ON branchroutes.BranchID = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchroutes.BranchID = branchdata_1.sno WHERE (branchroutes.BranchID = @BranchID) OR (branchdata_1.SalesOfficeID = @SOID)");
    //            cmd.Parameters.AddWithValue("@BranchID", Session["branch"].ToString());
    //            cmd.Parameters.AddWithValue("@SOID", Session["branch"].ToString());
    //            cmd.Parameters.AddWithValue("@flag", "1");
    //            DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
    //            ddlDispName.DataSource = dtRoutedata;
    //            ddlDispName.DataTextField = "RouteName";
    //            ddlDispName.DataValueField = "Sno";
    //            ddlDispName.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        lblmsg.Text = ex.Message;
    //    }
    //}
    //protected void ddlSalesOffice_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    vdm = new VehicleDBMgr();
    //    cmd = new MySqlCommand("SELECT    branchroutes.flag, branchroutes.RouteName, branchroutes.Sno FROM  branchroutes INNER JOIN branchdata ON branchroutes.BranchID = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchroutes.BranchID = branchdata_1.sno WHERE ((branchroutes.BranchID = @BranchID) AND (branchroutes.flag=@flag)) OR ((branchdata_1.SalesOfficeID = @SOID) AND (branchroutes.flag=@flag))");
    //    //cmd = new MySqlCommand("SELECT dispatch.DispName, dispatch.sno FROM dispatch INNER JOIN branchdata ON dispatch.Branch_Id = branchdata.sno INNER JOIN branchdata branchdata_1 ON dispatch.Branch_Id = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) and (dispatch.flag=@flag)) OR ((branchdata_1.SalesOfficeID = @SOID) and (dispatch.flag=@flag))");
    //    cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
    //    cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
    //    cmd.Parameters.AddWithValue("@flag", "1");
    //    DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
    //    ddlDispName.DataSource = dtRoutedata;
    //    ddlDispName.DataTextField = "RouteName";
    //    ddlDispName.DataValueField = "Sno";
    //    ddlDispName.DataBind();
    //}
    //protected void ddlReportType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    string type = ddlReportType.SelectedValue;
    //    if (type == "SalesOffice Wise")
    //    {
    //        ddlDispName.Visible = false;
    //        ddlSalesOffice.Visible = true;
    //    }
    //    if (type == "Route Wise")
    //    {
    //        ddlDispName.Visible = true;
    //        ddlSalesOffice.Visible = true;
    //    }
    //}
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GetReport();
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
    private DateTime GetLowMonthRetrive(DateTime dt)
    {
        double Day, Hour, Min, Sec;
        DateTime DT = dt;
        DT = dt;
        Day = -dt.Day + 1;
        Hour = -dt.Hour;
        Min = -dt.Minute;
        Sec = -dt.Second;
        DT = DT.AddDays(Day);
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        return DT;

    }
    private DateTime GetHighMonth(DateTime dt)
    {
        double Day, Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        Day = 31 - dt.Day;
        Hour = 23 - dt.Hour;
        Min = 59 - dt.Minute;
        Sec = 59 - dt.Second;
        DT = dt;
        DT = DT.AddDays(Day);
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        if (DT.Day == 3)
        {
            DT = DT.AddDays(-3);
        }
        else if (DT.Day == 2)
        {
            DT = DT.AddDays(-2);
        }
        else if (DT.Day == 1)
        {
            DT = DT.AddDays(-1);
        }
        return DT;
    }
    DataTable Report = new DataTable();
    void GetReport()
    {
        try
        {
            lblmsg.Text = "";
            pnlHide.Visible = true;
            vdm = new VehicleDBMgr();
            DateTime fromdate = DateTime.Now;
            Report = new DataTable();
            string[] fromdatestrig = txtFromdate.Text.Split(' ');
            if (fromdatestrig.Length > 1)
            {
                if (fromdatestrig[0].Split('-').Length > 0)
                {
                    string[] dates = fromdatestrig[0].Split('-');
                    string[] times = fromdatestrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            //fromdate = fromdate.AddDays(-1);
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
            //Session["filename"] = "Monthly Route Product ->" + ddlDispName.SelectedItem.Text;
            //lblAgent.Text = ddlDispName.SelectedItem.Text;
            lbl_fromDate.Text = txtFromdate.Text;
            lbl_selttodate.Text = txtTodate.Text;
            DateTime firstmonth = new DateTime();
            DateTime firstmonth1 = new DateTime();
            DateTime lastmonth = new DateTime();
            int frommonth = fromdate.Month;
            int tomonth = todate.Month;
            TimeSpan dateSpan = todate.Subtract(fromdate);
            int years = (dateSpan.Days / 365);
            int months = ((dateSpan.Days % 365) / 31) + (years * 12);
            Report.Columns.Add("SNo");
            Report.Columns.Add("ProductName");
            int Count = 0;
            string s = "AvgRate";
            if (s == "AvgRate")
            {
                Count = 0;
            }
            else
            {
                Count = 1;
            }
            int N = 0;
            if (months != 0)
            {
                for (int k = 0; k < months; k++)
                {
                    firstmonth = GetLowMonthRetrive(fromdate.AddMonths(k));
                    string ChangedTime1 = firstmonth.ToString("MMM/yyyy");
                    string Changedt = firstmonth.ToString("MMM/yy");
                    Changedt = Changedt + " AvgRate";
                    Report.Columns.Add(Changedt).DataType = typeof(Double);
                }
            }
            DataTable dtPProducts = new DataTable();
            cmd = new MySqlCommand("SELECT  branchproducts.branch_sno, branchproducts.product_sno, branchproducts.flag, productsdata.ProductName FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno WHERE (branchproducts.branch_sno = @Branchid) AND (productsdata.Flag = @flag) ORDER BY branchproducts.Rank");
            cmd.Parameters.AddWithValue("@Branchid", Context.Session["Branch"].ToString());
            cmd.Parameters.AddWithValue("@flag", "1");
            dtPProducts = vdm.SelectQuery(cmd).Tables[0];
            int p = 0;
            string temp1 = "";
            foreach (DataRow dragents in dtPProducts.Rows)
            {
                DataRow newrow = Report.NewRow();
                newrow["SNo"] = p++.ToString();
                newrow["ProductName"] = dragents["ProductName"].ToString();
                Report.Rows.Add(newrow);
            }
            if (months != 0)
            {
                for (int j = 0; j < months; j++)
                {
                    firstmonth = GetLowMonthRetrive(fromdate.AddMonths(j));
                    lastmonth = GetHighMonth(firstmonth);
                    if (Session["salestype"].ToString() == "Plant")
                    {
                        cmd = new MySqlCommand("SELECT   branchmappingtable.SuperBranch, ROUND(SUM(indents_subtable.DeliveryQty), 2) AS DeliveryQty, ROUND(AVG(indents_subtable.DeliveryQty), 2) AS AvgQty,ROUND(SUM(indents_subtable.UnitCost * indents_subtable.DeliveryQty), 2) AS SaleValue, productsdata.ProductName FROM branchmappingtable INNER JOIN branchdata ON branchmappingtable.SubBranch = branchdata.sno INNER JOIN branchmappingtable branchmappingtable_1 ON branchdata.sno = branchmappingtable_1.SuperBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable_1.SubBranch = branchdata_1.sno INNER JOIN indents ON branchdata_1.sno = indents.Branch_id INNER JOIN indents_subtable ON indents.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno WHERE (indents.I_date BETWEEN @d1 AND @d2) AND (branchmappingtable.SuperBranch = @BranchID) AND  (indents_subtable.DeliveryQty <> 0) AND (productsdata.tempsubcatsno IS NOT NULL) GROUP BY productsdata.sno ORDER BY productsdata.Rank");
                        //cmd = new MySqlCommand("SELECT   modifiedroutes.RouteName, modifiedroutes.Sno AS routeid, ROUND(SUM(indents_subtable.DeliveryQty), 2) AS DeliveryQty, branchdata.sno AS BSno, branchdata.BranchName,indent.I_date FROM modifiedroutes INNER JOIN modifiedroutesubtable ON modifiedroutes.Sno = modifiedroutesubtable.RefNo INNER JOIN branchdata ON modifiedroutesubtable.BranchID = branchdata.sno INNER JOIN (SELECT IndentNo, Branch_id, Status, I_date, IndentType FROM  indents WHERE (I_date BETWEEN @starttime AND @endtime) AND (Status <> 'D')) indent ON branchdata.sno = indent.Branch_id INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (modifiedroutesubtable.EDate IS NULL) AND (modifiedroutesubtable.CDate <= @endtime) AND (modifiedroutes.BranchID = @TripID) OR (modifiedroutesubtable.EDate > @starttime) AND (modifiedroutesubtable.CDate <= @starttime) AND (modifiedroutes.BranchID = @TripID) GROUP BY branchdata.BranchName ORDER BY modifiedroutes.RouteName,indent.I_date");
                        cmd.Parameters.AddWithValue("@BranchID", Context.Session["Branch"].ToString());
                    }
                    else
                    {
                        cmd = new MySqlCommand("SELECT   branchmappingtable.SuperBranch, ROUND(SUM(indents_subtable.DeliveryQty), 2) AS DeliveryQty, ROUND(AVG(indents_subtable.DeliveryQty), 2) AS AvgQty,ROUND(SUM(indents_subtable.UnitCost * indents_subtable.DeliveryQty), 2) AS SaleValue, productsdata.ProductName FROM branchmappingtable INNER JOIN branchdata ON branchmappingtable.SubBranch = branchdata.sno INNER JOIN branchmappingtable branchmappingtable_1 ON branchdata.sno = branchmappingtable_1.SuperBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable_1.SubBranch = branchdata_1.sno INNER JOIN indents ON branchdata_1.sno = indents.Branch_id INNER JOIN indents_subtable ON indents.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno WHERE (indents.I_date BETWEEN @d1 AND @d2) AND (branchmappingtable.SubBranch = @BranchID) AND  (indents_subtable.DeliveryQty <> 0) AND (productsdata.tempsubcatsno IS NOT NULL) GROUP BY productsdata.sno ORDER BY productsdata.Rank");
                        //cmd = new MySqlCommand("SELECT   modifiedroutes.RouteName, modifiedroutes.Sno AS routeid, ROUND(SUM(indents_subtable.DeliveryQty), 2) AS DeliveryQty, branchdata.sno AS BSno, branchdata.BranchName,indent.I_date FROM modifiedroutes INNER JOIN modifiedroutesubtable ON modifiedroutes.Sno = modifiedroutesubtable.RefNo INNER JOIN branchdata ON modifiedroutesubtable.BranchID = branchdata.sno INNER JOIN (SELECT IndentNo, Branch_id, Status, I_date, IndentType FROM  indents WHERE (I_date BETWEEN @starttime AND @endtime) AND (Status <> 'D')) indent ON branchdata.sno = indent.Branch_id INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (modifiedroutesubtable.EDate IS NULL) AND (modifiedroutesubtable.CDate <= @endtime) AND (modifiedroutes.BranchID = @TripID) OR (modifiedroutesubtable.EDate > @starttime) AND (modifiedroutesubtable.CDate <= @starttime) AND (modifiedroutes.BranchID = @TripID) GROUP BY branchdata.BranchName ORDER BY modifiedroutes.RouteName,indent.I_date");
                        cmd.Parameters.AddWithValue("@BranchID", Context.Session["Branch"].ToString());
                    }
                    DateTime dtF = firstmonth.AddDays(-1);
                    cmd.Parameters.AddWithValue("@d1", dtF);
                    cmd.Parameters.AddWithValue("@d2", lastmonth);
                    DataTable dtAgent = vdm.SelectQuery(cmd).Tables[0];
                    string ChangedTime1 = firstmonth.ToString("MMM/yyyy");
                    string Changedt = firstmonth.ToString("MMM");
                    Changedt = Changedt + " AvgRate";
                    TimeSpan TimeSpan = lastmonth.Subtract(dtF);
                    int NoOfdays = TimeSpan.Days;
                    int i; int M;
                    if (s == "AvgRate")
                    {
                        N = 0;
                        i = N + 2;
                        M = N + 2;
                    }
                    else
                    {
                        i = N + 2;
                        M = N + 3;
                    }
                    //cmd = new MySqlCommand("SELECT  COUNT(indents.I_date) AS Nodays, indents.Branch_id FROM  indents INNER JOIN  branchmappingtable ON indents.Branch_id = branchmappingtable.SubBranch WHERE (indents.I_date BETWEEN @d1 AND @d2) AND (branchmappingtable.SuperBranch = @branchId) GROUP BY indents.Branch_id");
                    //cmd.Parameters.AddWithValue("@BranchId", ddlSalesOffice.SelectedValue);
                    //cmd.Parameters.AddWithValue("@d1", dtF);
                    //cmd.Parameters.AddWithValue("@d2", lastmonth);
                    //DataTable dtagentnoofdays = vdm.SelectQuery(cmd).Tables[0];


                    //foreach (DataRow drdtclubtotal in dtAgent.Select("SuperBranch='" + Context.Session["Branch"].ToString() + "'"))
                    //{
                    //    int.TryParse(drdtclubtotal["Nodays"].ToString(), out NoOfdays);
                    //}
                    foreach (DataRow drAgent in Report.Rows)
                    {
                        foreach (DataRow dr in dtAgent.Rows)
                        {
                            try
                            {
                                if (drAgent["ProductName"].ToString() == dr["ProductName"].ToString())
                                {
                                    double delQty = 0; double salevalue = 0;
                                    int temp = 0;
                                    int.TryParse(drAgent["SNo"].ToString(), out temp);
                                    double.TryParse(dr["DeliveryQty"].ToString(), out delQty);
                                    double.TryParse(dr["SaleValue"].ToString(), out salevalue);
                                    //Report.Rows[temp][Count + i] = dr["DeliveryQty"].ToString();
                                    double avg = 0;
                                    avg = salevalue / delQty;
                                    avg = Math.Round(avg, 2);
                                    //Report.Rows[temp][Count + M] = avg.ToString();
                                    if (s == "AvgRate")
                                    {
                                        Report.Rows[temp][Count + M] = avg.ToString();
                                    }
                                }
                            }
                            catch
                            {
                            }
                        }
                    }
                    Count++;
                    N++;
                }
                //DataRow newvartical = Report.NewRow();
                //newvartical["ProductName"] = "Total";
                //double val = 0.0;
                //foreach (DataColumn dc in Report.Columns)
                //{
                //    if (dc.DataType == typeof(Double))
                //    {
                //        val = 0.0;
                //        double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                //        newvartical[dc.ToString()] = val;
                //    }
                //}
                //Report.Rows.Add(newvartical);
                grdReports.DataSource = Report;
                grdReports.DataBind();
                Session["xportdata"] = Report;
            }
            else
            {
                pnlHide.Visible = false;
                lblmsg.Text = "Please Select atleast two months";
                grdReports.DataSource = Report;
                grdReports.DataBind();
            }
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