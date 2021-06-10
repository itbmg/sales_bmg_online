using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using MySql.Data.MySqlClient;

public partial class SAPInward : System.Web.UI.Page
{

    //MySqlCommand cmd;
    //string UserName = "";
    //VehicleDBMgr vdm;
    //protected void Page_Load(object sender, EventArgs e)
    //{
    //    if (Session["salestype"] == null)
    //    {
    //        Response.Redirect("Login.aspx");
    //    }
    //    //UserName = Session["field1"].ToString();
    //    //vdm = new VehicleDBMgr();
    //    if (!this.IsPostBack)
    //    {
    //        if (!Page.IsCallback)
    //        {
    //            txtFromdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
    //            lblTitle.Text = Session["TitleName"].ToString();
    //            FillRouteName();
    //        }
    //    }


    //}
    //protected void btnGenerate_Click(object sender, EventArgs e)
    //{
    //    GetReport();
    //}
    //void FillRouteName()
    //{
    //    vdm = new VehicleDBMgr();
    //    if (Session["salestype"].ToString() == "Plant")
    //    {
    //        PBranch.Visible = true;
    //        cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType) or (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType1) ");
    //        cmd.Parameters.AddWithValue("@SuperBranch", Session["branch"]);
    //        cmd.Parameters.AddWithValue("@SalesType", "21");
    //        cmd.Parameters.AddWithValue("@SalesType1", "26");
    //        DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
    //        ddlSalesOffice.DataSource = dtRoutedata;
    //        ddlSalesOffice.DataTextField = "BranchName";
    //        ddlSalesOffice.DataValueField = "sno";
    //        ddlSalesOffice.DataBind();
    //        ddlSalesOffice.Items.Insert(0, new ListItem("Kuppam Plant", "1801"));
    //        ddlSalesOffice.Items.Insert(0, new ListItem("Manapakkam Plant", "3625"));
    //    }
    //    else
    //    {
    //        PBranch.Visible = true;
    //        cmd = new MySqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM  branchdata INNER JOIN branchdata branchdata_1 ON branchdata.sno = branchdata_1.sno WHERE (branchdata_1.SalesOfficeID = @SOID) AND (branchdata.SalesType IS NOT NULL) OR (branchdata.sno = @BranchID) AND (branchdata.SalesType IS NOT NULL)");
    //        cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
    //        cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
    //        DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
    //        ddlSalesOffice.DataSource = dtRoutedata;
    //        ddlSalesOffice.DataTextField = "BranchName";
    //        ddlSalesOffice.DataValueField = "sno";
    //        ddlSalesOffice.DataBind();
    //        ddlSalesOffice.Items.Insert(0, new ListItem("Kuppam Plant", "1801"));
    //        ddlSalesOffice.Items.Insert(0, new ListItem("Manapakkam Plant", "3625"));
    //    }
    //}
    //private DateTime GetLowDate(DateTime dt)
    //{
    //    double Hour, Min, Sec;
    //    DateTime DT = DateTime.Now;
    //    DT = dt;
    //    Hour = -dt.Hour;
    //    Min = -dt.Minute;
    //    Sec = -dt.Second;
    //    DT = DT.AddHours(Hour);
    //    DT = DT.AddMinutes(Min);
    //    DT = DT.AddSeconds(Sec);
    //    return DT;
    //}
    //private DateTime GetHighDate(DateTime dt)
    //{
    //    double Hour, Min, Sec;
    //    DateTime DT = DateTime.Now;
    //    Hour = 23 - dt.Hour;
    //    Min = 59 - dt.Minute;
    //    Sec = 59 - dt.Second;
    //    DT = dt;
    //    DT = DT.AddHours(Hour);
    //    DT = DT.AddMinutes(Min);
    //    DT = DT.AddSeconds(Sec);
    //    return DT;
    //}
    //DataTable Report = new DataTable();
    //void GetReport()
    //{
    //    try
    //    {
    //        lblmsg.Text = "";
    //        pnlHide.Visible = true;
    //        Session["RouteName"] = ddlSalesOffice.SelectedItem.Text;
    //        Session["IDate"] = DateTime.Now.AddDays(1).ToString("dd/MM/yyyy");
    //        vdm = new VehicleDBMgr();
    //        DateTime fromdate = DateTime.Now;
    //        string[] dateFromstrig = txtFromdate.Text.Split(' ');
    //        if (dateFromstrig.Length > 1)
    //        {
    //            if (dateFromstrig[0].Split('-').Length > 0)
    //            {
    //                string[] dates = dateFromstrig[0].Split('-');
    //                string[] times = dateFromstrig[1].Split(':');
    //                fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
    //            }
    //        }

    //        lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
    //        lblRoutName.Text = ddlSalesOffice.SelectedItem.Text;
    //        Session["xporttype"] = "TallyInward";
    //        Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Tally Inward" + fromdate.ToString("dd/MM/yyyy");
    //        if (ddlSalesOffice.SelectedItem.Text == "Cash Sale" || ddlSalesOffice.SelectedItem.Text == "Staff Sale")
    //        {
    //            Report.Columns.Add("Voucher Date");
    //            Report.Columns.Add("Voucher No");
    //            Report.Columns.Add("Category Code");
    //            Report.Columns.Add("Item Code");
    //            Report.Columns.Add("Item Name");
    //            Report.Columns.Add("Qty");
    //            Report.Columns.Add("Narration");
    //            if (ddlSalesOffice.SelectedItem.Text == "Cash Sale")
    //            {
    //                cmd = new MySqlCommand("SELECT TripInfo.Sno, TripInfo.DCNo, ProductInfo.tproduct,ProductInfo.itemcode, ProductInfo.Categoryname,ProductInfo.categorycode, ProductInfo.Qty, TripInfo.I_Date, TripInfo.VehicleNo, TripInfo.Status, TripInfo.DispName, TripInfo.DispType, TripInfo.DispMode FROM (SELECT tripdata.Sno, tripdata.DCNo, tripdata.I_Date, tripdata.VehicleNo, tripdata.Status, dispatch.DispName, dispatch.DispType, dispatch.DispMode FROM branchdata INNER JOIN dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno WHERE (dispatch.DispMode = 'LOCAL') AND (dispatch.Branch_Id = @branch) AND (tripdata.AssignDate BETWEEN @d1 AND @d2)) TripInfo INNER JOIN (SELECT Categoryname, ProductName, Sno, Qty, tproduct,categorycode FROM  (SELECT products_category.Categoryname,products_category.categorycode,productsdata.ProductName, tripdata_1.Sno, tripsubdata.Qty, productsdata.tproduct,productsdata.itemcode FROM tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno");
    //            }
    //            else
    //            {
    //                cmd = new MySqlCommand("SELECT TripInfo.Sno, TripInfo.DCNo, ProductInfo.tproduct,ProductInfo.itemcode, ProductInfo.Categoryname, ProductInfo.categorycode,ProductInfo.Qty, TripInfo.I_Date, TripInfo.VehicleNo, TripInfo.Status, TripInfo.DispName, TripInfo.DispType, TripInfo.DispMode FROM (SELECT tripdata.Sno, tripdata.DCNo, tripdata.I_Date, tripdata.VehicleNo, tripdata.Status, dispatch.DispName, dispatch.DispType, dispatch.DispMode FROM branchdata INNER JOIN dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno WHERE (dispatch.DispMode = 'Staff') AND (dispatch.Branch_Id = @branch) AND (tripdata.AssignDate BETWEEN @d1 AND @d2)) TripInfo INNER JOIN (SELECT Categoryname, ProductName, Sno, Qty, tproduct,categorycode FROM  (SELECT products_category.Categoryname,products_category.categorycode, productsdata.ProductName, tripdata_1.Sno, tripsubdata.Qty, productsdata.tproduct,productsdata.itemcode FROM tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno");
    //            }
    //            cmd.Parameters.AddWithValue("@branch", Session["branch"]);
    //            cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
    //            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
    //            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
    //            DataTable dtble = vdm.SelectQuery(cmd).Tables[0];
    //            int i = 1;
    //            foreach (DataRow branch in dtble.Rows)
    //            {
    //                DataRow newrow = Report.NewRow();
    //                newrow["Voucher Date"] = fromdate.ToString("dd-MMM-yyyy");
    //                newrow["Voucher No"] = branch["Sno"].ToString();  
    //                newrow["Item Code"] = branch["itemcode"].ToString();
    //                newrow["Category Code"] = branch["categorycode"].ToString();
    //                newrow["Item Name"] = branch["tproduct"].ToString();
    //                newrow["Qty"] = branch["qty"].ToString();
    //                if (ddlSalesOffice.SelectedItem.Text == "Cash Sale")
    //                {
    //                    newrow["Narration"] = "Being the stock transfer to  " + ddlSalesOffice.SelectedItem.Text + " vide dc No " + branch["sno"].ToString() + ",DC Date " + fromdate.AddDays(-1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
    //                }
    //                else
    //                {
    //                    newrow["Narration"] = "Being the stock transfer to  " + branch["DispName"].ToString() + " from " + ddlSalesOffice.SelectedItem.Text + " vide dc No " + branch["sno"].ToString() + ",DC Date " + fromdate.AddDays(-1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();

    //                }
    //                Report.Rows.Add(newrow);
    //                i++;
    //            }
    //            grdReports.DataSource = Report;
    //            grdReports.DataBind();
    //            Session["xportdata"] = Report;
    //        }
    //        else
    //        {
    //            cmd = new MySqlCommand("SELECT sno, BranchName, incentivename,whcode FROM branchdata WHERE (sno = @BranchID)");
    //            if (Session["salestype"].ToString() == "Plant")
    //            {
    //                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
    //            }
    //            else
    //            {
    //                cmd.Parameters.AddWithValue("@BranchID", Session["branch"]);
    //            }
    //            DataTable dtwhcode = vdm.SelectQuery(cmd).Tables[0];
    //            cmd = new MySqlCommand("SELECT productsdata.tproduct, productsdata.Itemcode, ROUND(SUM(tripsubdata.Qty), 2) AS qty, tripdata.Sno, tripdata.I_Date, empmanage.UserName, products_subcategory.category_sno, products_category.categorycode FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN empmanage ON tripdata.EmpId = empmanage.Sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata.I_Date BETWEEN @d1 AND @d2) AND (empmanage.Branch = @BranchID) AND (tripdata.BranchID = @PlantID) GROUP BY productsdata.tproduct,productsdata.Itemcode");
    //            cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
    //            cmd.Parameters.AddWithValue("@PlantID", Session["branch"]);
    //            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
    //            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
    //            cmd.Parameters.AddWithValue("@Type", "Agent");
    //            DataTable dtAgent = vdm.SelectQuery(cmd).Tables[0];
    //            if (dtAgent.Rows.Count > 0)
    //            {
    //                Report.Columns.Add("Voucher Date");
    //                Report.Columns.Add("Voucher No");
    //                Report.Columns.Add("Wh Code");
    //                Report.Columns.Add("Category Code");
    //                Report.Columns.Add("Item Code");
    //                Report.Columns.Add("Item Name");
    //                Report.Columns.Add("Qty");
    //                Report.Columns.Add("Narration");
    //                //DataTable distincttable = view.ToTable(true, "BranchName", "BSno");
    //                int i = 1;
    //                foreach (DataRow branch in dtAgent.Rows)
    //                {
    //                    DataRow newrow = Report.NewRow();
    //                    if (ddlSalesOffice.SelectedValue == "306")
    //                    {
    //                        newrow["Voucher Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
    //                    }
    //                    else
    //                    {
    //                        newrow["Voucher Date"] = fromdate.ToString("dd-MMM-yyyy");
    //                    }
    //                    newrow["Voucher No"] = branch["sno"].ToString();
    //                    newrow["Wh Code"] = dtwhcode.Rows[0]["whcode"].ToString();
    //                    newrow["Category Code"] = branch["categorycode"].ToString();
    //                    newrow["Item Code"] = branch["itemcode"].ToString();
    //                    newrow["Item Name"] = branch["tproduct"].ToString();
    //                    newrow["Qty"] = branch["qty"].ToString();
    //                    newrow["Narration"] = "Being the stock transfer to  " + ddlSalesOffice.SelectedItem.Text + " vide dc No " + branch["sno"].ToString() + ",DC Date " + fromdate.AddDays(1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
    //                    Report.Rows.Add(newrow);
    //                    i++;
    //                }
    //                cmd = new MySqlCommand("SELECT  dispatch.DispName, dispatch.sno, dispatch.BranchID, tripdata.I_Date, tripdata.Sno AS TripSno, dispatch.DispMode, branchmappingtable.SuperBranch, triproutes.Tripdata_sno FROM dispatch INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno INNER JOIN branchmappingtable ON dispatch.BranchID = branchmappingtable.SubBranch WHERE (dispatch.BranchID = @BranchID) AND (tripdata.I_Date BETWEEN @d1 AND @d2)and (dispatch.DispType ='SO') and (tripdata.Status<>'C') OR (tripdata.I_Date BETWEEN @d1 AND @d2) AND (branchmappingtable.SuperBranch = @SuperBranch)  and (dispatch.DispType = 'SO')and (tripdata.Status<>'C')  ORDER BY dispatch.sno");
    //                cmd.Parameters.AddWithValue("@SuperBranch", ddlSalesOffice.SelectedValue);
    //                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
    //                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
    //                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
    //                DataTable dtDispnames = vdm.SelectQuery(cmd).Tables[0];
    //                foreach (DataRow drSub in dtDispnames.Rows)
    //                {
    //                    if (drSub["DispMode"].ToString() == "" || drSub["DispMode"].ToString() == "SPL")
    //                    {
    //                    }
    //                    else
    //                    {
    //                        cmd = new MySqlCommand("SELECT        ff.TripID, Triproutes.RouteID, ff.Qty, ff.ProductId, Triproutes.Tripdata_sno, ff.I_Date, ff.tproduct, ff.Itemcode, ff.categorycode FROM (SELECT Tripdata_sno, RouteID, Sno FROM triproutes triproutes_1 WHERE (Tripdata_sno = @TripSno)) Triproutes INNER JOIN (SELECT TripID, Qty, ProductId, I_Date, tproduct, Itemcode, categorycode FROM (SELECT tripdata.Sno AS TripID, tripsubdata.Qty, tripsubdata.ProductId, tripdata.I_Date, productsdata.tproduct, productsdata.Itemcode, products_category.categorycode FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata.I_Date BETWEEN @starttime AND @endtime)) tripinfo) ff ON ff.TripID = Triproutes.Tripdata_sno");
    //                        cmd.Parameters.AddWithValue("@TripSno", drSub["TripSno"].ToString());
    //                        cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
    //                        cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
    //                        DataTable DtTripSubData = vdm.SelectQuery(cmd).Tables[0];
    //                        foreach (DataRow branch in DtTripSubData.Rows)
    //                        {
    //                            DataRow newrow = Report.NewRow();
    //                            newrow["Voucher Date"] = fromdate.ToString("dd-MMM-yyyy");
    //                            newrow["Voucher No"] = branch["TripID"].ToString();
    //                            newrow["Wh Code"] = dtwhcode.Rows[0]["whcode"].ToString();
    //                            newrow["Category Code"] = branch["categorycode"].ToString();
    //                            newrow["Item Code"] = branch["itemcode"].ToString();
    //                            newrow["Item Name"] = branch["tproduct"].ToString();
    //                            newrow["Qty"] = branch["Qty"].ToString();
    //                            newrow["Narration"] = "Being the stock transfer to " + drSub["DispName"].ToString() + " from " + ddlSalesOffice.SelectedItem.Text + " vide dc No " + branch["TripID"].ToString() + ",DC Date " + fromdate.AddDays(1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
    //                            Report.Rows.Add(newrow);
    //                            i++;
    //                        }
    //                    }

    //                }

    //                grdReports.DataSource = Report;
    //                grdReports.DataBind();
    //                Session["xportdata"] = Report;
    //            }
    //            else
    //            {
    //                pnlHide.Visible = false;
    //                lblmsg.Text = "No Indent Found";
    //                grdReports.DataSource = Report;
    //                grdReports.DataBind();
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        lblmsg.Text = ex.Message;
    //        grdReports.DataSource = Report;
    //        grdReports.DataBind();
    //    }
    //}
    //private string GetSpace(string p)
    //{
    //    int i = 0;
    //    for (; i < p.Length; i++)
    //    {
    //        if (char.IsNumber(p[i]))
    //        {
    //            break;
    //        }
    //    }
    //    return p.Substring(0, i) + " " + p.Substring(i, p.Length - i);
    //}
    //SqlCommand sqlcmd;
    //protected void BtnSave_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        vdm = new VehicleDBMgr();
    //        DateTime CreateDate = VehicleDBMgr.GetTime(vdm.conn);
    //        SAPdbmanger SAPvdm = new SAPdbmanger();
    //        DateTime fromdate = DateTime.Now;
    //        DataTable dt = (DataTable)Session["xportdata"];
    //        string[] dateFromstrig = txtFromdate.Text.Split(' ');
    //        if (dateFromstrig.Length > 1)
    //        {
    //            if (dateFromstrig[0].Split('-').Length > 0)
    //            {
    //                string[] dates = dateFromstrig[0].Split('-');
    //                string[] times = dateFromstrig[1].Split(':');
    //                fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
    //            }
    //        }
    //        if (ddlSalesOffice.SelectedValue == "306")
    //        {
    //            fromdate = fromdate.AddDays(1);
    //        }
    //        else
    //        {
    //            fromdate = fromdate;
    //        }
    //        //cmd = new MySqlCommand("SELECT sno, BranchName, whcode, ladger_dr_code, tax, ntax, ledger_jv_code FROM branchdata WHERE (sno = @BranchID)");
    //        //cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
    //        //DataTable dtwhscode = vdm.SelectQuery(cmd).Tables[0];
    //        //sqlcmd = new SqlCommand("SELECT CreateDate, PostingDate, DocDate, ReferenceNo AS Processed, Series FROM EMROWTR WHERE (PostingDate BETWEEN @d1 AND @d2) AND (ToWhsCode=@ToWhsCode)");
    //        //sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
    //        //sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
    //        //sqlcmd.Parameters.Add("@ToWhsCode", dtwhscode.Rows[0]["whcode"].ToString());
    //        //DataTable dtinward = SAPvdm.SelectQuery(sqlcmd).Tables[0];
    //        //if (dtinward.Rows.Count > 0)
    //        //{
    //        //    lblmsg.Text = "This Transaction already saved";
    //        //}
    //        //else
    //        //{
    //        DataTable dtST = new DataTable();
    //        string ToWhsCode = "";
    //        string fromwhcode = "";
    //        foreach (DataRow dr in dt.Rows)
    //        {
    //            double amount = 10;
    //            string B1Upload = "N";
    //            string Processed = "N";
    //            string ledgercode = dr["Item Code"].ToString();
    //            if (ledgercode == "")
    //            {
    //            }
    //            else
    //            {
    //                //////string CategoryCode = dr["Category Code"].ToString();
    //                //////if (CategoryCode == "P0001")
    //                //////{
    //                //////    sqlcmd = new SqlCommand("Insert into EMROIGN (CreateDate,PostingDate,DocDate,ReferenceNo,ItemCode,ItemName,Quantity,WhsCode,Price,series,OcrCode,Remarks,B1Upload,Processed,OcrCode2) values (@CreateDate,@PostingDate,@DocDate,@ReferenceNo,@ItemCode,@ItemName,@Quantity,@WhsCode,@Price,@series,@OcrCode,@Remarks,@B1Upload,@Processed,@OcrCode2)");
    //                //////    sqlcmd.Parameters.Add("@CreateDate", GetLowDate(fromdate));
    //                //////    sqlcmd.Parameters.Add("@PostingDate", GetLowDate(fromdate));
    //                //////    sqlcmd.Parameters.Add("@DocDate", GetLowDate(fromdate));
    //                //////    sqlcmd.Parameters.Add("@ReferenceNo", dr["Voucher No"].ToString());
    //                //////    sqlcmd.Parameters.Add("@ItemCode", dr["Item Code"].ToString());
    //                //////    sqlcmd.Parameters.Add("@ItemName", dr["Item Name"].ToString());
    //                //////    sqlcmd.Parameters.Add("@Quantity", dr["Qty"].ToString());
    //                //////    sqlcmd.Parameters.Add("@WhsCode", dr["Wh Code"].ToString());
    //                //////    sqlcmd.Parameters.Add("@Price", amount);
    //                //////    string series = "19";
    //                //////    sqlcmd.Parameters.Add("@series", series);
    //                //////    sqlcmd.Parameters.Add("@OcrCode", dr["Wh Code"].ToString());
    //                //////    sqlcmd.Parameters.Add("@OcrCode2", dr["Category Code"].ToString());
    //                //////    sqlcmd.Parameters.Add("@Remarks", dr["Narration"].ToString());
    //                //////    sqlcmd.Parameters.Add("@B1Upload", B1Upload);
    //                //////    sqlcmd.Parameters.Add("@Processed", Processed);
    //                //////    SAPvdm.insert(sqlcmd);
    //                //////}
    //                sqlcmd = new SqlCommand("SELECT CreateDate, PostingDate, DocDate, ReferenceNo AS Processed, Series FROM EMROWTR WHERE (PostingDate BETWEEN @d1 AND @d2) AND (ItemCode=@ItemCode) AND (ReferenceNo = @ReferenceNo)");
    //                sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
    //                sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
    //                sqlcmd.Parameters.Add("@ReferenceNo", dr["Voucher No"].ToString());
    //                sqlcmd.Parameters.Add("@ItemCode", dr["Item Code"].ToString());
    //                dtST = SAPvdm.SelectQuery(sqlcmd).Tables[0];
    //                if (dtST.Rows.Count > 0)
    //                {
    //                    lblmsg.Text = "This Transaction already saved";
    //                    break;
    //                }
    //                else
    //                {
    //                    sqlcmd = new SqlCommand("Insert into EMROWTR (CreateDate,PostingDate,DocDate,ReferenceNo,FromWhsCode,ToWhsCode,ItemCode,ItemName,Quantity,Price,OcrCode,OcrCode2,Remarks,B1Upload,Processed,series) values (@CreateDate,@PostingDate,@DocDate,@ReferenceNo,@FromWhsCode,@ToWhsCode,@ItemCode,@ItemName,@Quantity,@Price,@OcrCode,@OcrCode2,@Remarks,@B1Upload,@Processed,@series)");
    //                    sqlcmd.Parameters.Add("@CreateDate", GetLowDate(fromdate));
    //                    sqlcmd.Parameters.Add("@PostingDate", GetLowDate(fromdate));
    //                    sqlcmd.Parameters.Add("@DocDate", GetLowDate(fromdate));
    //                    sqlcmd.Parameters.Add("@ReferenceNo", dr["Voucher No"].ToString());
    //                    if (ddlSalesOffice.SelectedValue == "538")
    //                    {
    //                         fromwhcode = "SVDSPP03";
    //                    }
    //                    else
    //                    {
    //                         fromwhcode = "SVDSPP02";
    //                    }
    //                     ToWhsCode = dr["Wh Code"].ToString();
    //                    if (fromwhcode == ToWhsCode)
    //                    {
    //                        lblmsg.Text = "You don't have this permission,two warehouses are equal";
    //                        break;
    //                    }
    //                    else
    //                    {
    //                        sqlcmd.Parameters.Add("@FromWhsCode", fromwhcode);
    //                        sqlcmd.Parameters.Add("@ToWhsCode", dr["Wh Code"].ToString());
    //                        sqlcmd.Parameters.Add("@ItemCode", dr["Item Code"].ToString());
    //                        sqlcmd.Parameters.Add("@ItemName", dr["Item Name"].ToString());
    //                        sqlcmd.Parameters.Add("@Quantity", dr["Qty"].ToString());
    //                        sqlcmd.Parameters.Add("@Price", amount);
    //                        sqlcmd.Parameters.Add("@OcrCode", fromwhcode);
    //                        sqlcmd.Parameters.Add("@OcrCode2", dr["Category Code"].ToString());
    //                        sqlcmd.Parameters.Add("@Remarks", dr["Narration"].ToString());
    //                        sqlcmd.Parameters.Add("@B1Upload", B1Upload);
    //                        sqlcmd.Parameters.Add("@Processed", Processed);
    //                        string series = "21";
    //                        sqlcmd.Parameters.Add("@series", series);
    //                        SAPvdm.insert(sqlcmd);
    //                    }
    //                }
    //            }
    //        }
    //        if (dtST.Rows.Count > 0)
    //        {
    //            pnlHide.Visible = false;
    //            DataTable dtempty = new DataTable();
    //            grdReports.DataSource = dtempty;
    //            grdReports.DataBind();
    //            lblmsg.Text = "This Transaction already saved";
    //        }
    //        else
    //        {
    //            if (fromwhcode == ToWhsCode)
    //            {
    //                pnlHide.Visible = false;
    //                DataTable dtempty = new DataTable();
    //                grdReports.DataSource = dtempty;
    //                grdReports.DataBind();
    //                lblmsg.Text = "You don't have this permission,two warehouses are equal";
    //            }
    //            else
    //            {
    //                pnlHide.Visible = false;
    //                DataTable dtempty = new DataTable();
    //                grdReports.DataSource = dtempty;
    //                grdReports.DataBind();
    //                lblmsg.Text = "Successfully Saved";
    //            }
    //        }
    //        //}
    //    }
    //    catch (Exception ex)
    //    {
    //        lblmsg.Text = ex.ToString();
    //    }
    //}
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
            //ddlSalesOffice.Items.Insert(0, new ListItem("Cash Sale", "0"));
            //ddlSalesOffice.Items.Insert(0, new ListItem("Staff Sale", "1"));
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
            //ddlSalesOffice.Items.Insert(0, new ListItem("Cash Sale", "0"));
            //ddlSalesOffice.Items.Insert(0, new ListItem("Staff Sale", "1"));
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

            lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
            lblRoutName.Text = ddlSalesOffice.SelectedItem.Text;
            Session["xporttype"] = "TallyInward";
            Session["filename"] = ddlSalesOffice.SelectedItem.Text + " Tally Inward" + fromdate.ToString("dd/MM/yyyy");

            cmd = new MySqlCommand("SELECT branchdata.sno,branchdata.whcode,branchdata.branchcode,branchdata.stateid,  branchdata.TbranchName, statemastar.statename ,statemastar.statecode FROM branchdata INNER JOIN statemastar ON branchdata.stateid = statemastar.sno WHERE (branchdata.sno = @BranchID)");
            cmd.Parameters.AddWithValue("@Branchid", ddlSalesOffice.SelectedValue);
            DataTable dtbranch = vdm.SelectQuery(cmd).Tables[0];
            string to_statecode = "";
            string to_branchcode = "";
            string to_branchName = "";
            string fromstateid = "";
            string toCustomerCode = "";
            if (dtbranch.Rows.Count > 0)
            {
                to_statecode = dtbranch.Rows[0]["statecode"].ToString();
                to_branchcode = dtbranch.Rows[0]["branchcode"].ToString();
                to_branchName = dtbranch.Rows[0]["TbranchName"].ToString();
                fromstateid = dtbranch.Rows[0]["stateid"].ToString();
                toCustomerCode = dtbranch.Rows[0]["whcode"].ToString();
            }
            cmd = new MySqlCommand("SELECT branchdata.sno,branchdata.branchcode,branchdata.whcode,branchdata.stateid,  branchdata.TbranchName, statemastar.statename ,statemastar.statecode FROM branchdata INNER JOIN statemastar ON branchdata.stateid = statemastar.sno WHERE (branchdata.sno = @BranchID)");
            cmd.Parameters.AddWithValue("@Branchid", Session["branch"]);
            DataTable dt_frombranch = vdm.SelectQuery(cmd).Tables[0];
            string from_statecode = "";
            string from_branchName = "";
            string from_branchCode = "";
            string from_customerCode = "";
            if (dt_frombranch.Rows.Count > 0)
            {
                from_statecode = dt_frombranch.Rows[0]["statecode"].ToString();
                from_branchName = dt_frombranch.Rows[0]["TbranchName"].ToString();
                from_branchCode = dt_frombranch.Rows[0]["branchcode"].ToString();
                from_customerCode = dt_frombranch.Rows[0]["branchcode"].ToString();
            }
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
            string tostate = Session["stateid"].ToString();
            if (ddlsalestype.SelectedValue == "NonTax")
            {
                cmd = new MySqlCommand("SELECT productsdata.hsncode, productsdata.itemcode,productsdata.igst, productsdata.cgst,products_category.tcategory, productsdata.sgst, productsdata.tproduct, ROUND(SUM(tripsubdata.Qty), 2) AS qty,tripdata.dcno,tripdata.taxdcno,tripdata.taxdcno, tripdata.Sno, tripdata.I_Date, empmanage.UserName, branchproducts.unitprice, products_category.Categoryname FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN empmanage ON tripdata.EmpId = empmanage.Sno INNER JOIN branchproducts ON empmanage.Branch = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE  (tripdata.I_Date BETWEEN @d1 AND @d2) AND (empmanage.Branch = @BranchID) AND (tripdata.BranchID = @PlantID) GROUP BY productsdata.tproduct, branchproducts.unitprice");
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@PlantID", Session["branch"]);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@Type", "Agent");
                DataTable dtAgent = vdm.SelectQuery(cmd).Tables[0];
                Report.Columns.Add("Customer Name");
                Report.Columns.Add("Customer Code");

                Report.Columns.Add("Invoice No");
                Report.Columns.Add("Invoice Date");
                Report.Columns.Add("Ledger Type");
                Report.Columns.Add("HSN Code");
                Report.Columns.Add("Item Name");
                Report.Columns.Add("Item Code");
                Report.Columns.Add("Qty");
                Report.Columns.Add("Rate");
                Report.Columns.Add("TAX CODE");
                Report.Columns.Add("TAX%");
                Report.Columns.Add("Taxable Value");
                //Report.Columns.Add("SGST%");
                //Report.Columns.Add("SGST Amount");
                //Report.Columns.Add("CGST%");
                //Report.Columns.Add("CGST Amount");
                //Report.Columns.Add("IGST%");
                //Report.Columns.Add("IGST Amount");
                Report.Columns.Add("Net Value");
                Report.Columns.Add("Narration");
                int i = 1;
                string taxcode = "";
                if (dtAgent.Rows.Count > 0)
                {
                    foreach (DataRow branch in dtAgent.Rows)
                    {
                        if (branch["Igst"].ToString() == "0")
                        {
                            DataRow newrow = Report.NewRow();
                            if (ddlSalesOffice.SelectedValue == "306")
                            {
                                newrow["Invoice Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                            }
                            else
                            {
                                newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
                            }
                            if (ddltype.SelectedValue == "AR Invoice")
                            {
                                newrow["Customer Name"] = to_branchName;
                                newrow["Customer Code"] = toCustomerCode;
                            }
                            else
                            {
                                newrow["Customer Name"] = from_branchName;
                                newrow["Customer Code"] = from_customerCode;
                            }
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
                            newrow["Invoice No"] = from_branchCode + "/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "N/" + DCNO;
                            // newrow["Ledger Type"] = branch["sno"].ToString();
                            newrow["HSN Code"] = branch["hsncode"].ToString();
                            newrow["Item Name"] = branch["tproduct"].ToString();
                            newrow["Item Code"] = branch["itemcode"].ToString();
                            newrow["Qty"] = branch["qty"].ToString();
                            // newrow["Rate"] = "0";
                            double rate = 0;
                            double.TryParse(branch["unitprice"].ToString(), out rate);
                            string tcategory = "";
                            double tot_vatamount = 0;
                            double PAmount = 0;
                            double invval = 0;
                            double qty = 0;
                            double taxval = 0;
                            double.TryParse(branch["qty"].ToString(), out  qty);
                            if (fromstateid == tostate)
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
                                tcategory = branch["tcategory"].ToString() + "-CGST/SGST-" + to_statecode;
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
                                if (ddltype.SelectedValue == "AR Invoice")
                                {
                                    tcategory = "Sale of " + branch["Categoryname"].ToString() + " inter branches";
                                }
                                else
                                {
                                    tcategory = "Purchase of " + branch["Categoryname"].ToString() + " inter branches";

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
                                tot_vatamount = Math.Round(tot_vatamount, 2);
                                //newrow["Igst amount"] = tot_vatamount.ToString();
                            }
                            invval = Math.Round(invval, 2);
                            double netvalue = 0;
                            netvalue = invval + taxval;
                            netvalue = Math.Round(netvalue, 2);
                            newrow["TAX%"] = "0";
                            taxcode = "EXEMPT";
                            newrow["TAX CODE"] = taxcode;
                            double tot_amount = PAmount + tot_vatamount;
                            tot_amount = Math.Round(tot_amount, 2);
                            newrow["Net Value"] = tot_amount;
                            if (ddltype.SelectedValue == "AR Invoice")
                            {
                                newrow["Narration"] = "Being the sale of milk to  " + ddlSalesOffice.SelectedItem.Text + " vide invoice no " + branch["dcno"].ToString() + ",DC Date " + fromdate.AddDays(1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                            }
                            else
                            {
                                newrow["Narration"] = "Being the purchase of milk to  " + ddlSalesOffice.SelectedItem.Text + " vide invoice no " + branch["dcno"].ToString() + ",DC Date " + fromdate.AddDays(1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                            }
                            Report.Rows.Add(newrow);
                            i++;
                        }
                    }
                }
                cmd = new MySqlCommand("SELECT dispatch.Branch_ID,  dispatch.DispName, dispatch.sno, dispatch.BranchID, tripdata.I_Date, tripdata.Sno AS TripSno, dispatch.DispMode,  triproutes.Tripdata_sno FROM dispatch INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno  WHERE (dispatch.BranchID = @BranchID) AND (tripdata.I_Date BETWEEN @d1 AND @d2)and (dispatch.DispType ='SO') and (tripdata.Status<>'C') ORDER BY dispatch.sno");
                cmd.Parameters.AddWithValue("@SuperBranch", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                DataTable dtDispnames = vdm.SelectQuery(cmd).Tables[0];
                if (dtDispnames.Rows.Count > 0)
                {
                    foreach (DataRow drSub in dtDispnames.Rows)
                    {
                        if (drSub["DispMode"].ToString() == "" || drSub["DispMode"].ToString() == "SPL")
                        {
                        }
                        else
                        {
                            if (drSub["Branch_ID"].ToString() == ddlSalesOffice.SelectedValue)
                            {
                            }
                            else
                            {
                                cmd = new MySqlCommand("SELECT ff.TripID, Triproutes.RouteID, ff.Qty, ff.ProductId, Triproutes.Tripdata_sno, ff.I_Date, ff.tproduct, ff.hsncode, ff.igst, ff.cgst, ff.sgst, ff.UnitPrice, ff.DCNo,ff.taxdcno, ff.Categoryname FROM (SELECT  Tripdata_sno, RouteID, Sno FROM triproutes triproutes_1 WHERE (Tripdata_sno = @TripSno)) Triproutes INNER JOIN (SELECT TripID, Qty, ProductId, I_Date, tproduct, hsncode, igst, cgst, sgst, UnitPrice, Categoryname, DCNo,taxdcno FROM (SELECT tripdata.Sno AS TripID, tripsubdata.Qty, tripsubdata.ProductId, tripdata.I_Date, productsdata.hsncode, productsdata.igst, productsdata.cgst, productsdata.sgst, productsdata.UnitPrice, productsdata.tproduct, products_category.Categoryname, tripdata.DCNo,tripdata.taxdcno FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE  (tripdata.I_Date BETWEEN @starttime AND @endtime)) tripinfo) ff ON ff.TripID = Triproutes.Tripdata_sno");
                                cmd.Parameters.AddWithValue("@TripSno", drSub["TripSno"].ToString());
                                cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
                                cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
                                DataTable DtTripSubData = vdm.SelectQuery(cmd).Tables[0];
                                foreach (DataRow branch in DtTripSubData.Rows)
                                {
                                    if (branch["Igst"].ToString() == "0")
                                    {
                                        DataRow newrow = Report.NewRow();
                                        newrow["Customer Name"] = to_branchName;
                                        newrow["Customer Code"] = toCustomerCode;
                                        newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
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
                                        if (countdc > 999)
                                        {
                                            DCNO = "0" + countdc;
                                        }
                                        newrow["Invoice No"] = from_branchCode + "/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "N/" + DCNO;
                                        //newrow["Ledger Type"] = branch["sno"].ToSt    ring();
                                        newrow["HSN Code"] = branch["hsncode"].ToString();
                                        newrow["Item Name"] = branch["tproduct"].ToString();
                                        newrow["Item Code"] = branch["itemcode"].ToString();
                                        newrow["Qty"] = branch["Qty"].ToString();
                                        double rate = 0;
                                        double.TryParse(branch["unitprice"].ToString(), out rate);
                                        string tcategory = "";
                                        double tot_vatamount = 0;
                                        double PAmount = 0;
                                        double invval = 0;
                                        double qty = 0;
                                        double taxval = 0;
                                        double.TryParse(branch["qty"].ToString(), out  qty);
                                        if (fromstateid == tostate)
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
                                            tcategory = branch["tcategory"].ToString() + "-CGST/SGST-" + to_statecode;
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
                                            if (ddltype.SelectedValue == "AR Invoice")
                                            {
                                                tcategory = "Sale of " + branch["Categoryname"].ToString() + " inter branches";
                                            }
                                            else
                                            {
                                                tcategory = "Purchase of " + branch["Categoryname"].ToString() + " inter branches";

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
                                            tot_vatamount = Math.Round(tot_vatamount, 2);
                                            //newrow["Igst amount"] = tot_vatamount.ToString();
                                        }
                                        invval = Math.Round(invval, 2);
                                        double netvalue = 0;
                                        netvalue = invval + taxval;
                                        netvalue = Math.Round(netvalue, 2);
                                        double tot_amount = PAmount + tot_vatamount;
                                        tot_amount = Math.Round(tot_amount, 2);
                                        newrow["TAX%"] = "0";
                                        taxcode = "EXEMPT";
                                        newrow["TAX CODE"] = taxcode;
                                        newrow["Net Value"] = tot_amount;
                                        if (ddltype.SelectedValue == "AR Invoice")
                                        {
                                            newrow["Narration"] = "Being the sale of milk to  " + ddlSalesOffice.SelectedItem.Text + " vide invoice no " + branch["dcno"].ToString() + ",DC Date " + fromdate.AddDays(1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                                        }
                                        else
                                        {
                                            newrow["Narration"] = "Being the purchase of milk to  " + ddlSalesOffice.SelectedItem.Text + " vide invoice no " + branch["dcno"].ToString() + ",DC Date " + fromdate.AddDays(1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                                        }
                                        Report.Rows.Add(newrow);
                                        i++;
                                    }
                                }
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
                    lblmsg.Text = "No Indent Found";
                    grdReports.DataSource = Report;
                    grdReports.DataBind();
                }
            }
            else
            {
                cmd = new MySqlCommand("SELECT productsdata.hsncode,productsdata.itemcode, productsdata.igst, productsdata.cgst, productsdata.sgst, productsdata.tproduct, ROUND(SUM(tripsubdata.Qty), 2) AS qty,tripdata.dcno,tripdata.taxdcno, tripdata.Sno, tripdata.I_Date, empmanage.UserName, branchproducts.unitprice, products_category.Categoryname FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN empmanage ON tripdata.EmpId = empmanage.Sno INNER JOIN branchproducts ON empmanage.Branch = branchproducts.branch_sno AND productsdata.sno = branchproducts.product_sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE  (tripdata.I_Date BETWEEN @d1 AND @d2) AND (empmanage.Branch = @BranchID) AND (tripdata.BranchID = @PlantID) GROUP BY productsdata.tproduct, branchproducts.unitprice");
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@PlantID", Session["branch"]);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate).AddDays(-1));
                cmd.Parameters.AddWithValue("@Type", "Agent");
                DataTable dtAgent = vdm.SelectQuery(cmd).Tables[0];
                Report.Columns.Add("Customer Name");
                Report.Columns.Add("Customer Code");
                Report.Columns.Add("Invoice No");
                Report.Columns.Add("Invoice Date");
                Report.Columns.Add("Ledger Type");
                Report.Columns.Add("HSN Code");
                Report.Columns.Add("Item Name");
                Report.Columns.Add("Item Code");
                Report.Columns.Add("Qty");
                Report.Columns.Add("Rate");
                Report.Columns.Add("TAX%");
                Report.Columns.Add("TAX CODE");
                Report.Columns.Add("Taxable Value");

                //Report.Columns.Add("SGST%");
                //Report.Columns.Add("SGST Amount");
                //Report.Columns.Add("CGST%");
                //Report.Columns.Add("CGST Amount");
                //Report.Columns.Add("IGST%");
                //Report.Columns.Add("IGST Amount");
                Report.Columns.Add("Net Value");
                Report.Columns.Add("Narration");
                int i = 1;
                string taxcode = "";
                if (dtAgent.Rows.Count > 0)
                {
                    foreach (DataRow branch in dtAgent.Rows)
                    {
                        if (branch["Igst"].ToString() != "0")
                        {
                            DataRow newrow = Report.NewRow();
                            if (ddlSalesOffice.SelectedValue == "306")
                            {
                                newrow["Invoice Date"] = fromdate.AddDays(1).ToString("dd-MMM-yyyy");
                            }
                            else
                            {
                                newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
                            }
                            if (ddltype.SelectedValue == "AR Invoice")
                            {
                                newrow["Customer Name"] = to_branchName;
                                newrow["Customer Code"] = toCustomerCode;
                            }
                            else
                            {
                                newrow["Customer Name"] = from_branchName;
                                newrow["Customer Code"] = from_customerCode;
                            }
                            string DCNO = "0";
                            int countdc = 0;
                            int.TryParse(branch["taxdcno"].ToString(), out countdc);
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
                            newrow["Invoice No"] = from_branchCode + "/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                            // newrow["Ledger Type"] = branch["sno"].ToString();
                            newrow["HSN Code"] = branch["hsncode"].ToString();
                            newrow["Item Name"] = branch["tproduct"].ToString();
                            newrow["Item Code"] = branch["itemcode"].ToString();
                            newrow["Qty"] = branch["qty"].ToString();
                            // newrow["Rate"] = "0";
                            double rate = 0;
                            double.TryParse(branch["unitprice"].ToString(), out rate);
                            string tcategory = "";
                            double tot_vatamount = 0;
                            double PAmount = 0;
                            double invval = 0;
                            double qty = 0;
                            double taxval = 0;
                            double.TryParse(branch["qty"].ToString(), out  qty);
                            if (fromstateid == tostate)
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
                                tcategory = branch["tcategory"].ToString() + "-CGST/SGST-" + to_statecode;
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

                                if (branch["cgst"].ToString() != "0")
                                {
                                    double cgsttax = Convert.ToDouble(branch["cgst"].ToString());
                                    cgsttax = cgsttax + cgsttax;
                                    taxcode = "CGST" + cgsttax + "";
                                    newrow["TAX%"] = branch["cgst"].ToString();
                                }
                                newrow["TAX CODE"] = taxcode;
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
                                if (ddltype.SelectedValue == "AR Invoice")
                                {
                                    tcategory = "Sale of " + branch["Categoryname"].ToString() + " inter branches";
                                }
                                else
                                {
                                    tcategory = "Purchase of " + branch["Categoryname"].ToString() + " inter branches";

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
                                tot_vatamount = Math.Round(tot_vatamount, 2);
                                //newrow["Igst amount"] = tot_vatamount.ToString();
                                if (branch["Igst"].ToString() != "0")
                                {
                                    double igsttax = Convert.ToDouble(branch["Igst"].ToString());
                                    taxcode = "IGST" + branch["Igst"].ToString() + "";
                                    newrow["TAX%"] = branch["Igst"].ToString();
                                }
                                newrow["TAX CODE"] = taxcode;
                            }
                            invval = Math.Round(invval, 2);
                            double netvalue = 0;
                            netvalue = invval + taxval;
                            netvalue = Math.Round(netvalue, 2);
                            double tot_amount = PAmount + tot_vatamount;
                            tot_amount = Math.Round(tot_amount, 2);
                            newrow["Net Value"] = tot_amount;
                            if (ddltype.SelectedValue == "AR Invoice")
                            {
                                newrow["Narration"] = "Being the sale of milk to  " + ddlSalesOffice.SelectedItem.Text + " vide invoice no " + branch["dcno"].ToString() + ",DC Date " + fromdate.AddDays(1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                            }
                            else
                            {
                                newrow["Narration"] = "Being the purchase of milk to  " + ddlSalesOffice.SelectedItem.Text + " vide invoice no " + branch["dcno"].ToString() + ",DC Date " + fromdate.AddDays(1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                            }
                            Report.Rows.Add(newrow);
                            i++;
                        }
                    }
                }
                cmd = new MySqlCommand("SELECT dispatch.Branch_ID,  dispatch.DispName, dispatch.sno, dispatch.BranchID, tripdata.I_Date, tripdata.Sno AS TripSno, dispatch.DispMode,  triproutes.Tripdata_sno FROM dispatch INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno  WHERE (dispatch.BranchID = @BranchID) AND (tripdata.I_Date BETWEEN @d1 AND @d2)and (dispatch.DispType ='SO') and (tripdata.Status<>'C') ORDER BY dispatch.sno");
                cmd.Parameters.AddWithValue("@SuperBranch", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate.AddDays(-1)));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate.AddDays(-1)));
                DataTable dtDispnames = vdm.SelectQuery(cmd).Tables[0];
                if (dtDispnames.Rows.Count > 0)
                {
                    foreach (DataRow drSub in dtDispnames.Rows)
                    {
                        if (drSub["DispMode"].ToString() == "" || drSub["DispMode"].ToString() == "SPL")
                        {
                        }
                        else
                        {
                            if (drSub["Branch_ID"].ToString() == ddlSalesOffice.SelectedValue)
                            {
                            }
                            else
                            {
                                cmd = new MySqlCommand("SELECT ff.TripID, Triproutes.RouteID, ff.Qty, ff.ProductId, Triproutes.Tripdata_sno, ff.I_Date, ff.tproduct, ff.hsncode, ff.igst, ff.cgst, ff.sgst, ff.UnitPrice, ff.DCNo,ff.taxdcno, ff.Categoryname FROM (SELECT  Tripdata_sno, RouteID, Sno FROM triproutes triproutes_1 WHERE (Tripdata_sno = @TripSno)) Triproutes INNER JOIN (SELECT TripID, Qty, ProductId, I_Date, tproduct, hsncode, igst, cgst, sgst, UnitPrice, Categoryname, DCNo,taxdcno, FROM (SELECT tripdata.Sno AS TripID, tripsubdata.Qty, tripsubdata.ProductId, tripdata.I_Date, productsdata.hsncode, productsdata.igst, productsdata.cgst, productsdata.sgst, productsdata.UnitPrice, productsdata.tproduct, products_category.Categoryname, tripdata.DCNo,tripdata.taxdcno FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE  (tripdata.I_Date BETWEEN @starttime AND @endtime)) tripinfo) ff ON ff.TripID = Triproutes.Tripdata_sno");
                                cmd.Parameters.AddWithValue("@TripSno", drSub["TripSno"].ToString());
                                cmd.Parameters.AddWithValue("@starttime", GetLowDate(fromdate.AddDays(-1)));
                                cmd.Parameters.AddWithValue("@endtime", GetHighDate(fromdate.AddDays(-1)));
                                DataTable DtTripSubData = vdm.SelectQuery(cmd).Tables[0];
                                foreach (DataRow branch in DtTripSubData.Rows)
                                {
                                    if (branch["Igst"].ToString() != "0")
                                    {
                                        DataRow newrow = Report.NewRow();
                                        newrow["Customer Name"] = to_branchName;
                                        newrow["Customer Code"] = toCustomerCode;
                                        newrow["Invoice Date"] = fromdate.ToString("dd-MMM-yyyy");
                                        string DCNO = "0";
                                        int countdc = 0;
                                        int.TryParse(branch["taxdcno"].ToString(), out countdc);
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
                                        newrow["Invoice No"] = from_branchCode + "/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "T/" + DCNO;
                                        //newrow["Ledger Type"] = branch["sno"].ToSt    ring();
                                        newrow["HSN Code"] = branch["hsncode"].ToString();
                                        newrow["Item Code"] = branch["itemcode"].ToString();
                                        newrow["Item Name"] = branch["tproduct"].ToString();
                                        newrow["Qty"] = branch["Qty"].ToString();
                                        double rate = 0;
                                        double.TryParse(branch["unitprice"].ToString(), out rate);
                                        string tcategory = "";
                                        double tot_vatamount = 0;
                                        double PAmount = 0;
                                        double invval = 0;
                                        double qty = 0;
                                        double taxval = 0;
                                        double.TryParse(branch["qty"].ToString(), out  qty);
                                        if (fromstateid == tostate)
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
                                            tcategory = branch["tcategory"].ToString() + "-CGST/SGST-" + to_statecode;
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
                                            if (branch["cgst"].ToString() != "0")
                                            {
                                                double cgsttax = Convert.ToDouble(branch["cgst"].ToString());
                                                cgsttax = cgsttax + cgsttax;
                                                taxcode = "CGST" + cgsttax + "";
                                                newrow["TAX%"] = branch["cgst"].ToString();
                                            }
                                            newrow["TAX CODE"] = taxcode;
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
                                            if (ddltype.SelectedValue == "AR Invoice")
                                            {
                                                tcategory = "Sale of " + branch["Categoryname"].ToString() + " inter branches";
                                            }
                                            else
                                            {
                                                tcategory = "Purchase of " + branch["Categoryname"].ToString() + " inter branches";

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
                                            tot_vatamount = Math.Round(tot_vatamount, 2);
                                            //newrow["Igst amount"] = tot_vatamount.ToString();
                                            if (branch["Igst"].ToString() != "0")
                                            {
                                                double igsttax = Convert.ToDouble(branch["Igst"].ToString());
                                                taxcode = "IGST" + branch["Igst"].ToString() + "";
                                                newrow["TAX%"] = branch["Igst"].ToString();
                                            }
                                            newrow["TAX CODE"] = taxcode;
                                        }
                                        invval = Math.Round(invval, 2);
                                        double netvalue = 0;
                                        netvalue = invval + taxval;
                                        netvalue = Math.Round(netvalue, 2);
                                        double tot_amount = PAmount + tot_vatamount;
                                        tot_amount = Math.Round(tot_amount, 2);
                                        newrow["Net Value"] = tot_amount;
                                        if (ddltype.SelectedValue == "AR Invoice")
                                        {
                                            newrow["Narration"] = "Being the sale of milk to  " + ddlSalesOffice.SelectedItem.Text + " vide invoice no " + branch["dcno"].ToString() + ",DC Date " + fromdate.AddDays(1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                                        }
                                        else
                                        {
                                            newrow["Narration"] = "Being the purchase of milk to  " + ddlSalesOffice.SelectedItem.Text + " vide invoice no " + branch["dcno"].ToString() + ",DC Date " + fromdate.AddDays(1).ToString("dd/MM/yyyy") + ",Emp Name " + Session["EmpName"].ToString();
                                        }
                                        Report.Rows.Add(newrow);
                                        i++;
                                    }
                                }
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
    protected void btn_save_click(object sender, EventArgs e)
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
            string ToWhsCode = "";
            string fromwhcode = "";
            if (ddlSalesOffice.SelectedValue == "538")
            {
                fromwhcode = "SVDSPP03";
            }
            else
            {
                fromwhcode = "SVDSPP02";
            }
            foreach (DataRow dr in dt.Rows)
            {
                string itemcode = dr["Item Code"].ToString();
                string cardcode = dr["Customer Code"].ToString();
                if (itemcode == "")
                {
                }
                else if (cardcode == "")
                {
                }
                else
                {
                    sqlcmd = new SqlCommand("SELECT * FROM EMROPOR WHERE (TaxDate BETWEEN @d1 AND @d2) AND (ReferenceNo = @ReferenceNo) AND (ItemCode = @ItemCode) AND (WhsCode = @WhsCode)");
                    sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
                    sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
                    sqlcmd.Parameters.Add("@ReferenceNo", dr["Invoice No"].ToString());
                    sqlcmd.Parameters.Add("@WhsCode", fromwhcode);
                    sqlcmd.Parameters.Add("@ItemCode", dr["Item Code"].ToString());
                    DataTable dtPCH = SAPvdm.SelectQuery(sqlcmd).Tables[0];
                    if (dtPCH.Rows.Count > 0)
                    {
                    }
                    else
                    {
                        sqlcmd = new SqlCommand("insert into EMROPOR (CreateDate, CardCode, CardName, TaxDate, DocDate, DocDueDate, ReferenceNo, ItemCode, Dscription, WhsCode, Quantity, Price, OcrCode, TaxCode, PURCHASETYPE, B1Upload, Processed,remarks,VAT_Percent) values (@CreateDate, @CardCode, @CardName, @TaxDate, @DocDate, @DocDueDate,  @ReferenceNo, @ItemCode, @Dscription, @WhsCode, @Quantity, @Price, @OcrCode, @TaxCode, @purchasetype, @B1Upload, @Processed,@remarks,@TAXPER)");
                        sqlcmd.Parameters.Add("@CreateDate", CreateDate);
                        sqlcmd.Parameters.Add("@CardCode", dr["Customer Code"].ToString());
                        sqlcmd.Parameters.Add("@CardName", dr["Customer Name"].ToString());
                        sqlcmd.Parameters.Add("@TaxDate", GetLowDate(fromdate));
                        sqlcmd.Parameters.Add("@DocDate", GetLowDate(fromdate));
                        sqlcmd.Parameters.Add("@DocDueDate", GetLowDate(fromdate));
                        //cmd.Parameters.AddWithValue("@DiscPercent", dr["DISCOUNT %"].ToString());
                        sqlcmd.Parameters.Add("@ReferenceNo", dr["Invoice No"].ToString());
                        sqlcmd.Parameters.Add("@ItemCode", dr["Item Code"].ToString());
                        sqlcmd.Parameters.Add("@Dscription", dr["Item Name"].ToString());
                        sqlcmd.Parameters.Add("@WhsCode", fromwhcode);
                        double qty = 0;
                        double.TryParse(dr["Qty"].ToString(), out qty);
                        sqlcmd.Parameters.Add("@Quantity", qty);
                        double price = 0;
                        double.TryParse(dr["Rate"].ToString(), out price);
                        sqlcmd.Parameters.Add("@Price", price);
                        sqlcmd.Parameters.Add("@OcrCode", fromwhcode);
                        sqlcmd.Parameters.Add("@TaxCode", dr["TAXCODE"].ToString());
                        sqlcmd.Parameters.Add("@TAXPER", dr["TAX%"].ToString());
                        string B1Upload = "N";
                        string Processed = "N";
                        string purchasetype = "93";
                        sqlcmd.Parameters.Add("@purchasetype", purchasetype);
                        sqlcmd.Parameters.Add("@B1Upload", B1Upload);
                        sqlcmd.Parameters.Add("@Processed", Processed);
                        sqlcmd.Parameters.Add("@remarks", dr["Narration"].ToString());
                        if (qty == 0.0)
                        {
                        }
                        else
                        {
                            SAPvdm.insert(sqlcmd);
                        }
                    }
                }
            }
            pnlHide.Visible = false;
            lblmsg.Text = "Saved successfully";
            DataTable dtempty = new DataTable();
            grdReports.DataSource = dtempty;
            grdReports.DataBind();


            //protected void BtnSave_Click(object sender, EventArgs e)
            //{
            //    try
            //    {
            //        vdm = new VehicleDBMgr();
            //        DateTime CreateDate = VehicleDBMgr.GetTime(vdm.conn);
            //        SAPdbmanger SAPvdm = new SAPdbmanger();
            //        DateTime fromdate = DateTime.Now;
            //        DataTable dt = (DataTable)Session["xportdata"];
            //        string[] dateFromstrig = txtFromdate.Text.Split(' ');
            //        if (dateFromstrig.Length > 1)
            //        {
            //            if (dateFromstrig[0].Split('-').Length > 0)
            //            {
            //                string[] dates = dateFromstrig[0].Split('-');
            //                string[] times = dateFromstrig[1].Split(':');
            //                fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
            //            }
            //        }
            //        if (ddlSalesOffice.SelectedValue == "306")
            //        {
            //            fromdate = fromdate.AddDays(1);
            //        }
            //        else
            //        {
            //            fromdate = fromdate;
            //        }
            //        //cmd = new MySqlCommand("SELECT sno, BranchName, whcode, ladger_dr_code, tax, ntax, ledger_jv_code FROM branchdata WHERE (sno = @BranchID)");
            //        //cmd.Parameters.AddWithValue("@BranchID", ddlSalesOffice.SelectedValue);
            //        //DataTable dtwhscode = vdm.SelectQuery(cmd).Tables[0];
            //        //sqlcmd = new SqlCommand("SELECT CreateDate, PostingDate, DocDate, ReferenceNo AS Processed, Series FROM EMROWTR WHERE (PostingDate BETWEEN @d1 AND @d2) AND (ToWhsCode=@ToWhsCode)");
            //        //sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
            //        //sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
            //        //sqlcmd.Parameters.Add("@ToWhsCode", dtwhscode.Rows[0]["whcode"].ToString());
            //        //DataTable dtinward = SAPvdm.SelectQuery(sqlcmd).Tables[0];
            //        //if (dtinward.Rows.Count > 0)
            //        //{
            //        //    lblmsg.Text = "This Transaction already saved";
            //        //}
            //        //else
            //        //{
            //        DataTable dtST = new DataTable();
            //        string ToWhsCode = "";
            //        string fromwhcode = "";
            //        foreach (DataRow dr in dt.Rows)
            //        {
            //            double amount = 10;
            //            string B1Upload = "N";
            //            string Processed = "N";
            //            string ledgercode = dr["Item Code"].ToString();
            //            if (ledgercode == "")
            //            {
            //            }
            //            else
            //            {
            //                //////string CategoryCode = dr["Category Code"].ToString();
            //                //////if (CategoryCode == "P0001")
            //                //////{
            //                //////    sqlcmd = new SqlCommand("Insert into EMROIGN (CreateDate,PostingDate,DocDate,ReferenceNo,ItemCode,ItemName,Quantity,WhsCode,Price,series,OcrCode,Remarks,B1Upload,Processed,OcrCode2) values (@CreateDate,@PostingDate,@DocDate,@ReferenceNo,@ItemCode,@ItemName,@Quantity,@WhsCode,@Price,@series,@OcrCode,@Remarks,@B1Upload,@Processed,@OcrCode2)");
            //                //////    sqlcmd.Parameters.Add("@CreateDate", GetLowDate(fromdate));
            //                //////    sqlcmd.Parameters.Add("@PostingDate", GetLowDate(fromdate));
            //                //////    sqlcmd.Parameters.Add("@DocDate", GetLowDate(fromdate));
            //                //////    sqlcmd.Parameters.Add("@ReferenceNo", dr["Voucher No"].ToString());
            //                //////    sqlcmd.Parameters.Add("@ItemCode", dr["Item Code"].ToString());
            //                //////    sqlcmd.Parameters.Add("@ItemName", dr["Item Name"].ToString());
            //                //////    sqlcmd.Parameters.Add("@Quantity", dr["Qty"].ToString());
            //                //////    sqlcmd.Parameters.Add("@WhsCode", dr["Wh Code"].ToString());
            //                //////    sqlcmd.Parameters.Add("@Price", amount);
            //                //////    string series = "19";
            //                //////    sqlcmd.Parameters.Add("@series", series);
            //                //////    sqlcmd.Parameters.Add("@OcrCode", dr["Wh Code"].ToString());
            //                //////    sqlcmd.Parameters.Add("@OcrCode2", dr["Category Code"].ToString());
            //                //////    sqlcmd.Parameters.Add("@Remarks", dr["Narration"].ToString());
            //                //////    sqlcmd.Parameters.Add("@B1Upload", B1Upload);
            //                //////    sqlcmd.Parameters.Add("@Processed", Processed);
            //                //////    SAPvdm.insert(sqlcmd);
            //                //////}
            //                sqlcmd = new SqlCommand("SELECT CreateDate, PostingDate, DocDate, ReferenceNo AS Processed, Series FROM EMROWTR WHERE (PostingDate BETWEEN @d1 AND @d2) AND (ItemCode=@ItemCode) AND (ReferenceNo = @ReferenceNo)");
            //                sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
            //                sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
            //                sqlcmd.Parameters.Add("@ReferenceNo", dr["Voucher No"].ToString());
            //                sqlcmd.Parameters.Add("@ItemCode", dr["Item Code"].ToString());
            //                dtST = SAPvdm.SelectQuery(sqlcmd).Tables[0];
            //                if (dtST.Rows.Count > 0)
            //                {
            //                    lblmsg.Text = "This Transaction already saved";
            //                    break;
            //                }
            //                else
            //                {
            //                    sqlcmd = new SqlCommand("Insert into EMROWTR (CreateDate,PostingDate,DocDate,ReferenceNo,FromWhsCode,ToWhsCode,ItemCode,ItemName,Quantity,Price,OcrCode,OcrCode2,Remarks,B1Upload,Processed,series) values (@CreateDate,@PostingDate,@DocDate,@ReferenceNo,@FromWhsCode,@ToWhsCode,@ItemCode,@ItemName,@Quantity,@Price,@OcrCode,@OcrCode2,@Remarks,@B1Upload,@Processed,@series)");
            //                    sqlcmd.Parameters.Add("@CreateDate", GetLowDate(fromdate));
            //                    sqlcmd.Parameters.Add("@PostingDate", GetLowDate(fromdate));
            //                    sqlcmd.Parameters.Add("@DocDate", GetLowDate(fromdate));
            //                    sqlcmd.Parameters.Add("@ReferenceNo", dr["Voucher No"].ToString());
            //                    if (ddlSalesOffice.SelectedValue == "538")
            //                    {
            //                         fromwhcode = "SVDSPP03";
            //                    }
            //                    else
            //                    {
            //                         fromwhcode = "SVDSPP02";
            //                    }
            //                     ToWhsCode = dr["Wh Code"].ToString();
            //                    if (fromwhcode == ToWhsCode)
            //                    {
            //                        lblmsg.Text = "You don't have this permission,two warehouses are equal";
            //                        break;
            //                    }
            //                    else
            //                    {
            //                        sqlcmd.Parameters.Add("@FromWhsCode", fromwhcode);
            //                        sqlcmd.Parameters.Add("@ToWhsCode", dr["Wh Code"].ToString());
            //                        sqlcmd.Parameters.Add("@ItemCode", dr["Item Code"].ToString());
            //                        sqlcmd.Parameters.Add("@ItemName", dr["Item Name"].ToString());
            //                        sqlcmd.Parameters.Add("@Quantity", dr["Qty"].ToString());
            //                        sqlcmd.Parameters.Add("@Price", amount);
            //                        sqlcmd.Parameters.Add("@OcrCode", fromwhcode);
            //                        sqlcmd.Parameters.Add("@OcrCode2", dr["Category Code"].ToString());
            //                        sqlcmd.Parameters.Add("@Remarks", dr["Narration"].ToString());
            //                        sqlcmd.Parameters.Add("@B1Upload", B1Upload);
            //                        sqlcmd.Parameters.Add("@Processed", Processed);
            //                        string series = "21";
            //                        sqlcmd.Parameters.Add("@series", series);
            //                        SAPvdm.insert(sqlcmd);
            //                    }
            //                }
            //            }
            //        }
            //        if (dtST.Rows.Count > 0)
            //        {
            //            pnlHide.Visible = false;
            //            DataTable dtempty = new DataTable();
            //            grdReports.DataSource = dtempty;
            //            grdReports.DataBind();
            //            lblmsg.Text = "This Transaction already saved";
            //        }
            //        else
            //        {
            //            if (fromwhcode == ToWhsCode)
            //            {
            //                pnlHide.Visible = false;
            //                DataTable dtempty = new DataTable();
            //                grdReports.DataSource = dtempty;
            //                grdReports.DataBind();
            //                lblmsg.Text = "You don't have this permission,two warehouses are equal";
            //            }
            //            else
            //            {
            //                pnlHide.Visible = false;
            //                DataTable dtempty = new DataTable();
            //                grdReports.DataSource = dtempty;
            //                grdReports.DataBind();
            //                lblmsg.Text = "Successfully Saved";
            //            }
            //        }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
            pnlHide.Visible = false;
        }
    }
}