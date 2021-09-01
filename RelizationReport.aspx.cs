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
using System.Drawing;
//using System

public partial class RelizationReport : System.Web.UI.Page
{
    MySqlCommand cmd;
    string UserName = "";
    VehicleDBMgr vdm;
    DataTable Dtbranchnames = new DataTable();
    DataTable tempdata = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["branch"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (!this.IsPostBack)
        {
            if (!Page.IsCallback)
            {
                lblTitle.Text = Session["TitleName"].ToString();
                FillAgentName();
                txtdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                txtTodate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
            }
        }
    }

    void FillAgentName()
    {

        try
        {
            vdm = new VehicleDBMgr();
            if (Session["salestype"].ToString() == "Plant")
            {
                //PBranch.Visible = true;
                //string bn = Session["branch"].ToString();
                //cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchdata.flag = 1) AND  (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType) or (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType1) ");
                //cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
                //cmd.Parameters.AddWithValue("@SalesType", "21");
                //cmd.Parameters.AddWithValue("@SalesType1", "26");
                //DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                //ddlSalesOffice.DataSource = dtRoutedata;
                //ddlSalesOffice.DataTextField = "BranchName";
                //ddlSalesOffice.DataValueField = "sno";
                //ddlSalesOffice.DataBind();
            }
            else
            {
                //PBranch.Visible = true;
                //cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM  branchdata INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE (branchdata.flag = 1) AND  ((branchdata_1.SalesOfficeID = @SOID) AND (branchdata_1.flag=@flag)) OR ((branchdata.sno = @BranchID) AND (branchdata.flag=@flag))");
                //cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
                //cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                //cmd.Parameters.AddWithValue("@flag", "1");
                //DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                //ddlSalesOffice.DataSource = dtRoutedata;
                //ddlSalesOffice.DataTextField = "BranchName";
                //ddlSalesOffice.DataValueField = "sno";
                //ddlSalesOffice.DataBind();
            }
        }
        catch
        {
        }
    }
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
    DataTable Report = new DataTable();
    DataTable dtSortedSubCategory = new DataTable();
    DataTable dtSortedCategory = new DataTable();
    DataTable dttempproducts = new DataTable();
    DataTable produtstbl1 = new DataTable();
    DataTable dtSubCatgory = new DataTable();
    DataTable dtCatgory = new DataTable();
    DataTable dtSortedCategoryAndSubCat = new DataTable();

    DataTable dtCatgoryAndSub = new DataTable();

    void GetReport()
    {
        try
        {
            vdm = new VehicleDBMgr();
            pnlHide.Visible = true;
            DateTime fromdate = DateTime.Now;
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
            string type = ddltype.SelectedValue;

            lblSalesOffice.Text = type + "RelizationReport";
            lbl_fromDate.Text = txtdate.Text;
            lbl_selttodate.Text = txtTodate.Text;
            DataTable tempbranchindentsale = new DataTable();

            if (type == "Salewise")
            {
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM  branchmappingtable INNER JOIN branchdata ON branchmappingtable.SubBranch = branchdata.sno WHERE(branchmappingtable.SuperBranch = @branchid)");
                cmd.Parameters.Add("@branchid", "4");
                Dtbranchnames = vdm.SelectQuery(cmd).Tables[0];

                cmd = new MySqlCommand("SELECT  SubBranch, ROUND(SUM(DeliveryQty) ) AS SaleQty,  ROUND(SUM(DeliveryQty * UnitCost)) AS SaleValue,ROUND(SUM((DeliveryQty * UnitCost)/DeliveryQty)) AS AvgRate,IndentDate FROM (SELECT t1.SubBranch, t1.SuperBranch, t2.DeliveryQty, t2.unitQty, t2.UnitCost,DATE_FORMAT(t2.I_date, '%d %b %y') AS IndentDate FROM (SELECT branchmappingtable.SubBranch, branchmappingtable_1.SuperBranch FROM branchmappingtable INNER JOIN branchmappingtable branchmappingtable_1 ON branchmappingtable.SubBranch = branchmappingtable_1.SubBranch WHERE (branchmappingtable_1.SuperBranch = @branchid) GROUP BY branchmappingtable.SubBranch, branchmappingtable_1.SuperBranch) t1 LEFT OUTER JOIN (SELECT indents_subtable.DeliveryQty, indents_subtable.unitQty, indents_subtable.UnitCost, branchmappingtable_2.SuperBranch, branchmappingtable_2.SubBranch,ind.I_date FROM branchmappingtable branchmappingtable_2 INNER JOIN (SELECT IndentNo, Branch_id, I_date FROM indents WHERE (I_date BETWEEN @d1 AND @d2)) ind ON branchmappingtable_2.SubBranch = ind.Branch_id INNER JOIN indents_subtable ON ind.IndentNo = indents_subtable.IndentNo) t2 ON t2.SuperBranch = t1.SubBranch) derivedtbl_1 GROUP BY IndentDate,SubBranch order by IndentDate,SubBranch");
                cmd.Parameters.Add("@branchid", "4");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(todate.AddDays(-1)));
                DataTable dtbranches_indent_sale = vdm.SelectQuery(cmd).Tables[0];
                if (dtbranches_indent_sale.Rows.Count > 0)
                {
                    Report = new DataTable();
                    Report.Columns.Add("Date");
                    int count = 0;
                    foreach (DataRow branch in Dtbranchnames.Rows)
                    {
                        Report.Columns.Add(branch["BranchName"].ToString() + "SaleQty").DataType = typeof(Double);
                        Report.Columns.Add(branch["BranchName"].ToString() + "SaleValue").DataType = typeof(Double);
                        Report.Columns.Add(branch["BranchName"].ToString() + "AvgRate").DataType = typeof(Double);
                        //Report.Columns.AddRange(new DataColumn[3] { new DataColumn(branch["BranchName"].ToString() + "SaleQty").DataType = typeof(Double), new DataColumn(branch["BranchName"].ToString() + "SaleValue").DataType = typeof(Double), new DataColumn(branch["BranchName"].ToString() + "AvgRate").DataType = typeof(Double) });
                    }
                    Report.Columns.Add("SaleQty");
                    Report.Columns.Add("Value");
                    Report.Columns.Add("AvgRate");
                    tempdata.Columns.Add("BranchName");
                    tempdata.Columns.Add("Sno");
                    int i = 1;
                    DataView view = new DataView(dtbranches_indent_sale);
                    DataTable distincttable = view.ToTable(true, "IndentDate");
                    //string BRANCHID = ddlSalesOffice.SelectedValue;
                    foreach (DataRow branch in distincttable.Rows)
                    {
                        double totalleak = 0;
                        double totalreturn = 0;
                        double totalshort = 0;
                        double totalfree = 0;
                        DataRow newrow = Report.NewRow();
                        double shortqty = 0;
                        double freeqty = 0;
                        double leakqty = 0;
                        double saleqty = 0;
                        double salevalue = 0;
                        double opqty = 0;
                        double cloqty = 0;
                        double DispQty = 0;
                        double returnqty = 0;
                        double tfree = 0;
                        double tshort = 0;
                        if (branch["IndentDate"].ToString() != "")
                        {
                            DateTime Date = Convert.ToDateTime(branch["IndentDate"].ToString());
                            DateTime Date_2 = Convert.ToDateTime(branch["IndentDate"].ToString()).AddDays(-1);
                            string Date1 = Date.ToString("dd MMM yyyy");
                            string Date2 = Date_2.ToString("dd MMM yy");
                            newrow["Date"] = Date1;
                            int j = 0;

                            double tdqty = 0; double tsvalue = 0; double tavgrate = 0;
                            foreach (DataRow drrdelivery in dtbranches_indent_sale.Rows)
                            {
                                string Date4 = "";
                                if (drrdelivery["IndentDate"].ToString() != "")
                                {
                                    DateTime Date_3 = Convert.ToDateTime(drrdelivery["IndentDate"].ToString());
                                    Date4 = Date_3.ToString("dd MMM yyyy");
                                }
                                if (Date1 == Date4)
                                {
                                    string BranchName = "";
                                    foreach (DataRow drbname in Dtbranchnames.Select("Sno='" + drrdelivery["SubBranch"].ToString() + "'"))
                                    {
                                        BranchName = drbname["BranchName"].ToString();
                                    }
                                    double dqty = 0;
                                    double.TryParse(drrdelivery["SaleQty"].ToString(), out dqty);
                                    double svalue = 0;
                                    double.TryParse(drrdelivery["SaleValue"].ToString(), out svalue);
                                    double avg = 0;
                                    if (dqty != 0)
                                    {
                                        avg = svalue / dqty;
                                    }
                                    newrow[BranchName + "SaleQty"] = dqty;
                                    newrow[BranchName + "SaleValue"] = svalue;
                                    newrow[BranchName + "AvgRate"] = Math.Round(avg, 2).ToString();

                                    tdqty += dqty;
                                    tsvalue += svalue;
                                    if (tdqty != 0)
                                    {
                                        tavgrate = tsvalue / tdqty;
                                    }
                                    newrow["SaleQty"] = Math.Round(tdqty, 2).ToString();
                                    newrow["Value"] = Math.Round(tsvalue, 2).ToString();
                                    newrow["AvgRate"] = Math.Round(tavgrate, 2).ToString();
                                }
                                //double dcqty = 0;
                                //double.TryParse(drrdelivery["DeliveryQty"].ToString(), out dcqty);
                                //DispQty += dcqty;
                                //newrow["DC Qty"] = Math.Round(DispQty, 2);
                            }
                            Report.Rows.Add(newrow);

                            //foreach (DataRow drropening in dtbranches_indent_sale.Select("BranchId='" + BRANCHID + "'AND inddate='" + Date2 + "'"))
                            //{
                            //    double.TryParse(drropening["openingstock"].ToString(), out opqty);
                            //    newrow["Op Stock"] = Math.Round(opqty, 2); //drrdelivery["DeliveryQty"].ToString();
                            //}
                        }
                    }
                    i++;
                    foreach (var column in Report.Columns.Cast<DataColumn>().ToArray())
                    {
                        if (Report.AsEnumerable().All(dr => dr.IsNull(column)))
                            Report.Columns.Remove(column);
                    }
                    DataRow newvartical = Report.NewRow();
                    newvartical["Date"] = "Total";
                    double val = 0.0;
                    foreach (DataColumn dc in Report.Columns)
                    {
                        if (dc.DataType == typeof(Double))
                        {
                            val = 0.0;
                            double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                            newvartical[dc.ToString()] = val;
                        }
                    }
                    Report.Rows.Add(newvartical);
                    foreach (DataColumn col in Report.Columns)
                    {
                        string Pname = col.ToString();
                        string ProductName = col.ToString();
                        ProductName = GetSpace(ProductName);
                        Report.Columns[Pname].ColumnName = ProductName;
                    }
                    foreach (DataColumn col in Report.Columns)
                    {
                        col.ToString();
                        DataRow newrow1 = tempdata.NewRow();
                        if (col.ToString().Contains("Chennai"))
                        {
                            newrow1["BranchName"] = "Chennai";
                            tempdata.Rows.Add(newrow1);
                        }
                        if (col.ToString().Contains("Bangalore"))
                        {
                            newrow1["BranchName"] = "Bangalore";
                            tempdata.Rows.Add(newrow1);
                        }
                        if (col.ToString().Contains("Ananthapur"))
                        {
                            newrow1["BranchName"] = "Ananthapur";
                            tempdata.Rows.Add(newrow1);
                        }
                    }
                }
            }
            else if (type == "DispatchWise")
            {
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM  branchmappingtable INNER JOIN branchdata ON branchmappingtable.SubBranch = branchdata.sno WHERE(branchmappingtable.SuperBranch = @branchid)");
                cmd.Parameters.Add("@branchid", "4");
                Dtbranchnames = vdm.SelectQuery(cmd).Tables[0];
                DataTable dtbranches_indent_sale = new DataTable();
                foreach (DataRow branch1 in Dtbranchnames.Rows)
                {
                    cmd = new MySqlCommand("SELECT TripInfo.Sno, ROUND(SUM(ProductInfo.Qty), 2) AS DCQty,ROUND(SUM(ProductInfo.Qty*ProductInfo.UnitPrice),2 ) AS DCValue, TripInfo.BranchName, TripInfo.Branch_Id, TripInfo.DispName, TripInfo.BranchID, DATE_FORMAT(TripInfo.I_Date, '%d %b %y') AS IndentDate  FROM    (SELECT        tripdata.Sno, tripdata.AssignDate, tripdata.I_Date, branchdata_1.BranchName, dispatch.BranchID, dispatch.Branch_Id, dispatch.GroupId, dispatch.CompanyId, dispatch.DispName   FROM            branchdata INNER JOIN  dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN  triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN  tripdata ON triproutes.Tripdata_sno = tripdata.Sno INNER JOIN branchdata branchdata_1 ON dispatch.Branch_Id = branchdata_1.sno   WHERE (dispatch.Branch_Id = @BranchID) AND (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (dispatch.BranchID = @SUBBRANCH)) TripInfo INNER JOIN (SELECT Sno, Qty,UnitPrice FROM (SELECT tripdata_1.Sno, tripsubdata.Qty,productsdata.UnitPrice FROM tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno  GROUP BY TripInfo.BranchID, TripInfo.I_Date  ORDER BY TripInfo.BranchID, IndentDate");
                    cmd.Parameters.AddWithValue("@BranchID", "4");
                    cmd.Parameters.AddWithValue("@SUBBRANCH", branch1["sno"].ToString());
                    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                    cmd.Parameters.AddWithValue("@d2", GetHighDate(todate).AddDays(-1));
                    DataTable dtDispatchesbranches = vdm.SelectQuery(cmd).Tables[0];
                    dtbranches_indent_sale.Merge(dtDispatchesbranches);
                }
                //DataTable dtbranches_indent_sale = vdm.SelectQuery(cmd).Tables[0];
                if (dtbranches_indent_sale.Rows.Count > 0)
                {
                    Report = new DataTable();
                    //Report.Columns.Add("SNo");
                    Report.Columns.Add("Date");
                    int count = 0;
                    foreach (DataRow branch in Dtbranchnames.Rows)
                    {
                        Report.Columns.Add(branch["BranchName"].ToString() + "DCQty").DataType = typeof(Double);
                        Report.Columns.Add(branch["BranchName"].ToString() + "DCValue").DataType = typeof(Double);
                        Report.Columns.Add(branch["BranchName"].ToString() + "AvgRate").DataType = typeof(Double);
                        //Report.Columns.AddRange(new DataColumn[3] { new DataColumn(branch["BranchName"].ToString() + "SaleQty").DataType = typeof(Double), new DataColumn(branch["BranchName"].ToString() + "SaleValue").DataType = typeof(Double), new DataColumn(branch["BranchName"].ToString() + "AvgRate").DataType = typeof(Double) });
                    }
                    Report.Columns.Add("DCQty");
                    Report.Columns.Add("DCValue");
                    Report.Columns.Add("AvgRate");
                    tempdata.Columns.Add("BranchName");
                    tempdata.Columns.Add("Sno");

                    int i = 1;
                    DataView view = new DataView(dtbranches_indent_sale);
                    DataTable distincttable = view.ToTable(true, "IndentDate");
                    //string BRANCHID = ddlSalesOffice.SelectedValue;
                    foreach (DataRow branch in distincttable.Rows)
                    {
                        double totalleak = 0;
                        double totalreturn = 0;
                        double totalshort = 0;
                        double totalfree = 0;
                        DataRow newrow = Report.NewRow();
                        double shortqty = 0;
                        double freeqty = 0;
                        double leakqty = 0;
                        double saleqty = 0;
                        double salevalue = 0;
                        double opqty = 0;
                        double cloqty = 0;
                        double DispQty = 0;
                        double returnqty = 0;
                        double tfree = 0;
                        double tshort = 0;
                        if (branch["IndentDate"].ToString() != "")
                        {
                            DateTime Date = Convert.ToDateTime(branch["IndentDate"].ToString());
                            DateTime Date_2 = Convert.ToDateTime(branch["IndentDate"].ToString()).AddDays(-1);
                            string Date1 = Date.ToString("dd MMM yyyy");
                            string Date2 = Date_2.ToString("dd MMM yy");
                            newrow["Date"] = Date1;
                            int j = 0;

                            double tdqty = 0; double tsvalue = 0; double tavgrate = 0;
                            foreach (DataRow drrdelivery in dtbranches_indent_sale.Rows)
                            {
                                string Date4 = "";
                                if (drrdelivery["IndentDate"].ToString() != "")
                                {
                                    DateTime Date_3 = Convert.ToDateTime(drrdelivery["IndentDate"].ToString());
                                    Date4 = Date_3.ToString("dd MMM yyyy");
                                }
                                if (Date1 == Date4)
                                {
                                   // newrow["SNo"] = j++;
                                    string BranchName = "";
                                    foreach (DataRow drbname in Dtbranchnames.Select("Sno='" + drrdelivery["BranchID"].ToString() + "'"))
                                    {
                                        BranchName = drbname["BranchName"].ToString();
                                    }
                                    double dqty = 0;
                                    double.TryParse(drrdelivery["DCQty"].ToString(), out dqty);
                                    double svalue = 0;
                                    double.TryParse(drrdelivery["DCValue"].ToString(), out svalue);
                                    double avg = 0;
                                    if (dqty != 0)
                                    {
                                        avg = svalue / dqty;
                                    }
                                    newrow[BranchName + "DCQty"] = dqty;
                                    newrow[BranchName + "DCValue"] = svalue;
                                    newrow[BranchName + "AvgRate"] = Math.Round(avg, 2).ToString();

                                    tdqty += dqty;
                                    tsvalue += svalue;
                                    if (tdqty != 0)
                                    {
                                        tavgrate = tsvalue / tdqty;
                                    }
                                    newrow["DCQty"] = Math.Round(tdqty, 2).ToString();
                                    newrow["DCValue"] = Math.Round(tsvalue, 2).ToString();
                                    newrow["AvgRate"] = Math.Round(tavgrate, 2).ToString();
                                }
                                //double dcqty = 0;
                                //double.TryParse(drrdelivery["DeliveryQty"].ToString(), out dcqty);
                                //DispQty += dcqty;
                                //newrow["DC Qty"] = Math.Round(DispQty, 2);
                            }
                            Report.Rows.Add(newrow);

                            //foreach (DataRow drropening in dtbranches_indent_sale.Select("BranchId='" + BRANCHID + "'AND inddate='" + Date2 + "'"))
                            //{
                            //    double.TryParse(drropening["openingstock"].ToString(), out opqty);
                            //    newrow["Op Stock"] = Math.Round(opqty, 2); //drrdelivery["DeliveryQty"].ToString();
                            //}
                        }
                    }
                    i++;
                    foreach (var column in Report.Columns.Cast<DataColumn>().ToArray())
                    {
                        if (Report.AsEnumerable().All(dr => dr.IsNull(column)))
                            Report.Columns.Remove(column);
                    }
                    DataRow newvartical = Report.NewRow();
                    newvartical["Date"] = "Total";
                    double val = 0.0;
                    foreach (DataColumn dc in Report.Columns)
                    {
                        if (dc.DataType == typeof(Double))
                        {
                            val = 0.0;
                            double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                            newvartical[dc.ToString()] = val;
                        }
                    }
                    //Report.Columns.Add("Toatal");
                    Report.Rows.Add(newvartical);
                    foreach (DataColumn col in Report.Columns)
                    {
                        string Pname = col.ToString();
                        string ProductName = col.ToString();
                        ProductName = GetSpace(ProductName);
                        Report.Columns[Pname].ColumnName = ProductName;
                    }

                    foreach (DataColumn col in Report.Columns)
                    {
                        col.ToString();
                        DataRow newrow1 = tempdata.NewRow();
                        if (col.ToString().Contains("Chennai"))
                        {
                            newrow1["BranchName"] = "Chennai";
                            tempdata.Rows.Add(newrow1);
                        }
                        if (col.ToString().Contains("Bangalore"))
                        {
                            newrow1["BranchName"] = "Bangalore";
                            tempdata.Rows.Add(newrow1);
                        }
                        if (col.ToString().Contains("Ananthapur"))
                        {
                            newrow1["BranchName"] = "Ananthapur";
                            tempdata.Rows.Add(newrow1);
                        }
                    }
                    //foreach (DataColumn col in Report.Columns)
                    //{
                    //    col.ToString();
                    //    if (BranchName1 != col.ToString())
                    //    {
                    //        DataRow newrow1 = tempdata.NewRow();
                    //        if (Totalcount == 1)
                    //        {
                    //            foreach (DataRow dr1 in Dtbranchnames.Rows)
                    //            {
                    //                if (col.ToString().Contains(dr1["BranchName"].ToString()))
                    //                {
                    //                    newrow1["BranchName"] = col.ToString();
                    //                }
                    //                Totalcount = 1;
                    //            }   
                    //            Totalcount++;
                    //        }
                    //        else
                    //        {
                    //            foreach (DataRow dr1 in Dtbranchnames.Rows)
                    //            {
                    //                if (col.ToString().Contains(dr1["BranchName"].ToString()))
                    //                {
                    //                    newrow1["BranchName"] = col.ToString();
                    //                }
                    //            }
                    //        }
                    //        tempdata.Rows.Add(newrow1);
                    //    }
                    //    BranchName1 = col.ToString();
                    //}
                }
            }
            else if (type == "ProductWise")
            {
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM  branchmappingtable INNER JOIN branchdata ON branchmappingtable.SubBranch = branchdata.sno WHERE(branchmappingtable.SuperBranch = @branchid)");
                cmd.Parameters.Add("@branchid", "4");
                Dtbranchnames = vdm.SelectQuery(cmd).Tables[0];
                DataTable dtbranches_indent_sale = new DataTable();
                foreach (DataRow branch1 in Dtbranchnames.Rows)
                {
                    cmd = new MySqlCommand("SELECT TripInfo.Sno, ROUND(SUM(ProductInfo.Qty), 2) AS SubcatQty,ROUND(SUM(ProductInfo.Qty*ProductInfo.UnitPrice),2 ) AS SubcatValue, ProductInfo.subcatsno,TripInfo.BranchName, TripInfo.Branch_Id, TripInfo.DispName, TripInfo.BranchID, DATE_FORMAT(TripInfo.I_Date, '%d %b %y') AS IndentDate  FROM    (SELECT        tripdata.Sno, tripdata.AssignDate, tripdata.I_Date, branchdata_1.BranchName, dispatch.BranchID, dispatch.Branch_Id, dispatch.GroupId, dispatch.CompanyId, dispatch.DispName   FROM            branchdata INNER JOIN  dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN  triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN  tripdata ON triproutes.Tripdata_sno = tripdata.Sno INNER JOIN branchdata branchdata_1 ON dispatch.Branch_Id = branchdata_1.sno   WHERE (dispatch.Branch_Id = @BranchID) AND (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (dispatch.BranchID = @SUBBRANCH)) TripInfo INNER JOIN (SELECT Sno, Qty,UnitPrice,subcatsno FROM (SELECT tripdata_1.Sno, tripsubdata.Qty,productsdata.UnitPrice,products_subcategory.sno as subcatsno FROM tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno  GROUP BY TripInfo.BranchID, ProductInfo.subcatsno  ORDER BY TripInfo.BranchID, ProductInfo.subcatsno");
                    cmd.Parameters.AddWithValue("@BranchID", "4");
                    cmd.Parameters.AddWithValue("@SUBBRANCH", branch1["sno"].ToString());
                    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                    cmd.Parameters.AddWithValue("@d2", GetHighDate(todate).AddDays(-1));
                    DataTable dtDispatchesbranches = vdm.SelectQuery(cmd).Tables[0];
                    dtbranches_indent_sale.Merge(dtDispatchesbranches);
                }
                cmd = new MySqlCommand("SELECT products_subcategory.sno,products_subcategory.SubCatName  from products_subcategory  INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno");
                DataTable dtsubcategory = vdm.SelectQuery(cmd).Tables[0];
                if (dtbranches_indent_sale.Rows.Count > 0)
                {
                    Report = new DataTable();
                    Report.Columns.Add("SNo");
                    Report.Columns.Add("BranchName");
                    int count = 0;
                    DataView view = new DataView(dtbranches_indent_sale);
                    DataTable distincttable = view.ToTable(true, "subcatsno");
                    foreach (DataRow drcat in distincttable.Rows)
                    {
                        foreach (DataRow drbind in dtsubcategory.Select("sno='" + drcat["subcatsno"].ToString() + "'"))
                        {
                            Report.Columns.Add(drbind["SubCatName"].ToString() + "Qty").DataType = typeof(Double);
                            Report.Columns.Add(drbind["SubCatName"].ToString() + "Value").DataType = typeof(Double);
                            Report.Columns.Add(drbind["SubCatName"].ToString() + "AvgRate").DataType = typeof(Double);
                            //Report.Columns.AddRange(new DataColumn[3] { new DataColumn(branch["BranchName"].ToString() + "SaleQty").DataType = typeof(Double), new DataColumn(branch["BranchName"].ToString() + "SaleValue").DataType = typeof(Double), new DataColumn(branch["BranchName"].ToString() + "AvgRate").DataType = typeof(Double) });
                        }
                    }
                    Report.Columns.Add("TotalQty");
                    Report.Columns.Add("Value");
                    Report.Columns.Add("AvgRate");

                    int i = 1;
                    //DataView view = new DataView(dtbranches_indent_sale);
                    //DataTable distincttable = view.ToTable(true, "IndentDate");
                    //string BRANCHID = ddlSalesOffice.SelectedValue;
                    foreach (DataRow branch in Dtbranchnames.Rows)
                    {
                        double totalleak = 0;
                        double totalreturn = 0;
                        double totalshort = 0;
                        double totalfree = 0;
                        DataRow newrow = Report.NewRow();
                        double shortqty = 0;
                        double freeqty = 0;
                        double leakqty = 0;
                        double saleqty = 0;
                        double salevalue = 0;
                        double opqty = 0;
                        double cloqty = 0;
                        double DispQty = 0;
                        double returnqty = 0;
                        double tfree = 0;
                        double tshort = 0;
                        newrow["BranchName"] = branch["BranchName"].ToString();
                        int j = 0;

                        double tdqty = 0; double tsvalue = 0; double tavgrate = 0;
                        foreach (DataRow drrdelivery in dtbranches_indent_sale.Rows)
                        {
                            if (branch["sno"].ToString() == drrdelivery["BranchId"].ToString())
                            {
                                newrow["SNo"] = j++;
                                string SubcatName = "";
                                foreach (DataRow drbname in dtsubcategory.Select("sno='" + drrdelivery["subcatsno"].ToString() + "'"))
                                {
                                    SubcatName = drbname["SubCatName"].ToString();
                                }
                                double dqty = 0;
                                double.TryParse(drrdelivery["SubcatQty"].ToString(), out dqty);
                                double svalue = 0;
                                double.TryParse(drrdelivery["SubcatValue"].ToString(), out svalue);
                                double avg = 0;
                                if (dqty != 0)
                                {
                                    avg = svalue / dqty;
                                }
                                newrow[SubcatName + "Qty"] = drrdelivery["SubcatQty"].ToString();
                                newrow[SubcatName + "Value"] = drrdelivery["SubcatValue"].ToString();
                                newrow[SubcatName + "AvgRate"] = Math.Round(avg, 2).ToString();

                                tdqty += dqty;
                                tsvalue += svalue;
                                if (tdqty != 0)
                                {
                                    tavgrate = tsvalue / tdqty;
                                }
                                newrow["TotalQty"] = Math.Round(tdqty, 2).ToString();
                                newrow["Value"] = Math.Round(tsvalue, 2).ToString();
                                newrow["AvgRate"] = Math.Round(tavgrate, 2).ToString();
                            }
                            //double dcqty = 0;
                            //double.TryParse(drrdelivery["DeliveryQty"].ToString(), out dcqty);
                            //DispQty += dcqty;
                            //newrow["DC Qty"] = Math.Round(DispQty, 2);
                        }
                        Report.Rows.Add(newrow);

                        //foreach (DataRow drropening in dtbranches_indent_sale.Select("BranchId='" + BRANCHID + "'AND inddate='" + Date2 + "'"))
                        //{
                        //    double.TryParse(drropening["openingstock"].ToString(), out opqty);
                        //    newrow["Op Stock"] = Math.Round(opqty, 2); //drrdelivery["DeliveryQty"].ToString();
                        //}
                    }
                    i++;
                    foreach (var column in Report.Columns.Cast<DataColumn>().ToArray())
                    {
                        if (Report.AsEnumerable().All(dr => dr.IsNull(column)))
                            Report.Columns.Remove(column);
                    }
                    DataRow newvartical = Report.NewRow();
                    newvartical["BranchName"] = "Total";
                    double val = 0.0;
                    foreach (DataColumn dc in Report.Columns)
                    {
                        if (dc.DataType == typeof(Double))
                        {
                            val = 0.0;
                            double.TryParse(Report.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                            newvartical[dc.ToString()] = val;
                        }
                    }
                    //Report.Columns.Add("Toatal");
                    Report.Rows.Add(newvartical);
                    foreach (DataColumn col in Report.Columns)
                    {
                        string Pname = col.ToString();
                        string ProductName = col.ToString();
                        ProductName = GetSpace(ProductName);
                        Report.Columns[Pname].ColumnName = ProductName;
                    }
                }
            }
            grdReports.DataSource = Report;
            grdReports.DataBind();
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
    protected void OnDataBound(object sender, EventArgs e)
    {
           string type2 = ddltype.SelectedValue;
        if (type2 != "ProductWise")
        {
            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);
            TableHeaderCell cell = new TableHeaderCell();
            cell.Text = "";
            cell.ColumnSpan = 1;
            row.Controls.Add(cell);
            int i = 1;
            DataView view = new DataView(tempdata);
            DataTable dtbranche = view.ToTable(true, "BranchName");
            foreach (DataRow drrr in dtbranche.Rows)
            {
                i++;
                    cell = new TableHeaderCell();
                    cell.ColumnSpan = 3;
                    cell.Text = drrr["BranchName"].ToString();
                    row.Controls.Add(cell);
            }
            cell = new TableHeaderCell();
            cell.ColumnSpan = 3;
            cell.Text = "Total";
            row.Controls.Add(cell);
            row.BackColor = ColorTranslator.FromHtml("#3AC0F2");
            grdReports.HeaderRow.Parent.Controls.AddAt(0, row);
        }
        ////cell = new TableHeaderCell();
        ////cell.ColumnSpan = 2;
        ////cell.Text = "BANGALORE";
        ////row.Controls.Add(cell);
        ////cell = new TableHeaderCell();
        ////cell.ColumnSpan = 2;
        ////cell.Text = "Ananthapur";
        ////row.Controls.Add(cell);




    }
    protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
           string type1 = ddltype.SelectedValue;
            if (type1 == "Salewise")
            {
                int count = e.Row.Cells.Count;
                for (int i = 0; i < count; i++)
                {
                    TableCell statusCell = e.Row.Cells[i];
                    if (statusCell.Text.Contains("SaleQty"))
                    {
                        statusCell.Text = "SaleQty";
                    }
                    else if (statusCell.Text.Contains("SaleValue"))
                    {
                        statusCell.Text = "SaleValue";
                    }
                    if (statusCell.Text.Contains("AvgRate"))
                    {
                        statusCell.Text = "AvgRate";
                    }

                }
            }
            else if(type1 == "DispatchWise")
            {
                int count = e.Row.Cells.Count;
                for (int i = 0; i < count; i++)
                {
                    TableCell statusCell = e.Row.Cells[i];
                    if (statusCell.Text.Contains("DCQty"))
                    {
                        statusCell.Text = "DCQty";
                    }
                    else if (statusCell.Text.Contains("DCValue"))
                    {
                        statusCell.Text = "DCValue";
                    }
                    if (statusCell.Text.Contains("AvgRate"))
                    {
                        statusCell.Text = "AvgRate";
                    }
                }
            }
            else if (type1 == "ProductWise")
            {
                int count = e.Row.Cells.Count;
                for (int i = 0; i < count; i++)
                {
                    TableCell statusCell = e.Row.Cells[i];
                    if (statusCell.Text.Contains("SaleQty"))
                    {
                        statusCell.Text = "SaleQty";
                    }
                    else if (statusCell.Text.Contains("Value"))
                    {
                        statusCell.Text = "Value";
                    }
                    if (statusCell.Text.Contains("AvgRate"))
                    {
                        statusCell.Text = "AvgRate";
                    }

                }
            }
        }
    }
    protected void btn_Export_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = new DataTable("GridView_Data");
            int count = 0;
            foreach (TableCell cell in grdReports.HeaderRow.Cells)
            {
                if (count == 1)
                {
                    dt.Columns.Add(cell.Text);
                }
                else
                {
                    dt.Columns.Add(cell.Text);
                }
                count++;
            }
            foreach (GridViewRow row in grdReports.Rows)
            {
                dt.Rows.Add();
                for (int i = 1; i < row.Cells.Count; i++)
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
                string FileName = "Branch Wse Net Sale";
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