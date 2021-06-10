using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Windows.Forms;
using System.Data.OleDb;
using System.IO;
using System.Text;
using ClosedXML.Excel;
using System.Configuration;
using System.Net;

public partial class TotalReport : System.Web.UI.Page
{
    MySqlCommand cmd;
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
                txtfromdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                txttodate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");

            }
        }
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GetReport();

    }
    protected void btnSMS_Click(object sender, EventArgs e)
    {
        //string MobNo = txtMobNo.Text;
        //if (MobNo.Length == 10)
        //{
        //    vdm = new VehicleDBMgr();
        //    DataTable Report = new DataTable();
        //    DateTime fromdate = DateTime.Now;
        //    string[] dateFromstrig = txtfromdate.Text.Split(' ');
        //    if (dateFromstrig.Length > 1)
        //    {
        //        if (dateFromstrig[0].Split('-').Length > 0)
        //        {
        //            string[] dates = dateFromstrig[0].Split('-');
        //            string[] times = dateFromstrig[1].Split(':');
        //            fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
        //        }
        //    }
        //    DateTime Todate = DateTime.Now;
        //    string[] dateTostrig = txttodate.Text.Split(' ');
        //    if (dateTostrig.Length > 1)
        //    {
        //        if (dateTostrig[0].Split('-').Length > 0)
        //        {
        //            string[] dates = dateTostrig[0].Split('-');
        //            string[] times = dateTostrig[1].Split(':');
        //            Todate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
        //        }
        //    }
        //    lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
        //    lbl_selttodate.Text = Todate.ToString("dd/MM/yyyy");
        //    Session["filename"] = "TOTAL DC REPORT";
        //    cmd = new MySqlCommand("SELECT ROUND(SUM(tripsubdata.Qty), 2) AS Qty, productsdata.ProductName FROM dispatch INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN (SELECT Sno, AssignDate, Status FROM tripdata WHERE (AssignDate BETWEEN @d1 AND @d2) AND (Status <> 'C')) tripdat ON triproutes.Tripdata_sno = tripdat.Sno INNER JOIN tripsubdata ON tripdat.Sno = tripsubdata.Tripdata_sno INNER JOIN (SELECT branch_sno, product_sno, unitprice, flag, userdata_sno, DTarget, WTarget, MTarget, BranchQty, LeakQty, Rank FROM branchproducts WHERE (branch_sno = @branch)) brnchprdt ON tripsubdata.ProductId = brnchprdt.product_sno INNER JOIN productsdata ON brnchprdt.product_sno = productsdata.sno WHERE (dispatch.Branch_Id = @branch) GROUP BY productsdata.sno ORDER BY brnchprdt.Rank");
        //    cmd.Parameters.AddWithValue("@branch", Session["branch"]);
        //    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
        //    cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate));
        //    DataTable dtTotalDespatch = vdm.SelectQuery(cmd).Tables[0];
        //    double TotalQty = 0;
        //    string ProductName = "";
        //    if (dtTotalDespatch.Rows.Count > 0)
        //    {
        //        foreach (DataRow dr in dtTotalDespatch.Rows)
        //        {
        //            double unitQty = 0;
        //            double.TryParse(dr["Qty"].ToString(), out unitQty);
        //            ProductName += dr["ProductName"].ToString() + "->" + Math.Round(unitQty, 2) + ";" + "\r\n";
        //            TotalQty += Math.Round(unitQty, 2);
        //        }
        //    }

        //    string Date = DateTime.Now.ToString("dd/MM/yyyy");
        //    WebClient client = new WebClient();
        //    string DispatchName = "SRIKALAHASTHI";
        //    Stream data = client.OpenRead(baseurl);
        //    StreamReader reader = new StreamReader(data);
        //    string ResponseID = reader.ReadToEnd();
        //    data.Close();
        //    reader.Close();

        //    cmd = new MySqlCommand("SELECT ROUND(SUM(tripsubdata.Qty), 2) AS Qty, products_subcategory.SubCatName, products_category.Categoryname, products_category.sno AS categorysno, products_subcategory.sno FROM dispatch INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN (SELECT Sno, AssignDate, Status FROM tripdata WHERE (AssignDate BETWEEN @d1 AND @d2) AND (Status <> 'C')) tripdat ON triproutes.Tripdata_sno = tripdat.Sno INNER JOIN tripsubdata ON tripdat.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (dispatch.Branch_Id = @branch) GROUP BY categorysno, products_subcategory.sno ORDER BY categorysno");
        //    cmd.Parameters.AddWithValue("@branch", Session["branch"]);
        //    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
        //    cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate));
        //    DataTable dtTotalDespatch_subcategorywise = vdm.SelectQuery(cmd).Tables[0];
        //    double SubCategoryTotalQty = 0;
        //    string subcategoryName = "";
        //    if (dtTotalDespatch_subcategorywise.Rows.Count > 0)
        //    {
        //        foreach (DataRow dr in dtTotalDespatch_subcategorywise.Rows)
        //        {
        //            double unitQty = 0;
        //            double.TryParse(dr["Qty"].ToString(), out unitQty);
        //            if (dr["categorysno"].ToString() == "10")
        //            {
        //                subcategoryName += dr["SubCatName"].ToString() + "CURD" + "->" + Math.Round(unitQty, 2) + ";" + "\r\n";
        //            }
        //            else
        //            {
        //                subcategoryName += dr["SubCatName"].ToString() + "->" + Math.Round(unitQty, 2) + ";" + "\r\n";
        //            }
        //            SubCategoryTotalQty += Math.Round(unitQty, 2);
        //        }
        //    }
        //    WebClient client1 = new WebClient();
        //    Stream data1 = client.OpenRead(baseurl1);
        //    StreamReader reader1 = new StreamReader(data1);
        //    string ResponseID1 = reader1.ReadToEnd();
        //    data1.Close();
        //    reader1.Close();

        //    lblmsg.Text = "Message Sent Successfully";
        //    txtMobNo.Text = "";
        //}
        //else
        //{
        //    lblmsg.Text = "Please Enter 10 digit Number";
        //}
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
    DataTable dtble1 = new DataTable();
    DataTable dtdirect = new DataTable();
    DataTable dtcurdBM = new DataTable();
    DataTable dtdirectcurdBM = new DataTable();
    void GetReport()
    {
        try
        {
            lblmsg.Text = "";
            pnlHide.Visible = true;
            Report = new DataTable();
            Session["IDate"] = DateTime.Now.AddDays(1).ToString("dd/MM/yyyy");
            vdm = new VehicleDBMgr();
            DateTime fromdate = DateTime.Now;
            string[] dateFromstrig = txtfromdate.Text.Split(' ');
            if (dateFromstrig.Length > 1)
            {
                if (dateFromstrig[0].Split('-').Length > 0)
                {
                    string[] dates = dateFromstrig[0].Split('-');
                    string[] times = dateFromstrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            DateTime Todate = DateTime.Now;
            string[] dateTostrig = txttodate.Text.Split(' ');
            if (dateTostrig.Length > 1)
            {
                if (dateTostrig[0].Split('-').Length > 0)
                {
                    string[] dates = dateTostrig[0].Split('-');
                    string[] times = dateTostrig[1].Split(':');
                    Todate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
            lbl_selttodate.Text = Todate.ToString("dd/MM/yyyy");
            Session["filename"] = "DAY WISE MILK SALE REPORT";
            TimeSpan dateSpan = Todate.Subtract(fromdate);
            int NoOfdays = dateSpan.Days;
            NoOfdays = NoOfdays + 1;
            if (ddlReportType.SelectedValue == "Despatch")
            {
                txttitle.Text = "Total Despatch";

                cmd = new MySqlCommand("SELECT tripdata.Sno, tripdata.AssignDate, tripdata.Status, DATE_FORMAT(tripdata.AssignDate, '%d %b %y') AS IndentDate, tripsubdata.ProductId, SUM(tripsubdata.Qty) AS despatchqty, productsdata.ProductName, productsdata.Inventorysno FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.BranchID = @BranchID) AND (tripdata.Status <> 'C') AND (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag =1) GROUP BY tripsubdata.ProductId, IndentDate ORDER BY brnchprdt.Rank, IndentDate");
                cmd.Parameters.AddWithValue("@BranchID", "172");

                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate).AddDays(-1));
                dtble1 = vdm.SelectQuery(cmd).Tables[0];


                DataView dv = dtble1.DefaultView;
                dv.Sort = "IndentDate ASC";
                DataTable sortedProductDT = dv.ToTable();
                if (sortedProductDT.Rows.Count > 0)
                {
                    DataView view = new DataView(sortedProductDT);
                    DataTable distinctproducts = view.ToTable(true, "ProductId", "ProductName");
                    Report = new DataTable();
                    //Report.Columns.Add("SNo");
                    Report.Columns.Add("DespatchDate");
                    foreach (DataRow dr in distinctproducts.Rows)
                    {
                        Report.Columns.Add(dr["ProductName"].ToString()).DataType = typeof(Double);
                    }
                    Report.Columns.Add("Total Despatch", typeof(Double));
                    DataTable distincttable = view.ToTable(true, "IndentDate");
                    int i = 1;
                    foreach (DataRow branch in distincttable.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        //newrow["SNo"] = i;
                        string AssignDate = branch["IndentDate"].ToString();
                        //DateTime dtAssignDate = Convert.ToDateTime(AssignDate).AddDays(1);
                        DateTime dtAssignDate = Convert.ToDateTime(AssignDate).AddDays(1);
                        string AssigDate = dtAssignDate.ToString("dd-MMM-yyyy");
                        string AssigDate1 = dtAssignDate.ToString("dd-MMM-yy");
                        newrow["DespatchDate"] = AssigDate1;

                        double totmilk = 0;

                        foreach (DataRow dr in sortedProductDT.Rows)
                        {
                            double directdel = 0;
                            if (dr["IndentDate"].ToString() == AssignDate)
                            {

                                double delqty = 0;
                                double.TryParse(dr["despatchqty"].ToString(), out delqty);
                                newrow[dr["ProductName"].ToString()] = Math.Round(delqty + directdel, 2);
                                totmilk += delqty + directdel;

                            }
                        }
                        newrow["Total Despatch"] = Math.Round(totmilk, 2);
                        Report.Rows.Add(newrow);
                        i++;
                    }
                }
                DataRow newvartical = Report.NewRow();
                newvartical["DespatchDate"] = "Total";
                DataRow newAvg = Report.NewRow();
                newAvg["DespatchDate"] = "Avg Per Day";
                double Avgval = 0.0;
                double val = 0.0;
                foreach (DataColumn dc in Report.Columns)
                {
                    if (dc.DataType == typeof(Double))
                    {
                        Avgval = 0.0;
                        val = 0.0;
                        double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                        newvartical[dc.ToString()] = val;
                        Avgval = val / NoOfdays;
                        newAvg[dc.ToString()] = Math.Round(Avgval, 2);
                    }
                }
                Report.Rows.Add(newvartical);
                Report.Rows.Add(newAvg);


            }
            if (ddlReportType.SelectedValue == "Milk Consolidated")
            {
                txttitle.Text = "Net Sale Milk Consolidated";

                cmd = new MySqlCommand("SELECT tripdata.Sno, tripdata.AssignDate, tripdata.Status, DATE_FORMAT(tripdata.AssignDate, '%d-%b-%y') AS IndentDate, tripsubdata.ProductId, SUM(tripsubdata.Qty) AS despatchqty, productsdata.ProductName, productsdata.Inventorysno, products_category.Categoryname, products_subcategory.SubCatName FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM  branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno INNER JOIN  products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.BranchID = @BranchID) AND (tripdata.Status <> 'C') AND (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag = 1) AND (products_category.Categoryname = 'Milk') GROUP BY IndentDate, products_category.Categoryname, products_subcategory.SubCatName ORDER BY brnchprdt.Rank, IndentDate");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate).AddDays(-1));
                dtble1 = vdm.SelectQuery(cmd).Tables[0];

                cmd = new MySqlCommand("SELECT tripdata.Sno, tripdata.EmpId, DATE_FORMAT(tripdata.AssignDate, '%d-%b-%y') AS IndentDate, tripdata.Status, leakages.ProductID, SUM(leakages.ReturnQty) AS Returnqty, SUM(leakages.TotalLeaks) AS leakqty, productsdata.ProductName, productsdata.Inventorysno, products_subcategory.SubCatName, products_category.Categoryname FROM tripdata INNER JOIN leakages ON tripdata.Sno = leakages.TripID INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.Status <> 'c') AND (tripdata.BranchID = @BranchID) AND (productsdata.Inventorysno = '1') AND  (productsdata.sangam_flag = 1) AND (products_category.Categoryname = 'Milk') GROUP BY IndentDate, products_subcategory.SubCatName, products_category.Categoryname ORDER BY IndentDate");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-2));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate).AddDays(-1));
                DataTable dtleaks = vdm.SelectQuery(cmd).Tables[0];

                cmd = new MySqlCommand("SELECT DATE_FORMAT(tripdata.AssignDate, '%d-%b-%y') AS IndentDate, SUM(leakages.ShortQty) AS shrtqty, SUM(leakages.FreeMilk) AS freemilk, leakages.ProductID, productsdata.ProductName, productsdata.Inventorysno, products_category.Categoryname, products_subcategory.SubCatName FROM tripdata INNER JOIN tripdata tripdata_1 ON tripdata.Sno = tripdata_1.ATripid INNER JOIN leakages ON tripdata_1.Sno = leakages.TripID INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.BranchID = @BranchID) AND (tripdata.Status <> 'C') AND (tripdata.SOTransfer IS NOT NULL) AND  (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag = 1) AND (products_category.Categoryname = 'Milk') GROUP BY IndentDate, products_category.Categoryname, products_subcategory.SubCatName ORDER BY IndentDate, brnchprdt.Rank");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate));
                DataTable dtshorts = vdm.SelectQuery(cmd).Tables[0];
                DataView dv = dtble1.DefaultView;
                dv.Sort = "IndentDate ASC";
                DataTable sortedProductDT = dv.ToTable();
                if (sortedProductDT.Rows.Count > 0)
                {
                    DataView view = new DataView(sortedProductDT);
                    DataTable distinctproducts = view.ToTable(true, "SubCatName");
                    Report = new DataTable();
                    //Report.Columns.Add("SNo");
                    Report.Columns.Add("DespatchDate");
                    foreach (DataRow dr in distinctproducts.Rows)
                    {
                        Report.Columns.Add(dr["SubCatName"].ToString()).DataType = typeof(Double);
                    }
                    Report.Columns.Add("Total Sale", typeof(Double));
                    DataTable distincttable = view.ToTable(true, "IndentDate");
                    int i = 1;
                    foreach (DataRow branch in distincttable.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        string AssignDate = branch["IndentDate"].ToString();
                        DateTime dtAssignDate = Convert.ToDateTime(AssignDate).AddDays(1);
                        string AssigDate = dtAssignDate.ToString("dd-MMM-yyyy");
                        string AssigDate1 = dtAssignDate.ToString("dd-MMM-yy");
                        newrow["DespatchDate"] = AssigDate1;
                        double totmilk = 0;
                        foreach (DataRow dr in sortedProductDT.Rows)
                        {
                            double directdel = 0;
                            double directdel1 = 0;
                            double leaks = 0;
                            double returns = 0;
                            double shorts = 0;
                            double freemilk = 0;
                            if (dr["IndentDate"].ToString() == AssignDate)
                            {
                                foreach (DataRow drdt1 in dtleaks.Select("IndentDate='" + AssigDate1 + "'"))
                                {
                                    if (dr["SubCatName"].ToString() == drdt1["SubCatName"].ToString())
                                    {
                                        double.TryParse(drdt1["leakqty"].ToString(), out leaks);
                                        double.TryParse(drdt1["Returnqty"].ToString(), out returns);
                                    }
                                }
                                foreach (DataRow drdt1 in dtshorts.Select("IndentDate='" + AssigDate1 + "'"))
                                {
                                    if (dr["SubCatName"].ToString() == drdt1["SubCatName"].ToString())
                                    {
                                        double.TryParse(drdt1["shrtqty"].ToString(), out shorts);
                                        double.TryParse(drdt1["freemilk"].ToString(), out freemilk);
                                    }
                                }
                                double delqty = 0;
                                double.TryParse(dr["despatchqty"].ToString(), out delqty);
                                var total = delqty + directdel + directdel1;
                                total = total - leaks - returns - freemilk - shorts;
                                newrow[dr["SubCatName"].ToString()] = Math.Round(total, 2);
                                totmilk += total;

                            }
                        }
                        newrow["Total Sale"] = Math.Round(totmilk, 2);
                        Report.Rows.Add(newrow);
                        i++;
                    }
                }
                DataRow newvartical = Report.NewRow();
                newvartical["DespatchDate"] = "Total";
                DataRow newAvg = Report.NewRow();
                newAvg["DespatchDate"] = "Avg Per Day";
                double Avgval = 0.0;
                double val = 0.0;
                foreach (DataColumn dc in Report.Columns)
                {
                    if (dc.DataType == typeof(Double))
                    {
                        Avgval = 0.0;
                        val = 0.0;
                        double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                        newvartical[dc.ToString()] = val;
                        Avgval = val / NoOfdays;
                        newAvg[dc.ToString()] = Math.Round(Avgval, 2);
                    }
                }
                Report.Rows.Add(newvartical);
                Report.Rows.Add(newAvg);

            }
            if (ddlReportType.SelectedValue == "Curd Consolidated")
            {
                txttitle.Text = "Net Sale Curd Consolidated";

                cmd = new MySqlCommand("SELECT tripdata.Sno, tripdata.AssignDate, tripdata.Status, DATE_FORMAT(tripdata.AssignDate, '%d-%b-%y') AS IndentDate, tripsubdata.ProductId, SUM(tripsubdata.Qty) AS despatchqty, productsdata.ProductName, productsdata.Inventorysno, products_category.Categoryname, products_subcategory.SubCatName FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM  branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno INNER JOIN  products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.BranchID = @BranchID) AND (tripdata.Status <> 'C') AND (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag = 1) AND (products_category.Categoryname = 'Curd' OR products_category.Categoryname = 'ButterMilk') GROUP BY IndentDate, products_category.Categoryname, products_subcategory.SubCatName ORDER BY brnchprdt.Rank, IndentDate");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate).AddDays(-1));
                dtble1 = vdm.SelectQuery(cmd).Tables[0];

                cmd = new MySqlCommand("SELECT tripdata.Sno, tripdata.EmpId, DATE_FORMAT(tripdata.AssignDate, '%d-%b-%y') AS IndentDate, tripdata.Status, leakages.ProductID, SUM(leakages.ReturnQty) AS Returnqty, SUM(leakages.TotalLeaks) AS leakqty, productsdata.ProductName, productsdata.Inventorysno, products_subcategory.SubCatName, products_category.Categoryname FROM tripdata INNER JOIN leakages ON tripdata.Sno = leakages.TripID INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.Status <> 'c') AND (tripdata.BranchID = @BranchID) AND (productsdata.Inventorysno = '1') AND  (productsdata.sangam_flag = 1) AND (products_category.Categoryname = 'Curd' OR products_category.Categoryname = 'ButterMilk') GROUP BY IndentDate, products_subcategory.SubCatName, products_category.Categoryname ORDER BY IndentDate");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-2));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate).AddDays(-1));
                DataTable dtleaks = vdm.SelectQuery(cmd).Tables[0];

                cmd = new MySqlCommand("SELECT DATE_FORMAT(tripdata.AssignDate, '%d-%b-%y') AS IndentDate, SUM(leakages.ShortQty) AS shrtqty, SUM(leakages.FreeMilk) AS freemilk, leakages.ProductID, productsdata.ProductName, productsdata.Inventorysno, products_category.Categoryname, products_subcategory.SubCatName FROM tripdata INNER JOIN tripdata tripdata_1 ON tripdata.Sno = tripdata_1.ATripid INNER JOIN leakages ON tripdata_1.Sno = leakages.TripID INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.BranchID = @BranchID) AND (tripdata.Status <> 'C') AND (tripdata.SOTransfer IS NOT NULL) AND  (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag = 1) AND (products_category.Categoryname = 'Curd' OR products_category.Categoryname = 'ButterMilk') GROUP BY IndentDate, products_category.Categoryname, products_subcategory.SubCatName ORDER BY IndentDate, brnchprdt.Rank");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate));
                DataTable dtshorts = vdm.SelectQuery(cmd).Tables[0];
                DataView dv = dtble1.DefaultView;
                dv.Sort = "IndentDate ASC";
                DataTable sortedProductDT = dv.ToTable();
                if (sortedProductDT.Rows.Count > 0)
                {
                    DataView view = new DataView(sortedProductDT);
                    DataTable distinctproducts = view.ToTable(true, "SubCatName");
                    Report = new DataTable();
                    //Report.Columns.Add("SNo");
                    Report.Columns.Add("DespatchDate");
                    foreach (DataRow dr in distinctproducts.Rows)
                    {
                        Report.Columns.Add(dr["SubCatName"].ToString()).DataType = typeof(Double);
                    }
                    Report.Columns.Add("Total Sale", typeof(Double));
                    DataTable distincttable = view.ToTable(true, "IndentDate");
                    int i = 1;
                    foreach (DataRow branch in distincttable.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        string AssignDate = branch["IndentDate"].ToString();
                        DateTime dtAssignDate = Convert.ToDateTime(AssignDate).AddDays(1);
                        string AssigDate = dtAssignDate.ToString("dd-MMM-yyyy");
                        string AssigDate1 = dtAssignDate.ToString("dd-MMM-yy");
                        newrow["DespatchDate"] = AssigDate1;
                        double totmilk = 0;
                        foreach (DataRow dr in sortedProductDT.Rows)
                        {
                            double directdel = 0;
                            double directdel1 = 0;
                            double leaks = 0;
                            double returns = 0;
                            double shorts = 0;
                            double freemilk = 0;
                            if (dr["IndentDate"].ToString() == AssignDate)
                            {
                                foreach (DataRow drdt1 in dtleaks.Select("IndentDate='" + AssigDate1 + "'"))
                                {
                                    if (dr["SubCatName"].ToString() == drdt1["SubCatName"].ToString())
                                    {
                                        double.TryParse(drdt1["leakqty"].ToString(), out leaks);
                                        double.TryParse(drdt1["Returnqty"].ToString(), out returns);
                                    }
                                }
                                foreach (DataRow drdt1 in dtshorts.Select("IndentDate='" + AssigDate1 + "'"))
                                {
                                    if (dr["SubCatName"].ToString() == drdt1["SubCatName"].ToString())
                                    {
                                        double.TryParse(drdt1["shrtqty"].ToString(), out shorts);
                                        double.TryParse(drdt1["freemilk"].ToString(), out freemilk);
                                    }
                                }
                                double delqty = 0;
                                double.TryParse(dr["despatchqty"].ToString(), out delqty);
                                var total = delqty + directdel + directdel1;
                                total = total - leaks - returns - freemilk - shorts;
                                if (dr["Categoryname"].ToString() == "ButterMilk")
                                {
                                    total = total / 3;
                                    newrow[dr["SubCatName"].ToString()] = Math.Round(total, 2);
                                    totmilk += total;
                                }
                                else
                                {
                                    newrow[dr["SubCatName"].ToString()] = Math.Round(total, 2);
                                    totmilk += total;
                                }
                            }
                        }
                        newrow["Total Sale"] = Math.Round(totmilk, 2);
                        Report.Rows.Add(newrow);
                        i++;
                    }
                }
                DataRow newvartical = Report.NewRow();
                newvartical["DespatchDate"] = "Total";
                DataRow newAvg = Report.NewRow();
                newAvg["DespatchDate"] = "Avg Per Day";
                double Avgval = 0.0;
                double val = 0.0;
                foreach (DataColumn dc in Report.Columns)
                {
                    if (dc.DataType == typeof(Double))
                    {
                        Avgval = 0.0;
                        val = 0.0;
                        double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                        newvartical[dc.ToString()] = val;
                        Avgval = val / NoOfdays;
                        newAvg[dc.ToString()] = Math.Round(Avgval, 2);
                    }
                }
                Report.Rows.Add(newvartical);
                Report.Rows.Add(newAvg);

            }
            if (ddlReportType.SelectedValue == "Leakages")
            {
                txttitle.Text = "Total Leakages";
                cmd = new MySqlCommand("SELECT tripdata.Sno, tripdata.EmpId, DATE_FORMAT(tripdata.AssignDate, '%d %b %y') AS IndentDate, tripdata.Status, leakages.ProductID, SUM(leakages.ReturnQty) AS Returnqty, SUM(leakages.TotalLeaks) AS leakqty, productsdata.ProductName, productsdata.Inventorysno FROM tripdata INNER JOIN leakages ON tripdata.Sno = leakages.TripID INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.Status <> 'c') AND (tripdata.BranchID = @BranchID) AND (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag =1) GROUP BY leakages.ProductID, IndentDate ORDER BY brnchprdt.Rank, IndentDate");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate));
                dtble1 = vdm.SelectQuery(cmd).Tables[0];
                DataView dv = dtble1.DefaultView;
                dv.Sort = "IndentDate ASC";
                DataTable sortedProductDT = dv.ToTable();
                if (sortedProductDT.Rows.Count > 0)
                {
                    DataView view = new DataView(sortedProductDT);
                    DataTable distinctproducts = view.ToTable(true, "ProductID", "ProductName");
                    Report = new DataTable();
                    //Report.Columns.Add("SNo");
                    Report.Columns.Add("DespatchDate");
                    foreach (DataRow dr in distinctproducts.Rows)
                    {
                        Report.Columns.Add(dr["ProductName"].ToString()).DataType = typeof(Double);
                    }
                    Report.Columns.Add("Total Leaks", typeof(Double));
                    DataTable distincttable = view.ToTable(true, "IndentDate");
                    int i = 1;
                    foreach (DataRow branch in distincttable.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        //newrow["SNo"] = i;
                        string AssignDate = branch["IndentDate"].ToString();
                        //DateTime dtAssignDate = Convert.ToDateTime(AssignDate).AddDays(1);
                        DateTime dtAssignDate = Convert.ToDateTime(AssignDate);
                        string AssigDate = dtAssignDate.ToString("dd-MMM-yyyy");
                        string AssigDate1 = dtAssignDate.ToString("dd-MMM-yy");
                        newrow["DespatchDate"] = AssigDate1;

                        double totmilk = 0;

                        foreach (DataRow dr in sortedProductDT.Rows)
                        {
                            double directdel = 0;
                            if (dr["IndentDate"].ToString() == AssignDate)
                            {
                                
                                double delqty = 0;
                                double.TryParse(dr["leakqty"].ToString(), out delqty);
                                newrow[dr["ProductName"].ToString()] = Math.Round(delqty + directdel, 2);
                                totmilk += delqty + directdel;

                            }
                        }
                        newrow["Total Leaks"] = Math.Round(totmilk, 2);
                        Report.Rows.Add(newrow);
                        i++;
                    }
                }
                DataRow newvartical = Report.NewRow();
                newvartical["DespatchDate"] = "Total";
                DataRow newAvg = Report.NewRow();
                newAvg["DespatchDate"] = "Avg Per Day";
                double Avgval = 0.0;
                double val = 0.0;
                foreach (DataColumn dc in Report.Columns)
                {
                    if (dc.DataType == typeof(Double))
                    {
                        Avgval = 0.0;
                        val = 0.0;
                        double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                        newvartical[dc.ToString()] = val;
                        Avgval = val / NoOfdays;
                        newAvg[dc.ToString()] = Math.Round(Avgval, 2);
                    }
                }
                Report.Rows.Add(newvartical);
                Report.Rows.Add(newAvg);



            }

            if (ddlReportType.SelectedValue == "Returns")
            {
                txttitle.Text = "Total Returns";
                cmd = new MySqlCommand("SELECT tripdata.Sno, tripdata.EmpId, DATE_FORMAT(tripdata.AssignDate, '%d %b %y') AS IndentDate, tripdata.Status, leakages.ProductID, SUM(leakages.ReturnQty) AS Returnqty, SUM(leakages.TotalLeaks) AS leakqty, productsdata.ProductName, productsdata.Inventorysno FROM tripdata INNER JOIN leakages ON tripdata.Sno = leakages.TripID INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.Status <> 'c') AND (tripdata.BranchID = @BranchID) AND (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag =1) GROUP BY leakages.ProductID, IndentDate ORDER BY brnchprdt.Rank, IndentDate");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate));
                dtble1 = vdm.SelectQuery(cmd).Tables[0];
                DataView dv = dtble1.DefaultView;
                dv.Sort = "IndentDate ASC";
                DataTable sortedProductDT = dv.ToTable();
                if (sortedProductDT.Rows.Count > 0)
                {
                    DataView view = new DataView(sortedProductDT);
                    DataTable distinctproducts = view.ToTable(true, "ProductID", "ProductName");
                    Report = new DataTable();
                    //Report.Columns.Add("SNo");
                    Report.Columns.Add("DespatchDate");
                    foreach (DataRow dr in distinctproducts.Rows)
                    {
                        Report.Columns.Add(dr["ProductName"].ToString()).DataType = typeof(Double);
                    }
                    Report.Columns.Add("Total Returns", typeof(Double));
                    DataTable distincttable = view.ToTable(true, "IndentDate");
                    int i = 1;
                    foreach (DataRow branch in distincttable.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        //newrow["SNo"] = i;
                        string AssignDate = branch["IndentDate"].ToString();
                        //DateTime dtAssignDate = Convert.ToDateTime(AssignDate).AddDays(1);
                        DateTime dtAssignDate = Convert.ToDateTime(AssignDate);
                        string AssigDate = dtAssignDate.ToString("dd-MMM-yyyy");
                        string AssigDate1 = dtAssignDate.ToString("dd-MMM-yy");
                        newrow["DespatchDate"] = AssigDate1;

                        double totmilk = 0;

                        foreach (DataRow dr in sortedProductDT.Rows)
                        {
                            double directdel = 0;
                            if (dr["IndentDate"].ToString() == AssignDate)
                            {
                                
                                double delqty = 0;
                                double.TryParse(dr["Returnqty"].ToString(), out delqty);
                                newrow[dr["ProductName"].ToString()] = Math.Round(delqty + directdel, 2);
                                totmilk += delqty + directdel;

                            }
                        }
                        newrow["Total Returns"] = Math.Round(totmilk, 2);
                        Report.Rows.Add(newrow);
                        i++;
                    }
                }
                DataRow newvartical = Report.NewRow();
                newvartical["DespatchDate"] = "Total";
                DataRow newAvg = Report.NewRow();
                newAvg["DespatchDate"] = "Avg Per Day";
                double Avgval = 0.0;
                double val = 0.0;
                foreach (DataColumn dc in Report.Columns)
                {
                    if (dc.DataType == typeof(Double))
                    {
                        Avgval = 0.0;
                        val = 0.0;
                        double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                        newvartical[dc.ToString()] = val;
                        Avgval = val / NoOfdays;
                        newAvg[dc.ToString()] = Math.Round(Avgval, 2);
                    }
                }
                Report.Rows.Add(newvartical);
                Report.Rows.Add(newAvg);



            }
            if (ddlReportType.SelectedValue == "Net Sales")
            {
                txttitle.Text = "Net Sale";

                cmd = new MySqlCommand("SELECT tripdata.Sno, tripdata.AssignDate, tripdata.Status, DATE_FORMAT(tripdata.AssignDate, '%d-%b-%y') AS IndentDate, tripsubdata.ProductId, SUM(tripsubdata.Qty) AS despatchqty, productsdata.ProductName, productsdata.Inventorysno FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.BranchID = @BranchID) AND (tripdata.Status <> 'C') AND (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag =1) GROUP BY tripsubdata.ProductId, IndentDate ORDER BY brnchprdt.Rank, IndentDate");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate).AddDays(-1));
                dtble1 = vdm.SelectQuery(cmd).Tables[0];
                cmd = new MySqlCommand("SELECT tripdata.Sno, tripdata.EmpId, DATE_FORMAT(tripdata.AssignDate, '%d-%b-%y') AS IndentDate, tripdata.Status, leakages.ProductID, SUM(leakages.ReturnQty) AS Returnqty, SUM(leakages.TotalLeaks) AS leakqty, productsdata.ProductName, productsdata.Inventorysno FROM tripdata INNER JOIN leakages ON tripdata.Sno = leakages.TripID INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.Status <> 'c') AND (tripdata.BranchID = @BranchID) AND (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag =1) GROUP BY leakages.ProductID, IndentDate ORDER BY brnchprdt.Rank, IndentDate");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-2));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate).AddDays(1));
                DataTable dtleaks = vdm.SelectQuery(cmd).Tables[0];
                cmd = new MySqlCommand("SELECT DATE_FORMAT(tripdata.AssignDate, '%d-%b-%y') AS IndentDate, SUM(leakages.ShortQty) AS shrtqty, SUM(leakages.FreeMilk) AS freemilk, leakages.ProductID, productsdata.ProductName, productsdata.Inventorysno FROM tripdata INNER JOIN tripdata tripdata_1 ON tripdata.Sno = tripdata_1.ATripid INNER JOIN leakages ON tripdata_1.Sno = leakages.TripID INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.BranchID = @BranchID) AND (tripdata.Status <> 'C') AND (tripdata.SOTransfer IS NOT NULL) AND (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag =1) GROUP BY leakages.ProductID, IndentDate ORDER BY IndentDate, brnchprdt.Rank");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate));
                DataTable dtshorts = vdm.SelectQuery(cmd).Tables[0];
                DataView dv = dtble1.DefaultView;
                dv.Sort = "IndentDate ASC";
                DataTable sortedProductDT = dv.ToTable();
                if (sortedProductDT.Rows.Count > 0)
                {
                    DataView view = new DataView(sortedProductDT);
                    DataTable distinctproducts = view.ToTable(true,  "ProductName");
                    Report = new DataTable();
                    //Report.Columns.Add("SNo");
                    Report.Columns.Add("DespatchDate");
                    foreach (DataRow dr in distinctproducts.Rows)
                    {
                        Report.Columns.Add(dr["ProductName"].ToString()).DataType = typeof(Double);
                    }
                    Report.Columns.Add("Total Sale", typeof(Double));
                    DataTable distincttable = view.ToTable(true, "IndentDate");
                    int i = 1;
                    foreach (DataRow branch in distincttable.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        //newrow["SNo"] = i;
                        string AssignDate = branch["IndentDate"].ToString();
                        //DateTime dtAssignDate = Convert.ToDateTime(AssignDate).AddDays(1);
                        DateTime dtAssignDate = Convert.ToDateTime(AssignDate).AddDays(1);
                        string AssigDate = dtAssignDate.ToString("dd-MMM-yyyy");
                        string AssigDate1 = dtAssignDate.ToString("dd-MMM-yy");
                        //newrow["DespatchDate"] = AssigDate;
                        newrow["DespatchDate"] = AssigDate1;

                        double totmilk = 0;

                        foreach (DataRow dr in sortedProductDT.Rows)
                        {
                            double directdel = 0;
                            double directdel1 = 0;
                            double leaks = 0;
                            double returns = 0;
                            double shorts = 0;
                            double freemilk = 0;
                            if (dr["IndentDate"].ToString() == AssignDate)
                            {
                                foreach (DataRow drdt1 in dtleaks.Select("IndentDate='" + AssigDate1 + "'"))
                                {
                                    if (dr["ProductName"].ToString() == drdt1["ProductName"].ToString())
                                    {
                                        double.TryParse(drdt1["leakqty"].ToString(), out leaks);
                                        double.TryParse(drdt1["Returnqty"].ToString(), out returns);
                                    }
                                }
                                foreach (DataRow drdt1 in dtshorts.Select("IndentDate='" + AssigDate1 + "'"))
                                {
                                    if (dr["ProductName"].ToString() == drdt1["ProductName"].ToString())
                                    {
                                        double.TryParse(drdt1["shrtqty"].ToString(), out shorts);
                                        double.TryParse(drdt1["freemilk"].ToString(), out freemilk);
                                    }
                                }
                                double delqty = 0;
                                double.TryParse(dr["despatchqty"].ToString(), out delqty);
                                var total = delqty + directdel + directdel1;
                                total = total - leaks - returns - freemilk - shorts;
                                newrow[dr["ProductName"].ToString()] = Math.Round(total, 2);
                                totmilk += total;

                            }
                        }
                        newrow["Total Sale"] = Math.Round(totmilk, 2);
                        Report.Rows.Add(newrow);
                        i++;
                    }
                }
                DataRow newvartical = Report.NewRow();
                newvartical["DespatchDate"] = "Total";
                DataRow newAvg = Report.NewRow();
                newAvg["DespatchDate"] = "Avg Per Day";
                double Avgval = 0.0;
                double val = 0.0;
                foreach (DataColumn dc in Report.Columns)
                {
                    if (dc.DataType == typeof(Double))
                    {
                        Avgval = 0.0;
                        val = 0.0;
                        double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                        newvartical[dc.ToString()] = val;
                        Avgval = val / NoOfdays;
                        newAvg[dc.ToString()] = Math.Round(Avgval, 2);
                    }
                }
                Report.Rows.Add(newvartical);
                Report.Rows.Add(newAvg);
            }
            if (ddlReportType.SelectedValue == "Shortages")
            {
                txttitle.Text = "Shortages AND Free";
                cmd = new MySqlCommand("SELECT DATE_FORMAT(tripdata.AssignDate, '%d %b %y') AS IndentDate, SUM(leakages.ShortQty) AS shrtqty, SUM(leakages.FreeMilk) AS freemilk, leakages.ProductID, productsdata.ProductName, productsdata.Inventorysno FROM tripdata INNER JOIN tripdata tripdata_1 ON tripdata.Sno = tripdata_1.ATripid INNER JOIN leakages ON tripdata_1.Sno = leakages.TripID INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN (SELECT branch_sno, product_sno, Rank FROM branchproducts WHERE (branch_sno = @BranchID)) brnchprdt ON productsdata.sno = brnchprdt.product_sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.BranchID = @BranchID) AND (tripdata.Status <> 'C') AND (tripdata.SOTransfer IS NOT NULL) AND (productsdata.Inventorysno = '1') AND (productsdata.sangam_flag =1) GROUP BY leakages.ProductID, IndentDate ORDER BY IndentDate, brnchprdt.Rank");
                cmd.Parameters.AddWithValue("@BranchID", "172");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate));
                dtble1 = vdm.SelectQuery(cmd).Tables[0];
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno, offer_indents_sub.product_id, SUM(offer_indents_sub.offer_delivered_qty) AS freeqty, DATE_FORMAT(offerindents.indent_date, '%d %b %y') AS IndentDate FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN (SELECT idoffer_indents, idoffers_assignment, salesoffice_id, route_id, agent_id, indent_date, indents_id, IndentType, I_modified_by FROM offer_indents WHERE (indent_date BETWEEN @d1 AND @d2)) offerindents ON branchdata.sno = offerindents.salesoffice_id INNER JOIN offer_indents_sub ON offerindents.idoffer_indents = offer_indents_sub.idoffer_indents WHERE (branchmappingtable.SuperBranch = @SuperBranch) AND (branchdata.SalesType = @SalesType) OR (branchmappingtable.SuperBranch = @SuperBranch) AND (branchdata.SalesType = @SalesType1) GROUP BY offer_indents_sub.product_id, IndentDate");
                cmd.Parameters.AddWithValue("@SuperBranch", "172");
                cmd.Parameters.AddWithValue("@SalesType", "21");
                cmd.Parameters.AddWithValue("@SalesType1", "26");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(Todate));
                DataTable dtoffer = vdm.SelectQuery(cmd).Tables[0];

                DataView dv = dtble1.DefaultView;
                dv.Sort = "IndentDate ASC";
                DataTable sortedProductDT = dv.ToTable();
                if (sortedProductDT.Rows.Count > 0)
                {
                    DataView view = new DataView(sortedProductDT);
                    DataTable distinctproducts = view.ToTable(true, "ProductID", "ProductName");
                    Report = new DataTable();
                    //Report.Columns.Add("SNo");
                    Report.Columns.Add("DespatchDate");
                    foreach (DataRow dr in distinctproducts.Rows)
                    {
                        Report.Columns.Add(dr["ProductName"].ToString()).DataType = typeof(Double);
                    }
                    Report.Columns.Add("Total Sale", typeof(Double));
                    DataTable distincttable = view.ToTable(true, "IndentDate");
                    int i = 1;
                    foreach (DataRow branch in distincttable.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        //newrow["SNo"] = i;
                        string AssignDate = branch["IndentDate"].ToString();
                        //DateTime dtAssignDate = Convert.ToDateTime(AssignDate).AddDays(1);
                        DateTime dtAssignDate = Convert.ToDateTime(AssignDate);
                        string AssigDate = dtAssignDate.ToString("dd-MMM-yyyy");
                        string AssigDate1 = dtAssignDate.ToString("dd-MMM-yy");
                        newrow["DespatchDate"] = AssigDate1;

                        double totmilk = 0;

                        foreach (DataRow dr in sortedProductDT.Rows)
                        {
                            double directdel = 0;
                            if (dr["IndentDate"].ToString() == AssignDate)
                            {
                                double offerqty = 0;
                                foreach (DataRow droffer in dtoffer.Select("product_id='" + dr["ProductID"].ToString() + "' AND IndentDate='" + dr["IndentDate"].ToString() + "'"))
                                {
                                    double offerpdtqty = 0;
                                    double.TryParse(droffer["freeqty"].ToString(), out offerpdtqty);
                                    offerqty += offerpdtqty;
                                }
                                double delqty = 0;
                                double.TryParse(dr["shrtqty"].ToString(), out delqty);
                                double.TryParse(dr["freemilk"].ToString(), out directdel);
                                newrow[dr["ProductName"].ToString()] = Math.Round(delqty + directdel + offerqty, 2);
                                totmilk += delqty + directdel + offerqty;

                            }
                        }
                        newrow["Total Sale"] = Math.Round(totmilk, 2);
                        Report.Rows.Add(newrow);
                        i++;
                    }
                }
                DataRow newvartical = Report.NewRow();
                newvartical["DespatchDate"] = "Total";
                DataRow newAvg = Report.NewRow();
                newAvg["DespatchDate"] = "Avg Per Day";
                double Avgval = 0.0;
                double val = 0.0;
                foreach (DataColumn dc in Report.Columns)
                {
                    if (dc.DataType == typeof(Double))
                    {
                        Avgval = 0.0;
                        val = 0.0;
                        double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                        newvartical[dc.ToString()] = val;
                        Avgval = val / NoOfdays;
                        newAvg[dc.ToString()] = Math.Round(Avgval, 2);
                    }
                }
                Report.Rows.Add(newvartical);
                Report.Rows.Add(newAvg);

            }
            DataView dv2 = Report.DefaultView;
            dv2.Sort = "DespatchDate ASC";
            DataTable sortedProductDT2 = dv2.ToTable();
            foreach (DataColumn col in sortedProductDT2.Columns)
            {
                string Pname = col.ToString();
                string ProductName = col.ToString();
                ProductName = GetSpace(ProductName);
                sortedProductDT2.Columns[Pname].ColumnName = ProductName;
            }

            grdtotal_dcReports.DataSource = sortedProductDT2;
            grdtotal_dcReports.DataBind();
        }
        catch 
        {

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
            int count = 1;
            foreach (TableCell cell in grdtotal_dcReports.HeaderRow.Cells)
            {
                if (count == 1 )
                {
                    dt.Columns.Add(cell.Text);

                }
                else
                {
                    dt.Columns.Add(cell.Text).DataType = typeof(double);
                }
                count++;
            }
            foreach (GridViewRow row in grdtotal_dcReports.Rows)
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
                wb.ColumnWidth = 5;
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
                    // HttpContext.Current.ApplicationInstance.CompleteRequest();
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