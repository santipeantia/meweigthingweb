using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using CrystalDecisions.CrystalReports.Engine;
using System.Security.Cryptography;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Drawing;


namespace medesignsoft.metruck_weigth
{
    public partial class truck_entry : System.Web.UI.Page
    {
        string ssql;
        string strOpt = "";

        DataTable dt;

        dbConnection dbConn = new dbConnection();


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //protected void truckdailyreport(object sender, EventArgs e) {
        //    try
        //    {
        //        string sdate = "2023-05-01";
        //        string edate = "2023-05-12";

        //        SqlCommand comm = new SqlCommand("spGetTruckDaily", dbConn.OpenConn());
        //        comm.CommandType = CommandType.StoredProcedure;
        //        comm.Parameters.AddWithValue("@sdate", sdate);
        //        comm.Parameters.AddWithValue("@edate", edate);
        //        comm.CommandTimeout = 1200;

        //        SqlDataAdapter da = new SqlDataAdapter();
        //        da = new SqlDataAdapter(comm);

        //        dt = new DataTable();
        //        da.Fill(dt);



        //        ExcelPackage excel = new ExcelPackage();
        //        var workSheet = excel.Workbook.Worksheets.Add("แผนการจัดส่งสินค้า");
        //        var totalCols = dt.Columns.Count;
        //        var totalRows = dt.Rows.Count;
        //        var totalFooter = dt.Columns.Count;

        //        #region excel header

        //        workSheet.Cells["A1:AH1"].Merge = true;
        //        workSheet.Cells["A1:AH1"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
        //        workSheet.Cells["A1:AH1"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["A1:AH1"].Style.Font.Size = 16;
        //        workSheet.Cells["A1:AH1"].Style.Font.Bold = true;
        //        workSheet.Cells["A1:AH1"].Value = "แผนการจัดส่งสินค้าสาขากิ่งแก้ว ประจำวันที่ " + sdate;
        //        workSheet.View.FreezePanes(4, 3);

        //        workSheet.Cells["A2:A3"].Merge = true;
        //        workSheet.Cells["A2:A3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["A2:A3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["A2:A3"].Value = "วันที่ส่งมอบ";
        //        workSheet.Cells["A2:A3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["A2:A3"].Style.Font.Size = 14;
        //        workSheet.Cells["A2:A3"].Style.Font.Bold = true;
        //        workSheet.Cells["A2:A3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["A2:A3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["A2:A3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["A2:A3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(1).Width = 18;

        //        workSheet.Cells["B2:B3"].Merge = true;
        //        workSheet.Cells["B2:B3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["B2:B3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["B2:B3"].Value = "ทะเบียนรถยนต์";
        //        workSheet.Cells["B2:B3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["B2:B3"].Style.Font.Size = 14;
        //        workSheet.Cells["B2:B3"].Style.Font.Bold = true;
        //        workSheet.Cells["B2:B3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["B2:B3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["B2:B3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["B2:B3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(2).Width = 18;

        //        workSheet.Cells["C2:C3"].Merge = true;
        //        workSheet.Cells["C2:C3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["C2:C3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["C2:C3"].Value = "เวลาเดินทาง";
        //        workSheet.Cells["C2:C3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["C2:C3"].Style.Font.Size = 14;
        //        workSheet.Cells["C2:C3"].Style.Font.Bold = true;
        //        workSheet.Cells["C2:C3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["C2:C3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["C2:C3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["C2:C3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(3).Width = 10;

        //        workSheet.Cells["D2:D3"].Merge = true;
        //        workSheet.Cells["D2:D3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["D2:D3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["D2:D3"].Value = "วันที่ทำรายการ";
        //        workSheet.Cells["D2:D3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["D2:D3"].Style.Font.Size = 14;
        //        workSheet.Cells["D2:D3"].Style.Font.Bold = true;
        //        workSheet.Cells["D2:D3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["D2:D3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["D2:D3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["D2:D3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(4).Width = 18;

        //        workSheet.Cells["E2:E3"].Merge = true;
        //        workSheet.Cells["E2:E3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["E2:E3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["E2:E3"].Value = "จำนวนเที่ยว";
        //        workSheet.Cells["E2:E3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["E2:E3"].Style.Font.Size = 14;
        //        workSheet.Cells["E2:E3"].Style.Font.Bold = true;
        //        workSheet.Cells["E2:E3"].Style.WrapText = true;
        //        workSheet.Cells["E2:E3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["E2:E3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["E2:E3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["E2:E3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(5).Width = 7;

        //        workSheet.Cells["F2:F3"].Merge = true;
        //        workSheet.Cells["F2:F3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["F2:F3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["F2:F3"].Value = "ชื่อบริษัทฯ";
        //        workSheet.Cells["F2:F3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["F2:F3"].Style.Font.Size = 14;
        //        workSheet.Cells["F2:F3"].Style.Font.Bold = true;
        //        workSheet.Cells["F2:F3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["F2:F3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["F2:F3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["F2:F3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(6).Width = 40;

        //        workSheet.Cells["G2:H2"].Merge = true;
        //        workSheet.Cells["G2:H2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["G2:H2"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["G2:H2"].Value = "สถานที่จัดส่งสินค้า";
        //        workSheet.Cells["G2:H2"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["G2:H2"].Style.Font.Size = 14;
        //        workSheet.Cells["G2:H2"].Style.Font.Bold = true;
        //        workSheet.Cells["G2:H2"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["G2:H2"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["G2:H2"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["G2:H2"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(7).Width = 30;

        //        workSheet.Cells["G3"].Merge = true;
        //        workSheet.Cells["G3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["G3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["G3"].Value = "โรงงาน";
        //        workSheet.Cells["G3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["G3"].Style.Font.Size = 14;
        //        workSheet.Cells["G3"].Style.Font.Bold = true;
        //        workSheet.Cells["G3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["G3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["G3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["G3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(7).Width = 15;

        //        workSheet.Cells["H3"].Merge = true;
        //        workSheet.Cells["H3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["H3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["H3"].Value = "ไซท์งาน";
        //        workSheet.Cells["H3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["H3"].Style.Font.Size = 14;
        //        workSheet.Cells["H3"].Style.Font.Bold = true;
        //        workSheet.Cells["H3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["H3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["H3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["H3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(8).Width = 30;

        //        workSheet.Cells["I2"].Merge = true;
        //        workSheet.Cells["I2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["I2"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["I2"].Value = "มูลค่าสินค้า";
        //        workSheet.Cells["I2"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["I2"].Style.Font.Size = 14;
        //        workSheet.Cells["I2"].Style.Font.Bold = true;
        //        workSheet.Cells["I2"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["I2"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["I2"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["I2"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(9).Width = 15;

        //        workSheet.Cells["I3"].Merge = true;
        //        workSheet.Cells["I3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["I3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["I3"].Value = "(บาท)";
        //        workSheet.Cells["I3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["I3"].Style.Font.Size = 14;
        //        workSheet.Cells["I3"].Style.Font.Bold = true;
        //        workSheet.Cells["I3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["I3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["I3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["I3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(9).Width = 15;

        //        workSheet.Cells["J2:K2"].Merge = true;
        //        workSheet.Cells["J2:K2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["J2:K2"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["J2:K2"].Value = "เงื่อนไข";
        //        workSheet.Cells["J2:K2"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["J2:K2"].Style.Font.Size = 14;
        //        workSheet.Cells["J2:K2"].Style.Font.Bold = true;
        //        workSheet.Cells["J2:K2"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["J2:K2"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["J2:K2"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["J2:K2"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(10).Width = 15;

        //        workSheet.Cells["J3"].Merge = true;
        //        workSheet.Cells["J3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["J3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["J3"].Value = "ได้";
        //        workSheet.Cells["J3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["J3"].Style.Font.Size = 14;
        //        workSheet.Cells["J3"].Style.Font.Bold = true;
        //        workSheet.Cells["J3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["J3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["J3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["J3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(10).Width = 7;

        //        workSheet.Cells["K3"].Merge = true;
        //        workSheet.Cells["K3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["K3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["K3"].Value = "พ่วงส่ง";
        //        workSheet.Cells["K3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["K3"].Style.Font.Size = 14;
        //        workSheet.Cells["K3"].Style.Font.Bold = true;
        //        workSheet.Cells["K3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["K3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["K3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["K3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(11).Width = 7;

        //        workSheet.Cells["L2:N2"].Merge = true;
        //        workSheet.Cells["L2:N2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["L2:N2"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["L2:N2"].Value = "ราคา (ใหม่)";
        //        workSheet.Cells["L2:N2"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["L2:N2"].Style.Font.Size = 14;
        //        workSheet.Cells["L2:N2"].Style.Font.Bold = true;
        //        workSheet.Cells["L2:N2"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["L2:N2"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["L2:N2"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["L2:N2"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(12).Width = 15;

        //        workSheet.Cells["L3"].Merge = true;
        //        workSheet.Cells["L3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["L3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["L3"].Value = "เงื่อนไข";
        //        workSheet.Cells["L3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["L3"].Style.Font.Size = 14;
        //        workSheet.Cells["L3"].Style.Font.Bold = true;
        //        workSheet.Cells["L3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["L3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["L3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["L3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(12).Width = 7;

        //        workSheet.Cells["M3"].Merge = true;
        //        workSheet.Cells["M3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["M3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["M3"].Value = "%";
        //        workSheet.Cells["M3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["M3"].Style.Font.Size = 14;
        //        workSheet.Cells["M3"].Style.Font.Bold = true;
        //        workSheet.Cells["M3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["M3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["M3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["M3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(13).Width = 12;

        //        workSheet.Cells["N3"].Merge = true;
        //        workSheet.Cells["N3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["N3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["N3"].Value = "ชดเชยค่าขนส่ง";
        //        workSheet.Cells["N3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["N3"].Style.Font.Size = 14;
        //        workSheet.Cells["N3"].Style.Font.Bold = true;
        //        workSheet.Cells["N3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["N3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["N3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["N3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(14).Width = 15;

        //        workSheet.Cells["O2:O3"].Merge = true;
        //        workSheet.Cells["O2:O3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["O2:O3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["O2:O3"].Value = "ลูกค้าจ่ายค่าขนส่ง";
        //        workSheet.Cells["O2:O3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["O2:O3"].Style.Font.Size = 14;
        //        workSheet.Cells["O2:O3"].Style.Font.Bold = true;
        //        workSheet.Cells["O2:O3"].Style.WrapText = true;
        //        workSheet.Cells["O2:O3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["O2:O3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["O2:O3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["O2:O3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(15).Width = 8;

        //        workSheet.Cells["P2:S2"].Merge = true;
        //        workSheet.Cells["P2:S2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["P2:S2"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["P2:S2"].Value = "ผลิตภัณฑ์";
        //        workSheet.Cells["P2:S2"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["P2:S2"].Style.Font.Size = 14;
        //        workSheet.Cells["P2:S2"].Style.Font.Bold = true;
        //        workSheet.Cells["P2:S2"].Style.WrapText = true;
        //        workSheet.Cells["P2:S2"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["P2:S2"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["P2:S2"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["P2:S2"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(16).Width = 30;

        //        workSheet.Cells["P3"].Merge = true;
        //        workSheet.Cells["P3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["P3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["P3"].Value = "Sky";
        //        workSheet.Cells["P3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["P3"].Style.Font.Size = 14;
        //        workSheet.Cells["P3"].Style.Font.Bold = true;
        //        workSheet.Cells["P3"].Style.WrapText = true;
        //        workSheet.Cells["P3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["P3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["P3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["P3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(16).Width = 15;

        //        workSheet.Cells["Q3"].Merge = true;
        //        workSheet.Cells["Q3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["Q3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["Q3"].Value = "D-Lite";
        //        workSheet.Cells["Q3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["Q3"].Style.Font.Size = 14;
        //        workSheet.Cells["Q3"].Style.Font.Bold = true;
        //        workSheet.Cells["Q3"].Style.WrapText = true;
        //        workSheet.Cells["Q3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["Q3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["Q3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["Q3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(17).Width = 15;

        //        workSheet.Cells["R3"].Merge = true;
        //        workSheet.Cells["R3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["R3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["R3"].Value = "A-ram";
        //        workSheet.Cells["R3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["R3"].Style.Font.Size = 14;
        //        workSheet.Cells["R3"].Style.Font.Bold = true;
        //        workSheet.Cells["R3"].Style.WrapText = true;
        //        workSheet.Cells["R3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["R3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["R3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["R3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(18).Width = 15;

        //        workSheet.Cells["S3"].Merge = true;
        //        workSheet.Cells["S3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["S3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["S3"].Value = "Screw";
        //        workSheet.Cells["S3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["S3"].Style.Font.Size = 14;
        //        workSheet.Cells["S3"].Style.Font.Bold = true;
        //        workSheet.Cells["S3"].Style.WrapText = true;
        //        workSheet.Cells["S3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["S3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["S3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["S3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(19).Width = 15;

        //        workSheet.Cells["T2:U2"].Merge = true;
        //        workSheet.Cells["T2:U2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["T2:U2"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["T2:U2"].Value = "จำนวน";
        //        workSheet.Cells["T2:U2"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["T2:U2"].Style.Font.Size = 14;
        //        workSheet.Cells["T2:U2"].Style.Font.Bold = true;
        //        workSheet.Cells["T2:U2"].Style.WrapText = true;
        //        workSheet.Cells["T2:U2"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["T2:U2"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["T2:U2"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["T2:U2"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(20).Width = 15;

        //        workSheet.Cells["T3"].Merge = true;
        //        workSheet.Cells["T3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["T3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["T3"].Value = "แผ่น";
        //        workSheet.Cells["T3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["T3"].Style.Font.Size = 14;
        //        workSheet.Cells["T3"].Style.Font.Bold = true;
        //        workSheet.Cells["T3"].Style.WrapText = true;
        //        workSheet.Cells["T3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["T3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["T3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["T3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(20).Width = 7;

        //        workSheet.Cells["U3"].Merge = true;
        //        workSheet.Cells["U3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["U3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["U3"].Value = "ชิ้น";
        //        workSheet.Cells["U3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["U3"].Style.Font.Size = 14;
        //        workSheet.Cells["U3"].Style.Font.Bold = true;
        //        workSheet.Cells["U3"].Style.WrapText = true;
        //        workSheet.Cells["U3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["U3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["U3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["U3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(21).Width = 7;

        //        workSheet.Cells["V2:W2"].Merge = true;
        //        workSheet.Cells["V2:W2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["V2:W2"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["V2:W2"].Value = "ความยาว";
        //        workSheet.Cells["V2:W2"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["V2:W2"].Style.Font.Size = 14;
        //        workSheet.Cells["V2:W2"].Style.Font.Bold = true;
        //        workSheet.Cells["V2:W2"].Style.WrapText = true;
        //        workSheet.Cells["V2:W2"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["V2:W2"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["V2:W2"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["V2:W2"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(22).Width = 20;

        //        workSheet.Cells["V3"].Merge = true;
        //        workSheet.Cells["V3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["V3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["V3"].Value = "สูงสุด (เมตร)";
        //        workSheet.Cells["V3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["V3"].Style.Font.Size = 14;
        //        workSheet.Cells["V3"].Style.Font.Bold = true;
        //        workSheet.Cells["V3"].Style.WrapText = true;
        //        workSheet.Cells["V3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["V3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["V3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["V3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(22).Width = 10;

        //        workSheet.Cells["W3"].Merge = true;
        //        workSheet.Cells["W3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["W3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["W3"].Value = "รวม (เมตร)";
        //        workSheet.Cells["W3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["W3"].Style.Font.Size = 14;
        //        workSheet.Cells["W3"].Style.Font.Bold = true;
        //        workSheet.Cells["W3"].Style.WrapText = true;
        //        workSheet.Cells["W3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["W3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["W3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["W3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(23).Width = 10;

        //        workSheet.Cells["X2:X3"].Merge = true;
        //        workSheet.Cells["X2:X3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["X2:X3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["X2:X3"].Value = "ระยะทางไปกลับ(กม.)";
        //        workSheet.Cells["X2:X3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["X2:X3"].Style.Font.Size = 14;
        //        workSheet.Cells["X2:X3"].Style.Font.Bold = true;
        //        workSheet.Cells["X2:X3"].Style.WrapText = true;
        //        workSheet.Cells["X2:X3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["X2:X3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["X2:X3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["X2:X3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(24).Width = 7;

        //        workSheet.Cells["Y2:Y3"].Merge = true;
        //        workSheet.Cells["Y2:Y3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["Y2:Y3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["Y2:Y3"].Value = "ต้นทุน 9 บาท/กม.";
        //        workSheet.Cells["Y2:Y3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["Y2:Y3"].Style.Font.Size = 14;
        //        workSheet.Cells["Y2:Y3"].Style.Font.Bold = true;
        //        workSheet.Cells["Y2:Y3"].Style.WrapText = true;
        //        workSheet.Cells["Y2:Y3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["Y2:Y3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["Y2:Y3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["Y2:Y3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(25).Width = 7;

        //        workSheet.Cells["Z2:Z3"].Merge = true;
        //        workSheet.Cells["Z2:Z3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["Z2:Z3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["Z2:Z3"].Value = "ต้นทุนขนส่ง/PO.";
        //        workSheet.Cells["Z2:Z3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["Z2:Z3"].Style.Font.Size = 14;
        //        workSheet.Cells["Z2:Z3"].Style.Font.Bold = true;
        //        workSheet.Cells["Z2:Z3"].Style.WrapText = true;
        //        workSheet.Cells["Z2:Z3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["Z2:Z3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["Z2:Z3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["Z2:Z3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(26).Width = 7;

        //        workSheet.Cells["AA2:AA3"].Merge = true;
        //        workSheet.Cells["AA2:AA3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["AA2:AA3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["AA2:AA3"].Value = "% ต้นทุนขนส่ง/PO.";
        //        workSheet.Cells["AA2:AA3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["AA2:AA3"].Style.Font.Size = 14;
        //        workSheet.Cells["AA2:AA3"].Style.Font.Bold = true;
        //        workSheet.Cells["AA2:AA3"].Style.WrapText = true;
        //        workSheet.Cells["AA2:AA3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AA2:AA3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AA2:AA3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AA2:AA3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(27).Width = 7;

        //        workSheet.Cells["AB2:AE2"].Merge = true;
        //        workSheet.Cells["AB2:AE2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["AB2:AE2"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["AB2:AE2"].Value = "ต้นทุนค่าขนส่ง";
        //        workSheet.Cells["AB2:AE2"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["AB2:AE2"].Style.Font.Size = 14;
        //        workSheet.Cells["AB2:AE2"].Style.Font.Bold = true;
        //        workSheet.Cells["AB2:AE2"].Style.WrapText = true;
        //        workSheet.Cells["AB2:AE2"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AB2:AE2"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AB2:AE2"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AB2:AE2"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(28).Width = 30;

        //        workSheet.Cells["AB3"].Merge = true;
        //        workSheet.Cells["AB3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["AB3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["AB3"].Value = "สุทธิ (บาท)";
        //        workSheet.Cells["AB3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["AB3"].Style.Font.Size = 14;
        //        workSheet.Cells["AB3"].Style.Font.Bold = true;
        //        workSheet.Cells["AB3"].Style.WrapText = true;
        //        workSheet.Cells["AB3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AB3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AB3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AB3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(28).Width = 10;

        //        workSheet.Cells["AC3"].Merge = true;
        //        workSheet.Cells["AC3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["AC3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["AC3"].Value = "บาท/กม.";
        //        workSheet.Cells["AC3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["AC3"].Style.Font.Size = 14;
        //        workSheet.Cells["AC3"].Style.Font.Bold = true;
        //        workSheet.Cells["AC3"].Style.WrapText = true;
        //        workSheet.Cells["AC3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AC3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AC3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AC3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(29).Width = 10;

        //        workSheet.Cells["AD3"].Merge = true;
        //        workSheet.Cells["AD3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["AD3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["AD3"].Value = "บาท/เมตร";
        //        workSheet.Cells["AD3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["AD3"].Style.Font.Size = 14;
        //        workSheet.Cells["AD3"].Style.Font.Bold = true;
        //        workSheet.Cells["AD3"].Style.WrapText = true;
        //        workSheet.Cells["AD3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AD3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AD3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AD3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(30).Width = 10;

        //        workSheet.Cells["AE3"].Merge = true;
        //        workSheet.Cells["AE3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["AE3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["AE3"].Value = "%";
        //        workSheet.Cells["AE3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["AE3"].Style.Font.Size = 14;
        //        workSheet.Cells["AE3"].Style.Font.Bold = true;
        //        workSheet.Cells["AE3"].Style.WrapText = true;
        //        workSheet.Cells["AE3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AE3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AE3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AE3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(31).Width = 10;

        //        workSheet.Cells["AF2:AG2"].Merge = true;
        //        workSheet.Cells["AF2:AG2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["AF2:AG2"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["AF2:AG2"].Value = "หน้างาน";
        //        workSheet.Cells["AF2:AG2"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["AF2:AG2"].Style.Font.Size = 14;
        //        workSheet.Cells["AF2:AG2"].Style.Font.Bold = true;
        //        workSheet.Cells["AF2:AG2"].Style.WrapText = true;
        //        workSheet.Cells["AF2:AG2"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AF2:AG2"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AF2:AG2"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AF2:AG2"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(32).Width = 20;

        //        workSheet.Cells["AF3"].Merge = true;
        //        workSheet.Cells["AF3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["AF3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["AF3"].Value = "ช่วยลงของ";
        //        workSheet.Cells["AF3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["AF3"].Style.Font.Size = 14;
        //        workSheet.Cells["AF3"].Style.Font.Bold = true;
        //        workSheet.Cells["AF3"].Style.WrapText = true;
        //        workSheet.Cells["AF3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AF3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AF3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AF3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(32).Width = 10;

        //        workSheet.Cells["AG3"].Merge = true;
        //        workSheet.Cells["AG3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["AG3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["AG3"].Value = "ใช้เครนยกของ";
        //        workSheet.Cells["AG3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["AG3"].Style.Font.Size = 14;
        //        workSheet.Cells["AG3"].Style.Font.Bold = true;
        //        workSheet.Cells["AG3"].Style.WrapText = true;
        //        workSheet.Cells["AG3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AG3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AG3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AG3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(33).Width = 10;

        //        workSheet.Cells["AH2:AH3"].Merge = true;
        //        workSheet.Cells["AH2:AH3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //        workSheet.Cells["AH2:AH3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //        workSheet.Cells["AH2:AH3"].Value = "หมายเหตุ";
        //        workSheet.Cells["AH2:AH3"].Style.Font.Name = "Angsana New";
        //        workSheet.Cells["AH2:AH3"].Style.Font.Size = 14;
        //        workSheet.Cells["AH2:AH3"].Style.Font.Bold = true;
        //        workSheet.Cells["AH2:AH3"].Style.WrapText = true;
        //        workSheet.Cells["AH2:AH3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AH2:AH3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AH2:AH3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //        workSheet.Cells["AH2:AH3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //        workSheet.Column(34).Width = 40;

        //        #endregion

        //        #region excel rows
        //        int row = 0;
        //        int col = 0;
        //        for (row = 0; row < totalRows; row++)
        //        {
        //            for (col = 0; col <= totalCols - 1; col++)
        //            {
        //                workSheet.Cells[row + 4, col + 1].Value = dt.Rows[row][col];
        //                workSheet.Cells[row + 4, col + 1].Style.Font.Name = "Angsana New";
        //                workSheet.Cells[row + 4, col + 1].Style.Font.Size = 14;
        //                workSheet.Cells[row + 4, col + 1].Style.Font.Bold = false;
        //                workSheet.Cells[row + 4, col + 1].Style.Border.Top.Style = ExcelBorderStyle.Thin;
        //                workSheet.Cells[row + 4, col + 1].Style.Border.Right.Style = ExcelBorderStyle.Thin;
        //                workSheet.Cells[row + 4, col + 1].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
        //                workSheet.Cells[row + 4, col + 1].Style.Border.Left.Style = ExcelBorderStyle.Thin;
        //                workSheet.Cells[row + 4, col + 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
        //                workSheet.Cells[row + 4, col + 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        //                workSheet.Cells[row + 4, 3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
        //            }
        //        }
        //        #endregion

        //        #region excel memory saveas
        //        using (var memoryStream = new MemoryStream())
        //        {
        //            Response.AddHeader("content-disposition", "attachment;  filename=แผนการจัดส่งสินค้าสาขากิ่งแก้ว ประจำวันที่" + sdate + ".xls");
        //            excel.SaveAs(memoryStream);
        //            memoryStream.WriteTo(Response.OutputStream);
        //            Response.Flush();
        //            Response.End();
        //        }
        //        #endregion
        //    }
        //    catch (Exception ex)
        //    {
        //        string exError = ex.Message;
        //    }
        //}
    }
}