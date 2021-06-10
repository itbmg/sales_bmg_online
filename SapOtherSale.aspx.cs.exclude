using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using System.Data.SqlClient;

public partial class SapOtherSale : System.Web.UI.Page
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
            cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType)  ");
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
            Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Tally Sales " + fromdate.ToString("dd/MM/yyyy");
            if (ddltype.SelectedValue == "Non Tax")
            {
                cmd = new MySqlCommand("SELECT  tripdata.Sno AS TripId, DATE_FORMAT(tripdata.AssignDate, '%d %b %y') AS AssignDate, tripdata.Permissions, tripdata.VehicleNo,dispatch.DispName AS DispatchName, empmanage.EmpName AS Employee FROM tripdata INNER JOIN empmanage ON tripdata.EmpId = empmanage.Sno INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno INNER JOIN branchdata ON empmanage.Branch = branchdata.sno WHERE (tripdata.DC_Type = 1) AND (tripdata.Status <> 'c') AND (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.Permissions LIKE '%D%') AND  (empmanage.Branch = @BranchID)");
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
                DataTable dttripid = vdm.SelectQuery(cmd).Tables[0];
                foreach (DataRow drdc in dttripid.Rows)
                {
                    cmd = new MySqlCommand("SELECT  products_category.categorycode, products_category.sno AS categoryid, productsdata.Itemcode, products_category.tcategory, branchdata.BranchName,branchdata.whcode, branchdata.sno AS BSno, indent.IndentType, indents_subtable.DeliveryQty, indents_subtable.UnitCost, productsdata.tproduct,productsdata.ProductName, productsdata.Units, productsdata.sno AS productsno, products_category.tcategory AS Expr1, tripdata.to_adr_Id,addresstable.companyname AS tBranchName, IFNULL(branchproducts.VatPercent, 0) AS VatPercent FROM (SELECT IndentNo, Branch_id, I_date, Status, IndentType FROM indents WHERE (I_date BETWEEN @d1 AND @d2) AND (Status <> 'D')) indent INNER JOIN branchdata ON indent.Branch_id = branchdata.sno INNER JOIN tripdata ON tripdata.BranchID = branchdata.sno INNER JOIN addresstable ON addresstable.sno = tripdata.to_adr_Id INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno WHERE (indents_subtable.DeliveryQty <> 0) AND (tripdata.Sno = @BranchID) GROUP BY productsdata.sno, BSno, branchproducts.VatPercent ORDER BY branchdata.BranchName");
                    cmd.Parameters.AddWithValue("@BranchID", drdc["TripId"].ToString());
                    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                    cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
                    DataTable dtothntax = vdm.SelectQuery(cmd).Tables[0];
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
                    if (dtothntax.Rows.Count > 0)
                    {
                        Report = new DataTable();
                        Report.Columns.Add("Ledger Type");
                        Report.Columns.Add("Customer Code");
                        Report.Columns.Add("Customer Name");
                        Report.Columns.Add("Invoice Date");
                        Report.Columns.Add("Invoce No");
                        Report.Columns.Add("Item Code");
                        Report.Columns.Add("Item Name");
                        Report.Columns.Add("Qty");
                        Report.Columns.Add("Rate");
                        Report.Columns.Add("Tax Code");
                        Report.Columns.Add("Sales Type");
                        Report.Columns.Add("Category Code");
                        Report.Columns.Add("vat_percent");
                        Report.Columns.Add("TaxAmount");
                        Report.Columns.Add("Rounding Off");
                        Report.Columns.Add("WH Code");
                        Report.Columns.Add("Inv Value");
                        Report.Columns.Add("Net Value");
                        Report.Columns.Add("Narration");
                        int i = 1;
                        cmd = new MySqlCommand("SELECT sno, BranchName, statename,tax,ntax FROM branchdata WHERE (sno = @BranchID)");
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
                        string tax = "";
                        string ntax = "";
                        if (dtstatename.Rows.Count > 0)
                        {
                            statename = dtstatename.Rows[0]["statename"].ToString();
                            tax = dtstatename.Rows[0]["tax"].ToString();
                            ntax = dtstatename.Rows[0]["ntax"].ToString();
                        }
                        foreach (DataRow branch in dtothntax.Rows)
                        {
                            DataRow newrow = Report.NewRow();
                            cmd = new MySqlCommand("SELECT agentdcno FROM  agentdc WHERE (BranchID = @BranchID) AND (IndDate BETWEEN @d1 AND @d2)");
                            cmd.Parameters.AddWithValue("@BranchID", branch["BSno"].ToString());
                            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                            DataTable dtsubDc = vdm.SelectQuery(cmd).Tables[0];
                            string DCNO = "";
                            if (dtsubDc.Rows.Count > 0)
                            {
                                DCNO = dtsubDc.Rows[0]["agentdcno"].ToString();
                            }
                            if (branch["vatpercent"].ToString() == "0")
                            {
                                newrow["WH Code"] = branch["whcode"].ToString();
                            }

                            cmd = new MySqlCommand("SELECT  sno, companyname, buildingaddress, street, mandal, district, state, pin, tin, cst, email, panno, customercode FROM addresstable WHERE (sno = @to_adr_Id)");
                            cmd.Parameters.AddWithValue("@to_adr_Id", branch["to_adr_Id"].ToString());
                            DataTable dtcustomer = vdm.SelectQuery(cmd).Tables[0];
                            newrow["Customer Name"] = dtcustomer.Rows[0]["companyname"].ToString();
                            newrow["Customer Code"] = dtcustomer.Rows[0]["customercode"].ToString();

                            double Roundingoff = 0;
                            int countdc = 0;
                            int.TryParse(DCNO, out countdc);
                            if (countdc < 10)
                            {
                                DCNO = "00" + DCNO;
                            }
                            if (countdc > 10 && countdc < 99)
                            {
                                DCNO = "0" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "174")
                            {
                                DCNO = "CHN/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "4607")
                            {
                                DCNO = "MPK/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "271")
                            {
                                DCNO = "NLR/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "285")
                            {
                                if (branch["BSno"].ToString() == "2624")
                                {
                                    DCNO = "PLR/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                                }
                                else
                                {
                                    DCNO = "TPT/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                                }
                            }
                            if (ddlSalesOffice.SelectedValue == "306")
                            {
                                DCNO = "KANCHI/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "2749")
                            {
                                if (branch["sno"].ToString() == "3781")
                                {
                                    DCNO = "TDP/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                                }
                                else
                                {
                                    DCNO = "MDPL/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                                }
                            }
                            if (ddlSalesOffice.SelectedValue == "3928")
                            {
                                DCNO = "AB/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "2909")
                            {
                                DCNO = "VLR/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "538")
                            {
                                DCNO = "BANG/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "159")
                            {
                                DCNO = "HYD/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "570")
                            {
                                DCNO = "VJD/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "457")
                            {
                                DCNO = "WNGL/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "158" || ddlSalesOffice.SelectedValue == "572")
                            {
                                DCNO = "WYRA/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "282")
                            {
                                DCNO = "KLH/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "458")
                            {
                                DCNO = "KMM/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "3559")
                            {
                                DCNO = "CTR/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (branch["vatpercent"].ToString() == "0")
                            {
                                newrow["Invoce No"] = DCNO;
                                newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
                                newrow["Item Name"] = branch["tProduct"].ToString();
                                newrow["Item Code"] = branch["Itemcode"].ToString();
                                double vatpercent = 0;
                                double.TryParse(branch["vatpercent"].ToString(), out vatpercent);
                                string tcategory = "";
                                string TaxCode = "EXEMPT";
                                if (vatpercent == null || vatpercent == 0.0)
                                {
                                    tcategory = branch["tcategory"].ToString();

                                    string category = branch["tcategory"].ToString();
                                    if (category == "G.Sale Of Milk" || category == "G.Sale Of Curd " || category == "Sale Of Buttermilk" || category == "Sale Of Lassi" || category == "Sale Of Butter")
                                    {
                                        tcategory = branch["tcategory"].ToString();
                                        TaxCode = "EXEMPT";
                                        newrow["Sales Type"] = ntax;
                                    }
                                    else
                                    {
                                        tcategory = branch["tcategory"].ToString();
                                    }
                                }
                                newrow["Category Code"] = branch["categorycode"].ToString();
                                newrow["Tax Code"] = TaxCode.ToString();
                                newrow["Ledger Type"] = tcategory.ToString();
                                if (branch["tBranchName"].ToString() == "" || branch["DeliveryQty"].ToString() == "" || branch["DeliveryQty"].ToString() == "0")
                                {
                                }
                                else
                                {
                                    double percent = 0;
                                    newrow["Qty"] = branch["DeliveryQty"].ToString();
                                    double UnitCost = 0;
                                    double Unitprice = 0;
                                    double.TryParse(branch["UnitCost"].ToString(), out UnitCost);
                                    Unitprice = UnitCost;
                                    double.TryParse(branch["vatpercent"].ToString(), out vatpercent);
                                    if (vatpercent == 0.0)
                                    {
                                        newrow["Rate"] = UnitCost.ToString();
                                    }
                                    else
                                    {
                                        percent = vatpercent / 100;
                                        percent = percent + 1;
                                        UnitCost = UnitCost / percent;
                                        UnitCost = Math.Round(UnitCost, 2);
                                        newrow["Rate"] = UnitCost.ToString();
                                    }
                                    newrow["vat_percent"] = vatpercent.ToString();
                                    newrow["Rounding Off"] = Roundingoff;
                                    double invval = 0;
                                    double qty = 0;
                                    double.TryParse(branch["DeliveryQty"].ToString(), out qty);
                                    double taxval = 0;
                                    if (vatpercent == 0.0)
                                    {
                                        invval = qty * UnitCost;
                                    }
                                    else
                                    {
                                        double diffcost = 0;
                                        diffcost = Unitprice - UnitCost;
                                        taxval = qty * diffcost;
                                        invval = qty * UnitCost;

                                    }
                                    invval = Math.Round(invval, 2);
                                    taxval = Math.Round(taxval, 2);
                                    newrow["TaxAmount"] = taxval;
                                    double netvalue = 0;
                                    netvalue = invval + taxval;
                                    netvalue = Math.Round(netvalue, 2);
                                    newrow["Inv Value"] = invval;
                                    newrow["Net Value"] = netvalue;
                                    newrow["Narration"] = "Being the sale of milk to  " + branch["tBranchName"].ToString() + " vide DC No " + DCNO + ",DC Date " + fromdate.ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                                    Report.Rows.Add(newrow);
                                    i++;
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
                        lblmsg.Text = "No Data Found";
                        grdReports.DataSource = Report;
                        grdReports.DataBind();
                    }
                }
            }
            else
            {
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
                Report = new DataTable();
                Report.Columns.Add("Ledger Type");
                Report.Columns.Add("Customer Code");
                Report.Columns.Add("Customer Name");
                Report.Columns.Add("Invoice Date");
                Report.Columns.Add("Invoce No");
                Report.Columns.Add("Item Code");
                Report.Columns.Add("Item Name");
                Report.Columns.Add("Qty");
                Report.Columns.Add("Rate");
                Report.Columns.Add("Tax Code");
                Report.Columns.Add("Sales Type");
                Report.Columns.Add("Category Code");
                Report.Columns.Add("vat_percent");
                Report.Columns.Add("TaxAmount");
                Report.Columns.Add("Rounding Off");
                Report.Columns.Add("WH Code");
                Report.Columns.Add("Inv Value");
                Report.Columns.Add("Net Value");
                Report.Columns.Add("Narration");
                int i = 1;
                cmd = new MySqlCommand("SELECT  tripdata.Sno AS TripId, DATE_FORMAT(tripdata.AssignDate, '%d %b %y') AS AssignDate, tripdata.Permissions, tripdata.VehicleNo,dispatch.DispName AS DispatchName, empmanage.EmpName AS Employee FROM tripdata INNER JOIN empmanage ON tripdata.EmpId = empmanage.Sno INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno INNER JOIN branchdata ON empmanage.Branch = branchdata.sno WHERE (tripdata.DC_Type = 1) AND (tripdata.Status <> 'c') AND (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (tripdata.Permissions LIKE '%D%') AND  (empmanage.Branch = @BranchID)");
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
                DataTable dttripid = vdm.SelectQuery(cmd).Tables[0];
                foreach (DataRow drdc in dttripid.Rows)
                {
                    cmd = new MySqlCommand("SELECT   addresstable.customercode,products_category.categorycode, productsdata.Itemcode, branchdata.whcode, products_category.sno AS categoryid, branchdata.tbranchname,branchdata.BranchName, branchdata.sno AS BSno, indent.IndentType, indents_subtable.DeliveryQty, indents_subtable.UnitCost, productsdata.tproduct,productsdata.ProductName, productsdata.Units, productsdata.sno AS productsno, products_category.tcategory, branchproducts.VatPercent, tripdata.to_adr_Id,addresstable.companyname AS tBranchName FROM  (SELECT IndentNo, Branch_id, I_date, Status, IndentType FROM indents WHERE (I_date BETWEEN @d1 AND @d2) AND (Status <> 'D')) indent INNER JOIN branchdata ON indent.Branch_id = branchdata.sno INNER JOIN tripdata ON tripdata.BranchID = branchdata.sno INNER JOIN addresstable ON addresstable.sno = tripdata.to_adr_Id INNER JOIN indents_subtable ON indent.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON branchdata.sno = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno WHERE (indents_subtable.DeliveryQty <> 0) AND (branchproducts.VatPercent > 0) AND (tripdata.Sno = @BranchID) GROUP BY productsdata.sno, BSno, branchproducts.VatPercent ORDER BY branchdata.BranchName");
                    cmd.Parameters.AddWithValue("@BranchID", drdc["TripId"].ToString());
                    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                    cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
                    DataTable dtothers = vdm.SelectQuery(cmd).Tables[0];
                    if (dtothers.Rows.Count > 0)
                    {

                        int j = 1;
                        cmd = new MySqlCommand("SELECT sno, BranchName, statename,tax,ntax FROM branchdata WHERE (sno = @BranchID)");
                        if (Session["salestype"].ToString() == "Plant")
                        {
                            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                        }
                        DataTable dtstate = vdm.SelectQuery(cmd).Tables[0];
                        string statename = "";
                        string tax = "";
                        string ntax = "";
                        if (dtstate.Rows.Count > 0)
                        {
                            statename = dtstate.Rows[0]["statename"].ToString();
                            tax = dtstate.Rows[0]["tax"].ToString();
                            ntax = dtstate.Rows[0]["ntax"].ToString();
                        }
                        foreach (DataRow branch in dtothers.Rows)
                        {
                            DataRow newrow = Report.NewRow();
                            string DCNO = "0";
                            long DcNo = 0;
                            cmd = new MySqlCommand("SELECT sno, taxdcno, invoiceno, agentid, branchid, productid, doe, indentdate FROM taxdc_table WHERE (branchid = @BranchID) AND (indentdate BETWEEN @d1 AND @d2)");
                            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                            DataTable dtotherDc = vdm.SelectQuery(cmd).Tables[0];
                            if (dtotherDc.Rows.Count > 0)
                            {
                                DataRow[] drotherdc = dtotherDc.Select("productid='" + branch["categoryid"].ToString() + "' and branchid='" + ddlSalesOffice.SelectedValue + "' and agentid='" + branch["BSno"].ToString() + "'");
                                if (drotherdc.Length > 0)
                                {
                                    foreach (DataRow drotherc in drotherdc)
                                    {
                                        DCNO = drotherc.ItemArray[1].ToString();
                                    }
                                }
                            }
                            int countdc = 0;
                            int.TryParse(DCNO, out countdc);
                            if (countdc <= 10)
                            {
                                DCNO = "00" + DCNO;
                            }
                            if (countdc >= 10 && countdc <= 99)
                            {
                                DCNO = "0" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "174")
                            {
                                DCNO = "CHN/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "4607")
                            {
                                DCNO = "MPK/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "271")
                            {
                                DCNO = "NLR/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "285")
                            {
                                if (branch["BSno"].ToString() == "2624")
                                {
                                    DCNO = "PLR/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                                }
                                else
                                {
                                    DCNO = "TPT/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                                }
                            }
                            if (ddlSalesOffice.SelectedValue == "306")
                            {
                                DCNO = "KANCHI/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "2749")
                            {
                                if (branch["sno"].ToString() == "3781")
                                {
                                    DCNO = "TDP/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                                }
                                else
                                {
                                    DCNO = "MDPL/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                                }
                            }
                            if (ddlSalesOffice.SelectedValue == "3928")
                            {
                                DCNO = "AB/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "2909")
                            {
                                DCNO = "VLR/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "NT/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "538")
                            {
                                DCNO = "BANG/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "159")
                            {
                                DCNO = "HYD/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "570")
                            {
                                DCNO = "VJD/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "457")
                            {
                                DCNO = "WNGL/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "158" || ddlSalesOffice.SelectedValue == "572")
                            {
                                DCNO = "WYRA/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "282")
                            {
                                DCNO = "KLH/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "458")
                            {
                                DCNO = "KMM/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            if (ddlSalesOffice.SelectedValue == "3559")
                            {
                                DCNO = "CTR/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            }
                            cmd = new MySqlCommand("SELECT  sno, companyname, buildingaddress, street, mandal, district, state, pin, tin, cst, email, panno, customercode FROM addresstable WHERE (sno = @to_adr_Id)");
                            cmd.Parameters.AddWithValue("@to_adr_Id", branch["to_adr_Id"].ToString());
                            DataTable dtcustomer = vdm.SelectQuery(cmd).Tables[0];
                            newrow["Customer Code"] = dtcustomer.Rows[0]["customercode"].ToString();   // branch["tbranchname1"].ToString();
                            newrow["WH Code"] = branch["whcode"].ToString();
                            newrow["Customer Name"] = dtcustomer.Rows[0]["companyname"].ToString();   // branch["tbranchname1"].ToString();
                            double Roundingoff = 0;
                            newrow["Invoce No"] = DCNO;
                            newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
                            newrow["Item Name"] = branch["tProduct"].ToString();
                            newrow["Item Code"] = branch["Itemcode"].ToString();
                            double vatpercent = 0;
                            double.TryParse(branch["vatpercent"].ToString(), out vatpercent);
                            double delqty = 0;
                            double.TryParse(branch["DeliveryQty"].ToString(), out delqty);
                            string tcategory = "";
                            string TaxCode = "EXEMPT";
                            if (vatpercent == null || vatpercent == 0.0)
                            {
                                tcategory = branch["tcategory"].ToString();
                                newrow["Sales Type"] = ntax;
                            }
                            else
                            {
                                tcategory = branch["tcategory"].ToString() + " " + "@" + " " + branch["vatpercent"].ToString() + "%-" + statename;
                                TaxCode = "VAT@" + branch["vatpercent"].ToString();
                                newrow["Sales Type"] = tax;
                            }
                            newrow["Ledger Type"] = tcategory.ToString();
                            newrow["Tax Code"] = TaxCode.ToString();
                            newrow["Category Code"] = branch["categorycode"].ToString();
                            double percent = 0;
                            newrow["Qty"] = branch["DeliveryQty"].ToString();
                            double UnitCost = 0;
                            double Unitprice = 0;
                            double.TryParse(branch["UnitCost"].ToString(), out UnitCost);
                            Unitprice = UnitCost;
                            double.TryParse(branch["vatpercent"].ToString(), out vatpercent);
                            if (vatpercent == 0.0)
                            {
                                newrow["Rate"] = UnitCost.ToString();
                            }
                            else
                            {
                                percent = vatpercent / 100;
                                percent = percent + 1;
                                UnitCost = UnitCost / percent;
                                UnitCost = Math.Round(UnitCost, 2);
                                newrow["Rate"] = UnitCost.ToString();
                            }
                            newrow["vat_percent"] = vatpercent.ToString();
                            newrow["Rounding Off"] = Roundingoff;
                            double invval = 0;
                            double qty = 0;
                            double.TryParse(branch["DeliveryQty"].ToString(), out qty);
                            double taxval = 0;
                            if (vatpercent == 0.0)
                            {
                                invval = qty * UnitCost;
                            }
                            else
                            {
                                double diffcost = 0;
                                diffcost = Unitprice - UnitCost;
                                taxval = qty * diffcost;
                                invval = qty * UnitCost;
                            }
                            invval = Math.Round(invval, 2);
                            taxval = Math.Round(taxval, 2);
                            newrow["TaxAmount"] = taxval;
                            double netvalue = 0;
                            netvalue = invval + taxval;
                            netvalue = Math.Round(netvalue, 2);
                            newrow["Inv Value"] = invval;
                            newrow["Net Value"] = netvalue;
                            newrow["Narration"] = "Being the sale of milk to  " + branch["tbranchname"].ToString() + " vide DC No " + DCNO + ",DC Date " + fromdate.ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                            Report.Rows.Add(newrow);
                            j++;
                            //}

                        }
                        grdReports.DataSource = Report;
                        grdReports.DataBind();
                        Session["xportdata"] = Report;
                    }

                    else
                    {
                        pnlHide.Visible = false;
                        lblmsg.Text = "No Data Found";
                        grdReports.DataSource = Report;
                        grdReports.DataBind();
                    }
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
                        sqlcmd.Parameters.Add("@vat_percent", dr["vat_percent"].ToString());
                        sqlcmd.Parameters.Add("@taxamount", dr["TaxAmount"].ToString());
                        sqlcmd.Parameters.Add("@ReferenceNo", dr["Invoce No"].ToString());
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
                        //SAPvdm.insert(sqlcmd);
                    }
                }
            }
            pnlHide.Visible = false;
            DataTable dtempty = new DataTable();
            grdReports.DataSource = dtempty;
            grdReports.DataBind();
            lblmsg.Text = "Successfully Saved";
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.ToString();
        }
    }
}