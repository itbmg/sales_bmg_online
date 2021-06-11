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
public partial class PriceListForm : System.Web.UI.Page
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
        //UserName = Session["field1"].ToString();
        //vdm = new VehicleDBMgr();
        if (!this.IsPostBack)
        {
            if (!Page.IsCallback)
            {
                FillSalesOffice();
            }
        }
        Button2.Visible = false;
    }
    void FillSalesOffice()
    {
        try
        {
            vdm = new VehicleDBMgr();
            if (Session["salestype"].ToString() == "Group")
            {
                PPlant.Visible = true;
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) ");
                cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
                DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
                ddlPlant.DataSource = dtRoutedata;
                ddlPlant.DataTextField = "BranchName";
                ddlPlant.DataValueField = "sno";
                ddlPlant.DataBind();
                ddlPlant.Items.Insert(0, new ListItem("Select Plant", "0"));
                
            }
            else if (Session["salestype"].ToString() == "Plant")
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
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType)  ");
                cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
                cmd.Parameters.AddWithValue("@SalesType", "23");
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
                ddlSalesOffice.Items.Insert(0, new ListItem("ALL", "ALL"));
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
        catch
        {
        }
    }
    protected void ddlPlant_SelectedIndexChanged(object sender, EventArgs e)
    {
        vdm = new VehicleDBMgr();
        PBranch.Visible = true;
        cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType) or (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType1) ");
        cmd.Parameters.AddWithValue("@SuperBranch", ddlPlant.SelectedValue);
        cmd.Parameters.AddWithValue("@SalesType", "21");
        cmd.Parameters.AddWithValue("@SalesType1", "26");
        DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
        ddlSalesOffice.DataSource = dtRoutedata;
        ddlSalesOffice.DataTextField = "BranchName";
        ddlSalesOffice.DataValueField = "sno";
        ddlSalesOffice.DataBind();
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
    DataTable dtBranch = new DataTable();
    DataTable dtSubCatgory = new DataTable();
    DataTable produtstbl1 = new DataTable();
    DataTable produtstbl = new DataTable();

    string id = "";
    //protected void btnGenerate_Click(object sender, EventArgs e)
    //{
    ////    GetReport();
    ////}
    ////void GetReport()
    ////{
    //    try
    //    {
    //        Button2.Visible = true;
    //        vdm = new VehicleDBMgr();
    //        DataTable Report = new DataTable();
    //        string branchname = Session["branchname"].ToString();
    //        Session["filename"] = branchname + " RateSheet " + DateTime.Now.ToString("dd/MM/yyyy");
    //        if (ddlSalesOffice.SelectedValue == "ALL")
    //        {
    //            //cmd = new MySqlCommand("SELECT branchdata.sno, branchdata.BranchName, branchproducts.product_sno, branchproducts.unitprice, productsdata.ProductName FROM branchroutes INNER JOIN branchroutesubtable ON branchroutes.Sno = branchroutesubtable.RefNo INNER JOIN branchdata ON branchroutesubtable.BranchID = branchdata.sno INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno WHERE (branchroutes.Sno = 73) ORDER BY branchproducts.Rank");
    //            cmd = new MySqlCommand("SELECT branchdata.BranchName, branchproducts.product_sno, productsdata.ProductName, branchproducts.unitprice, branchdata.sno FROM branchdata INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno WHERE ((branchmappingtable.SuperBranch = @BranchID) and (branchdata.flag='1') and branchproducts.unitprice<>'0') OR ((branchdata_1.SalesOfficeID = @SOID) and (branchdata_1.flag='1') and branchproducts.unitprice<>'0') ORDER BY branchdata.sno");
    //            cmd.Parameters.AddWithValue("@Flag", "1");
    //            cmd.Parameters.AddWithValue("@BranchID", BranchID);
    //            cmd.Parameters.AddWithValue("@SOID", BranchID);
    //            DataTable dtAgents = vdm.SelectQuery(cmd).Tables[0];
    //            // cmd = new MySqlCommand("SELECT productsdata.ProductName, branchproducts.product_sno, branchproducts.unitprice, branchdata.BranchName, branchdata.sno FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN branchdata ON branchproducts.branch_sno = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) and (branchdata.flag='1')) OR ((branchdata_1.SalesOfficeID = @SOID) and (branchdata_1.flag='1')) ORDER BY branchproducts.Rank");
    //            cmd = new MySqlCommand("SELECT    productsdata.ProductName, branchproducts.unitprice, branchproducts.branch_sno AS sno, branchdata.BranchName, branchproducts.product_sno FROM  productsdata INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno INNER JOIN branchdata ON branchproducts.branch_sno = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE (branchdata.sno = @BranchID) AND (branchdata.flag = '1') OR (branchdata_1.SalesOfficeID = @SOID) AND (branchdata_1.flag = '1') ORDER BY branchproducts.Rank");
    //            cmd.Parameters.AddWithValue("@Flag", "1");
    //            cmd.Parameters.AddWithValue("@SOID", BranchID);
    //            cmd.Parameters.AddWithValue("@BranchID", BranchID);
    //            dtBranch = vdm.SelectQuery(cmd).Tables[0];
    //            if (dtAgents.Rows.Count > 0)
    //            {
    //                foreach (DataRow dr in dtAgents.Rows)
    //                {
    //                    DataRow drnew = dtBranch.NewRow();
    //                    drnew["BranchName"] = dr["BranchName"].ToString();
    //                    drnew["product_sno"] = dr["product_sno"].ToString();
    //                    drnew["ProductName"] = dr["ProductName"].ToString();
    //                    drnew["unitprice"] = dr["unitprice"].ToString();
    //                    drnew["sno"] = dr["sno"].ToString();
    //                    dtBranch.Rows.Add(drnew);
    //                }
    //            }
    //            cmd = new MySqlCommand("SELECT    branchproducts.branch_sno,products_subcategory.tempsub_catsno AS SubCatSno, products_category.description AS Categoryname, branchproducts.product_sno, productsdata.ProductName, branchproducts.Rank,products_subcategory.description AS SubCategoryName FROM  products_category INNER JOIN products_subcategory ON products_category.tempcatsno = products_subcategory.tempcatsno INNER JOIN productsdata ON products_subcategory.tempsub_catsno = productsdata.tempsubcatsno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (branchproducts.branch_sno = @BranchId) ORDER BY products_subcategory.tempsub_catsno, branchproducts.Rank");

    //            //cmd = new MySqlCommand("SELECT products_category.Categoryname, productsdata.sno, productsdata.ProductName, branchproducts.product_sno FROM productsdata INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (branchproducts.branch_sno = @BranchID)  ORDER BY branchproducts.Rank");
    //            //cmd.Parameters.AddWithValue("@Flag", "1");
    //            cmd.Parameters.AddWithValue("@BranchID", BranchID);
    //            produtstbl = vdm.SelectQuery(cmd).Tables[0];
    //            if (produtstbl.Rows.Count > 0)
    //            {
    //                DataView SubCatview = new DataView(produtstbl);
    //                dtSubCatgory = SubCatview.ToTable(true, "SubCategoryName", "SubCatSno");
    //                DataView view = new DataView(dtBranch);
    //                DataTable distincttable = view.ToTable(true, "BranchName", "sno");
    //                DataView dv = distincttable.DefaultView;
    //                dv.Sort = "sno ASC";
    //                DataTable sortedProductDT = dv.ToTable();
    //                Report = new DataTable();
    //                Report.Columns.Add("SNo");
    //                Report.Columns.Add("Agent Code");
    //                Report.Columns.Add("Agent Name");
    //                foreach (DataRow dr in produtstbl.Rows)
    //                {
    //                    Report.Columns.Add(dr["ProductName"].ToString()).DataType = typeof(Double);
    //                }
    //                int i = 1;
    //                foreach (DataRow branch in sortedProductDT.Rows)
    //                {
    //                    DataRow newrow = Report.NewRow();
    //                    newrow["SNo"] = i;
    //                    newrow["Agent Code"] = branch["sno"].ToString();
    //                    newrow["Agent Name"] = branch["BranchName"].ToString();
    //                    foreach (DataRow dr in dtBranch.Rows)
    //                    {
    //                        try
    //                        {
    //                            if (branch["BranchName"].ToString() == dr["BranchName"].ToString())
    //                            {
    //                                id = dr["BranchName"].ToString();
    //                                id += branch["sno"].ToString();
    //                                double unitprice = 0;
    //                                double.TryParse(dr["unitprice"].ToString(), out unitprice);
    //                                newrow[dr["ProductName"].ToString()] = unitprice;
    //                            }
    //                        }
    //                        catch
    //                        {
    //                        }
    //                    }
    //                    Report.Rows.Add(newrow);
    //                    i++;
    //                }
    //            }
    //            for (int i = Report.Rows.Count - 1; i >= 0; i--)
    //            {
    //                if (Report.Rows[i][1] == DBNull.Value)
    //                    Report.Rows[i].Delete();
    //            }

    //            grdReports.DataSource = Report;
    //            grdReports.DataBind();
    //            Session["xportdata"] = Report;
    //        }
    //        else
    //        {
    //            //cmd = new MySqlCommand("SELECT branchdata.sno, branchdata.BranchName, branchproducts.product_sno, branchproducts.unitprice, productsdata.ProductName FROM branchroutes INNER JOIN branchroutesubtable ON branchroutes.Sno = branchroutesubtable.RefNo INNER JOIN branchdata ON branchroutesubtable.BranchID = branchdata.sno INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno WHERE (branchroutes.Sno = 73) ORDER BY branchproducts.Rank");
    //            cmd = new MySqlCommand("SELECT branchdata.BranchName, branchproducts.product_sno, productsdata.ProductName, branchproducts.unitprice, branchdata.sno FROM branchdata INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno WHERE ((branchmappingtable.SuperBranch = @BranchID) and (branchdata.flag='1') and branchproducts.unitprice<>'0') OR ((branchdata_1.SalesOfficeID = @SOID) and (branchdata_1.flag='1') and branchproducts.unitprice<>'0') ORDER BY branchdata.sno");
    //            cmd.Parameters.AddWithValue("@Flag", "1");
    //            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
    //            cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
    //            DataTable dtAgents = vdm.SelectQuery(cmd).Tables[0];
    //            // cmd = new MySqlCommand("SELECT productsdata.ProductName, branchproducts.product_sno, branchproducts.unitprice, branchdata.BranchName, branchdata.sno FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN branchdata ON branchproducts.branch_sno = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) and (branchdata.flag='1')) OR ((branchdata_1.SalesOfficeID = @SOID) and (branchdata_1.flag='1')) ORDER BY branchproducts.Rank");
    //            cmd = new MySqlCommand("SELECT    productsdata.ProductName, branchproducts.unitprice, branchproducts.branch_sno AS sno, branchdata.BranchName, branchproducts.product_sno FROM  productsdata INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno INNER JOIN branchdata ON branchproducts.branch_sno = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE (branchdata.sno = @BranchID) AND (branchdata.flag = '1') OR (branchdata_1.SalesOfficeID = @SOID) AND (branchdata_1.flag = '1') ORDER BY branchproducts.Rank");
    //            cmd.Parameters.AddWithValue("@Flag", "1");
    //            cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
    //            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
    //            dtBranch = vdm.SelectQuery(cmd).Tables[0];
    //            if (dtBranch.Rows.Count > 0)
    //            {
    //                foreach (DataRow dr in dtBranch.Rows)
    //                {
    //                    DataRow drnew = dtAgents.NewRow();
    //                    drnew["BranchName"] = dr["BranchName"].ToString();
    //                    drnew["product_sno"] = dr["product_sno"].ToString();
    //                    drnew["ProductName"] = dr["ProductName"].ToString();
    //                    drnew["unitprice"] = dr["unitprice"].ToString();
    //                    drnew["sno"] = dr["sno"].ToString();
    //                    dtAgents.Rows.Add(drnew);
    //                }
    //            }
    //            cmd = new MySqlCommand("SELECT    branchproducts.branch_sno,products_subcategory.tempsub_catsno AS SubCatSno, products_category.description AS Categoryname, branchproducts.product_sno, productsdata.ProductName, branchproducts.Rank,products_subcategory.description AS SubCategoryName FROM  products_category INNER JOIN products_subcategory ON products_category.tempcatsno = products_subcategory.tempcatsno INNER JOIN productsdata ON products_subcategory.tempsub_catsno = productsdata.tempsubcatsno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (branchproducts.branch_sno = @BranchId) ORDER BY products_subcategory.tempsub_catsno, branchproducts.Rank");
    //            //cmd = new MySqlCommand("SELECT products_category.Categoryname, productsdata.sno, productsdata.ProductName, branchproducts.product_sno FROM productsdata INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (branchproducts.branch_sno = @BranchID)  ORDER BY branchproducts.Rank");
    //            //cmd.Parameters.AddWithValue("@Flag", "1");
    //            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
    //            produtstbl = vdm.SelectQuery(cmd).Tables[0];
    //            if (produtstbl.Rows.Count > 0)
    //            {
    //                DataView SubCatview = new DataView(produtstbl);
    //                dtSubCatgory = SubCatview.ToTable(true, "SubCategoryName", "SubCatSno");


    //                DataView view = new DataView(dtBranch);
    //                DataTable distincttable = view.ToTable(true, "BranchName", "sno");
    //                Report = new DataTable();
    //                Report.Columns.Add("SNo");
    //                Report.Columns.Add("Agent Code");
    //                Report.Columns.Add("Agent Name");
    //                foreach (DataRow dr in produtstbl.Rows)
    //                {
    //                    Report.Columns.Add(dr["ProductName"].ToString()).DataType = typeof(Double);
    //                }
    //                int i = 1;
    //                foreach (DataRow branch in distincttable.Rows)
    //                {
    //                    DataRow newrow = Report.NewRow();
    //                    newrow["SNo"] = i;
    //                    newrow["Agent Code"] = branch["sno"].ToString();
    //                    newrow["Agent Name"] = branch["BranchName"].ToString();
    //                    foreach (DataRow dr in dtBranch.Rows)
    //                    {
    //                        try
    //                        {
    //                            if (branch["BranchName"].ToString() == dr["BranchName"].ToString())
    //                            {
    //                                id = dr["BranchName"].ToString();
    //                                id += branch["sno"].ToString();
    //                                double unitprice = 0;
    //                                double.TryParse(dr["unitprice"].ToString(), out unitprice);
    //                                newrow[dr["ProductName"].ToString()] = unitprice;
    //                            }
    //                        }
    //                        catch
    //                        {
    //                        }
    //                    }
    //                    Report.Rows.Add(newrow);
    //                    i++;
    //                }
    //            }
    //            for (int i = Report.Rows.Count - 1; i >= 0; i--)
    //            {
    //                if (Report.Rows[i][1] == DBNull.Value)
    //                    Report.Rows[i].Delete();
    //            }

    //            grdReports.DataSource = Report;
    //            grdReports.DataBind();
    //            Session["xportdata"] = Report;
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        string msg = ex.Message;
    //        msg += id;
    //        //lblmsg.Text = msg;
    //    }
    //}

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        //    GetReport();
        //}
        //void GetReport()
        //{
        try
        {
            Button2.Visible = true;
            vdm = new VehicleDBMgr();
            DateTime ServerDateCurrentdate = VehicleDBMgr.GetTime(vdm.conn);

            DataTable Report = new DataTable();
            string branchname = Session["branchname"].ToString();
            Session["filename"] = branchname + " RateSheet " + DateTime.Now.ToString("dd/MM/yyyy");
            if (ddlSalesOffice.SelectedValue != "ALL")
            {
                //cmd = new MySqlCommand("SELECT branchdata.sno, branchdata.BranchName, branchproducts.product_sno, branchproducts.unitprice, productsdata.ProductName FROM branchroutes INNER JOIN branchroutesubtable ON branchroutes.Sno = branchroutesubtable.RefNo INNER JOIN branchdata ON branchroutesubtable.BranchID = branchdata.sno INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno WHERE (branchroutes.Sno = 73) ORDER BY branchproducts.Rank");
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchproducts.product_sno,branchproducts.Rank, productsdata.ProductName,productsdata.tempsubcatsno, branchproducts.unitprice, branchdata.sno FROM branchdata INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno WHERE ((branchmappingtable.SuperBranch = @BranchID) and (branchdata.flag='1') and branchproducts.unitprice<>'0') OR ((branchdata_1.SalesOfficeID = @SOID) and (branchdata_1.flag='1') and branchproducts.unitprice<>'0')  group by branchproducts.product_sno,branchdata.sno ORDER BY productsdata.tempsubcatsno");
                cmd.Parameters.AddWithValue("@Flag", "1");
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
                DataTable dtAgents = vdm.SelectQuery(cmd).Tables[0];
                // cmd = new MySqlCommand("SELECT productsdata.ProductName, branchproducts.product_sno, branchproducts.unitprice, branchdata.BranchName, branchdata.sno FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN branchdata ON branchproducts.branch_sno = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) and (branchdata.flag='1')) OR ((branchdata_1.SalesOfficeID = @SOID) and (branchdata_1.flag='1')) ORDER BY branchproducts.Rank");
                cmd = new MySqlCommand("SELECT    productsdata.ProductName,productsdata.tempsubcatsno,branchproducts.Rank, branchproducts.unitprice,  branchdata.BranchName, branchproducts.branch_sno AS sno,branchproducts.product_sno FROM  productsdata INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno INNER JOIN branchdata ON branchproducts.branch_sno = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE (branchdata.sno = @BranchID) AND (branchdata.flag = '1') OR (branchdata_1.SalesOfficeID = @SOID) AND (branchdata_1.flag = '1') GROUP BY  sno,branchproducts.product_sno ORDER BY productsdata.tempsubcatsno,branchproducts.Rank");
                cmd.Parameters.AddWithValue("@Flag", "1");
                cmd.Parameters.AddWithValue("@SOID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                dtBranch = vdm.SelectQuery(cmd).Tables[0];
                //if (dtAgents.Rows.Count > 0)
                //{
                //    foreach (DataRow dr in dtAgents.Rows)
                //    {
                //        DataRow drnew = dtBranch.NewRow();
                //        drnew["BranchName"] = dr["BranchName"].ToString();
                //        drnew["product_sno"] = dr["product_sno"].ToString();
                //        drnew["ProductName"] = dr["ProductName"].ToString();
                //        drnew["unitprice"] = dr["unitprice"].ToString();
                //        drnew["sno"] = dr["sno"].ToString();
                //        //drnew["Rank"] = dr["Rank"].ToString();
                //        dtBranch.Rows.Add(drnew);
                //    }
                //}
                //cmd = new MySqlCommand("SELECT  modifiedroutes.Sno, modifiedroutes.RouteName, branchdata.sno AS Branchid, branchdata.BranchName FROM modifiedroutes INNER JOIN modifiedroutesubtable ON modifiedroutes.Sno = modifiedroutesubtable.RefNo INNER JOIN branchdata ON modifiedroutesubtable.BranchID = branchdata.sno WHERE (branchdata.flag = @flag) AND (modifiedroutes.BranchID = @BranchID) AND (modifiedroutesubtable.EDate IS NULL) AND (modifiedroutesubtable.CDate <= @starttime) OR (branchdata.flag = @flag) AND (modifiedroutes.BranchID = @BranchID) AND (modifiedroutesubtable.EDate > @starttime) AND (modifiedroutesubtable.CDate <= @starttime) GROUP BY branchdata.sno, branchdata.BranchName");
                //cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                //cmd.Parameters.AddWithValue("@starttime", GetLowDate(ServerDateCurrentdate.AddDays(-1)));
                //cmd.Parameters.AddWithValue("@flag", "1");
                //produtstbl = vdm.SelectQuery(cmd).Tables[0];

                cmd = new MySqlCommand("SELECT    branchproducts.branch_sno,products_subcategory.tempsub_catsno AS SubCatSno, products_category.description AS Categoryname, branchproducts.product_sno, productsdata.ProductName, branchproducts.Rank,products_subcategory.description AS SubCategoryName FROM  products_category INNER JOIN products_subcategory ON products_category.tempcatsno = products_subcategory.tempcatsno INNER JOIN productsdata ON products_subcategory.tempsub_catsno = productsdata.tempsubcatsno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (branchproducts.branch_sno = @BranchId) ORDER BY products_subcategory.tempsub_catsno, branchproducts.Rank");
                //cmd = new MySqlCommand("SELECT products_category.Categoryname, productsdata.sno, productsdata.ProductName, branchproducts.product_sno FROM productsdata INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (branchproducts.branch_sno = @BranchID)  ORDER BY branchproducts.Rank");
                //cmd.Parameters.AddWithValue("@Flag", "1");
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                produtstbl1 = vdm.SelectQuery(cmd).Tables[0];
                if (produtstbl1.Rows.Count > 0)
                {
                    DataView SubCatview = new DataView(produtstbl1);
                    dtSubCatgory = SubCatview.ToTable(true, "SubCategoryName", "SubCatSno");
                    DataTable tempproducttable = new DataTable();
                    tempproducttable.Columns.Add("BranchName");
                    tempproducttable.Columns.Add("product_sno");
                    tempproducttable.Columns.Add("ProductName");
                    tempproducttable.Columns.Add("unitprice");
                    tempproducttable.Columns.Add("sno");

                    foreach (DataRow drsubcategory in dtSubCatgory.Rows)
                    {
                        foreach (DataRow drr in dtBranch.Select("tempsubcatsno='" + drsubcategory["SubCatSno"].ToString() + "'"))
                        {
                            DataRow drnew = tempproducttable.NewRow();
                            drnew["BranchName"] = drr["BranchName"].ToString();
                            drnew["product_sno"] = drr["product_sno"].ToString();
                            drnew["ProductName"] = drr["ProductName"].ToString();
                            drnew["unitprice"] = drr["unitprice"].ToString();
                            drnew["sno"] = drr["sno"].ToString();
                            //drnew["Rank"] = dr["Rank"].ToString();
                            tempproducttable.Rows.Add(drnew);
                        }
                    }

                    DataView view = new DataView(dtBranch);
                    DataTable distincttable = view.ToTable(true, "ProductName", "product_sno");
                    DataTable distincttable1 = view.ToTable(true, "BranchName", "sno");
                    DataView dv = distincttable.DefaultView;
                    //  dv.Sort = "Rank ASC";
                    DataTable sortedProductDT = dv.ToTable();
                    Report = new DataTable();
                    Report.Columns.Add("SubCategory Name");
                    Report.Columns.Add("SNo");
                    Report.Columns.Add("Product Name");
                    foreach (DataRow dr in distincttable1.Rows)
                    {
                        Report.Columns.Add(dr["BranchName"].ToString()).DataType = typeof(Double);
                    }
                    int i = 1;
                    foreach (DataRow branch in sortedProductDT.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        newrow["SNo"] = i;
                        foreach (DataRow drtripinv in produtstbl1.Select("product_sno='" + branch["product_sno"].ToString() + "'"))
                        {
                            newrow["SubCategory Name"] = drtripinv["SubCategoryName"].ToString();
                        }
                        newrow["Product Name"] = branch["ProductName"].ToString();
                        foreach (DataRow dr in tempproducttable.Rows)
                        {
                            try
                            {
                                if (branch["ProductName"].ToString() == dr["ProductName"].ToString())
                                {
                                    id = dr["ProductName"].ToString();
                                    id += branch["product_sno"].ToString();
                                    double unitprice = 0;
                                    double.TryParse(dr["unitprice"].ToString(), out unitprice);
                                    newrow[dr["BranchName"].ToString()] = unitprice;
                                }
                            }
                            catch
                            {
                            }
                        }
                        Report.Rows.Add(newrow);
                        i++;
                    }
                }
                for (int i = Report.Rows.Count - 1; i >= 0; i--)
                {
                    if (Report.Rows[i][1] == DBNull.Value)
                        Report.Rows[i].Delete();
                }
                grdReports.DataSource = Report;
                grdReports.DataBind();
                Session["xportdata"] = Report;
            }
            else
            {
                cmd = new MySqlCommand("SELECT branchdata.BranchName, branchproducts.product_sno, productsdata.ProductName, branchproducts.unitprice, branchdata.sno FROM branchdata INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno WHERE ((branchmappingtable.SuperBranch = @BranchID) and (branchdata.flag='1') and branchproducts.unitprice<>'0') OR ((branchdata_1.SalesOfficeID = @SOID) and (branchdata_1.flag='1') and branchproducts.unitprice<>'0') ORDER BY branchdata.sno");
                cmd.Parameters.AddWithValue("@Flag", "1");
                cmd.Parameters.AddWithValue("@BranchID", BranchID);
                cmd.Parameters.AddWithValue("@SOID", BranchID);
                DataTable dtAgents = vdm.SelectQuery(cmd).Tables[0];
                // cmd = new MySqlCommand("SELECT productsdata.ProductName, branchproducts.product_sno, branchproducts.unitprice, branchdata.BranchName, branchdata.sno FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN branchdata ON branchproducts.branch_sno = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE ((branchdata.sno = @BranchID) and (branchdata.flag='1')) OR ((branchdata_1.SalesOfficeID = @SOID) and (branchdata_1.flag='1')) ORDER BY branchproducts.Rank");
                cmd = new MySqlCommand("SELECT    productsdata.ProductName, branchproducts.unitprice, branchproducts.branch_sno AS sno, branchdata.BranchName, branchproducts.product_sno FROM  productsdata INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno INNER JOIN branchdata ON branchproducts.branch_sno = branchdata.sno INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE (branchdata.sno = @BranchID) AND (branchdata.flag = '1') OR (branchdata_1.SalesOfficeID = @SOID) AND (branchdata_1.flag = '1') ORDER BY branchproducts.Rank");
                cmd.Parameters.AddWithValue("@Flag", "1");
                cmd.Parameters.AddWithValue("@SOID", BranchID);
                cmd.Parameters.AddWithValue("@BranchID", BranchID);
                dtBranch = vdm.SelectQuery(cmd).Tables[0];
                if (dtAgents.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtAgents.Rows)
                    {
                        DataRow drnew = dtBranch.NewRow();
                        drnew["BranchName"] = dr["BranchName"].ToString();
                        drnew["product_sno"] = dr["product_sno"].ToString();
                        drnew["ProductName"] = dr["ProductName"].ToString();
                        drnew["unitprice"] = dr["unitprice"].ToString();
                        drnew["sno"] = dr["sno"].ToString();
                        dtBranch.Rows.Add(drnew);
                    }
                }
                cmd = new MySqlCommand("SELECT    branchproducts.branch_sno,products_subcategory.tempsub_catsno AS SubCatSno, products_category.description AS Categoryname, branchproducts.product_sno, productsdata.ProductName, branchproducts.Rank,products_subcategory.description AS SubCategoryName FROM  products_category INNER JOIN products_subcategory ON products_category.tempcatsno = products_subcategory.tempcatsno INNER JOIN productsdata ON products_subcategory.tempsub_catsno = productsdata.tempsubcatsno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (branchproducts.branch_sno = @BranchId) ORDER BY products_subcategory.tempsub_catsno, branchproducts.Rank");

                //cmd = new MySqlCommand("SELECT products_category.Categoryname, productsdata.sno, productsdata.ProductName, branchproducts.product_sno FROM productsdata INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (branchproducts.branch_sno = @BranchID)  ORDER BY branchproducts.Rank");
                //cmd.Parameters.AddWithValue("@Flag", "1");
                cmd.Parameters.AddWithValue("@BranchID", BranchID);
                produtstbl = vdm.SelectQuery(cmd).Tables[0];
                if (produtstbl.Rows.Count > 0)
                {
                    DataView SubCatview = new DataView(produtstbl);
                    dtSubCatgory = SubCatview.ToTable(true, "SubCategoryName", "SubCatSno");
                    DataView view = new DataView(dtBranch);
                    DataTable distincttable = view.ToTable(true, "BranchName", "sno");
                    DataView dv = distincttable.DefaultView;
                    dv.Sort = "sno ASC";
                    DataTable sortedProductDT = dv.ToTable();
                    Report = new DataTable();
                    Report.Columns.Add("SNo");
                    Report.Columns.Add("Agent Code");
                    Report.Columns.Add("Agent Name");
                    foreach (DataRow dr in produtstbl.Rows)
                    {
                        Report.Columns.Add(dr["ProductName"].ToString()).DataType = typeof(Double);
                    }
                    int i = 1;
                    foreach (DataRow branch in sortedProductDT.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        newrow["SNo"] = i;
                        newrow["Agent Code"] = branch["sno"].ToString();
                        newrow["Agent Name"] = branch["BranchName"].ToString();
                        foreach (DataRow dr in dtBranch.Rows)
                        {
                            try
                            {
                                if (branch["BranchName"].ToString() == dr["BranchName"].ToString())
                                {
                                    id = dr["BranchName"].ToString();
                                    id += branch["sno"].ToString();
                                    double unitprice = 0;
                                    double.TryParse(dr["unitprice"].ToString(), out unitprice);
                                    newrow[dr["ProductName"].ToString()] = unitprice;
                                }
                            }
                            catch
                            {
                            }
                        }
                        Report.Rows.Add(newrow);
                        i++;
                    }
                }
                for (int i = Report.Rows.Count - 1; i >= 0; i--)
                {
                    if (Report.Rows[i][1] == DBNull.Value)
                        Report.Rows[i].Delete();
                }
                grdReports.DataSource = Report;
                grdReports.DataBind();
                Session["xportdata"] = Report;
            }
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            msg += id;
            //lblmsg.Text = msg;
        }
    }
    protected void btn_Export_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = new DataTable("GridView_Data");
            foreach (TableCell cell in grdReports.HeaderRow.Cells)
            {
                if (ddlSalesOffice.SelectedValue != "ALL")
                {
                    if (cell.Text == "SubCategory Name")
                    {
                        dt.Columns.Add(cell.Text);
                    }
                    else if (cell.Text == "SNo")
                    {
                        dt.Columns.Add(cell.Text);
                    }
                    else if (cell.Text == "Product Name")
                    {
                        dt.Columns.Add(cell.Text);
                    }
                    else
                    {
                        dt.Columns.Add(cell.Text).DataType = typeof(double);
                    }
                }
                else
                {
                    if (cell.Text == "SNo")
                    {
                        dt.Columns.Add(cell.Text);
                    }
                    else if (cell.Text == "Agent Code")
                    {
                        dt.Columns.Add(cell.Text);
                    }
                    else if (cell.Text == "Agent Name")
                    {
                        dt.Columns.Add(cell.Text);
                    }
                    else
                    {
                        dt.Columns.Add(cell.Text).DataType = typeof(double);
                    }
                }

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
                    if (row.Cells[i].Text == "")
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
           // lblmsg.Text = ex.Message;
        }
    }
    int j = 0;
    protected void grdReports_RowCreated(object sender, GridViewRowEventArgs e)
    {
        // Adding a column manually once the header created
        if (e.Row.RowType == DataControlRowType.Header) // If header created
        {
            //j++;
            //e.Row.Cells[1].Visible = false;
            GridView ProductGrid = (GridView)sender;
            GridViewRow HeaderRow = new GridViewRow(0, 0, DataControlRowType.Separator, DataControlRowState.Insert);
            //   grdReports.HeaderRow.Cells[0].Text = "Header 1";

            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //cell.VerticalAlign = VerticalAlign.Middle;
            //string ItemName = cell.Text;
            TableCell HeaderCell = new TableCell();
            //if (j == 0)
            //{
            if (ddlSalesOffice.SelectedValue == "ALL")
            {
                int i = 3;
                HeaderCell = new TableCell();
                HeaderCell.Text = "Branch Price List";
                HeaderCell.VerticalAlign = VerticalAlign.Middle;
                HeaderCell.ColumnSpan = 3; // For merging three columns (Direct, Referral, Total)
                HeaderCell.CssClass = "HeaderStyle";
                HeaderRow.Cells.Add(HeaderCell);
                foreach (DataRow drsubcategory in dtSubCatgory.Rows)
                {
                    int k = 0;
                    foreach (DataRow dramount in produtstbl.Select("SubCatSno='" + drsubcategory["SubCatSno"].ToString() + "'"))
                    {
                        //foreach (DataRow dramount in dtBranch.Select("ProductName='" + ItemName + "' AND SubCatSno='" + drsubcategory["SubCatSno"].ToString() + "'"))
                        //{
                        //    string Temp = dramount["ProductName"].ToString();
                        //}
                        //Adding Year Column
                        k++;
                    }
                    HeaderCell = new TableCell();
                    HeaderCell.Text = drsubcategory["SubCategoryName"].ToString();
                    HeaderCell.VerticalAlign = VerticalAlign.Middle;
                    HeaderCell.ColumnSpan = k; // For merging three columns (Direct, Referral, Total)
                    HeaderCell.CssClass = "HeaderStyle";
                    //HeaderCell.ForeColor = col
                    HeaderRow.Cells.Add(HeaderCell);
                    // HeaderRow.Controls.Add(HeaderCell);
                    //(GridView2.HeaderRow.Cells[3].
                    ProductGrid.Controls[0].Controls.AddAt(0, HeaderRow);
                }
            }
           // }
        }
    }

    protected void grdReports_DataBinding(object sender, EventArgs e)
    {
        try
        {
            if (ddlSalesOffice.SelectedValue != "ALL")
            {
                GridViewGroup First = new GridViewGroup(grdReports, null, "SubCategory Name");
            }
             // GridViewGroup three = new GridViewGroup(grdReports, seconf, "PF");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void grdReports_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //e.Row.Cells[1].Visible = false;
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    foreach (DataRow drsubcategory in dtSubCatgory.Rows)
        //    {
        //        int k = 0;
        //        foreach (DataRow dramount in produtstbl1.Select("SubCatSno='" + drsubcategory["SubCatSno"].ToString() + "'"))
        //        {
        //            //foreach (DataRow dramount in dtBranch.Select("ProductName='" + ItemName + "' AND SubCatSno='" + drsubcategory["SubCatSno"].ToString() + "'"))
        //            //{
        //            //    string Temp = dramount["ProductName"].ToString();
        //            //}
        //            //Adding Year Column
        //            k++;
        //        }
        //        int RowSpan = k;
        //        for (int i = grdReports.Rows.Count - 2; i >= 0; i--)
        //        {
        //            GridViewRow currRow = grdReports.Rows[i];
        //            GridViewRow prevRow = grdReports.Rows[i + 1];
        //            if (currRow.Cells[1].Text == prevRow.Cells[1].Text)
        //            {
        //                currRow.Cells[1].RowSpan = RowSpan;
        //                prevRow.Cells[1].Visible = false;
        //                RowSpan += 1;
        //            }
        //            else
        //            {
        //                RowSpan = 2;
        //            }
        //        }
        //    }
        //}
    }
}