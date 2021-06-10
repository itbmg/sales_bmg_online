using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using MySql.Data.MySqlClient;

public partial class SAPLeaks_JV : System.Web.UI.Page
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
            Report.Columns.Add("JV No");
            Report.Columns.Add("JV Date");
            Report.Columns.Add("WH Code");
            Report.Columns.Add("Ledger Code");
            Report.Columns.Add("Ledger Name");
            Report.Columns.Add("Item Code");
            Report.Columns.Add("Item Name");
            Report.Columns.Add("Category Code");
            Report.Columns.Add("Total Amount");
            Report.Columns.Add("Narration");
            lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
            lblRoutName.Text = ddlSalesOffice.SelectedItem.Text;
            Session["xporttype"] = "TallyLekas";
            DateTime ReportDate = fromdate;
            DateTime dtapril = new DateTime();
            DateTime dtmarch = new DateTime();
            int currentyear = ReportDate.Year;
            int nextyear = ReportDate.Year + 1;
            if (ReportDate.Month > 3)
            {
                string apr = "4/1/" + currentyear;
                dtapril = DateTime.Parse(apr);
                string march = "3/31/" + nextyear;
                dtmarch = DateTime.Parse(march);
            }
            if (ReportDate.Month <= 3)
            {
                string apr = "4/1/" + (currentyear - 1);
                dtapril = DateTime.Parse(apr);
                string march = "3/31/" + (nextyear - 1);
                dtmarch = DateTime.Parse(march);
            }
            string DCNO = "";
            if (ddlSalesOffice.SelectedValue == "174")
            {
                DCNO = "CHN/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "271")
            {
                DCNO = "NLR/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "285")
            {
                DCNO = "TPT/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "306")
            {
                DCNO = "KANCHI/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "2749")
            {
                DCNO = "MDPL/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "2909")
            {
                DCNO = "VLR/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "538")
            {
                DCNO = "BANG/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "159")
            {
                DCNO = "HYD/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "570")
            {
                DCNO = "VJD/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "457")
            {
                DCNO = "WNGL/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "3928")
            {
                DCNO = "AB/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "158" || ddlSalesOffice.SelectedValue == "572")
            {
                DCNO = "WYRA/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "282")
            {
                DCNO = "KLH/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "458")
            {
                DCNO = "KMM/JV/" + DCNO;
            }
            if (ddlSalesOffice.SelectedValue == "3559")
            {
                DCNO = "CTR/JV/" + DCNO;
            }
            cmd = new MySqlCommand("SELECT sno, BranchName, incentivename,ledger_jv_code,whcode FROM branchdata WHERE (sno = @BranchID)");
            if (Session["salestype"].ToString() == "Plant")
            {
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            }
            else
            {
                cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
            }
            DataTable dtincetivename = vdm.SelectQuery(cmd).Tables[0];
            Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Tally Lekas" + fromdate.ToString("dd/MM/yyyy");
            cmd = new MySqlCommand("SELECT  dispatch.DispName, dispatch.sno, dispatch.BranchID, tripdata.I_Date,tripdata.dcno, tripdata.Sno AS TripSno, dispatch.DispMode, branchmappingtable.SuperBranch, triproutes.Tripdata_sno FROM dispatch INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno INNER JOIN branchmappingtable ON dispatch.BranchID = branchmappingtable.SubBranch WHERE (dispatch.BranchID = @BranchID) AND (tripdata.I_Date BETWEEN @d1 AND @d2)and (dispatch.DispType='SO') and (tripdata.Status<>'C') OR (tripdata.I_Date BETWEEN @d1 AND @d2) AND (branchmappingtable.SuperBranch = @SuperBranch)  and (dispatch.DispType='SO')and (tripdata.Status<>'C') GROUP BY tripdata.Sno ORDER BY dispatch.sno");
            cmd.Parameters.AddWithValue("@SuperBranch", ddlSalesOffice.SelectedValue);
            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
            DataTable dtDispnames = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dtDispnames.Rows)
            {
                //cmd = new MySqlCommand("SELECT leakages.TotalLeaks, leakages.TripID, leakages.VLeaks, leakages.VReturns, leakages.ReturnQty, productsdata.tproduct,  branchproducts.unitprice, leakages.ProductID, leakages.FreeMilk, leakages.ShortQty, branchproducts.branch_sno FROM productsdata INNER JOIN leakages ON productsdata.sno = leakages.ProductID INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (leakages.TripID = @tripID) AND (branchproducts.branch_sno = @BranchID)");
                cmd = new MySqlCommand("SELECT leakages.TotalLeaks, leakages.TripID, leakages.VLeaks, leakages.VReturns, leakages.ReturnQty, productsdata.tproduct,productsdata.itemcode, branchproducts.unitprice, leakages.ProductID, leakages.FreeMilk, leakages.ShortQty,  branchproducts.branch_sno, products_category.categorycode FROM productsdata INNER JOIN leakages ON productsdata.sno = leakages.ProductID INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (leakages.TripID = @tripID) AND (branchproducts.branch_sno = @BranchID)");
                cmd.Parameters.AddWithValue("@tripID", dr["TripSno"].ToString());
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                DataTable dtLeakble = vdm.SelectQuery(cmd).Tables[0];
                string tripID = "";
                if (dtLeakble.Rows.Count > 0)
                {
                    DataView view = new DataView(dtLeakble);
                    int i = 1;
                    double totleaksamount = 0;
                    foreach (DataRow branch in dtLeakble.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        double Qty = 0;
                        double.TryParse(branch["TotalLeaks"].ToString(), out Qty);
                        if (Qty == 0.0)
                        {
                        }
                        else
                        {
                            double Rate = 0;
                            double.TryParse(branch["unitprice"].ToString(), out Rate);
                            double amount = 0;
                            amount = Qty * Rate;
                            totleaksamount += amount;
                            tripID = dr["dcno"].ToString();
                            newrow["JV No"] = DCNO + "L" + dr["dcno"].ToString();
                            if (ddlSalesOffice.SelectedValue == "306")
                            {
                                newrow["JV Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                            }
                            else
                            {
                                newrow["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                            }
                            newrow["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                            newrow["Ledger Code"] = dtincetivename.Rows[0]["ledger_jv_code"].ToString();
                            newrow["Ledger Name"] = "Sales-" + dtincetivename.Rows[0]["incentivename"].ToString();
                            newrow["Item Code"] = branch["itemcode"].ToString();
                            newrow["Item Name"] = branch["tproduct"].ToString();
                            newrow["Category Code"] = branch["categorycode"].ToString();
                            newrow["Total Amount"] = "-" + amount;
                            if (amount == 0.0)
                            {
                            }
                            else
                            {
                                newrow["Narration"] = "Being the Sale Of Milk Through " + ddlSalesOffice.SelectedItem.Text + ". This is Leakage Milk Vide JV No " + dr["dcno"].ToString() + ",Emp Name  " + Session["EmpName"].ToString();
                                Report.Rows.Add(newrow);
                                i++;
                            }
                        }
                    }
                    //DataRow newrowleaks = Report.NewRow();
                    //newrowleaks["JV No"] = DCNO + "L" + tripID;
                    //newrowleaks["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                    //newrowleaks["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                    //newrowleaks["Ledger Code"] = dtincetivename.Rows[0]["ledger_jv_code"].ToString();
                    //newrowleaks["Ledger Name"] = "Sales-" + dtincetivename.Rows[0]["incentivename"].ToString();
                    //newrowleaks["Total Amount"] = "-" + totleaksamount;
                    //newrowleaks["Narration"] = "Being the Sale Of Milk Through " + ddlSalesOffice.SelectedItem.Text + ". This is Leakage Milk Vide JV No " + dr["dcno"].ToString() + ",Emp Name  " + Session["EmpName"].ToString();
                    //Report.Rows.Add(newrowleaks);

                    DataRow newrow2 = Report.NewRow();
                    newrow2["JV No"] = DCNO + "L" + tripID;
                    if (ddlSalesOffice.SelectedValue == "306")
                    {
                        newrow2["JV Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                    }
                    else
                    {
                        newrow2["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                    }
                    newrow2["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                    newrow2["Ledger Code"] = "5134004";
                    newrow2["Ledger Name"] = "Sales leakages-" + dtincetivename.Rows[0]["incentivename"].ToString();
                    newrow2["Total Amount"] = totleaksamount;
                    Report.Rows.Add(newrow2);

                    double totreturnamount = 0;
                    foreach (DataRow branch in dtLeakble.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        double ReturnQty = 0;
                        double.TryParse(branch["ReturnQty"].ToString(), out ReturnQty);
                        if (ReturnQty == 0.0)
                        {
                        }
                        else
                        {
                            double Rate = 0;
                            double.TryParse(branch["unitprice"].ToString(), out Rate);
                            double amount = 0;
                            amount = ReturnQty * Rate;
                            totreturnamount += amount;
                            tripID = dr["dcno"].ToString();
                            newrow["JV No"] = DCNO + "R" + dr["dcno"].ToString();
                            if (ddlSalesOffice.SelectedValue == "306")
                            {
                                newrow["JV Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                            }
                            else
                            {
                                newrow["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                            }
                            newrow["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                            newrow["Ledger Code"] = dtincetivename.Rows[0]["ledger_jv_code"].ToString();
                            newrow["Ledger Name"] = "Sales-" + dtincetivename.Rows[0]["incentivename"].ToString();
                            newrow["Item Code"] = branch["itemcode"].ToString();
                            newrow["Item Name"] = branch["tproduct"].ToString();
                            newrow["Category Code"] = branch["categorycode"].ToString();
                            newrow["Total Amount"] = "-" + amount;
                            newrow["Narration"] = "Being the Sale Of Milk Through " + ddlSalesOffice.SelectedItem.Text + ". This is Return Milk Vide JV No " + dr["dcno"].ToString() + ",Emp Name  " + Session["EmpName"].ToString();
                            Report.Rows.Add(newrow);
                            i++;
                        }
                    }

                    //DataRow newretruns = Report.NewRow();
                    //newretruns["JV No"] = DCNO + "R" + tripID;
                    //newretruns["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                    //newretruns["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                    //newretruns["Ledger Code"] = dtincetivename.Rows[0]["ledger_jv_code"].ToString();
                    //newretruns["Ledger Name"] = "Sales-" + dtincetivename.Rows[0]["incentivename"].ToString();
                    //if (totreturnamount == 0.0)
                    //{
                    //}
                    //else
                    //{
                    //    newretruns["Total Amount"] = "-" + totreturnamount;
                    //    newretruns["Narration"] = "Being the Sale Of Milk Through " + ddlSalesOffice.SelectedItem.Text + ". This is Return Milk Vide JV No " + dr["dcno"].ToString() + ",Emp Name  " + Session["EmpName"].ToString();
                    //    Report.Rows.Add(newretruns);
                    //}

                    DataRow newrow4 = Report.NewRow();
                    newrow4["JV No"] = DCNO + "R" + tripID;
                    if (ddlSalesOffice.SelectedValue == "306")
                    {
                        newrow4["JV Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                    }
                    else
                    {
                        newrow4["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                    }
                    newrow4["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                    newrow4["Ledger Code"] = "5134005";
                    newrow4["Ledger Name"] = "Sales Returns-" + dtincetivename.Rows[0]["incentivename"].ToString();
                    if (totreturnamount == 0.0)
                    {
                    }
                    else
                    {
                        newrow4["Total Amount"] = totreturnamount;
                        Report.Rows.Add(newrow4);
                    }
                }
                //cmd = new MySqlCommand("SELECT SUM(leakages.ShortQty) AS ShortQty, SUM(leakages.FreeMilk) AS FreeMilk, productsdata.tproduct, branchproducts.unitprice FROM leakages INNER JOIN tripdata ON leakages.TripID = tripdata.Sno INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (tripdata.ATripid = @TripID) AND (branchproducts.branch_sno = @BranchID) GROUP BY productsdata.tproduct");
                cmd = new MySqlCommand("SELECT SUM(leakages.ShortQty) AS ShortQty, SUM(leakages.FreeMilk) AS FreeMilk, productsdata.tproduct, branchproducts.unitprice, products_category.categorycode,productsdata.itemcode FROM leakages INNER JOIN  tripdata ON leakages.TripID = tripdata.Sno INNER JOIN productsdata ON leakages.ProductID = productsdata.sno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata.ATripid = @TripID) AND (branchproducts.branch_sno = @BranchID) GROUP BY productsdata.tproduct, products_category.categorycode,productsdata.ProductName");
                cmd.Parameters.AddWithValue("@TripID", dr["TripSno"].ToString());
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                DataTable Dtfreemilk = vdm.SelectQuery(cmd).Tables[0];

                //cmd = new MySqlCommand("SELECT branchleaktrans.ShortQty  AS ShortQty,branchleaktrans.FreeQty AS FreeMilk, productsdata.tproduct, branchproducts.unitprice FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN branchleaktrans ON productsdata.sno = branchleaktrans.ProdId WHERE (branchproducts.branch_sno = @BranchID) AND (branchleaktrans.TripId = @TripID)GROUP BY productsdata.tproduct");
                cmd = new MySqlCommand("SELECT branchleaktrans.ShortQty, branchleaktrans.FreeQty AS FreeMilk, productsdata.tproduct, branchproducts.unitprice, products_category.categorycode,productsdata.itemcode FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN branchleaktrans ON productsdata.sno = branchleaktrans.ProdId INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (branchproducts.branch_sno = @BranchID) AND (branchleaktrans.TripId = @TripID) GROUP BY productsdata.tproduct, products_category.categorycode,productsdata.ProductName");
                cmd.Parameters.AddWithValue("@TripID", dr["TripSno"].ToString());
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                DataTable dtsalesofficeshortfree = vdm.SelectQuery(cmd).Tables[0];
                DataTable newdt = new DataTable();
                newdt = Dtfreemilk.Copy();
                newdt.Merge(dtsalesofficeshortfree, true, MissingSchemaAction.Ignore);

                double totshortamount = 0;
                foreach (DataRow branch in newdt.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    double ShortQty = 0;
                    double.TryParse(branch["ShortQty"].ToString(), out ShortQty);
                    if (ShortQty == 0.0)
                    {
                    }
                    else
                    {
                        double Rate = 0;
                        double.TryParse(branch["unitprice"].ToString(), out Rate);
                        ShortQty = Math.Round(ShortQty, 2);
                        double amount = 0;
                        amount = ShortQty * Rate;
                        totshortamount += amount;
                        amount = Math.Round(amount, 2);
                        tripID = dr["dcno"].ToString();
                        newrow["JV No"] = DCNO + "S" + dr["dcno"].ToString();
                        if (ddlSalesOffice.SelectedValue == "306")
                        {
                            newrow["JV Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                        }
                        else
                        {
                            newrow["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                        }
                        newrow["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                        newrow["Ledger Code"] = dtincetivename.Rows[0]["ledger_jv_code"].ToString();
                        newrow["Ledger Name"] = "Sales-" + dtincetivename.Rows[0]["incentivename"].ToString();
                        newrow["Item Code"] = branch["itemcode"].ToString();
                        newrow["Item Name"] = branch["tproduct"].ToString();
                        newrow["Category Code"] = branch["categorycode"].ToString();
                        newrow["Total Amount"] = "-" + amount;
                        newrow["Narration"] = "Being the Sale Of Milk Through " + ddlSalesOffice.SelectedItem.Text + ". This is Short Milk Vide JV No " + dr["dcno"].ToString() + ",Emp Name  " + Session["EmpName"].ToString();
                        Report.Rows.Add(newrow);
                    }
                }
                //DataRow newShorts = Report.NewRow();
                //newShorts["JV No"] = DCNO + "S" + tripID;
                //newShorts["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                //newShorts["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                //newShorts["Ledger Code"] = dtincetivename.Rows[0]["ledger_jv_code"].ToString();
                //newShorts["Ledger Name"] = "Sales-" + dtincetivename.Rows[0]["incentivename"].ToString();
                //if (totshortamount == 0.0)
                //{
                //}
                //else
                //{
                //    totshortamount = Math.Round(totshortamount, 2);
                //    newShorts["Total Amount"] = "-" + totshortamount;
                //    newShorts["Narration"] = "Being the Sale Of Milk Through " + ddlSalesOffice.SelectedItem.Text + ". This is Short Milk Vide JV No " + dr["dcno"].ToString() + ",Emp Name  " + Session["EmpName"].ToString();
                //    Report.Rows.Add(newShorts);
                //}

                DataRow newrow6 = Report.NewRow();
                newrow6["JV No"] = DCNO + "S" + tripID;
                if (ddlSalesOffice.SelectedValue == "306")
                {
                    newrow6["JV Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                }
                else
                {
                    newrow6["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                }
                newrow6["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                newrow6["Ledger Code"] = "5134009";
                newrow6["Ledger Name"] = "Spolige & Shortage-" + dtincetivename.Rows[0]["incentivename"].ToString();
                if (totshortamount == 0.0)
                {
                }
                else
                {
                    totshortamount = Math.Round(totshortamount, 2);
                    newrow6["Total Amount"] = totshortamount;
                    Report.Rows.Add(newrow6);
                }

                double totfreeamount = 0;
                foreach (DataRow branch in Dtfreemilk.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    double FreeMilk = 0;
                    double.TryParse(branch["FreeMilk"].ToString(), out FreeMilk);
                    if (FreeMilk == 0.0)
                    {
                    }
                    else
                    {
                        double Rate = 0;
                        double.TryParse(branch["unitprice"].ToString(), out Rate);
                        FreeMilk = Math.Round(FreeMilk, 2);
                        double amount = 0;
                        amount = FreeMilk * Rate;
                        totfreeamount += amount;
                        tripID = dr["dcno"].ToString();
                        newrow["JV No"] = DCNO + "F" + dr["dcno"].ToString();
                        if (ddlSalesOffice.SelectedValue == "306")
                        {
                            newrow["JV Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                        }
                        else
                        {
                            newrow["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                        }
                        newrow["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                        newrow["Ledger Code"] = dtincetivename.Rows[0]["ledger_jv_code"].ToString();
                        newrow["Ledger Name"] = "Sales-" + dtincetivename.Rows[0]["incentivename"].ToString();
                        newrow["Item Code"] = branch["itemcode"].ToString();
                        newrow["Item Name"] = branch["tproduct"].ToString();
                        newrow["Category Code"] = branch["categorycode"].ToString();
                        newrow["Total Amount"] = "-" + amount;
                        newrow["Narration"] = "Being the Sale Of Milk Through " + ddlSalesOffice.SelectedItem.Text + ". This is Free Milk Vide JV No " + dr["dcno"].ToString() + ",Emp Name  " + Session["EmpName"].ToString();
                        Report.Rows.Add(newrow);
                    }
                }
                //DataRow newfree = Report.NewRow();
                //newfree["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                //newfree["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                //newfree["Ledger Code"] = dtincetivename.Rows[0]["ledger_jv_code"].ToString();
                //newfree["Ledger Name"] = "Sales-" + dtincetivename.Rows[0]["incentivename"].ToString();
                //if (totfreeamount == 0.0)
                //{
                //}
                //else
                //{
                //    totfreeamount = Math.Round(totfreeamount, 2);5134008
                //    newfree["Total Amount"] = "-" + totfreeamount;
                //    newfree["Narration"] = "Being the Sale Of Milk Through " + ddlSalesOffice.SelectedItem.Text + ". This is Free Milk Vide JV No " + dr["dcno"].ToString() + ",Emp Name  " + Session["EmpName"].ToString();
                //    Report.Rows.Add(newfree);
                //}

                DataRow newrow7 = Report.NewRow();
                newrow7["JV No"] = DCNO + "F" + tripID;
                if (ddlSalesOffice.SelectedValue == "306")
                {
                    newrow7["JV Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                }
                else
                {
                    newrow7["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                }
                newrow7["WH Code"] = dtincetivename.Rows[0]["whcode"].ToString();
                newrow7["Ledger Code"] = "5134008";
                newrow7["Ledger Name"] = "Free Sales-Milk-" + dtincetivename.Rows[0]["incentivename"].ToString();
                if (totfreeamount == 0.0)
                {
                }
                else
                {
                    totfreeamount = Math.Round(totfreeamount, 2);
                    newrow7["Total Amount"] = totfreeamount;
                    Report.Rows.Add(newrow7);
                }
            }
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
            if (ddlSalesOffice.SelectedValue == "306")
            {
                fromdate = fromdate.AddDays(1);
            }
            else
            {
                fromdate = fromdate;
            }

            //cmd = new MySqlCommand("SELECT sno, BranchName, whcode, ladger_dr_code, tax, ntax, ledger_jv_code FROM branchdata WHERE (sno = @BranchID)");
            //cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            //DataTable dtwhscode = vdm.SelectQuery(cmd).Tables[0];
            //sqlcmd = new SqlCommand("SELECT CreateDate, RefDate, DocDate, Ref1, Ref2, Ref3, TransNo, AcctCode FROM EMROJDT WHERE (RefDate BETWEEN @d1 AND @d2) AND (OcrCode = @WhsCode)");
            //sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
            //sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
            //sqlcmd.Parameters.Add("@WhsCode", dtwhscode.Rows[0]["whcode"].ToString());
            //DataTable dtGI = SAPvdm.SelectQuery(sqlcmd).Tables[0];
            //if (dtGI.Rows.Count > 0)
            //{
            //    lblmsg.Text = "This Transaction already saved";
            //}
            //else
            //{
            DataTable dtJournelPay = new DataTable();
            foreach (DataRow dr in dt.Rows)
            {
                string AcctCode = dr["Ledger Code"].ToString();
                string whCode = dr["WH Code"].ToString();

                if (AcctCode == "" && whCode == "")
                {
                }
                else
                {
                    sqlcmd = new SqlCommand("SELECT CreateDate, RefDate, DocDate, Ref1, Ref2, Ref3, TransNo, AcctCode FROM EMROJDT WHERE (RefDate BETWEEN @d1 AND @d2) AND (TransNo = @TransNo) AND (Ref1=@Ref1) AND (OcrCode = @OcrCode)");
                    sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
                    sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
                    sqlcmd.Parameters.Add("@TransNo", dr["JV No"].ToString());
                    sqlcmd.Parameters.Add("@OcrCode", dr["WH Code"].ToString());
                    sqlcmd.Parameters.Add("@Ref1", dr["Item Code"].ToString());
                    dtJournelPay = SAPvdm.SelectQuery(sqlcmd).Tables[0];
                    if (dtJournelPay.Rows.Count > 0)
                    {
                        lblmsg.Text = "This Transaction already saved";
                        break;
                    }
                    else
                    {
                        sqlcmd = new SqlCommand("Insert into EMROJDT (CreateDate, RefDate, DocDate, TransNo, AcctCode, AcctName, Debit, Credit, B1Upload, Processed,Ref1,OcrCode,OcrCode2,series) values (@CreateDate, @RefDate, @DocDate,@TransNo, @AcctCode, @AcctName, @Debit, @Credit, @B1Upload, @Processed,@Ref1,@OcrCode,@OcrCode2,@series)");
                        sqlcmd.Parameters.Add("@CreateDate", GetLowDate(fromdate));
                        sqlcmd.Parameters.Add("@RefDate", GetLowDate(fromdate));
                        sqlcmd.Parameters.Add("@docdate", GetLowDate(fromdate));
                        sqlcmd.Parameters.Add("@Ref1", dr["Item Code"].ToString());
                        sqlcmd.Parameters.Add("@TransNo", dr["JV No"].ToString());
                        sqlcmd.Parameters.Add("@AcctCode", dr["Ledger Code"].ToString());
                        sqlcmd.Parameters.Add("@AcctName", dr["Ledger Name"].ToString());
                        double amount = 0;
                        double.TryParse(dr["Total Amount"].ToString(), out amount);
                        amount = Math.Round(amount, 2);
                        if (amount < 0)
                        {
                            amount = Math.Abs(amount);
                            double Debit = 0;
                            sqlcmd.Parameters.Add("@Debit", Debit);
                            sqlcmd.Parameters.Add("@Credit", amount);
                        }
                        else
                        {
                            amount = Math.Abs(amount);
                            double Credit = 0;
                            sqlcmd.Parameters.Add("@Debit", amount);
                            sqlcmd.Parameters.Add("@Credit", Credit);
                        }
                        string B1Upload = "N";
                        string Processed = "N";
                        sqlcmd.Parameters.Add("@B1Upload", B1Upload);
                        sqlcmd.Parameters.Add("@Processed", Processed);
                        sqlcmd.Parameters.Add("@OcrCode", dr["WH Code"].ToString());
                        sqlcmd.Parameters.Add("@OcrCode2", dr["Category Code"].ToString());
                        string series = "17";
                        sqlcmd.Parameters.Add("@series", series);
                        if (amount == 0.0)
                        {
                        }
                        else
                        {
                            SAPvdm.insert(sqlcmd);
                        }
                    }
                }
            }
            if (dtJournelPay.Rows.Count > 0)
            {
                pnlHide.Visible = false;
                DataTable dtempty = new DataTable();
                grdReports.DataSource = dtempty;
                grdReports.DataBind();
                lblmsg.Text = "This Transaction already saved";
            }
            else
            {
                pnlHide.Visible = false;
                DataTable dtempty = new DataTable();
                grdReports.DataSource = dtempty;
                grdReports.DataBind();
                lblmsg.Text = "Successfully Saved";
            }
            //}
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.ToString();
        }
    }
}