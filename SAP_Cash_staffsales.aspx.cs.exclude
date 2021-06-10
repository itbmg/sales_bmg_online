using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;

public partial class SAP_Cash_staffsales : System.Web.UI.Page
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
                //filltaxtypes();
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
        ddlSalesOffice.Items.Insert(0, new ListItem("Cash Sale", "0"));
        ddlSalesOffice.Items.Insert(0, new ListItem("Staff Sale", "1"));
        ddlSalesOffice.Items.Insert(0, new ListItem("Free Sale", "2"));
        ddlSalesOffice.Items.Insert(0, new ListItem("Others", "3"));
    }
    //void filltaxtypes()
    //{
    //    vdm = new VehicleDBMgr();
    //    ddltype.Items.Insert(0, new ListItem("Non Tax", "0"));
    //    ddltype.Items.Insert(0, new ListItem("Tax", "1"));
    //}
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
        #region
        //try
        //{
        //    lblmsg.Text = "";
        //    pnlHide.Visible = true;
        //    Session["RouteName"] = ddlSalesOffice.SelectedItem.Text;
        //    Session["IDate"] = DateTime.Now.AddDays(1).ToString("dd/MM/yyyy");
        //    vdm = new VehicleDBMgr();
        //    DateTime fromdate = DateTime.Now;
        //    string[] dateFromstrig = txtFromdate.Text.Split(' ');
        //    if (dateFromstrig.Length > 1)
        //    {
        //        if (dateFromstrig[0].Split('-').Length > 0)
        //        {
        //            string[] dates = dateFromstrig[0].Split('-');
        //            string[] times = dateFromstrig[1].Split(':');
        //            fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
        //        }
        //    }

        //    lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
        //    lblRoutName.Text = ddlSalesOffice.SelectedItem.Text;
        //    Session["xporttype"] = "TallyCashStaff";
        //    DateTime ReportDate = VehicleDBMgr.GetTime(vdm.conn);
        //    DateTime dtapril = new DateTime();
        //    DateTime dtmarch = new DateTime();
        //    int currentyear = ReportDate.Year;
        //    int nextyear = ReportDate.Year + 1;
        //    if (ReportDate.Month > 3)
        //    {
        //        string apr = "4/1/" + currentyear;
        //        dtapril = DateTime.Parse(apr);
        //        string march = "3/31/" + nextyear;
        //        dtmarch = DateTime.Parse(march);
        //    }
        //    if (ReportDate.Month <= 3)
        //    {
        //        string apr = "4/1/" + (currentyear - 1);
        //        dtapril = DateTime.Parse(apr);
        //        string march = "3/31/" + (nextyear - 1);
        //        dtmarch = DateTime.Parse(march);
        //    }

        //    Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Tally Inward" + fromdate.ToString("dd/MM/yyyy");
        //    if ((ddlSalesOffice.SelectedItem.Text == "Cash Sale") && (ddltype.SelectedItem.Text == "Non Tax") || (ddlSalesOffice.SelectedItem.Text == "Staff Sale") && (ddltype.SelectedItem.Text == "Non Tax"))
        //    {
        //        Report = new DataTable();
        //        Report.Columns.Add("Ledger Type");
        //        Report.Columns.Add("Customer Code");
        //        Report.Columns.Add("Customer Name");
        //        Report.Columns.Add("Invoce No");
        //        Report.Columns.Add("Invoice Date");
        //        Report.Columns.Add("Item Name");
        //        Report.Columns.Add("Qty");
        //        Report.Columns.Add("Rate");
        //        Report.Columns.Add("Rounding Off");
        //        Report.Columns.Add("Inv Value");
        //        Report.Columns.Add("Net Value");
        //        Report.Columns.Add("Narration");
        //        cmd = new MySqlCommand("SELECT sno, BranchName, statename FROM branchdata WHERE (sno = @BranchID)");
        //        if (Session["salestype"].ToString() == "Plant")
        //        {
        //            cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
        //        }
        //        else
        //        {
        //            cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
        //        }
        //        DataTable dtstatename = vdm.SelectQuery(cmd).Tables[0];
        //        string statename = "";
        //        if (dtstatename.Rows.Count > 0)
        //        {
        //            statename = dtstatename.Rows[0]["statename"].ToString();
        //        }
        //        cmd = new MySqlCommand("SELECT TripInfo.Sno, TripInfo.DCNo, ProductInfo.tproduct, ProductInfo.Prodsno, ProductInfo.Categoryname, ProductInfo.Qty, TripInfo.I_Date, TripInfo.VehicleNo, TripInfo.Status, TripInfo.DispName, TripInfo.DispType, TripInfo.DispMode FROM (SELECT tripdata.Sno, tripdata.DCNo, tripdata.I_Date, tripdata.VehicleNo, tripdata.Status, dispatch.DispName, dispatch.DispType, dispatch.DispMode FROM branchdata INNER JOIN dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno WHERE (dispatch.DispMode = 'LOCAL') AND (dispatch.Branch_Id = @branch) AND (tripdata.AssignDate BETWEEN @d1 AND @d2)) TripInfo INNER JOIN (SELECT Categoryname, ProductName, Sno, Qty, tproduct,Prodsno FROM  (SELECT products_category.Categoryname, productsdata.ProductName, tripdata_1.Sno, tripsubdata.Qty, productsdata.tproduct,productsdata.sno as Prodsno FROM tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno");
        //        cmd.Parameters.AddWithValue("@branch", Session["branch"]);
        //        cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
        //        cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
        //        cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate).AddDays(-1));
        //        DataTable dtble = vdm.SelectQuery(cmd).Tables[0];
        //        cmd = new MySqlCommand("SELECT branchproducts.branch_sno, branchproducts.product_sno, branchproducts.unitprice,IFNULL(branchproducts.VatPercent, 0) AS VatPercent, products_category.tcategory FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (branchproducts.branch_sno = @BranchID)");
        //        if (ddlSalesOffice.SelectedItem.Text == "Cash Sale")
        //        {
        //            cmd.Parameters.AddWithValue("@BranchID", "282");
        //        }
        //        else
        //        {
        //            string barnch = "760";
        //            cmd.Parameters.AddWithValue("@BranchID", barnch);
        //        }
        //        DataTable dtprodcts = vdm.SelectQuery(cmd).Tables[0];
        //        int i = 1;
        //        cmd = new MySqlCommand("SELECT agentdc.agentdcno, agentdc.BranchID FROM agentdc INNER JOIN branchmappingtable ON agentdc.BranchID = branchmappingtable.SubBranch INNER JOIN  branchdata ON branchmappingtable.SuperBranch = branchdata.sno WHERE (agentdc.IndDate BETWEEN @d1 AND @d2) AND (branchmappingtable.SuperBranch = @BranchID) AND (agentdc.agentdcno > 1) OR (agentdc.IndDate BETWEEN @d1 AND @d2) AND (branchdata.SalesOfficeID = @SOID) AND (agentdc.agentdcno > 1) GROUP BY agentdc.BranchID ORDER BY agentdc.agentdcno");
        //        string BranchID = ddlSalesOffice.SelectedValue;
        //        if (BranchID == "572")
        //        {
        //            BranchID = "158";
        //        }
        //        cmd.Parameters.AddWithValue("@BranchID", "282");
        //        cmd.Parameters.AddWithValue("@SOID", "282");
        //        cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
        //        cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
        //        DataTable dtDc = vdm.SelectQuery(cmd).Tables[0];
        //        foreach (DataRow branch in dtble.Rows)
        //        {
        //            double vatpercent = 0;
        //            double UnitCost = 0;
        //            double Unitprice = 0;
        //            string tcategory = "";
        //            foreach (DataRow dr in dtprodcts.Select("product_sno='" + branch["Prodsno"].ToString() + "'"))
        //            {
        //                DataRow newrow = Report.NewRow();
        //                double.TryParse(dr["unitprice"].ToString(), out UnitCost);
        //                double.TryParse(dr["vatpercent"].ToString(), out vatpercent);
        //                if (vatpercent == null || vatpercent == 0.0)
        //                {
        //                    string DCNO = "0";
        //                    if (dtDc.Rows.Count > 0)
        //                    {
        //                        DataRow[] drdc = dtDc.Select("BranchID=" + dr["branch_sno"].ToString());
        //                        foreach (DataRow drc in drdc)
        //                        {
        //                            DCNO = drc.ItemArray[0].ToString();
        //                        }
        //                    }
        //                    if (DCNO == "1" || DCNO == "" || DCNO == "0")
        //                    {
        //                        DCNO = "0";
        //                        long DcNo = 0;
        //                        string socode = "";
        //                        DataRow[] drdc = dtDc.Select("BranchID=" + dr["branch_sno"].ToString());
        //                        if (drdc.Length < 2)
        //                        {
        //                            cmd = new MySqlCommand("SELECT IFNULL(MAX(agentdcno), 0) + 1 AS Sno FROM agentdc WHERE (soid = @BranchID) AND (IndDate BETWEEN @d1 AND @d2)");
        //                            if (Session["salestype"].ToString() == "Plant")
        //                            {
        //                                socode = "282";
        //                            }
        //                            else
        //                            {
        //                                socode = "282";
        //                            }
        //                            cmd.Parameters.AddWithValue("@BranchID", socode);
        //                            cmd.Parameters.AddWithValue("@d1", GetLowDate(dtapril.AddDays(-1)));
        //                            cmd.Parameters.AddWithValue("@d2", GetHighDate(dtmarch.AddDays(-1)));
        //                            DataTable dtadcno = vdm.SelectQuery(cmd).Tables[0];
        //                            string agentdcNo = dtadcno.Rows[0]["Sno"].ToString();
        //                            cmd = new MySqlCommand("Insert Into Agentdc (BranchId,IndDate,soid,agentdcno) Values(@BranchId,@IndDate,@soid,@agentdcno)");
        //                            cmd.Parameters.AddWithValue("@BranchId", dr["branch_sno"].ToString());
        //                            cmd.Parameters.AddWithValue("@IndDate", GetLowDate(fromdate.AddDays(-1)));
        //                            cmd.Parameters.AddWithValue("@soid", socode);
        //                            cmd.Parameters.AddWithValue("@agentdcno", agentdcNo);
        //                            DcNo = vdm.insertScalar(cmd);
        //                            cmd = new MySqlCommand("SELECT IndentNo FROM indents WHERE (Branch_id = @BranchId) AND (I_date BETWEEN @d1 AND @d2)");
        //                            cmd.Parameters.AddWithValue("@BranchId", dr["branch_sno"].ToString());
        //                            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
        //                            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
        //                            DataTable dtindentno = vdm.SelectQuery(cmd).Tables[0];
        //                            if (dtindentno.Rows.Count > 0)
        //                            {
        //                                foreach (DataRow drr in dtindentno.Rows)
        //                                {
        //                                    cmd = new MySqlCommand("Insert Into dcsubTable (DcNo,IndentNo) Values(@DcNo,@IndentNo)");
        //                                    cmd.Parameters.AddWithValue("@DcNo", DcNo);
        //                                    cmd.Parameters.AddWithValue("@IndentNo", drr["IndentNo"].ToString());
        //                                    vdm.insert(cmd);
        //                                }
        //                            }
        //                            cmd = new MySqlCommand("SELECT agentdcno FROM  agentdc WHERE (BranchID = @BranchID) AND (IndDate BETWEEN @d1 AND @d2)");
        //                            cmd.Parameters.AddWithValue("@BranchID", dr["branch_sno"].ToString());
        //                            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
        //                            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
        //                            DataTable dtsubDc = vdm.SelectQuery(cmd).Tables[0];
        //                            if (dtsubDc.Rows.Count > 0)
        //                            {
        //                                DCNO = dtsubDc.Rows[0]["agentdcno"].ToString();
        //                            }
        //                            DCNO = DcNo.ToString();
        //                        }
        //                    }
        //                    if (ddlSalesOffice.SelectedItem.Text == "Staff Sale")
        //                    {
        //                        newrow["Customer Name"] = branch["DispName"].ToString();
        //                        newrow["Customer Code"] = "0001";
        //                    }
        //                    else
        //                    {
        //                        newrow["Customer Code"] = "132456";
        //                        newrow["Customer Name"] = "Cash sales-Pbk";
        //                    }
        //                    int countdc = 0;
        //                    int.TryParse(DCNO, out countdc);
        //                    if (countdc <= 10)
        //                    {
        //                        DCNO = "0000" + countdc;
        //                    }
        //                    if (countdc >= 10 && countdc <= 99)
        //                    {
        //                        DCNO = "000" + countdc;
        //                    }
        //                    if (countdc >= 99 && countdc <= 999)
        //                    {
        //                        DCNO = "00" + countdc;
        //                    }
        //                    if (countdc > 999)
        //                    {
        //                        DCNO = "0" + countdc;
        //                    }
        //                    newrow["Invoce No"] = "KLH/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "/NT/" + DCNO;
        //                    newrow["Invoice Date"] = fromdate.AddDays(-1).ToString("dd-MMM-yyyy");
        //                    newrow["Item Name"] = branch["tproduct"].ToString();
        //                    newrow["Qty"] = branch["qty"].ToString();
        //                    tcategory = dr["tcategory"].ToString();
        //                    newrow["Ledger Type"] = tcategory.ToString();
        //                    Unitprice = UnitCost;
        //                    double percent = 0;
        //                    newrow["Rate"] = Unitprice.ToString();
        //                    double Roundingoff = 0;
        //                    newrow["Rounding Off"] = Roundingoff;
        //                    double invval = 0;
        //                    double qty = 0;
        //                    double.TryParse(branch["qty"].ToString(), out qty);
        //                    double taxval = 0;
        //                    if (vatpercent == 0.0)
        //                    {
        //                        invval = qty * UnitCost;
        //                    }
        //                    else
        //                    {
        //                        double diffcost = 0;
        //                        diffcost = UnitCost - Unitprice;
        //                        taxval = qty * diffcost;
        //                        invval = qty * UnitCost;

        //                    };
        //                    invval = qty * UnitCost;
        //                    invval = Math.Round(invval, 2);
        //                    double netvalue = 0;
        //                    netvalue = invval;
        //                    netvalue = Math.Round(netvalue, 2);
        //                    newrow["Inv Value"] = invval - taxval;
        //                    newrow["Net Value"] = netvalue - taxval;
        //                    if (ddlSalesOffice.SelectedItem.Text == "Cash Sale")
        //                    {
        //                        newrow["Narration"] = "Being the stock transfer to  " + ddlSalesOffice.SelectedItem.Text + " vide dc No " + branch["sno"].ToString() + ",DC Date " + fromdate.AddDays(-1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
        //                    }
        //                    else
        //                    {
        //                        newrow["Narration"] = "Being the stock transfer to  " + branch["DispName"].ToString() + " from " + ddlSalesOffice.SelectedItem.Text + " vide dc No " + branch["sno"].ToString() + ",DC Date " + fromdate.AddDays(-1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
        //                    }
        //                    Report.Rows.Add(newrow);
        //                    i++;
        //                }
        //            }
        //        }
        //        grdReports.DataSource = Report;
        //        grdReports.DataBind();
        //        Session["xportdata"] = Report;
        //    }
        //    else
        //    {
        //        Report = new DataTable();
        //        Report.Columns.Add("Ledger Type");
        //        Report.Columns.Add("Customer Code");
        //        Report.Columns.Add("Customer Name");
        //        Report.Columns.Add("Invoce No");
        //        Report.Columns.Add("Invoice Date");
        //        Report.Columns.Add("Item Name");
        //        Report.Columns.Add("Qty");
        //        Report.Columns.Add("Rate");
        //        Report.Columns.Add("Tax Percentage %");
        //        Report.Columns.Add("Tax Value");
        //        Report.Columns.Add("Rounding Off");
        //        Report.Columns.Add("Inv Value");
        //        Report.Columns.Add("Net Value");
        //        Report.Columns.Add("Narration");
        //        cmd = new MySqlCommand("SELECT sno, BranchName, statename FROM branchdata WHERE (sno = @BranchID)");
        //        if (Session["salestype"].ToString() == "Plant")
        //        {
        //            cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
        //        }
        //        else
        //        {
        //            cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
        //        }
        //        DataTable dtstatename = vdm.SelectQuery(cmd).Tables[0];
        //        string statename = "";
        //        if (dtstatename.Rows.Count > 0)
        //        {
        //            statename = dtstatename.Rows[0]["statename"].ToString();
        //        }
        //        cmd = new MySqlCommand("SELECT TripInfo.Sno, TripInfo.DCNo, ProductInfo.tproduct, ProductInfo.Prodsno, ProductInfo.Categoryname, ProductInfo.Qty, TripInfo.I_Date, TripInfo.VehicleNo, TripInfo.Status, TripInfo.DispName, TripInfo.DispType, TripInfo.DispMode FROM (SELECT tripdata.Sno, tripdata.DCNo, tripdata.I_Date, tripdata.VehicleNo, tripdata.Status, dispatch.DispName, dispatch.DispType, dispatch.DispMode FROM branchdata INNER JOIN dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno WHERE (dispatch.DispMode = 'LOCAL') AND (dispatch.Branch_Id = @branch) AND (tripdata.AssignDate BETWEEN @d1 AND @d2)) TripInfo INNER JOIN (SELECT Categoryname, ProductName, Sno, Qty, tproduct,Prodsno FROM  (SELECT products_category.Categoryname, productsdata.ProductName, tripdata_1.Sno, tripsubdata.Qty, productsdata.tproduct,productsdata.sno as Prodsno FROM tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno");
        //        cmd.Parameters.AddWithValue("@branch", Session["branch"]);
        //        cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
        //        cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
        //        cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate).AddDays(-1));
        //        DataTable dtble = vdm.SelectQuery(cmd).Tables[0];
        //        cmd = new MySqlCommand("SELECT branchproducts.branch_sno, products_category.sno AS categoryid, branchproducts.product_sno, branchproducts.unitprice,IFNULL(branchproducts.VatPercent, 0) AS VatPercent, products_category.tcategory FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (branchproducts.branch_sno = @BranchID)");
        //        if (ddlSalesOffice.SelectedItem.Text == "Cash Sale")
        //        {
        //            cmd.Parameters.AddWithValue("@BranchID", "282");
        //        }
        //        else
        //        {
        //            string barnch = "760";
        //            cmd.Parameters.AddWithValue("@BranchID", barnch);
        //        }
        //        DataTable dtprodcts = vdm.SelectQuery(cmd).Tables[0];
        //        cmd = new MySqlCommand("SELECT sno, taxdcno, invoiceno, agentid, branchid, productid, doe, indentdate FROM taxdc_table WHERE (branchid = @BranchID) AND (indentdate BETWEEN @d1 AND @d2)");
        //        cmd.Parameters.AddWithValue("@BranchID", "282");
        //        cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
        //        cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
        //        DataTable dtDc = vdm.SelectQuery(cmd).Tables[0];
        //        int i = 1;
        //        foreach (DataRow branch in dtble.Rows)
        //        {
        //            double vatpercent = 0;
        //            double UnitCost = 0;
        //            double Unitprice = 0;
        //            string tcategory = "";
        //            string DCNO = "0";
        //            long DcNo = 0;
        //            foreach (DataRow dr in dtprodcts.Select("product_sno='" + branch["Prodsno"].ToString() + "'"))
        //            {
        //                double.TryParse(dr["unitprice"].ToString(), out UnitCost);
        //                double.TryParse(dr["vatpercent"].ToString(), out vatpercent);
        //                if (vatpercent != 0.0)
        //                {
        //                    if (dtDc.Rows.Count > 0)
        //                    {
        //                        DataRow[] drdc = dtDc.Select("productid='" + dr["categoryid"].ToString() + "' and branchid='" + dr["branch_sno"].ToString() + "'");
        //                        if (drdc.Length > 0)
        //                        {
        //                            foreach (DataRow drc in drdc)
        //                            {
        //                                DCNO = drc.ItemArray[1].ToString();
        //                            }
        //                        }
        //                        else
        //                        {
        //                            cmd = new MySqlCommand("SELECT IFNULL(MAX(taxdcno), 0) + 1 AS Sno FROM taxdc_table WHERE (branchid = @branchid) AND (indentdate BETWEEN @d1 AND @d2)");
        //                            cmd.Parameters.AddWithValue("@branchid", "282");
        //                            cmd.Parameters.AddWithValue("@d1", GetLowDate(dtapril.AddDays(-1)));
        //                            cmd.Parameters.AddWithValue("@d2", GetHighDate(dtmarch.AddDays(-1)));
        //                            DataTable dtadcno = vdm.SelectQuery(cmd).Tables[0];
        //                            DCNO = dtadcno.Rows[0]["Sno"].ToString();
        //                            string agentdcno = dtadcno.Rows[0]["Sno"].ToString();
        //                            cmd = new MySqlCommand("Insert Into taxdc_table (taxdcno, invoiceno, agentid, branchid, productid, doe, indentdate) Values(@taxdcno, @invoiceno, @agentid, @branchid, @productid, @doe, @indentdate)");
        //                            cmd.Parameters.AddWithValue("@taxdcno", agentdcno);
        //                            cmd.Parameters.AddWithValue("@invoiceno", DCNO);
        //                            cmd.Parameters.AddWithValue("@agentid", dr["branch_sno"].ToString());
        //                            cmd.Parameters.AddWithValue("@branchid", "282");
        //                            cmd.Parameters.AddWithValue("@productid", dr["categoryid"].ToString());
        //                            cmd.Parameters.AddWithValue("@doe", ReportDate);
        //                            cmd.Parameters.AddWithValue("@indentdate", GetLowDate(fromdate.AddDays(-1)));
        //                            vdm.insert(cmd);
        //                        }
        //                    }
        //                    else
        //                    {
        //                        cmd = new MySqlCommand("SELECT IFNULL(MAX(taxdcno), 0) + 1 AS Sno FROM taxdc_table WHERE (branchid = @branchid) AND (indentdate BETWEEN @d1 AND @d2)");
        //                        cmd.Parameters.AddWithValue("@branchid", ddlSalesOffice.SelectedValue);
        //                        cmd.Parameters.AddWithValue("@d1", GetLowDate(dtapril.AddDays(-1)));
        //                        cmd.Parameters.AddWithValue("@d2", GetHighDate(dtmarch.AddDays(-1)));
        //                        DataTable dtadcno = vdm.SelectQuery(cmd).Tables[0];
        //                        DCNO = dtadcno.Rows[0]["Sno"].ToString();
        //                        string agentdcno = dtadcno.Rows[0]["Sno"].ToString();
        //                        cmd = new MySqlCommand("Insert Into taxdc_table (taxdcno, invoiceno, agentid, branchid, productid, doe, indentdate) Values(@taxdcno, @invoiceno, @agentid, @branchid, @productid, @doe, @indentdate)");
        //                        cmd.Parameters.AddWithValue("@taxdcno", agentdcno);
        //                        cmd.Parameters.AddWithValue("@invoiceno", DCNO);
        //                        cmd.Parameters.AddWithValue("@agentid", dr["branch_sno"].ToString());
        //                        cmd.Parameters.AddWithValue("@branchid", "282");
        //                        cmd.Parameters.AddWithValue("@productid", dr["categoryid"].ToString());
        //                        cmd.Parameters.AddWithValue("@doe", ReportDate);
        //                        cmd.Parameters.AddWithValue("@indentdate", GetLowDate(fromdate.AddDays(-1)));
        //                        vdm.insert(cmd);
        //                    }
        //                    DataRow newrow = Report.NewRow();
        //                    if (ddlSalesOffice.SelectedItem.Text == "Staff Sale")
        //                    {
        //                        newrow["Customer Name"] = branch["DispName"].ToString();
        //                        newrow["Customer Code"] = "0001";
        //                    }
        //                    else
        //                    {
        //                        newrow["Customer Code"] = "132456";
        //                        newrow["Customer Name"] = "Cash sales-Pbk";
        //                    }
        //                    int countdc = 0;
        //                    int.TryParse(DCNO, out countdc);
        //                    if (countdc <= 10)
        //                    {
        //                        DCNO = "000" + countdc;
        //                    }
        //                    if (countdc >= 10 && countdc <= 99)
        //                    {
        //                        DCNO = "00" + countdc;
        //                    }
        //                    if (countdc >= 99 && countdc <= 999)
        //                    {
        //                        DCNO = "0" + countdc;
        //                    }
        //                    if (countdc >= 999 && countdc <= 9999)
        //                    {
        //                        DCNO = "" + countdc;
        //                    }
        //                    newrow["Invoce No"] = "KLH/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "/T/" + DCNO;
        //                    newrow["Invoice Date"] = fromdate.AddDays(-1).ToString("dd-MMM-yyyy");
        //                    newrow["Item Name"] = branch["tproduct"].ToString();
        //                    newrow["Qty"] = branch["qty"].ToString();
        //                    string category = dr["tcategory"].ToString();
        //                    tcategory = dr["tcategory"].ToString() + " " + "@" + " " + dr["vatpercent"].ToString() + "%-" + statename;
        //                    newrow["Ledger Type"] = tcategory.ToString();
        //                    Unitprice = UnitCost;
        //                    double percent = 0;
        //                    percent = vatpercent / 100;
        //                    percent = percent + 1;
        //                    Unitprice = Unitprice / percent;
        //                    Unitprice = Math.Round(Unitprice, 2);
        //                    newrow["Rate"] = Unitprice.ToString();
        //                    double Roundingoff = 0;
        //                    newrow["Tax Percentage %"] = vatpercent.ToString();
        //                    newrow["Rounding Off"] = Roundingoff;
        //                    double invval = 0;
        //                    double qty = 0;
        //                    double.TryParse(branch["qty"].ToString(), out qty);
        //                    double taxval = 0;
        //                    double diffcost = 0;
        //                    diffcost = UnitCost - Unitprice;
        //                    taxval = qty * diffcost;
        //                    invval = qty * UnitCost;
        //                    invval = Math.Round(invval, 2);
        //                    taxval = Math.Round(taxval, 2);
        //                    newrow["Tax Value"] = taxval;
        //                    double netvalue = 0;
        //                    netvalue = invval + taxval;
        //                    netvalue = Math.Round(netvalue, 2);
        //                    newrow["Inv Value"] = invval - taxval;
        //                    newrow["Net Value"] = netvalue - taxval;
        //                    if (ddlSalesOffice.SelectedItem.Text == "Cash Sale")
        //                    {
        //                        newrow["Narration"] = "Being the stock transfer to  " + ddlSalesOffice.SelectedItem.Text + " vide dc No " + branch["sno"].ToString() + ",DC Date " + fromdate.AddDays(-1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
        //                    }
        //                    else
        //                    {
        //                        newrow["Narration"] = "Being the stock transfer to  " + branch["DispName"].ToString() + " from " + ddlSalesOffice.SelectedItem.Text + " vide dc No " + branch["sno"].ToString() + ",DC Date " + fromdate.AddDays(-1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
        //                    }
        //                    Report.Rows.Add(newrow);
        //                    i++;
        //                }
        //            }
        //        }
        //        grdReports.DataSource = Report;
        //        grdReports.DataBind();
        //        Session["xportdata"] = Report;
        //    }
        //}
        //catch
        //{
        //}
        #endregion

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

            lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
            lblRoutName.Text = ddlSalesOffice.SelectedItem.Text;
            Session["xporttype"] = "TallyCashStaff";
            DateTime ReportDate = VehicleDBMgr.GetTime(vdm.conn);
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

            Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Tally Inward" + fromdate.ToString("dd/MM/yyyy");
            if (ddlSalesOffice.SelectedItem.Text == "Cash Sale" || ddlSalesOffice.SelectedItem.Text == "Staff Sale" || ddlSalesOffice.SelectedItem.Text == "Free Sale" || ddlSalesOffice.SelectedItem.Text == "Others")
            {
                Report = new DataTable();
                Report.Columns.Add("Ledger Type");
                Report.Columns.Add("Customer Code");
                Report.Columns.Add("Customer Name");
                Report.Columns.Add("WH Code");
                Report.Columns.Add("Invoce No.");
                Report.Columns.Add("Invoice Date");
                Report.Columns.Add("Category Code");
                Report.Columns.Add("HSN CODE");
                Report.Columns.Add("Item Code");
                Report.Columns.Add("Item Name");
                Report.Columns.Add("Qty");
                Report.Columns.Add("Rate");
                Report.Columns.Add("Taxable Value");
                Report.Columns.Add("SGST%");
                Report.Columns.Add("SGST Amount");
                Report.Columns.Add("CGST%");
                Report.Columns.Add("CGST Amount");
                Report.Columns.Add("IGST%");
                Report.Columns.Add("IGST Amount");
                Report.Columns.Add("Net Value");
                Report.Columns.Add("Narration");
                cmd = new MySqlCommand("SELECT branchdata.whcode,branchdata.sno,branchdata.branchcode, branchdata.BranchName, statemastar.statename ,statemastar.statecode FROM branchdata INNER JOIN statemastar ON branchdata.stateid = statemastar.sno WHERE (branchdata.sno = @BranchID)");
                if (Session["salestype"].ToString() == "Plant")
                {
                    cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                }
                DataTable dtstatename = vdm.SelectQuery(cmd).Tables[0];
                string statename = "";
                string statecode = "";
                string branchcode = "";
                string whcode = "";
                if (dtstatename.Rows.Count > 0)
                {
                    statename = dtstatename.Rows[0]["statename"].ToString();
                    statecode = dtstatename.Rows[0]["statecode"].ToString();
                    branchcode = dtstatename.Rows[0]["branchcode"].ToString();
                    whcode = dtstatename.Rows[0]["whcode"].ToString();
                }
                if (ddlSalesOffice.SelectedItem.Text == "Cash Sale")
                {
                    cmd = new MySqlCommand("SELECT TripInfo.Sno, TripInfo.customercode,TripInfo.DCNo, ProductInfo.tproduct,ProductInfo.hsncode,ProductInfo.igst,ProductInfo.cgst,ProductInfo.sgst, ProductInfo.Prodsno, ProductInfo.Categoryname,ProductInfo.categorycode, ProductInfo.Qty,ProductInfo.Itemcode, TripInfo.I_Date, TripInfo.VehicleNo, TripInfo.Status, TripInfo.DispName, TripInfo.DispType, TripInfo.DispMode FROM (SELECT tripdata.Sno, tripdata.DCNo, tripdata.I_Date, tripdata.VehicleNo, tripdata.Status, dispatch.DispName, dispatch.DispType, branchdata.customercode,dispatch.DispMode FROM branchdata INNER JOIN dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno WHERE (dispatch.DispMode = 'LOCAL') AND (dispatch.Branch_Id = @branch) AND (tripdata.AssignDate BETWEEN @d1 AND @d2)) TripInfo INNER JOIN (SELECT Categoryname, categorycode,itemcode,ProductName, Sno, Qty, tproduct,Prodsno,hsncode,igst,sgst,cgst FROM  (SELECT products_category.Categoryname,products_category.categorycode, productsdata.ProductName, productsdata.itemcode,tripdata_1.Sno, tripsubdata.Qty,productsdata.hsncode,productsdata.igst,productsdata.cgst,productsdata.sgst, productsdata.tproduct,productsdata.sno as Prodsno FROM tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno");
                }
                else if (ddlSalesOffice.SelectedItem.Text == "Staff Sale")
                {
                    cmd = new MySqlCommand("SELECT TripInfo.Sno, TripInfo.customercode,TripInfo.DCNo, ProductInfo.tproduct,ProductInfo.hsncode,ProductInfo.igst,ProductInfo.cgst,ProductInfo.sgst, ProductInfo.Prodsno, ProductInfo.Categoryname,ProductInfo.categorycode, ProductInfo.Qty,ProductInfo.Itemcode, TripInfo.I_Date, TripInfo.VehicleNo, TripInfo.Status, TripInfo.DispName, TripInfo.DispType, TripInfo.DispMode FROM (SELECT tripdata.Sno, tripdata.DCNo, tripdata.I_Date, tripdata.VehicleNo, tripdata.Status, dispatch.DispName, dispatch.DispType, branchdata.customercode,dispatch.DispMode FROM branchdata INNER JOIN dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno WHERE (dispatch.DispMode = 'Staff') AND (dispatch.Branch_Id = @branch) AND (tripdata.AssignDate BETWEEN @d1 AND @d2)) TripInfo INNER JOIN (SELECT Categoryname,categorycode,itemcode, ProductName, Sno, Qty, tproduct,Prodsno,hsncode,igst,sgst,cgst FROM  (SELECT products_category.Categoryname, products_category.categorycode,productsdata.ProductName, productsdata.itemcode,tripdata_1.Sno, tripsubdata.Qty,productsdata.hsncode,productsdata.igst,productsdata.cgst,productsdata.sgst, productsdata.tproduct,productsdata.sno as Prodsno FROM tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno");
                }
                else if (ddlSalesOffice.SelectedItem.Text == "Free Sale")
                {
                    cmd = new MySqlCommand("SELECT  TripInfo.Sno, TripInfo.customercode,TripInfo.DCNo, ProductInfo.tproduct, ProductInfo.hsncode, ProductInfo.igst, ProductInfo.cgst, ProductInfo.sgst, ProductInfo.Prodsno, ProductInfo.Categoryname,ProductInfo.categorycode, ProductInfo.Qty,ProductInfo.Itemcode, TripInfo.I_Date, TripInfo.VehicleNo, TripInfo.Status, TripInfo.DispName, TripInfo.DispType, TripInfo.DispMode FROM (SELECT tripdata.Sno, tripdata.DCNo, tripdata.I_Date, tripdata.VehicleNo, tripdata.Status, dispatch.DispName, dispatch.DispType,branchdata.customercode, dispatch.DispMode FROM branchdata INNER JOIN dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno WHERE (dispatch.DispMode = 'Free') AND (dispatch.Branch_Id = @branch) AND (tripdata.AssignDate BETWEEN @d1 AND @d2)) TripInfo INNER JOIN (SELECT Categoryname,categorycode,itemcode, ProductName, Sno, Qty, tproduct, Prodsno, hsncode, igst, sgst, cgst FROM (SELECT products_category.Categoryname,products_category.categorycode, productsdata.ProductName, productsdata.itemcode,tripdata_1.Sno, tripsubdata.Qty, productsdata.hsncode, productsdata.igst,productsdata.cgst, productsdata.sgst, productsdata.tproduct, productsdata.sno AS Prodsno FROM  tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno");
                }
                else
                {
                    cmd = new MySqlCommand("SELECT  TripInfo.Sno,TripInfo.customercode, TripInfo.DCNo, ProductInfo.tproduct, ProductInfo.hsncode, ProductInfo.igst, ProductInfo.cgst, ProductInfo.sgst, ProductInfo.Prodsno, ProductInfo.Categoryname,ProductInfo.categorycode, ProductInfo.Qty,ProductInfo.Itemcode, TripInfo.I_Date, TripInfo.VehicleNo, TripInfo.Status, TripInfo.DispName, TripInfo.DispType, TripInfo.DispMode FROM (SELECT tripdata.Sno, tripdata.DCNo, tripdata.I_Date, tripdata.VehicleNo, tripdata.Status, dispatch.DispName, dispatch.DispType,branchdata.customercode, dispatch.DispMode FROM branchdata INNER JOIN dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno WHERE (dispatch.DispType = 'AGENT') AND(dispatch.DispMode = 'AGENT') AND (dispatch.Branch_Id = @branch) AND (tripdata.AssignDate BETWEEN @d1 AND @d2)) TripInfo INNER JOIN (SELECT Categoryname,categorycode,itemcode, ProductName, Sno, Qty, tproduct, Prodsno, hsncode, igst, sgst, cgst FROM (SELECT products_category.Categoryname,products_category.categorycode, productsdata.ProductName,productsdata.itemcode, tripdata_1.Sno, tripsubdata.Qty, productsdata.hsncode, productsdata.igst,productsdata.cgst, productsdata.sgst, productsdata.tproduct, productsdata.sno AS Prodsno FROM  tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno");
                }
                cmd.Parameters.AddWithValue("@branch", Session["branch"]);
                cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate).AddDays(-1));
                DataTable dtble = vdm.SelectQuery(cmd).Tables[0];
                cmd = new MySqlCommand("SELECT branchproducts.branch_sno, branchproducts.product_sno, branchproducts.unitprice, branchproducts.VatPercent, products_category.tcategory,products_category.categorycode FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (branchproducts.branch_sno = @BranchID)");
                if (ddlSalesOffice.SelectedItem.Text == "Cash Sale" || ddlSalesOffice.SelectedItem.Text == "Free Sale" || ddlSalesOffice.SelectedItem.Text == "Others")
                {
                    cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                }
                else
                {
                    string barnch = "760";
                    cmd.Parameters.AddWithValue("@BranchID", barnch);
                }
                DataTable dtprodcts = vdm.SelectQuery(cmd).Tables[0];
                int i = 1;
                foreach (DataRow branch in dtble.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    if (ddlSalesOffice.SelectedItem.Text == "Staff Sale")
                    {
                        newrow["Customer Name"] = branch["DispName"].ToString();
                        newrow["Customer Code"] = branch["customercode"].ToString();
                    }
                    else if (ddlSalesOffice.SelectedItem.Text == "Free Sale")
                    {
                        newrow["Customer Name"] = branch["DispName"].ToString();
                        newrow["Customer Code"] = branch["customercode"].ToString();
                    }
                    else if (ddlSalesOffice.SelectedItem.Text == "Others")
                    {
                        newrow["Customer Name"] = branch["DispName"].ToString();
                        newrow["Customer Code"] = branch["customercode"].ToString();
                    }
                    else
                    {
                        newrow["Customer Name"] = "Cash sales-Pbk";
                        newrow["Customer Code"] = branch["customercode"].ToString();
                    }
                    newrow["HSN CODE"] = branch["hsncode"].ToString();

                    string DCNO = "0";
                    int countdc = 0;
                    int.TryParse(branch["DCNo"].ToString(), out countdc);
                    if (countdc <= 10)
                    {
                        DCNO = "0000" + countdc;
                    }
                    if (countdc >= 10 && countdc <= 99)
                    {
                        DCNO = "000" + countdc;
                    }
                    if (countdc >= 99 && countdc <= 999)
                    {
                        DCNO = "00" + countdc;
                    }
                    if (countdc > 999 && countdc <= 9999)
                    {
                        DCNO = "0" + countdc;
                    }
                    if (countdc > 9999)
                    {
                        DCNO = "" + countdc;
                    }
                    newrow["Invoce No."] = statecode + "/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "/" + DCNO;
                    newrow["Invoice Date"] = fromdate.AddDays(-1).ToString("dd-MMM-yyyy");
                    newrow["Item Name"] = branch["tproduct"].ToString();
                    newrow["Item Name"] = branch["itemcode"].ToString();
                    newrow["WH Code"] = whcode;
                    newrow["Qty"] = branch["qty"].ToString();
                    double UnitCost = 0;
                    double Unitprice = 0;
                    string tcategory = "";
                    double igst = 0;
                    double.TryParse(branch["igst"].ToString(), out igst);
                    double cgst = 0;
                    double.TryParse(branch["cgst"].ToString(), out cgst);
                    double sgst = 0;
                    double.TryParse(branch["sgst"].ToString(), out sgst);
                    foreach (DataRow dr in dtprodcts.Select("product_sno='" + branch["Prodsno"].ToString() + "'"))
                    {
                        double.TryParse(dr["unitprice"].ToString(), out UnitCost);
                        if (igst == null || igst == 0.0)
                        {
                            tcategory = dr["tcategory"].ToString();
                        }
                        else
                        {
                            string category = dr["tcategory"].ToString();
                            if (category == "G.Sale Of Milk" || category == "G.Sale Of Curd " || category == "Sale Of Buttermilk" || category == "Sale Of Lassi")
                            {
                                tcategory = dr["tcategory"].ToString();
                            }
                            else
                            {
                                tcategory = dr["tcategory"].ToString() + "-CGST/SGST-" + statecode;

                            }
                        }
                    }
                    newrow["Ledger Type"] = tcategory.ToString();
                    //newrow["Ledger Type"] = categorycode;
                    Unitprice = UnitCost;
                    double percent = 0;
                    double.TryParse(branch["igst"].ToString(), out igst);
                    double invval = 0;
                    double qty = 0;
                    double.TryParse(branch["qty"].ToString(), out qty);
                    double taxval = 0;
                    double netvalue = 0;
                    netvalue = invval + taxval;
                    netvalue = Math.Round(netvalue, 2);
                    newrow["Taxable Value"] = invval;
                    double sgstamount = 0;
                    double cgstamount = 0;
                    double Igst = 0;
                    double Igstamount = 0;
                    double totRate = 0;
                    double.TryParse(branch["Igst"].ToString(), out Igst);
                    double Igstcon = 100 + Igst;
                    float rate = 0;
                    double tot_vatamount = 0;
                    double PAmount = 0;
                    float.TryParse(UnitCost.ToString(), out rate);
                    Igstamount = (rate / Igstcon) * Igst;
                    Igstamount = Math.Round(Igstamount, 2);
                    totRate = Igstamount;
                    newrow["Ledger Type"] = tcategory.ToString();
                    double Vatrate = rate - totRate;
                    Vatrate = Math.Round(Vatrate, 2);
                    Vatrate = Math.Round(Vatrate, 2);
                    newrow["Rate"] = Vatrate.ToString();
                    PAmount = qty * Vatrate;
                    newrow["Taxable Value"] = Math.Round(PAmount, 2);
                    tot_vatamount = (PAmount * Igst) / 100;
                    sgstamount = (tot_vatamount / 2);
                    sgstamount = Math.Round(sgstamount, 2);
                    newrow["sgst%"] = "'" + branch["sgst"].ToString();
                    newrow["sgst amount"] = sgstamount.ToString();
                    cgstamount = (tot_vatamount / 2);
                    cgstamount = Math.Round(cgstamount, 2);
                    newrow["cgst%"] = "'" + branch["cgst"].ToString();
                    newrow["cgst amount"] = cgstamount.ToString();
                    newrow["Igst%"] = "'" + 0;
                    newrow["Igst amount"] = 0;
                    invval = Math.Round(invval, 2);
                    netvalue = invval + taxval;
                    netvalue = Math.Round(netvalue, 2);
                    double tot_amount = PAmount + tot_vatamount;
                    tot_amount = Math.Round(tot_amount, 2);
                    newrow["Net Value"] = tot_amount;
                    if (ddlSalesOffice.SelectedItem.Text == "Cash Sale")
                    {
                        newrow["Narration"] = "Being the stock transfer to  " + ddlSalesOffice.SelectedItem.Text + " vide dc No " + branch["sno"].ToString() + ",DC Date " + fromdate.AddDays(-1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                    }
                    else
                    {
                        newrow["Narration"] = "Being the stock transfer to  " + branch["DispName"].ToString() + " from " + ddlSalesOffice.SelectedItem.Text + " vide dc No " + branch["sno"].ToString() + ",DC Date " + fromdate.AddDays(-1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();

                    }
                    Report.Rows.Add(newrow);
                    i++;
                }
                grdReports.DataSource = Report;
                grdReports.DataBind();
                Session["xportdata"] = Report;
            }
        }
        catch
        {
        }
    }
}
    
