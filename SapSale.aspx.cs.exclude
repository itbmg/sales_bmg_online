using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Data.SqlClient;
public partial class SapSale : System.Web.UI.Page
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
                txtFromdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                lblTitle.Text = Session["TitleName"].ToString();
                FillRouteName();
            }
        }
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        vdm = new VehicleDBMgr();
        FillRouteName();
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
            cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType)  ");
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
        }
        else
        {
            PBranch.Visible = true;
            cmd = new MySqlCommand("SELECT BranchName, sno FROM branchdata WHERE (sno = @BranchID)");
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
        #region
        //try
        //{
        //    lblmsg.Text = "";
        //    pnlHide.Visible = true;
        //    Report = new DataTable();
        //    Session["RouteName"] = ddlSalesOffice.SelectedItem.Text;
        //    Session["xporttype"] = "TallySales";
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
        //    Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Tally Sales " + fromdate.ToString("dd/MM/yyyy");
        //    if (ddltype.SelectedValue == "Non Tax")
        //    {
        //        cmd = new MySqlCommand("SELECT  products_category.sno AS categoryid,products_category.categorycode,  branchdata.tbranchname, branchdata_1.sno, branchdata.BranchName,branchdata.stateid, branchdata.sno AS BSno, indent.IndentType, ROUND(SUM(indents_subtable.DeliveryQty), 2) AS DeliveryQty, indents_subtable.UnitCost, productsdata.tproduct, productsdata.ProductName,productsdata.hsncode,productsdata.igst,productsdata.sgst,productsdata.cgst, productsdata.Units, productsdata.sno AS productsno, branchdata_1.SalesOfficeID, products_category.tcategory, branchproducts.VatPercent FROM (SELECT IndentNo, Branch_id, I_date, Status, IndentType FROM indents WHERE (I_date BETWEEN @starttime AND @endtime) AND (Status <> 'D')) indent INNER JOIN branchdata ON indent.Branch_id = branchdata.sno INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON branchmappingtable.SuperBranch = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno WHERE (branchmappingtable.SuperBranch = @BranchID)  AND (indents_subtable.DeliveryQty <> 0) OR  (branchdata_1.SalesOfficeID = @SOID) AND (indents_subtable.DeliveryQty <> 0) GROUP BY productsdata.sno, BSno, branchmappingtable.SuperBranch, productsdata.igst ORDER BY branchdata.BranchName");

        //        cmd = new MySqlCommand("SELECT products_category.categorycode,  branchdata_1.whcode,branchdata.tbranchname,branchdata.customercode, branchdata_1.sno, branchdata.BranchName, branchdata.sno AS BSno, indent.IndentType, ROUND(SUM(indents_subtable.DeliveryQty), 2) AS DeliveryQty, indents_subtable.UnitCost, productsdata.tproduct, productsdata.ProductName,productsdata.Itemcode, productsdata.Units, productsdata.sno AS Expr1,branchdata_1.SalesOfficeID, products_category.tcategory, IFNULL(branchproducts.VatPercent, 0) AS VatPercent FROM (SELECT IndentNo, Branch_id, I_date, Status, IndentType FROM indents WHERE (I_date BETWEEN @starttime AND @endtime) AND (Status <> 'D')) indent INNER JOIN branchdata ON indent.Branch_id = branchdata.sno INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON branchmappingtable.SuperBranch = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno WHERE (branchmappingtable.SuperBranch = @BranchID) OR (branchdata_1.SalesOfficeID = @SOID) GROUP BY productsdata.sno, BSno, branchmappingtable.SuperBranch, branchproducts.VatPercent ORDER BY branchdata.BranchName");
        //        if (Session["salestype"].ToString() == "Plant")
        //        {
        //            string BranchID = ddlSalesOffice.SelectedValue;
        //            if (BranchID == "572")
        //            {
        //                BranchID = "158";
        //            }
        //            cmd.Parameters.AddWithValue("@BranchID", BranchID);
        //            cmd.Parameters.AddWithValue("@SOID", BranchID);
        //        }
        //        else
        //        {
        //            cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
        //            cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
        //        }
        //        cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
        //        cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
        //        DataTable dtble = vdm.SelectQuery(cmd).Tables[0];
        //        DateTime ReportDate = VehicleDBMgr.GetTime(vdm.conn);
        //        DateTime dtapril = new DateTime();
        //        DateTime dtmarch = new DateTime();
        //        int currentyear = ReportDate.Year;
        //        int nextyear = ReportDate.Year + 1;
        //        if (ReportDate.Month > 3)
        //        {
        //            string apr = "4/1/" + currentyear;
        //            dtapril = DateTime.Parse(apr);
        //            string march = "3/31/" + nextyear;
        //            dtmarch = DateTime.Parse(march);
        //        }
        //        if (ReportDate.Month <= 3)
        //        {
        //            string apr = "4/1/" + (currentyear - 1);
        //            dtapril = DateTime.Parse(apr);
        //            string march = "3/31/" + (nextyear - 1);
        //            dtmarch = DateTime.Parse(march);
        //        }
        //        if (dtble.Rows.Count > 0)
        //        {
        //            DataView view = new DataView(dtble);
        //            Report = new DataTable();
        //            Report.Columns.Add("Ledger Type");
        //            Report.Columns.Add("Customer Code");
        //            Report.Columns.Add("Customer Name");
        //            Report.Columns.Add("Invoice Date");
        //            Report.Columns.Add("Invoce No");
        //            Report.Columns.Add("Item Code");
        //            Report.Columns.Add("Item Name");
        //            Report.Columns.Add("Qty");
        //            Report.Columns.Add("Rate");
        //            Report.Columns.Add("Tax Code");
        //            Report.Columns.Add("Sales Type");
        //            Report.Columns.Add("Category Code");
        //            Report.Columns.Add("vat_percent");
        //            Report.Columns.Add("TaxAmount");
        //            Report.Columns.Add("Rounding Off");
        //            Report.Columns.Add("WH Code");
        //            Report.Columns.Add("Inv Value");
        //            Report.Columns.Add("Net Value");
        //            Report.Columns.Add("Narration");
        //            int i = 1;
        //            cmd = new MySqlCommand("SELECT branchdata.sno,branchdata.branchcode,  branchdata.BranchName, branchdata.tax, branchdata.ntax, statemastar.statename,statemastar.statecode FROM branchdata INNER JOIN statemastar ON branchdata.stateid = statemastar.sno WHERE (branchdata.sno = @BranchID)");
        //            if (Session["salestype"].ToString() == "Plant")
        //            {
        //                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
        //            }
        //            else
        //            {
        //                cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
        //            }
        //            DataTable dtstatename = vdm.SelectQuery(cmd).Tables[0];
        //            string statename = "";
        //            string statecode = "";
        //            string tax = "";
        //            string ntax = "";
        //            string branchcode = "";
        //            if (dtstatename.Rows.Count > 0)
        //            {
        //                statecode = dtstatename.Rows[0]["statecode"].ToString();
        //                statename = dtstatename.Rows[0]["statename"].ToString();
        //                tax = dtstatename.Rows[0]["tax"].ToString();
        //                ntax = dtstatename.Rows[0]["ntax"].ToString();
        //                branchcode = dtstatename.Rows[0]["branchcode"].ToString();
        //            }
        //            cmd = new MySqlCommand("SELECT agentdc.agentdcno, agentdc.BranchID FROM agentdc INNER JOIN branchmappingtable ON agentdc.BranchID = branchmappingtable.SubBranch INNER JOIN  branchdata ON branchmappingtable.SuperBranch = branchdata.sno WHERE (agentdc.IndDate BETWEEN @d1 AND @d2) AND (branchmappingtable.SuperBranch = @BranchID) AND (agentdc.agentdcno > 1) OR (agentdc.IndDate BETWEEN @d1 AND @d2) AND (branchdata.SalesOfficeID = @SOID) AND (agentdc.agentdcno > 1) GROUP BY agentdc.BranchID ORDER BY agentdc.agentdcno");
        //            string BranchID = ddlSalesOffice.SelectedValue;
        //            if (BranchID == "572")
        //            {
        //                BranchID = "158";
        //            }
        //            cmd.Parameters.AddWithValue("@BranchID", BranchID);
        //            cmd.Parameters.AddWithValue("@SOID", BranchID);
        //            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
        //            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
        //            DataTable dtDc = vdm.SelectQuery(cmd).Tables[0];
        //            foreach (DataRow branch in dtble.Rows)
        //            {
        //                DataRow newrow = Report.NewRow();
        //                string DCNO = "0";
        //                if (dtDc.Rows.Count > 0)
        //                {
        //                    DataRow[] drdc = dtDc.Select("BranchID=" + branch["BSno"].ToString());
        //                    foreach (DataRow drc in drdc)
        //                    {
        //                        DCNO = drc.ItemArray[0].ToString();
        //                    }
        //                }
        //                if (DCNO == "1" || DCNO == "" || DCNO == "0")
        //                {
        //                    DCNO = "0";
        //                    long DcNo = 0;
        //                    string socode = "";
        //                    DataRow[] drdc = dtDc.Select("BranchID=" + branch["BSno"].ToString());
        //                    if (drdc.Length < 2)
        //                    {
        //                        cmd = new MySqlCommand("SELECT IFNULL(MAX(agentdcno), 0) + 1 AS Sno FROM agentdc WHERE (soid = @BranchID) AND (IndDate BETWEEN @d1 AND @d2)");
        //                        if (Session["salestype"].ToString() == "Plant")
        //                        {
        //                            socode = ddlSalesOffice.SelectedValue;
        //                        }
        //                        else
        //                        {
        //                            socode = Session["branch"].ToString();
        //                        }
        //                        if (socode == "527" || socode == "3781")
        //                        {
        //                            if (socode == "527")
        //                            {
        //                                cmd.Parameters.AddWithValue("@BranchID", "174");
        //                                socode = "174";
        //                            }
        //                            else
        //                            {
        //                                cmd.Parameters.AddWithValue("@BranchID", "2749");
        //                                socode = "2749";
        //                            }
        //                        }
        //                        else
        //                        {
        //                            cmd.Parameters.AddWithValue("@BranchID", socode);
        //                        }
        //                        cmd.Parameters.AddWithValue("@d1", GetLowDate(dtapril.AddDays(-1)));
        //                        cmd.Parameters.AddWithValue("@d2", GetHighDate(dtmarch.AddDays(-1)));
        //                        DataTable dtadcno = vdm.SelectQuery(cmd).Tables[0];
        //                        string agentdcNo = dtadcno.Rows[0]["Sno"].ToString();
        //                        cmd = new MySqlCommand("Insert Into Agentdc (BranchId,IndDate,soid,agentdcno) Values(@BranchId,@IndDate,@soid,@agentdcno)");
        //                        cmd.Parameters.AddWithValue("@BranchId", branch["BSno"].ToString());
        //                        cmd.Parameters.AddWithValue("@IndDate", GetLowDate(fromdate.AddDays(-1)));
        //                        cmd.Parameters.AddWithValue("@soid", socode);
        //                        cmd.Parameters.AddWithValue("@agentdcno", agentdcNo);
        //                        DcNo = vdm.insertScalar(cmd);
        //                        cmd = new MySqlCommand("SELECT IndentNo FROM indents WHERE (Branch_id = @BranchId) AND (I_date BETWEEN @d1 AND @d2)");
        //                        cmd.Parameters.AddWithValue("@BranchId", branch["BSno"].ToString());
        //                        cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
        //                        cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
        //                        DataTable dtindentno = vdm.SelectQuery(cmd).Tables[0];
        //                        if (dtindentno.Rows.Count > 0)
        //                        {
        //                            foreach (DataRow dr in dtindentno.Rows)
        //                            {
        //                                cmd = new MySqlCommand("Insert Into dcsubTable (DcNo,IndentNo) Values(@DcNo,@IndentNo)");
        //                                cmd.Parameters.AddWithValue("@DcNo", DcNo);
        //                                cmd.Parameters.AddWithValue("@IndentNo", dr["IndentNo"].ToString());
        //                                vdm.insert(cmd);
        //                            }
        //                        }
        //                        cmd = new MySqlCommand("SELECT agentdcno FROM  agentdc WHERE (BranchID = @BranchID) AND (IndDate BETWEEN @d1 AND @d2)");
        //                        cmd.Parameters.AddWithValue("@BranchID", branch["BSno"].ToString());
        //                        cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
        //                        cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
        //                        DataTable dtsubDc = vdm.SelectQuery(cmd).Tables[0];
        //                        if (dtsubDc.Rows.Count > 0)
        //                        {
        //                            DCNO = dtsubDc.Rows[0]["agentdcno"].ToString();
        //                        }
        //                        DCNO = DcNo.ToString();
        //                    }
        //                }
        //                if (branch["vatpercent"].ToString() == "0")
        //                {
        //                    newrow["Customer Code"] = branch["customercode"].ToString();
        //                    newrow["Customer Name"] = branch["tBranchName"].ToString();
        //                    newrow["WH Code"] = branch["whcode"].ToString();
        //                }
        //                double Roundingoff = 0;
        //                int countdc = 0;
        //                int.TryParse(DCNO, out countdc);
        //                if (countdc < 10)
        //                {
        //                    DCNO = "00" + DCNO;
        //                }
        //                if (countdc > 10 && countdc < 99)
        //                {
        //                    DCNO = "0" + DCNO;
        //                }
        //                DCNO = branchcode + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "E/" + DCNO;

        //                if (branch["vatpercent"].ToString() == "0")
        //                {
        //                    newrow["Invoce No"] = DCNO;
        //                    if (ddlSalesOffice.SelectedValue == "306")
        //                    {
        //                        newrow["Invoice Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
        //                    }
        //                    else
        //                    {
        //                        newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
        //                    }
        //                    newrow["Item Code"] = branch["Itemcode"].ToString();
        //                    newrow["Item Name"] = branch["tProduct"].ToString();
        //                    double vatpercent = 0;
        //                    double.TryParse(branch["vatpercent"].ToString(), out vatpercent);
        //                    string tcategory = "";
        //                    string TaxCode = "EXEMPT";

        //                    if (vatpercent == null || vatpercent == 0.0)
        //                    {
        //                        tcategory = branch["tcategory"].ToString();
        //                        newrow["Sales Type"] = ntax;
        //                    }
        //                    else
        //                    {
        //                        string category = branch["tcategory"].ToString();
        //                        if (category == "G.Sale Of Milk" || category == "G.Sale Of Curd " || category == "Sale Of Buttermilk" || category == "Sale Of Lassi")
        //                        {
        //                            tcategory = branch["tcategory"].ToString();
        //                            TaxCode = "EXEMPT";
        //                            newrow["Sales Type"] = ntax;

        //                        }
        //                        else
        //                        {
        //                            tcategory = branch["tcategory"].ToString() + " " + "@" + " " + branch["vatpercent"].ToString() + "%-" + statecode;
        //                            TaxCode = "VAT@" + branch["vatpercent"].ToString();
        //                            newrow["Sales Type"] = tax;
        //                        }
        //                    }
        //                    newrow["Category Code"] = branch["categorycode"].ToString();
        //                    newrow["Tax Code"] = TaxCode.ToString();
        //                    newrow["Ledger Type"] = tcategory.ToString();
        //                    if (branch["tBranchName"].ToString() == "" || branch["DeliveryQty"].ToString() == "" || branch["DeliveryQty"].ToString() == "0")
        //                    {
        //                    }
        //                    else
        //                    {
        //                        double percent = 0;
        //                        newrow["Qty"] = branch["DeliveryQty"].ToString();
        //                        double UnitCost = 0;
        //                        double Unitprice = 0;
        //                        double.TryParse(branch["UnitCost"].ToString(), out UnitCost);
        //                        Unitprice = UnitCost;
        //                        double.TryParse(branch["vatpercent"].ToString(), out vatpercent);
        //                        if (vatpercent == 0.0)
        //                        {
        //                            newrow["Rate"] = UnitCost.ToString();
        //                        }
        //                        else
        //                        {
        //                            percent = vatpercent / 100;
        //                            percent = percent + 1;
        //                            UnitCost = UnitCost / percent;
        //                            UnitCost = Math.Round(UnitCost, 2);
        //                            newrow["Rate"] = UnitCost.ToString();
        //                        }
        //                        newrow["vat_percent"] = vatpercent.ToString();
        //                        newrow["Rounding Off"] = Roundingoff;
        //                        double invval = 0;
        //                        double qty = 0;
        //                        double.TryParse(branch["DeliveryQty"].ToString(), out qty);
        //                        double taxval = 0;
        //                        if (vatpercent == 0.0)
        //                        {
        //                            invval = qty * UnitCost;
        //                        }
        //                        else
        //                        {
        //                            double diffcost = 0;
        //                            diffcost = Unitprice - UnitCost;
        //                            taxval = qty * diffcost;
        //                            invval = qty * UnitCost;

        //                        }
        //                        invval = Math.Round(invval, 2);
        //                        taxval = Math.Round(taxval, 2);
        //                        newrow["TaxAmount"] = taxval;
        //                        double netvalue = 0;
        //                        netvalue = invval + taxval;
        //                        netvalue = Math.Round(netvalue, 2);
        //                        newrow["Inv Value"] = invval;
        //                        newrow["Net Value"] = netvalue;
        //                        newrow["Narration"] = "Being the sale of milk to  " + branch["tBranchName"].ToString() + " vide DC No " + DCNO + ",DC Date " + fromdate.ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
        //                        Report.Rows.Add(newrow);
        //                        i++;
        //                    }
        //                }
        //            }
        //            grdReports.DataSource = Report;
        //            grdReports.DataBind();
        //            Session["xportdata"] = Report;
        //        }
        //        else
        //        {
        //            pnlHide.Visible = false;
        //            lblmsg.Text = "No Indent Found";
        //            grdReports.DataSource = Report;
        //            grdReports.DataBind();
        //        }
        //    }
        //    else
        //    {
        //        cmd = new MySqlCommand("SELECT products_category.categorycode, products_category.sno AS categoryid,branchdata_1.whcode,  branchdata.tbranchname,branchdata.customercode, branchdata_1.sno, branchdata.BranchName, branchdata.sno AS BSno, indent.IndentType, ROUND(SUM(indents_subtable.DeliveryQty), 2) AS DeliveryQty, indents_subtable.UnitCost, productsdata.tproduct, productsdata.ProductName,productsdata.Itemcode, productsdata.Units, productsdata.sno AS productsno, branchdata_1.SalesOfficeID, products_category.tcategory, branchproducts.VatPercent FROM (SELECT IndentNo, Branch_id, I_date, Status, IndentType FROM indents WHERE (I_date BETWEEN @starttime AND @endtime) AND (Status <> 'D')) indent INNER JOIN branchdata ON indent.Branch_id = branchdata.sno INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON branchmappingtable.SuperBranch = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno WHERE (branchmappingtable.SuperBranch = @BranchID) AND (branchproducts.VatPercent > 0) AND (indents_subtable.DeliveryQty <> 0) OR (branchproducts.VatPercent > 0) AND (branchdata_1.SalesOfficeID = @SOID) AND (indents_subtable.DeliveryQty <> 0) GROUP BY productsdata.sno, BSno, branchmappingtable.SuperBranch, branchproducts.VatPercent ORDER BY branchdata.BranchName");
        //        if (Session["salestype"].ToString() == "Plant")
        //        {
        //            string BranchID = ddlSalesOffice.SelectedValue;
        //            if (BranchID == "572")
        //            {
        //                BranchID = "158";
        //            }
        //            cmd.Parameters.AddWithValue("@BranchID", BranchID);
        //            cmd.Parameters.AddWithValue("@SOID", BranchID);
        //        }
        //        else
        //        {
        //            cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
        //            cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
        //        }
        //        cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
        //        cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
        //        DataTable dtble = vdm.SelectQuery(cmd).Tables[0];

        //        cmd = new MySqlCommand("SELECT  products_category.categorycode AS tcategorycode,products_category.sno AS categoryid,  branchdata.BranchName, branchdata.sno AS BSno, indent.IndentType,indents_subtable.DeliveryQty AS DeliveryQty, indents_subtable.UnitCost, productsdata.tproduct, productsdata.ProductName, productsdata.Units,productsdata.sno AS productsno, productsdata.Itemcode, products_category.tcategory, branchproducts.VatPercent, addresstable.companyname AS tbranchname,branchdata.whcode, addresstable.customercode FROM (SELECT IndentNo, Branch_id, I_date, Status, IndentType FROM indents WHERE (I_date BETWEEN @starttime AND @endtime) AND (Status <> 'D')) indent INNER JOIN branchdata ON indent.Branch_id = branchdata.sno INNER JOIN tripdata ON tripdata.BranchID = branchdata.sno INNER JOIN addresstable ON addresstable.sno = tripdata.to_adr_Id INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno WHERE (branchproducts.VatPercent > 0) AND (indents_subtable.DeliveryQty <> 0) AND (branchdata.sno = @BranchID) OR (branchproducts.VatPercent > 0) AND (indents_subtable.DeliveryQty <> 0) AND (branchdata.sno = @SOID) GROUP BY productsdata.sno, BSno, branchproducts.VatPercent ORDER BY branchdata.BranchName");
        //        cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
        //        cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
        //        cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate));
        //        cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate));
        //        DataTable dtothers = vdm.SelectQuery(cmd).Tables[0];
        //        DateTime ReportDate = VehicleDBMgr.GetTime(vdm.conn);
        //        DateTime dtapril = new DateTime();
        //        DateTime dtmarch = new DateTime();
        //        int currentyear = ReportDate.Year;
        //        int nextyear = ReportDate.Year + 1;
        //        if (ReportDate.Month > 3)
        //        {
        //            string apr = "4/1/" + currentyear;
        //            dtapril = DateTime.Parse(apr);
        //            string march = "3/31/" + nextyear;
        //            dtmarch = DateTime.Parse(march);
        //        }
        //        if (ReportDate.Month <= 3)
        //        {
        //            string apr = "4/1/" + (currentyear - 1);
        //            dtapril = DateTime.Parse(apr);
        //            string march = "3/31/" + (nextyear - 1);
        //            dtmarch = DateTime.Parse(march);
        //        }
        //        if (dtble.Rows.Count > 0)
        //        {
        //            DataView view = new DataView(dtble);
        //            Report = new DataTable();
        //            Report.Columns.Add("Ledger Type");
        //            Report.Columns.Add("Customer Code");
        //            Report.Columns.Add("Customer Name");
        //            Report.Columns.Add("Invoice Date");
        //            Report.Columns.Add("Invoce No");
        //            Report.Columns.Add("Item Code");
        //            Report.Columns.Add("Item Name");
        //            Report.Columns.Add("Qty");
        //            Report.Columns.Add("Rate");
        //            Report.Columns.Add("Tax Code");
        //            Report.Columns.Add("Sales Type");
        //            Report.Columns.Add("Category Code");
        //            Report.Columns.Add("vat_percent");
        //            Report.Columns.Add("TaxAmount");
        //            Report.Columns.Add("Rounding Off");
        //            Report.Columns.Add("WH Code");
        //            Report.Columns.Add("Inv Value");
        //            Report.Columns.Add("Net Value");
        //            Report.Columns.Add("Narration");
        //            int i = 1;
        //            cmd = new MySqlCommand("SELECT branchdata.sno,branchdata.branchcode, branchdata.BranchName, branchdata.tax, branchdata.ntax, statemastar.statename, statemastar.statecode FROM branchdata INNER JOIN statemastar ON branchdata.stateid = statemastar.sno WHERE (branchdata.sno = @BranchID)");
        //            if (Session["salestype"].ToString() == "Plant")
        //            {
        //                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
        //            }
        //            else
        //            {
        //                cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
        //            }
        //            DataTable dtstatename = vdm.SelectQuery(cmd).Tables[0];
        //            string statename = "";
        //            string statecode = "";
        //            string tax = "";
        //            string ntax = "";
        //            string branchcode = "";
        //            if (dtstatename.Rows.Count > 0)
        //            {
        //                statename = dtstatename.Rows[0]["statename"].ToString();
        //                statecode = dtstatename.Rows[0]["statecode"].ToString();
        //                tax = dtstatename.Rows[0]["tax"].ToString();
        //                ntax = dtstatename.Rows[0]["ntax"].ToString();
        //                branchcode = dtstatename.Rows[0]["branchcode"].ToString();
        //            }
        //            foreach (DataRow branch in dtble.Rows)
        //            {
        //                DataRow newrow = Report.NewRow();
        //                string DCNO = "0";
        //                long DcNo = 0;
        //                cmd = new MySqlCommand("SELECT sno, taxdcno, invoiceno, agentid, branchid, productid, doe, indentdate FROM taxdc_table WHERE (branchid = @BranchID) AND (indentdate BETWEEN @d1 AND @d2)");
        //                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
        //                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
        //                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
        //                DataTable dtDc = vdm.SelectQuery(cmd).Tables[0];
        //                if (dtDc.Rows.Count > 0)
        //                {
        //                    DataRow[] drdc = dtDc.Select("productid='" + branch["categoryid"].ToString() + "' and branchid='" + ddlSalesOffice.SelectedValue + "' and agentid='" + branch["BSno"].ToString() + "'");
        //                    if (drdc.Length > 0)
        //                    {
        //                        foreach (DataRow drc in drdc)
        //                        {
        //                            DCNO = drc.ItemArray[1].ToString();
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
        //                        cmd.Parameters.AddWithValue("@agentid", branch["BSno"].ToString());
        //                        cmd.Parameters.AddWithValue("@branchid", ddlSalesOffice.SelectedValue);
        //                        cmd.Parameters.AddWithValue("@productid", branch["categoryid"].ToString());
        //                        cmd.Parameters.AddWithValue("@doe", ReportDate);
        //                        cmd.Parameters.AddWithValue("@indentdate", GetLowDate(fromdate.AddDays(-1)));
        //                        vdm.insert(cmd);
        //                    }
        //                }
        //                else
        //                {
        //                    cmd = new MySqlCommand("SELECT IFNULL(MAX(taxdcno), 0) + 1 AS Sno FROM taxdc_table WHERE (branchid = @branchid) AND (indentdate BETWEEN @d1 AND @d2)");
        //                    cmd.Parameters.AddWithValue("@branchid", ddlSalesOffice.SelectedValue);
        //                    cmd.Parameters.AddWithValue("@d1", GetLowDate(dtapril.AddDays(-1)));
        //                    cmd.Parameters.AddWithValue("@d2", GetHighDate(dtmarch.AddDays(-1)));
        //                    DataTable dtadcno = vdm.SelectQuery(cmd).Tables[0];
        //                    DCNO = dtadcno.Rows[0]["Sno"].ToString();
        //                    string agentdcno = dtadcno.Rows[0]["Sno"].ToString();
        //                    cmd = new MySqlCommand("Insert Into taxdc_table (taxdcno, invoiceno, agentid, branchid, productid, doe, indentdate) Values(@taxdcno, @invoiceno, @agentid, @branchid, @productid, @doe, @indentdate)");
        //                    cmd.Parameters.AddWithValue("@taxdcno", agentdcno);
        //                    cmd.Parameters.AddWithValue("@invoiceno", DCNO);
        //                    cmd.Parameters.AddWithValue("@agentid", branch["BSno"].ToString());
        //                    cmd.Parameters.AddWithValue("@branchid", ddlSalesOffice.SelectedValue);
        //                    cmd.Parameters.AddWithValue("@productid", branch["categoryid"].ToString());
        //                    cmd.Parameters.AddWithValue("@doe", ReportDate);
        //                    cmd.Parameters.AddWithValue("@indentdate", GetLowDate(fromdate.AddDays(-1)));
        //                    vdm.insert(cmd);
        //                }
        //                int countdc = 0;
        //                int.TryParse(DCNO, out countdc);
        //                if (countdc < 10)
        //                {
        //                    DCNO = "00" + DCNO;
        //                }
        //                if (countdc > 10 && countdc < 99)
        //                {
        //                    DCNO = "0" + DCNO;
        //                }
        //                DCNO = branchcode + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;

        //                newrow["Customer Code"] = branch["customercode"].ToString();
        //                newrow["Customer Name"] = branch["tBranchName"].ToString();
        //                newrow["WH Code"] = branch["whcode"].ToString();

        //                double Roundingoff = 0;
        //                newrow["Invoce No"] = DCNO;
        //                if (ddlSalesOffice.SelectedValue == "306")
        //                {
        //                    newrow["Invoice Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
        //                }
        //                else
        //                {
        //                    newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
        //                }
        //                newrow["Item Code"] = branch["Itemcode"].ToString();

        //                newrow["Item Name"] = branch["tProduct"].ToString();
        //                double vatpercent = 0;
        //                double.TryParse(branch["vatpercent"].ToString(), out vatpercent);
        //                double delqty = 0;
        //                double.TryParse(branch["DeliveryQty"].ToString(), out delqty);
        //                string tcategory = "";
        //                string TaxCode = "EXEMPT";
        //                if (vatpercent == null || vatpercent == 0.0)
        //                {
        //                    tcategory = branch["tcategory"].ToString();
        //                    newrow["Sales Type"] = ntax;
        //                }
        //                else
        //                {
        //                    tcategory = branch["tcategory"].ToString() + " " + "@" + " " + branch["vatpercent"].ToString() + "%-" + statecode;
        //                    TaxCode = "VAT@" + branch["vatpercent"].ToString();
        //                    newrow["Sales Type"] = tax;
        //                }
        //                newrow["Category Code"] = branch["categorycode"].ToString();
        //                newrow["Tax Code"] = TaxCode.ToString();
        //                newrow["Ledger Type"] = tcategory.ToString();
        //                double percent = 0;
        //                newrow["Qty"] = branch["DeliveryQty"].ToString();
        //                double UnitCost = 0;
        //                double Unitprice = 0;
        //                double.TryParse(branch["UnitCost"].ToString(), out UnitCost);
        //                Unitprice = UnitCost;
        //                double.TryParse(branch["vatpercent"].ToString(), out vatpercent);
        //                if (vatpercent == 0.0)
        //                {
        //                    newrow["Rate"] = UnitCost.ToString();
        //                }
        //                else
        //                {
        //                    percent = vatpercent / 100;
        //                    percent = percent + 1;
        //                    UnitCost = UnitCost / percent;
        //                    UnitCost = Math.Round(UnitCost, 2);
        //                    newrow["Rate"] = UnitCost.ToString();
        //                }
        //                newrow["vat_percent"] = vatpercent.ToString();
        //                newrow["Rounding Off"] = Roundingoff;
        //                double invval = 0;
        //                double qty = 0;
        //                double.TryParse(branch["DeliveryQty"].ToString(), out qty);
        //                double taxval = 0;
        //                if (vatpercent == 0.0)
        //                {
        //                    invval = qty * UnitCost;
        //                }
        //                else
        //                {
        //                    double diffcost = 0;
        //                    diffcost = Unitprice - UnitCost;
        //                    taxval = qty * diffcost;
        //                    invval = qty * UnitCost;

        //                }
        //                invval = Math.Round(invval, 2);
        //                taxval = Math.Round(taxval, 2);
        //                newrow["TaxAmount"] = taxval;
        //                double netvalue = 0;
        //                netvalue = invval + taxval;
        //                netvalue = Math.Round(netvalue, 2);
        //                newrow["Inv Value"] = invval;
        //                newrow["Net Value"] = netvalue;
        //                newrow["Narration"] = "Being the sale of milk to  " + branch["tBranchName"].ToString() + " vide DC No " + DCNO + ",DC Date " + fromdate.ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
        //                Report.Rows.Add(newrow);
        //                i++;
        //                //}
        //            }
        //            if (dtothers.Rows.Count > 0)
        //            {

        //                int j = 1;
        //                cmd = new MySqlCommand("SELECT sno,branchcode, BranchName, statename,tax,ntax  FROM branchdata WHERE (sno = @BranchID)");
        //                if (Session["salestype"].ToString() == "Plant")
        //                {
        //                    cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
        //                }
        //                else
        //                {
        //                    cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
        //                }
        //                DataTable dtstate = vdm.SelectQuery(cmd).Tables[0];
        //                string state = "";
        //                tax = "";
        //                ntax = "";
        //                branchcode = "";
        //                if (dtstatename.Rows.Count > 0)
        //                {
        //                    state = dtstate.Rows[0]["statename"].ToString();
        //                    tax = dtstate.Rows[0]["tax"].ToString();
        //                    ntax = dtstate.Rows[0]["ntax"].ToString();
        //                    branchcode = dtstate.Rows[0]["branchcode"].ToString();
        //                }
        //                foreach (DataRow branch in dtothers.Rows)
        //                {
        //                    DataRow newrow = Report.NewRow();
        //                    string DCNO = "0";
        //                    long DcNo = 0;
        //                    cmd = new MySqlCommand("SELECT sno, taxdcno, invoiceno, agentid, branchid, productid, doe, indentdate FROM taxdc_table WHERE (branchid = @BranchID) AND (indentdate BETWEEN @d1 AND @d2)");
        //                    cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
        //                    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
        //                    cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
        //                    DataTable dtotherDc = vdm.SelectQuery(cmd).Tables[0];
        //                    if (dtotherDc.Rows.Count > 0)
        //                    {
        //                        DataRow[] drotherdc = dtotherDc.Select("productid='" + branch["categoryid"].ToString() + "' and branchid='" + ddlSalesOffice.SelectedValue + "' and agentid='" + branch["BSno"].ToString() + "'");
        //                        if (drotherdc.Length > 0)
        //                        {
        //                            foreach (DataRow drotherc in drotherdc)
        //                            {
        //                                DCNO = drotherc.ItemArray[1].ToString();
        //                            }
        //                        }
        //                    }
        //                    int countdc = 0;
        //                    int.TryParse(DCNO, out countdc);
        //                    if (countdc <= 10)
        //                    {
        //                        DCNO = "00" + DCNO;
        //                    }
        //                    if (countdc >= 10 && countdc <= 99)
        //                    {
        //                        DCNO = "0" + DCNO;
        //                    }

        //                    DCNO = branchcode + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;

        //                    newrow["Customer Name"] = branch["tbranchname"].ToString();
        //                    newrow["Customer Code"] = branch["customercode"].ToString();
        //                    newrow["WH Code"] = branch["whcode"].ToString();
        //                    double Roundingoff = 0;
        //                    newrow["Invoce No"] = DCNO;
        //                    newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
        //                    newrow["Item Name"] = branch["tProduct"].ToString();
        //                    newrow["Item Code"] = branch["Itemcode"].ToString();
        //                    double vatpercent = 0;
        //                    double.TryParse(branch["vatpercent"].ToString(), out vatpercent);
        //                    double delqty = 0;
        //                    double.TryParse(branch["DeliveryQty"].ToString(), out delqty);
        //                    string tcategory = "";
        //                    string TaxCode = "";
        //                    if (vatpercent == null || vatpercent == 0.0)
        //                    {
        //                        tcategory = branch["tcategory"].ToString();
        //                        newrow["Sales Type"] = ntax;
        //                    }
        //                    else
        //                    {
        //                        tcategory = branch["tcategory"].ToString() + " " + "@" + " " + branch["vatpercent"].ToString() + "%-" + statecode;
        //                        TaxCode = "VAT@" + branch["vatpercent"].ToString();
        //                        newrow["Sales Type"] = tax;
        //                    }
        //                    newrow["Category Code"] = branch["tcategorycode"].ToString();
        //                    newrow["Ledger Type"] = tcategory.ToString();
        //                    newrow["Tax Code"] = TaxCode.ToString();
        //                    double percent = 0;
        //                    newrow["Qty"] = branch["DeliveryQty"].ToString();
        //                    double UnitCost = 0;
        //                    double Unitprice = 0;
        //                    double.TryParse(branch["UnitCost"].ToString(), out UnitCost);
        //                    Unitprice = UnitCost;
        //                    double.TryParse(branch["vatpercent"].ToString(), out vatpercent);
        //                    if (vatpercent == 0.0)
        //                    {
        //                        newrow["Rate"] = UnitCost.ToString();
        //                    }
        //                    else
        //                    {
        //                        percent = vatpercent / 100;
        //                        percent = percent + 1;
        //                        UnitCost = UnitCost / percent;
        //                        UnitCost = Math.Round(UnitCost, 2);
        //                        newrow["Rate"] = UnitCost.ToString();
        //                    }
        //                    newrow["vat_percent"] = vatpercent.ToString();
        //                    newrow["Rounding Off"] = Roundingoff;
        //                    double invval = 0;
        //                    double qty = 0;
        //                    double.TryParse(branch["DeliveryQty"].ToString(), out qty);
        //                    double taxval = 0;
        //                    if (vatpercent == 0.0)
        //                    {
        //                        invval = qty * UnitCost;
        //                    }
        //                    else
        //                    {
        //                        double diffcost = 0;
        //                        diffcost = Unitprice - UnitCost;
        //                        taxval = qty * diffcost;
        //                        invval = qty * UnitCost;
        //                    }
        //                    invval = Math.Round(invval, 2);
        //                    taxval = Math.Round(taxval, 2);
        //                    newrow["TaxAmount"] = taxval;
        //                    double netvalue = 0;
        //                    netvalue = invval + taxval;
        //                    netvalue = Math.Round(netvalue, 2);
        //                    newrow["Inv Value"] = invval;
        //                    newrow["Net Value"] = netvalue;
        //                    newrow["Narration"] = "Being the sale of milk to  " + branch["tbranchname"].ToString() + " vide DC No " + DCNO + ",DC Date " + fromdate.ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
        //                    Report.Rows.Add(newrow);
        //                    j++;
        //                    //}
        //                }
        //            }
        //            grdReports.DataSource = Report;
        //            grdReports.DataBind();
        //            Session["xportdata"] = Report;
        //        }
        //        else
        //        {
        //            pnlHide.Visible = false;
        //            lblmsg.Text = "No Indent Found";
        //            grdReports.DataSource = Report;
        //            grdReports.DataBind();
        //        }
        //    }
        //}
        //catch (Exception ex)
        //{
        //    lblmsg.Text = ex.Message;
        //    grdReports.DataSource = Report;
        //    grdReports.DataBind();
        //}
        #endregion

        try
        {
            lblmsg.Text = "";
            pnlHide.Visible = true;
            Report = new DataTable();
            Session["RouteName"] = ddlSalesOffice.SelectedItem.Text;
            Session["xporttype"] = "TallySales";
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
            Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Tally Sales " + fromdate.ToString("dd/MM/yyyy");
            if (ddltype.SelectedValue == "Non Tax")
            {
                cmd = new MySqlCommand("SELECT  branchdata.customercode,products_category.categorycode,products_category.sno AS categoryid,  branchdata.tbranchname, branchdata_1.sno, branchdata.BranchName,branchdata.stateid, branchdata.sno AS BSno, indent.IndentType, ROUND(SUM(indents_subtable.DeliveryQty), 2) AS DeliveryQty, indents_subtable.UnitCost, productsdata.Itemcode,productsdata.tproduct, branchdata.customercode,productsdata.ProductName,productsdata.hsncode,productsdata.igst,productsdata.sgst,productsdata.cgst, productsdata.Units, productsdata.sno AS productsno, branchdata_1.SalesOfficeID, products_category.tcategory, branchproducts.VatPercent FROM (SELECT IndentNo, Branch_id, I_date, Status, IndentType FROM indents WHERE (I_date BETWEEN @starttime AND @endtime) AND (Status <> 'D')) indent INNER JOIN branchdata ON indent.Branch_id = branchdata.sno INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON branchmappingtable.SuperBranch = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno WHERE (branchmappingtable.SuperBranch = @BranchID)  AND (indents_subtable.DeliveryQty <> 0) OR  (branchdata_1.SalesOfficeID = @SOID) AND (indents_subtable.DeliveryQty <> 0) GROUP BY productsdata.sno, BSno, branchmappingtable.SuperBranch, productsdata.igst ORDER BY branchdata.BranchName");
                if (Session["salestype"].ToString() == "Plant")
                {
                    string BranchID = ddlSalesOffice.SelectedValue;
                    if (BranchID == "572")
                    {
                        BranchID = "158";
                    }
                    cmd.Parameters.AddWithValue("@BranchID", BranchID);
                    cmd.Parameters.AddWithValue("@SOID", BranchID);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                    cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
                }
                cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
                DataTable dtble = vdm.SelectQuery(cmd).Tables[0];
                cmd = new MySqlCommand("SELECT  products_category.sno AS categoryid, branchdata.tbranchname, branchdata.BranchName, branchdata.sno AS BSno, indent.IndentType,indents_subtable.DeliveryQty AS DeliveryQty, indents_subtable.UnitCost, productsdata.tproduct, productsdata.ProductName, productsdata.Units,productsdata.sno AS productsno, products_category.tcategory, branchproducts.VatPercent,branchdata.customercode, addresstable.companyname AS tbranchname,addresstable.customercode FROM (SELECT IndentNo, Branch_id, I_date, Status, IndentType FROM indents WHERE (I_date BETWEEN @starttime AND @endtime) AND (Status <> 'D')) indent INNER JOIN branchdata ON indent.Branch_id = branchdata.sno INNER JOIN tripdata ON tripdata.BranchID = branchdata.sno INNER JOIN addresstable ON addresstable.sno = tripdata.to_adr_Id INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno WHERE  (indents_subtable.DeliveryQty <> 0) AND (branchdata.sno = @BranchID) OR  (indents_subtable.DeliveryQty <> 0) AND (branchdata.sno = @SOID) GROUP BY productsdata.sno, BSno, branchproducts.VatPercent ORDER BY branchdata.BranchName");
                cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
                cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate));
                cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate));
                DataTable dtothers = vdm.SelectQuery(cmd).Tables[0];
                if (dtble.Rows.Count > 0)
                {
                    DataView view = new DataView(dtble);
                    Report = new DataTable();
                    Report.Columns.Add("Ledger Type");
                    Report.Columns.Add("Customer Code");
                    Report.Columns.Add("Customer Name");
                    Report.Columns.Add("WH Code");
                    //Report.Columns.Add("Sales Type");
                    Report.Columns.Add("Invoce No.");
                    Report.Columns.Add("Invoice Date");
                    Report.Columns.Add("Category Code");
                    Report.Columns.Add("HSN CODE");
                    Report.Columns.Add("Item Code");
                    Report.Columns.Add("Item Name");
                    Report.Columns.Add("Qty");
                    Report.Columns.Add("Rate");
                    Report.Columns.Add("Taxable Value");
                    Report.Columns.Add("TAX%");
                    Report.Columns.Add("TAX CODE");
                    Report.Columns.Add("Sales Type");

                    //Report.Columns.Add("SGST%");
                    //Report.Columns.Add("SGST Amount");
                    //Report.Columns.Add("CGST%");
                    //Report.Columns.Add("CGST Amount");
                    //Report.Columns.Add("IGST%");
                    //Report.Columns.Add("IGST Amount");
                    ////Report.Columns.Add("Inv Value");
                    Report.Columns.Add("Net Value");
                    Report.Columns.Add("Narration");
                    int i = 1;
                    cmd = new MySqlCommand("SELECT branchdata.whcode,branchdata.sno,branchdata.ntax,branchdata.tax,branchdata.Branchcode,branchdata.companycode,  branchdata.BranchName,branchdata.stateid, statemastar.statename, statemastar.statecode , statemastar.gststatecode FROM branchdata INNER JOIN statemastar ON branchdata.stateid = statemastar.sno WHERE (branchdata.sno = @BranchID)");
                    if (Session["salestype"].ToString() == "Plant")
                    {
                        cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                    }
                    DataTable dtstatename = vdm.SelectQuery(cmd).Tables[0];
                    string statename = "";
                    string statecode = "";
                    string fromstateid = "";
                    string Branchcode = "";
                    string gststatecode = "";
                    string companycode = "";
                    string whcode = "";
                    string ntax = "";
                    string tax = "";
                    if (dtstatename.Rows.Count > 0)
                    {
                        Branchcode = dtstatename.Rows[0]["Branchcode"].ToString();
                        statename = dtstatename.Rows[0]["statename"].ToString();
                        statecode = dtstatename.Rows[0]["statecode"].ToString();
                        fromstateid = dtstatename.Rows[0]["stateid"].ToString();
                        gststatecode = dtstatename.Rows[0]["gststatecode"].ToString();
                        companycode = dtstatename.Rows[0]["companycode"].ToString();
                        whcode = dtstatename.Rows[0]["whcode"].ToString();
                        ntax = dtstatename.Rows[0]["ntax"].ToString();
                        tax = dtstatename.Rows[0]["tax"].ToString();
                    }
                    string taxcode ="";
                    foreach (DataRow branch in dtble.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        string DCNO = "0";
                        long DcNo = 0;
                        cmd = new MySqlCommand("SELECT agentdcno FROM  agentdc WHERE (BranchID = @BranchID) AND (IndDate BETWEEN @d1 AND @d2)");
                        cmd.Parameters.AddWithValue("@BranchID", branch["BSno"].ToString());
                        cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                        cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                        DataTable dtDcnumber = vdm.SelectQuery(cmd).Tables[0];
                        string dcnumber = "";
                        if (dtDcnumber.Rows.Count > 0)
                        {
                            dcnumber = dtDcnumber.Rows[0]["agentdcno"].ToString();
                            DCNO = dcnumber.ToString();
                        }
                        //else
                        //{
                        //    cmd = new MySqlCommand("SELECT IFNULL(MAX(agentdcno), 0) + 1 AS Sno FROM agentdc WHERE (stateid = @stateid) AND (companycode=@companycode) AND (IndDate BETWEEN @d1 AND @d2)");
                        //    cmd.Parameters.AddWithValue("@stateid", gststatecode);
                        //    cmd.Parameters.AddWithValue("@companycode", companycode);
                        //    cmd.Parameters.AddWithValue("@d1", GetLowDate(dtapril.AddDays(-1)));
                        //    cmd.Parameters.AddWithValue("@d2", GetHighDate(dtmarch.AddDays(-1)));
                        //    DataTable dtadcno = vdm.SelectQuery(cmd).Tables[0];
                        //    string agentdcNo = dtadcno.Rows[0]["Sno"].ToString();
                        //    cmd = new MySqlCommand("Insert Into Agentdc (BranchId,IndDate,soid,agentdcno,stateid,companycode,moduleid,doe) Values(@BranchId,@IndDate,@soid,@agentdcno,@stateid,@companycode,@moduleid,@doe)");
                        //    cmd.Parameters.AddWithValue("@BranchId", branch["BSno"].ToString());
                        //    cmd.Parameters.AddWithValue("@IndDate", GetLowDate(fromdate.AddDays(-1)));
                        //    cmd.Parameters.AddWithValue("@soid", ddlSalesOffice.SelectedValue);
                        //    cmd.Parameters.AddWithValue("@agentdcno", agentdcNo);
                        //    cmd.Parameters.AddWithValue("@stateid", gststatecode);
                        //    cmd.Parameters.AddWithValue("@companycode", companycode);
                        //    cmd.Parameters.AddWithValue("@doe", ReportDate);
                        //    cmd.Parameters.AddWithValue("@moduleid", Session["moduleid"].ToString());
                        //    DcNo = vdm.insertScalar(cmd);
                        //    cmd = new MySqlCommand("SELECT IndentNo FROM indents WHERE (Branch_id = @BranchId) AND (I_date BETWEEN @d1 AND @d2)");
                        //    cmd.Parameters.AddWithValue("@BranchId", branch["BSno"].ToString());
                        //    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                        //    cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                        //    DataTable dtindentno = vdm.SelectQuery(cmd).Tables[0];
                        //    if (dtindentno.Rows.Count > 0)
                        //    {
                        //        foreach (DataRow dr in dtindentno.Rows)
                        //        {
                        //            cmd = new MySqlCommand("Insert Into dcsubTable (DcNo,IndentNo) Values(@DcNo,@IndentNo)");
                        //            cmd.Parameters.AddWithValue("@DcNo", DcNo);
                        //            cmd.Parameters.AddWithValue("@IndentNo", dr["IndentNo"].ToString());
                        //            vdm.insert(cmd);
                        //        }
                        //    }
                        //    cmd = new MySqlCommand("SELECT agentdcno FROM  agentdc WHERE (BranchID = @BranchID) AND (IndDate BETWEEN @d1 AND @d2)");
                        //    cmd.Parameters.AddWithValue("@BranchID", branch["BSno"].ToString());
                        //    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                        //    cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                        //    DataTable dtsubDc = vdm.SelectQuery(cmd).Tables[0];
                        //    if (dtsubDc.Rows.Count > 0)
                        //    {
                        //        DCNO = dtsubDc.Rows[0]["agentdcno"].ToString();
                        //    }
                        //    DCNO = DCNO.ToString();
                        //}
                        int countdc = 0;
                        int.TryParse(DCNO, out countdc);
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
                        if (countdc > 999)
                        {
                            DCNO = "0" + countdc;
                        }
                        if (branch["igst"].ToString() == "0")
                        {
                            DCNO = Branchcode + "/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "E/" + DCNO;
                            newrow["Customer Name"] = branch["tBranchName"].ToString();
                            newrow["Customer Code"] = branch["customercode"].ToString();
                            // newrow["Customer Code"] = branch["customercode"].ToString();
                            newrow["WH Code"] = whcode;
                            newrow["Invoce No."] = DCNO;
                            if (ddlSalesOffice.SelectedValue == "306")
                            {
                                newrow["Invoice Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                            }
                            else
                            {
                                newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
                            }
                            newrow["HSN CODE"] = branch["hsncode"].ToString();
                            newrow["Item Name"] = branch["tProduct"].ToString();
                            newrow["Item Code"] = branch["Itemcode"].ToString();
                            newrow["Category Code"] = branch["categorycode"].ToString();
                            double igst = 0;
                            double.TryParse(branch["igst"].ToString(), out igst);
                            double delqty = 0;
                            double.TryParse(branch["DeliveryQty"].ToString(), out delqty);
                            string tcategory = "";
                            double percent = 0;
                            newrow["Qty"] = branch["DeliveryQty"].ToString();
                            double UnitCost = 0;
                            double Unitprice = 0;
                            double.TryParse(branch["UnitCost"].ToString(), out UnitCost);
                            Unitprice = UnitCost;
                            double.TryParse(branch["igst"].ToString(), out igst);
                            float rate = 0;
                            double invval = 0;
                            double qty = 0;
                            double.TryParse(branch["DeliveryQty"].ToString(), out qty);
                            double taxval = 0;
                            float.TryParse(branch["UnitCost"].ToString(), out rate);
                            double tot_vatamount = 0;
                            double PAmount = 0;
                            string tostateid = branch["stateid"].ToString();
                            double sgst = 0;
                            double sgstamount = 0;
                            double cgst = 0;
                            double cgstamount = 0;
                            double Igst = 0;
                            double Igstamount = 0;
                            double totRate = 0;
                            double.TryParse(branch["Igst"].ToString(), out Igst);
                            double Igstcon = 100 + Igst;
                            Igstamount = (rate / Igstcon) * Igst;
                            Igstamount = Math.Round(Igstamount, 2);
                            totRate = Igstamount;
                            if (igst == null || igst == 0.0)
                            {
                                tcategory = branch["tcategory"].ToString();
                            }
                            else
                            {
                                tcategory = branch["tcategory"].ToString() + "-CGST/SGST-" + statecode;
                            }
                            newrow["TAX%"] = "0";

                            newrow["Sales Type"] = ntax;
                            newrow["Ledger Type"] = tcategory.ToString();
                            double Vatrate = rate - totRate;
                            Vatrate = Math.Round(Vatrate, 2);
                            newrow["Rate"] = Vatrate.ToString();
                            PAmount = qty * Vatrate;
                            newrow["Taxable Value"] = Math.Round(PAmount, 2);
                            invval = Math.Round(invval, 2);
                            taxcode = "EXEMPT";
                            newrow["TAX CODE"] = taxcode;
                            double netvalue = 0;
                            netvalue = invval + taxval;
                            netvalue = Math.Round(netvalue, 2);
                            double tot_amount = PAmount + tot_vatamount;
                            tot_amount = Math.Round(tot_amount, 2);
                            newrow["Net Value"] = tot_amount;
                            newrow["Narration"] = "Being the sale of milk to  " + branch["tBranchName"].ToString() + " vide DC No " + DCNO + ",DC Date " + fromdate.ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                            Report.Rows.Add(newrow);
                            i++;
                            //}
                        }
                    }
                    grdReports.DataSource = Report;
                    grdReports.DataBind();
                    Session["xportdata"] = Report;
                }
                else
                {
                    pnlHide.Visible = false;
                    lblmsg.Text = "No Indent Found";
                    grdReports.DataSource = Report;
                    grdReports.DataBind();
                }
            }
            else
            {
                cmd = new MySqlCommand("SELECT  branchdata.customercode,products_category.categorycode,products_category.sno AS categoryid,  branchdata.tbranchname, branchdata_1.sno, branchdata.BranchName,branchdata.stateid, branchdata.sno AS BSno, indent.IndentType, ROUND(SUM(indents_subtable.DeliveryQty), 2) AS DeliveryQty, indents_subtable.UnitCost, productsdata.Itemcode,productsdata.tproduct, branchdata.customercode,productsdata.ProductName,productsdata.hsncode,productsdata.igst,productsdata.sgst,productsdata.cgst, productsdata.Units, productsdata.sno AS productsno, branchdata_1.SalesOfficeID, products_category.tcategory, branchproducts.VatPercent FROM (SELECT IndentNo, Branch_id, I_date, Status, IndentType FROM indents WHERE (I_date BETWEEN @starttime AND @endtime) AND (Status <> 'D')) indent INNER JOIN branchdata ON indent.Branch_id = branchdata.sno INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch INNER JOIN branchdata branchdata_1 ON branchmappingtable.SuperBranch = branchdata_1.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON branchmappingtable.SuperBranch = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno WHERE (branchmappingtable.SuperBranch = @BranchID)  AND (indents_subtable.DeliveryQty <> 0) OR  (branchdata_1.SalesOfficeID = @SOID) AND (indents_subtable.DeliveryQty <> 0) GROUP BY productsdata.sno, BSno, branchmappingtable.SuperBranch, productsdata.igst ORDER BY branchdata.BranchName");
                if (Session["salestype"].ToString() == "Plant")
                {
                    string BranchID = ddlSalesOffice.SelectedValue;
                    if (BranchID == "572")
                    {
                        BranchID = "158";
                    }
                    cmd.Parameters.AddWithValue("@BranchID", BranchID);
                    cmd.Parameters.AddWithValue("@SOID", BranchID);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                    cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
                }
                cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
                DataTable dtble = vdm.SelectQuery(cmd).Tables[0];
                if (dtble.Rows.Count > 0)
                {
                    DataView view = new DataView(dtble);
                    Report = new DataTable();
                    Report.Columns.Add("Ledger Type");
                    Report.Columns.Add("Customer Code");
                    Report.Columns.Add("Customer Name");
                    Report.Columns.Add("WH Code");
                    //Report.Columns.Add("Sales Type");
                    Report.Columns.Add("Invoce No.");
                    Report.Columns.Add("Invoice Date");
                    Report.Columns.Add("Category Code");
                    Report.Columns.Add("HSN CODE");
                    Report.Columns.Add("Item Code");
                    Report.Columns.Add("Item Name");
                    Report.Columns.Add("Qty");
                    Report.Columns.Add("Rate");
                    Report.Columns.Add("Taxable Value");
                    Report.Columns.Add("Sales Type");
                    Report.Columns.Add("TAX%");
                    Report.Columns.Add("TAX CODE");
                                
                    //Report.Columns.Add("SGST%");
                    //Report.Columns.Add("SGST Amount");
                    //Report.Columns.Add("CGST%");
                    //Report.Columns.Add("CGST Amount");
                    //Report.Columns.Add("IGST%");
                    //Report.Columns.Add("IGST Amount");
                    //Report.Columns.Add("Inv Value");
                    Report.Columns.Add("Net Value");
                    Report.Columns.Add("Narration");
                    int i = 1;
                    cmd = new MySqlCommand("SELECT branchdata.whcode,branchdata.sno,branchdata.Branchcode,branchdata.tax,branchdata.ntax,branchdata.companycode,  branchdata.BranchName,branchdata.stateid, statemastar.statename, statemastar.statecode , statemastar.gststatecode FROM branchdata INNER JOIN statemastar ON branchdata.stateid = statemastar.sno WHERE (branchdata.sno = @BranchID)");
                    if (Session["salestype"].ToString() == "Plant")
                    {
                        cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
                    }
                    DataTable dtstatename = vdm.SelectQuery(cmd).Tables[0];
                    string statename = "";
                    string statecode = "";
                    string fromstateid = "";
                    string Branchcode = "";
                    string gststatecode = "";
                    string companycode = "";
                    string whcode = "";
                    string ntax = "";
                    string tax = "";
                    if (dtstatename.Rows.Count > 0)
                    {
                        Branchcode = dtstatename.Rows[0]["Branchcode"].ToString();
                        statename = dtstatename.Rows[0]["statename"].ToString();
                        statecode = dtstatename.Rows[0]["statecode"].ToString();
                        fromstateid = dtstatename.Rows[0]["stateid"].ToString();
                        gststatecode = dtstatename.Rows[0]["gststatecode"].ToString();
                        companycode = dtstatename.Rows[0]["companycode"].ToString();
                        whcode = dtstatename.Rows[0]["whcode"].ToString();
                        ntax = dtstatename.Rows[0]["ntax"].ToString();
                        tax = dtstatename.Rows[0]["tax"].ToString();
                    }
                    string taxcode = "";
                    foreach (DataRow branch in dtble.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        string DCNO = "0";
                        long DcNo = 0;
                        cmd = new MySqlCommand("SELECT agentdcno FROM  agenttaxdc WHERE (BranchID = @BranchID) AND (IndDate BETWEEN @d1 AND @d2)");
                        cmd.Parameters.AddWithValue("@BranchID", branch["BSno"].ToString());
                        cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                        cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                        DataTable dtDcnumber = vdm.SelectQuery(cmd).Tables[0];
                        string dcnumber = "";
                        if (dtDcnumber.Rows.Count > 0)
                        {
                            dcnumber = dtDcnumber.Rows[0]["agentdcno"].ToString();
                            DCNO = dcnumber.ToString();
                        }
                        
                        if (branch["igst"].ToString() != "0")
                        {
                            int countdc = 0;
                            int.TryParse(DCNO, out countdc);
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
                            if (countdc > 999)
                            {
                                DCNO = "0" + countdc;
                            }
                            DCNO = Branchcode + "/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            newrow["Customer Name"] = branch["tBranchName"].ToString();
                            newrow["Customer Code"] = branch["customercode"].ToString();
                            // newrow["Customer Code"] = branch["customercode"].ToString();
                            newrow["WH Code"] = whcode;
                            newrow["Invoce No."] = DCNO;
                            if (ddlSalesOffice.SelectedValue == "306")
                            {
                                newrow["Invoice Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                            }
                            else
                            {
                                newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
                            }
                            newrow["HSN CODE"] = branch["hsncode"].ToString();
                            newrow["Item Name"] = branch["tProduct"].ToString();
                            newrow["Item Code"] = branch["Itemcode"].ToString();
                            newrow["Category Code"] = branch["categorycode"].ToString();
                            double igst = 0;
                            double.TryParse(branch["igst"].ToString(), out igst);
                            double delqty = 0;
                            double.TryParse(branch["DeliveryQty"].ToString(), out delqty);
                            string tcategory = "";
                            double percent = 0;
                            newrow["Qty"] = branch["DeliveryQty"].ToString();
                            double UnitCost = 0;
                            double Unitprice = 0;
                            double.TryParse(branch["UnitCost"].ToString(), out UnitCost);
                            Unitprice = UnitCost;
                            double.TryParse(branch["igst"].ToString(), out igst);
                            float rate = 0;
                            double invval = 0;
                            double qty = 0;
                            double.TryParse(branch["DeliveryQty"].ToString(), out qty);
                            double taxval = 0;
                            float.TryParse(branch["UnitCost"].ToString(), out rate);
                            double tot_vatamount = 0;
                            double PAmount = 0;
                            string tostateid = branch["stateid"].ToString();
                            if (fromstateid == tostateid)
                            {
                                double sgst = 0;
                                double sgstamount = 0;
                                double cgst = 0;
                                double cgstamount = 0;
                                double Igst = 0;
                                double Igstamount = 0;
                                double totRate = 0;
                                double.TryParse(branch["Igst"].ToString(), out Igst);
                                double Igstcon = 100 + Igst;
                                Igstamount = (rate / Igstcon) * Igst;
                                Igstamount = Math.Round(Igstamount, 2);
                                totRate = Igstamount;
                                if (igst == null || igst == 0.0)
                                {
                                    tcategory = branch["tcategory"].ToString();
                                }
                                else
                                {
                                    tcategory = branch["tcategory"].ToString() + "-CGST/SGST-" + statecode;
                                }
                                newrow["Ledger Type"] = tcategory.ToString();
                                double Vatrate = rate - totRate;
                                Vatrate = Math.Round(Vatrate, 2);
                                newrow["Rate"] = Vatrate.ToString();
                                PAmount = qty * Vatrate;
                                newrow["Taxable Value"] = Math.Round(PAmount, 2);
                                tot_vatamount = (PAmount * Igst) / 100;
                                sgstamount = (tot_vatamount / 2);
                                sgstamount = Math.Round(sgstamount, 2);
                                //newrow["sgst%"] = "'" + branch["sgst"].ToString();
                                //newrow["sgst amount"] = sgstamount.ToString();
                                cgstamount = (tot_vatamount / 2);
                                cgstamount = Math.Round(cgstamount, 2);
                                //newrow["cgst%"] = "'" + branch["cgst"].ToString();
                                //newrow["cgst amount"] = cgstamount.ToString();
                                //newrow["Igst%"] = "'" + 0;
                                //newrow["Igst amount"] = 0;
                                //if (IGST != "0")
                                //{
                                //    double igsttax = Convert.ToDouble(IGST);
                                //    taxcode = "IGST" + IGST + "";
                                //    newrow["TAX%"] = IGST;
                                //}
                                if (branch["cgst"].ToString() != "0")
                                {
                                    double cgsttax = Convert.ToDouble(branch["cgst"].ToString());
                                    cgsttax = cgsttax + cgsttax;
                                    taxcode = "CGST" + cgsttax + "";
                                    newrow["TAX%"] = branch["cgst"].ToString();
                                }
                                newrow["TAX CODE"] = taxcode;
                                newrow["Sales Type"] = tax;
                            }
                            else
                            {

                                double Igst = 0;
                                double Igstamount = 0;
                                double totRate = 0;
                                double.TryParse(branch["Igst"].ToString(), out Igst);
                                double Igstcon = 100 + Igst;
                                Igstamount = (rate / Igstcon) * Igst;
                                Igstamount = Math.Round(Igstamount, 2);
                                totRate = Igstamount;
                                if (igst == null || igst == 0.0)
                                {
                                    tcategory = branch["tcategory"].ToString();
                                }
                                else
                                {
                                    tcategory = branch["tcategory"].ToString() + "-IGST-" + statecode;
                                }
                                newrow["Ledger Type"] = tcategory.ToString();
                                double Vatrate = rate - totRate;
                                Vatrate = Math.Round(Vatrate, 2);
                                newrow["Rate"] = Vatrate.ToString();
                                PAmount = qty * Vatrate;
                                newrow["Taxable Value"] = Math.Round(PAmount, 2);
                                tot_vatamount = (PAmount * Igst) / 100;
                                //newrow["sgst%"] = "'" + 0;
                                //newrow["sgst amount"] = 0;
                                //newrow["cgst%"] = "'" + 0;
                                //newrow["cgst amount"] = 0;
                                //newrow["Igst%"] = "'" + branch["Igst"].ToString();
                                newrow["Sales Type"] = tax;

                                if (branch["Igst"].ToString() != "0")
                                {
                                    double igsttax = Convert.ToDouble(branch["Igst"].ToString());
                                    taxcode = "IGST" + branch["Igst"].ToString() + "";
                                    newrow["TAX%"] = branch["Igst"].ToString();
                                }

                                newrow["TAX CODE"] = taxcode;
                                tot_vatamount = Math.Round(tot_vatamount, 2);
                                //newrow["Igst amount"] = tot_vatamount.ToString();
                            }
                            invval = Math.Round(invval, 2);
                            double netvalue = 0;
                            netvalue = invval + taxval;
                            netvalue = Math.Round(netvalue, 2);
                            double tot_amount = PAmount + tot_vatamount;
                            tot_amount = Math.Round(tot_amount, 2);
                            newrow["Net Value"] = tot_amount;
                            newrow["Narration"] = "Being the sale of milk to  " + branch["tBranchName"].ToString() + " vide DC No " + DCNO + ",DC Date " + fromdate.ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                            Report.Rows.Add(newrow);
                            i++;
                            //}
                        }
                        grdReports.DataSource = Report;
                        grdReports.DataBind();
                        Session["xportdata"] = Report;
                    }
                }
                else
                {
                    pnlHide.Visible = false;
                    lblmsg.Text = "No Indent Found";
                    grdReports.DataSource = Report;
                    grdReports.DataBind();
                }
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
            cmd = new MySqlCommand("SELECT sno, BranchName, whcode, ladger_dr_code, tax, ntax, ledger_jv_code FROM branchdata WHERE (sno = @BranchID)");
            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            DataTable dtwhscode = vdm.SelectQuery(cmd).Tables[0];
            if (ddltype.SelectedValue == "Tax")
            {
                sqlcmd = new SqlCommand("SELECT CreateDate, CardCode, CardName, TaxDate, DocDate, DocDueDate, DiscPercent, ReferenceNo FROM EMROINV WHERE (TaxDate BETWEEN @d1 AND @d2) and  (WhsCode = @WhsCode) AND  (TaxCode <> 'EXEMPT')");
                sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
                sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
                sqlcmd.Parameters.Add("@WhsCode", dtwhscode.Rows[0]["whcode"].ToString());
            }
            else
            {
                sqlcmd = new SqlCommand("SELECT CreateDate, CardCode, CardName, TaxDate, DocDate, DocDueDate, DiscPercent, ReferenceNo FROM EMROINV WHERE (TaxDate BETWEEN @d1 AND @d2) and  (WhsCode = @WhsCode)  and (TaxCode ='EXEMPT')");
                sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
                sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
                sqlcmd.Parameters.Add("@WhsCode", dtwhscode.Rows[0]["whcode"].ToString());
            }
            DataTable dtSales = SAPvdm.SelectQuery(sqlcmd).Tables[0];
            if (dtSales.Rows.Count > 0)
            {
                lblmsg.Text = "This Transaction already saved";
            }
            else
            {
                foreach (DataRow dr in dt.Rows)
                {
                    string Customercode = dr["Customer Code"].ToString();
                    string whccode = dr["WH Code"].ToString();
                    if (Customercode == "")
                    {
                    }
                    else
                    {
                        string Itemcode = dr["Item Code"].ToString();
                        if (Itemcode == "")
                        {
                        }
                        else
                        {
                            //sqlcmd = new SqlCommand("SELECT CreateDate, CardCode, CardName, TaxDate, DocDate, DocDueDate, DiscPercent, ReferenceNo FROM EMROINV WHERE (TaxDate BETWEEN @d1 AND @d2) and itemcode=@itemcode AND (WhsCode = @WhsCode) AND (ReferenceNo = @ReferenceNo)");
                            //sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
                            //sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
                            //sqlcmd.Parameters.Add("@WhsCode", whccode);
                            //sqlcmd.Parameters.Add("@ReferenceNo", dr["Invoce No"].ToString());
                            //sqlcmd.Parameters.Add("@itemcode", dr["Item Code"].ToString());
                            //DataTable dtadcno = SAPvdm.SelectQuery(sqlcmd).Tables[0];
                            //if (dtadcno.Rows.Count > 0)
                            //{
                            //}
                            //else
                            //{
                            sqlcmd = new SqlCommand("Insert into EMROINV (cardcode,cardname,TaxDate, DocDate, DocDueDate,dscription,itemcode,quantity,price,whscode,vat_percent,taxamount,ReferenceNo,TaxCode,B1Upload,Processed,CreateDate,REMARKS,SALETYPE,OcrCode,ocrCode2) values(@cardcode,@cardname,@TaxDate,@DocDate,@DocDueDate,@dscription,@itemcode,@quantity,@price,@whscode,@vat_percent,@taxamount,@ReferenceNo,@TaxCode,@B1Upload,@Processed,@CreateDate,@REMARKS,@SALETYPE,@OcrCode,@ocrCode2)");
                            sqlcmd.Parameters.Add("@cardcode", dr["Customer Code"].ToString());
                            sqlcmd.Parameters.Add("@cardname", dr["Customer Name"].ToString());
                            sqlcmd.Parameters.Add("@TaxDate", GetLowDate(fromdate));
                            sqlcmd.Parameters.Add("@docdate", GetLowDate(fromdate));
                            sqlcmd.Parameters.Add("@DocDueDate", GetLowDate(fromdate));
                            sqlcmd.Parameters.Add("@dscription", dr["Item Name"].ToString());
                            sqlcmd.Parameters.Add("@itemcode", dr["Item Code"].ToString());
                            sqlcmd.Parameters.Add("@quantity", dr["Qty"].ToString());
                            sqlcmd.Parameters.Add("@price", dr["Rate"].ToString());
                            sqlcmd.Parameters.Add("@whscode", whccode);
                            sqlcmd.Parameters.Add("@OcrCode", whccode);
                            sqlcmd.Parameters.Add("@ocrCode2", dr["Category Code"].ToString());
                            sqlcmd.Parameters.Add("@vat_percent", dr["TAX%"].ToString());
                            sqlcmd.Parameters.Add("@taxamount", dr["Taxable Value"].ToString());
                            sqlcmd.Parameters.Add("@ReferenceNo", dr["Invoce No."].ToString());
                            string TaxCode = dr["Tax Code"].ToString();
                            string B1Upload = "N";
                            string Processed = "N";
                            sqlcmd.Parameters.Add("@TaxCode", TaxCode);
                            sqlcmd.Parameters.Add("@B1Upload", B1Upload);
                            sqlcmd.Parameters.Add("@Processed", Processed);
                            sqlcmd.Parameters.Add("@CreateDate", CreateDate);
                            sqlcmd.Parameters.Add("@REMARKS", dr["Narration"].ToString());
                            string salestype = dr["Sales Type"].ToString();
                            sqlcmd.Parameters.Add("@SALETYPE", salestype);//Cash-sale
                            SAPvdm.insert(sqlcmd);
                        }
                        //}
                    }
                }
                pnlHide.Visible = false;
                DataTable dtempty = new DataTable();
                grdReports.DataSource = dtempty;
                grdReports.DataBind();
                lblmsg.Text = "Successfully Saved";
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.ToString();
        }
    }
}
