using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using ClosedXML.Excel;
using System.IO;
using System.Data.SqlClient;
public partial class SapProduction : System.Web.UI.Page
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
                lblTitle.Text = Session["TitleName"].ToString();
                txtfromdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                //txttodate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
            }
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
    void GetReport()
    {
        try
        {
            lblmsg.Text = "";
            Report = new DataTable();
            pnlHide.Visible = true;
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

            DateTime ServerDateCurrentdate = VehicleDBMgr.GetTime(vdm.conn);
            DateTime dtapril = new DateTime();
            DateTime dtmarch = new DateTime();
            int currentyear = fromdate.Year;
            int nextyear = fromdate.Year + 1;
            if (fromdate.Month > 3)
            {
                string apr = "4/1/" + currentyear;
                dtapril = DateTime.Parse(apr);
                string march = "3/31/" + nextyear;
                dtmarch = DateTime.Parse(march);
            }
            if (fromdate.Month <= 3)
            {
                string apr = "4/1/" + (currentyear - 1);
                dtapril = DateTime.Parse(apr);
                string march = "3/31/" + (nextyear - 1);
                dtmarch = DateTime.Parse(march);
            }
            string date = fromdate.ToString("dd/MM/yy");
            string[] str = date.Split('/');
            string dtdate = str[0].ToString();
            string month = str[1].ToString();
            string year = str[2].ToString();

            string dmarch = dtmarch.ToString("dd/MM/yy");
            string[] strm = dmarch.Split('/');
            string dtmarchdate = strm[0].ToString();
            string marchmonth = strm[1].ToString();
            string marchyear = strm[2].ToString();

            string dapril = dtapril.ToString("dd/MM/yy");
            string[] stra = dapril.Split('/');
            string dtaprildate = stra[0].ToString();
            string aprilmonth = stra[1].ToString();
            string aprilyear = stra[2].ToString();

            cmd = new MySqlCommand("SELECT    branchcode FROM branchdata WHERE  (sno = @branchid)");
            cmd.Parameters.AddWithValue("@branchid", Session["branch"]);
            DataTable dtbranch = vdm.SelectQuery(cmd).Tables[0];
            string branchcode = "";
            if (dtbranch.Rows.Count > 0)
            {
                branchcode = dtbranch.Rows[0]["branchcode"].ToString();//  d dr["branchcode"].ToString();
            }
            string refno = "" + branchcode + "/" + aprilyear + "" + marchyear + "/" + dtdate + "" + month + "";
            lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
            Session["filename"] = "TOTAL DC REPORT";
            cmd = new MySqlCommand("SELECT TripInfo.Sno, TripInfo.DCNo,ProductInfo.ProductName,ProductInfo.categorycode,ProductInfo.Categoryname,ProductInfo.UnitPrice, ProductInfo.Qty,ProductInfo.Productid,ProductInfo.Itemcode, TripInfo.I_Date, TripInfo.VehicleNo, TripInfo.Status,TripInfo.whcode,TripInfo.DispName, TripInfo.DispType, TripInfo.DispMode FROM (SELECT tripdata.Sno, tripdata.DCNo, tripdata.I_Date, tripdata.VehicleNo, tripdata.Status, dispatch.DispName, dispatch.DispType, dispatch.DispMode,branchdata.whcode FROM            branchdata INNER JOIN dispatch ON branchdata.sno = dispatch.Branch_Id INNER JOIN triproutes ON dispatch.sno = triproutes.RouteID INNER JOIN tripdata ON triproutes.Tripdata_sno = tripdata.Sno WHERE        (dispatch.Branch_Id = @branch) AND (tripdata.AssignDate BETWEEN @d1 AND @d2)) TripInfo INNER JOIN (SELECT Categoryname,categorycode, ProductName, Sno, Qty,Productid,Itemcode,UnitPrice FROM (SELECT products_category.Categoryname,products_category.categorycode, productsdata.ProductName,productsdata.sno as Productid, productsdata.Itemcode,productsdata.UnitPrice,tripdata_1.Sno, tripsubdata.Qty FROM            tripdata tripdata_1 INNER JOIN tripsubdata ON tripdata_1.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata_1.AssignDate BETWEEN @d1 AND @d2)) TripSubInfo) ProductInfo ON TripInfo.Sno = ProductInfo.Sno");
            cmd.Parameters.AddWithValue("@branch", Session["branch"]);
            cmd.Parameters.AddWithValue("@SOID", Session["branch"]);
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            DataTable dtble = vdm.SelectQuery(cmd).Tables[0];
            cmd = new MySqlCommand("SELECT productsdata.sno,productsdata.Itemcode,products_category.Categoryname, products_subcategory.SubCatName, branchproducts.Rank, productsdata.ProductName, branchproducts.branch_sno FROM tripdata INNER JOIN tripsubdata ON tripdata.Sno = tripsubdata.Tripdata_sno INNER JOIN productsdata ON tripsubdata.ProductId = productsdata.sno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (tripdata.AssignDate BETWEEN @d1 AND @d2) AND (branchproducts.branch_sno = @Branch) AND (tripdata.BranchID = @BranchID) GROUP BY productsdata.ProductName ORDER BY branchproducts.Rank");
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            cmd.Parameters.AddWithValue("@BranchID", Session["branch"].ToString());
            cmd.Parameters.AddWithValue("@Branch", Session["branch"].ToString());
            DataTable produtstbl = vdm.SelectQuery(cmd).Tables[0];
            if (produtstbl.Rows.Count > 0)
            {
                DataView view = new DataView(dtble);
                DataTable distinctproducts = view.ToTable(true, "Productid", "Categoryname");
                Report = new DataTable();
                Report.Columns.Add("SNo");
                Report.Columns.Add("CreateDate");
                Report.Columns.Add("PostingDate");
                Report.Columns.Add("DocDate");
                Report.Columns.Add("WhsCode");
                Report.Columns.Add("RefNo");
                Report.Columns.Add("OcrCode");
                Report.Columns.Add("OcrCode2");
                Report.Columns.Add("ItemName");
                Report.Columns.Add("ItemCode");
                Report.Columns.Add("Production Quantity");
                Report.Columns.Add("Price");
                Report.Columns.Add("Remarks");
                //DataTable distincttable = view.ToTable(true, "Batter", "Chapathi", "Chikki", "Icecream", "PAROTA", "Rasagulla", "Malailaddu", "KALAKANDA");
                int i = 1;

                string ProductName = "";
                string Itemcode = "";
                string UnitPrice = "";
                string WhsCode = "";
                string categorycode = "";
                foreach (DataRow dr in produtstbl.Rows)
                {
                    //if (dr["Categoryname"].ToString() == "Batter" || dr["Categoryname"].ToString() == "Chapathi" || dr["Categoryname"].ToString() == "Chikki" || dr["Categoryname"].ToString() == "Icecream" || dr["Categoryname"].ToString() == "PAROTA" || dr["Categoryname"].ToString() == "Rasagulla" || dr["Categoryname"].ToString() == "KALAKANDA" || dr["Categoryname"].ToString() == "Malailaddu")
                    //{
                    double totalqty = 0;
                    DataRow newrow = Report.NewRow();
                    foreach (DataRow drproduct in dtble.Select("Productid='" + dr["sno"].ToString() + "'"))
                    {
                        double AssignQty = 0;
                        double.TryParse(drproduct["Qty"].ToString(), out AssignQty); ;
                        ProductName = drproduct["ProductName"].ToString();
                        Itemcode = drproduct["Itemcode"].ToString();
                        UnitPrice = drproduct["UnitPrice"].ToString();
                        WhsCode = drproduct["whcode"].ToString();
                        categorycode = drproduct["categorycode"].ToString();
                        totalqty += AssignQty;
                    }
                    newrow["SNo"] = i++;
                    newrow["ItemName"] = ProductName;
                    newrow["ItemCode"] = Itemcode;
                    newrow["Production Quantity"] = totalqty;
                    newrow["Price"] = UnitPrice;
                    newrow["WhsCode"] = WhsCode;
                    newrow["RefNo"] = refno;
                    DateTime createdate = Convert.ToDateTime(fromdate).AddDays(1);
                    newrow["CreateDate"] = ServerDateCurrentdate.ToString(("dd/MM/yyyy"));
                    newrow["PostingDate"] = createdate.ToString(("dd/MM/yyyy")); ;
                    newrow["DocDate"] = createdate.ToString(("dd/MM/yyyy"));
                    newrow["Remarks"] = "";
                    newrow["OcrCode2"] = categorycode;
                    newrow["OcrCode"] = WhsCode;
                    Report.Rows.Add(newrow);
                    //}
                }
                grdReports.DataSource = Report;
                grdReports.DataBind();
                Session["xportdata"] = Report;
            }
            else
            {
                pnlHide.Visible = false;
                lblmsg.Text = "No DC Found";
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
            DateTime ServerDateCurrentdate = VehicleDBMgr.GetTime(vdm.conn);
            fromdate = fromdate.AddDays(1);
            if (dt.Rows.Count > 0)
            {
                DateTime doe = DateTime.Now;
                int i = 1;
                foreach (DataRow dr in dt.Rows)
                {

                    string ocrcode2 = "";
                    sqlcmd = new SqlCommand("SELECT PostingDate,DocDate FROM EMROIGN WHERE DocDate BETWEEN @d1 and @d2 AND ReferenceNo=@rno AND ItemCode=@ItemCode AND ItemName=@ItemName and WhsCode=@WhsCode");
                    sqlcmd.Parameters.Add("@d1", GetLowDate(fromdate));
                    sqlcmd.Parameters.Add("@d2", GetHighDate(fromdate));
                    sqlcmd.Parameters.Add("@rno", dr["RefNo"].ToString());
                    sqlcmd.Parameters.Add("@ItemCode", dr["ItemCode"].ToString());
                    sqlcmd.Parameters.Add("@ItemName", dr["ItemName"].ToString());
                    sqlcmd.Parameters.Add("@WhsCode", dr["WhsCode"].ToString());
                    DataTable dtSAPproduction = SAPvdm.SelectQuery(sqlcmd).Tables[0];
                    if (dtSAPproduction.Rows.Count > 0)
                    {
                        lblmsg.Text = "This date data already Saved";
                    }
                    else
                    {
                        sqlcmd = new SqlCommand("Insert into EMROIGN (CreateDate,PostingDate,DocDate,ReferenceNo,ItemCode,ItemName,Quantity,WhsCode,Price,OcrCode,Remarks,B1Upload,Processed,Series,OcrCode2) values (@CreateDate,@PostingDate,@DocDate,@ReferenceNo,@ItemCode,@ItemName,@Quantity,@WhsCode,@Price,@OcrCode,@Remarks,@B1Upload,@Processed,@Series,@OcrCode2)");
                        sqlcmd.Parameters.Add("@CreateDate", ServerDateCurrentdate);
                        sqlcmd.Parameters.Add("@PostingDate", fromdate);
                        sqlcmd.Parameters.Add("@DocDate", fromdate);
                        sqlcmd.Parameters.Add("@ReferenceNo", dr["RefNo"].ToString());
                        sqlcmd.Parameters.Add("@ItemCode", dr["ItemCode"].ToString());
                        sqlcmd.Parameters.Add("@ItemName", dr["ItemName"].ToString());
                        sqlcmd.Parameters.Add("@Quantity", dr["Production Quantity"].ToString());
                        sqlcmd.Parameters.Add("@WhsCode", dr["WhsCode"].ToString());
                        sqlcmd.Parameters.Add("@Price", dr["Price"].ToString());
                        sqlcmd.Parameters.Add("@OcrCode", dr["WhsCode"].ToString());
                        sqlcmd.Parameters.Add("@Remarks", dr["Remarks"].ToString());
                        sqlcmd.Parameters.Add("@Series", "19");
                        sqlcmd.Parameters.Add("@OcrCode2", dr["OcrCode2"].ToString());
                        string B1Upload = "N";
                        string Processed = "N";
                        sqlcmd.Parameters.Add("@B1Upload", B1Upload);
                        sqlcmd.Parameters.Add("@Processed", Processed);
                        SAPvdm.insert(sqlcmd);
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
            lblmsg.Text = ex.Message;
        }
    }
}