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
using EPPlus;

namespace medesignsoft.metruck_weigth
{
    public partial class report_render : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();

        ReportDocument rpt = new ReportDocument();

        public string strMsgAlert = "";
        public string strUser = "sa";
        //public string strPassword = "123456789";
        //public string strServer = "SANTI-IT\\MSSQLSERVER17";

        public string strServer = "SERVERAYL";
        public string strPassword = "CA42se@ayl";

        public string strSource = "DB_AYUTTAYALAND";
        string ssql;
               

        protected void Page_Load(object sender, EventArgs e)
        {
            
            string rpt_id = Request.Params["id"];
            string sdate = Request.Params["sdate"];
            string edate = Request.Params["edate"];

            if (rpt_id == "truck_report_excel" && sdate != null && edate != null) { truckdailyreport_excel(sdate, edate); }
            else if (rpt_id == "truck_report_pdf" && sdate != null && edate != null) { truckdailyreport_pdf(sdate, edate); }
            else if (rpt_id == "truck_ticket_pdf" && sdate != null && edate != null) { truck_ticket_pdf(rpt_id, sdate, edate); }
            else if (rpt_id == "truck_report1_pdf" && sdate != null && edate != null) { truck_report1_pdf(rpt_id, sdate, edate); }
            else if (rpt_id == "truck_report1_excel" && sdate != null && edate != null) { truck_report1_excel(rpt_id, sdate, edate); }
            else if (rpt_id == "truck_reportamount_pdf" && sdate != null && edate != null) { truck_reportamount_pdf(rpt_id, sdate, edate); }
            else if (rpt_id == "truck_reportamount_excel" && sdate != null && edate != null) { truck_reportamount_excel(rpt_id, sdate, edate); }            
            
            else { Response.Write("<script>alert('พบข้อผิดพลาด..!, ข้อมูลรายงานไม่ถูกต้องโปรดตรวจตสอบ...');</script>"); }



        }

        protected void truckdailyreport_excel(string sdate, string edate) {
            try
            {               
                SqlCommand comm = new SqlCommand("spGetTruckDailyReport", dbConn.OpenConn());
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@sdate", sdate);
                comm.Parameters.AddWithValue("@edate", edate);
                comm.CommandTimeout = 1200;

                SqlDataAdapter da = new SqlDataAdapter();
                da = new SqlDataAdapter(comm);

                dt = new DataTable();
                da.Fill(dt);

                ExcelPackage excel = new ExcelPackage();
                var workSheet = excel.Workbook.Worksheets.Add("รายงานเครื่องชั่งรายวัน");
                var totalCols = dt.Columns.Count;
                var totalRows = dt.Rows.Count;
                var totalFooter = dt.Columns.Count;

                Color DeepBlueHexCode = ColorTranslator.FromHtml("#254061");

                #region excel header

                workSheet.Cells["A1:AB1"].Merge = true;
                workSheet.Cells["A1:AB1"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                workSheet.Cells["A1:AB1"].Style.Font.Name = "Angsana New";
                workSheet.Cells["A1:AB1"].Style.Font.Size = 16;
                workSheet.Cells["A1:AB1"].Style.Font.Bold = true;
                workSheet.Cells["A1:AB1"].Value = "รายงานเครื่องชั่งรายวัน ประจำวันที่ " + sdate + " ถึง " + edate;
                workSheet.View.FreezePanes(4, 3);

                workSheet.Cells["A2:A3"].Merge = true;
                workSheet.Cells["A2:A3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["A2:A3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["A2:A3"].Value = "รูปแบบการชั่ง";
                workSheet.Cells["A2:A3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["A2:A3"].Style.Font.Size = 14;
                workSheet.Cells["A2:A3"].Style.Font.Bold = true;
                workSheet.Cells["A2:A3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A2:A3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A2:A3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A2:A3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(1).Width = 18;

                workSheet.Cells["B2:B3"].Merge = true;
                workSheet.Cells["B2:B3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["B2:B3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["B2:B3"].Value = "ทะเบียนรถยนต์";
                workSheet.Cells["B2:B3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["B2:B3"].Style.Font.Size = 14;
                workSheet.Cells["B2:B3"].Style.Font.Bold = true;
                workSheet.Cells["B2:B3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["B2:B3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["B2:B3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["B2:B3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(2).Width = 18;

                workSheet.Cells["C2:C3"].Merge = true;
                workSheet.Cells["C2:C3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["C2:C3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["C2:C3"].Value = "ชื่อรถขนส่ง";
                workSheet.Cells["C2:C3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["C2:C3"].Style.Font.Size = 14;
                workSheet.Cells["C2:C3"].Style.Font.Bold = true;
                workSheet.Cells["C2:C3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["C2:C3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["C2:C3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["C2:C3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(3).Width = 21;

                workSheet.Cells["D2:D3"].Merge = true;
                workSheet.Cells["D2:D3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["D2:D3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["D2:D3"].Value = "น้ำหนักรถ";
                workSheet.Cells["D2:D3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["D2:D3"].Style.Font.Size = 14;
                workSheet.Cells["D2:D3"].Style.Font.Bold = true;
                workSheet.Cells["D2:D3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["D2:D3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["D2:D3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["D2:D3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(4).Width = 16;

                workSheet.Cells["E2:E3"].Merge = true;
                workSheet.Cells["E2:E3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["E2:E3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["E2:E3"].Value = "ประเภท";
                workSheet.Cells["E2:E3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["E2:E3"].Style.Font.Size = 14;
                workSheet.Cells["E2:E3"].Style.Font.Bold = true;
                workSheet.Cells["E2:E3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["E2:E3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["E2:E3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["E2:E3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(5).Width = 16;

                workSheet.Cells["F2:F3"].Merge = true;
                workSheet.Cells["F2:F3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["F2:F3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["F2:F3"].Value = "ชื่อประเภท";
                workSheet.Cells["F2:F3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["F2:F3"].Style.Font.Size = 14;
                workSheet.Cells["F2:F3"].Style.Font.Bold = true;
                workSheet.Cells["F2:F3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["F2:F3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["F2:F3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["F2:F3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(6).Width = 26;

                workSheet.Cells["G2:G3"].Merge = true;
                workSheet.Cells["G2:G3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["G2:G3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["G2:G3"].Value = "รหัสลูกค้า";
                workSheet.Cells["G2:G3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["G2:G3"].Style.Font.Size = 14;
                workSheet.Cells["G2:G3"].Style.Font.Bold = true;
                workSheet.Cells["G2:G3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["G2:G3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["G2:G3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["G2:G3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(7).Width = 16;

                workSheet.Cells["H2:H3"].Merge = true;
                workSheet.Cells["H2:H3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["H2:H3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["H2:H3"].Value = "ชื่อลูกค้า";
                workSheet.Cells["H2:H3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["H2:H3"].Style.Font.Size = 14;
                workSheet.Cells["H2:H3"].Style.Font.Bold = true;
                workSheet.Cells["H2:H3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["H2:H3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["H2:H3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["H2:H3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(8).Width = 26;

                workSheet.Cells["I2:I3"].Merge = true;
                workSheet.Cells["I2:I3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["I2:I3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["I2:I3"].Value = "รหัสสินค้า";
                workSheet.Cells["I2:I3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["I2:I3"].Style.Font.Size = 14;
                workSheet.Cells["I2:I3"].Style.Font.Bold = true;
                workSheet.Cells["I2:I3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["I2:I3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["I2:I3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["I2:I3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(9).Width = 16;

                workSheet.Cells["J2:J3"].Merge = true;
                workSheet.Cells["J2:J3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["J2:J3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["J2:J3"].Value = "ชื่อสินค้า";
                workSheet.Cells["J2:J3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["J2:J3"].Style.Font.Size = 14;
                workSheet.Cells["J2:J3"].Style.Font.Bold = true;
                workSheet.Cells["J2:J3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["J2:J3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["J2:J3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["J2:J3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(10).Width = 26;

                workSheet.Cells["K2:K3"].Merge = true;
                workSheet.Cells["K2:K3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["K2:K3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["K2:K3"].Value = "รหัส ผรม.";
                workSheet.Cells["K2:K3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["K2:K3"].Style.Font.Size = 14;
                workSheet.Cells["K2:K3"].Style.Font.Bold = true;
                workSheet.Cells["K2:K3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["K2:K3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["K2:K3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["K2:K3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(11).Width = 16;

                workSheet.Cells["L2:L3"].Merge = true;
                workSheet.Cells["L2:L3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["L2:L3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["L2:L3"].Value = "ชื่อ ผรม.";
                workSheet.Cells["L2:L3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["L2:L3"].Style.Font.Size = 14;
                workSheet.Cells["L2:L3"].Style.Font.Bold = true;
                workSheet.Cells["L2:L3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["L2:L3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["L2:L3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["L2:L3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(12).Width = 18;

                workSheet.Cells["M2:M3"].Merge = true;
                workSheet.Cells["M2:M3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["M2:M3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["M2:M3"].Value = "ตัวแปร";
                workSheet.Cells["M2:M3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["M2:M3"].Style.Font.Size = 14;
                workSheet.Cells["M2:M3"].Style.Font.Bold = true;
                workSheet.Cells["M2:M3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["M2:M3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["M2:M3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["M2:M3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(13).Width = 16;

                workSheet.Cells["N2:N3"].Merge = true;
                workSheet.Cells["N2:N3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["N2:N3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["N2:N3"].Value = "รวมภาษี";
                workSheet.Cells["N2:N3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["N2:N3"].Style.Font.Size = 14;
                workSheet.Cells["N2:N3"].Style.Font.Bold = true;
                workSheet.Cells["N2:N3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["N2:N3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["N2:N3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["N2:N3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(14).Width = 16;

                workSheet.Cells["O2:O3"].Merge = true;
                workSheet.Cells["O2:O3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["O2:O3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["O2:O3"].Value = "ราคา";
                workSheet.Cells["O2:O3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["O2:O3"].Style.Font.Size = 14;
                workSheet.Cells["O2:O3"].Style.Font.Bold = true;
                workSheet.Cells["O2:O3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["O2:O3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["O2:O3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["O2:O3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(15).Width = 16;

                workSheet.Cells["P2:P3"].Merge = true;
                workSheet.Cells["P2:P3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["P2:P3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["P2:P3"].Value = "อัตราคำนวณ";
                workSheet.Cells["P2:P3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["P2:P3"].Style.Font.Size = 14;
                workSheet.Cells["P2:P3"].Style.Font.Bold = true;
                workSheet.Cells["P2:P3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["P2:P3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["P2:P3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["P2:P3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(16).Width = 16;

                workSheet.Cells["Q2:Q3"].Merge = true;
                workSheet.Cells["Q2:Q3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["Q2:Q3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["Q2:Q3"].Value = "ตั๋วขาเข้า";
                workSheet.Cells["Q2:Q3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["Q2:Q3"].Style.Font.Size = 14;
                workSheet.Cells["Q2:Q3"].Style.Font.Bold = true;
                workSheet.Cells["Q2:Q3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["Q2:Q3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["Q2:Q3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["Q2:Q3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(17).Width = 18;

                workSheet.Cells["R2:R3"].Merge = true;
                workSheet.Cells["R2:R3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["R2:R3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["R2:R3"].Value = "วันที่ชั่งเข้า";
                workSheet.Cells["R2:R3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["R2:R3"].Style.Font.Size = 14;
                workSheet.Cells["R2:R3"].Style.Font.Bold = true;
                workSheet.Cells["R2:R3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["R2:R3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["R2:R3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["R2:R3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(18).Width = 18;

                workSheet.Cells["S2:S3"].Merge = true;
                workSheet.Cells["S2:S3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["S2:S3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["S2:S3"].Value = "เวลาชั่งเข้า";
                workSheet.Cells["S2:S3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["S2:S3"].Style.Font.Size = 14;
                workSheet.Cells["S2:S3"].Style.Font.Bold = true;
                workSheet.Cells["S2:S3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["S2:S3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["S2:S3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["S2:S3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(19).Width = 18;

                workSheet.Cells["T2:T3"].Merge = true;
                workSheet.Cells["T2:T3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["T2:T3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["T2:T3"].Value = "น้ำหนักเข้า";
                workSheet.Cells["T2:T3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["T2:T3"].Style.Font.Size = 14;
                workSheet.Cells["T2:T3"].Style.Font.Bold = true;
                workSheet.Cells["T2:T3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["T2:T3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["T2:T3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["T2:T3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(20).Width = 18;

                workSheet.Cells["U2:U3"].Merge = true;
                workSheet.Cells["U2:U3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["U2:U3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["U2:U3"].Value = "ตั๋วขาออก";
                workSheet.Cells["U2:U3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["U2:U3"].Style.Font.Size = 14;
                workSheet.Cells["U2:U3"].Style.Font.Bold = true;
                workSheet.Cells["U2:U3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["U2:U3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["U2:U3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["U2:U3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(21).Width = 18;

                workSheet.Cells["V2:V3"].Merge = true;
                workSheet.Cells["V2:V3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["V2:V3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["V2:V3"].Value = "วันที่ชั่งออก";
                workSheet.Cells["V2:V3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["V2:V3"].Style.Font.Size = 14;
                workSheet.Cells["V2:V3"].Style.Font.Bold = true;
                workSheet.Cells["V2:V3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["V2:V3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["V2:V3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["V2:V3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(22).Width = 18;

                workSheet.Cells["W2:W3"].Merge = true;
                workSheet.Cells["W2:W3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["W2:W3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["W2:W3"].Value = "เวลาชั่งออก";
                workSheet.Cells["W2:W3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["W2:W3"].Style.Font.Size = 14;
                workSheet.Cells["W2:W3"].Style.Font.Bold = true;
                workSheet.Cells["W2:W3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["W2:W3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["W2:W3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["W2:W3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(23).Width = 18;

                workSheet.Cells["X2:X3"].Merge = true;
                workSheet.Cells["X2:X3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["X2:X3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["X2:X3"].Value = "เวลาชั่งเข้า - ชั่งออก";
                workSheet.Cells["X2:X3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["X2:X3"].Style.Font.Size = 14;
                workSheet.Cells["X2:X3"].Style.Font.Bold = true;
                workSheet.Cells["X2:X3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["X2:X3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["X2:X3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["X2:X3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(24).Width = 18;

              
                workSheet.Cells["Y2:Y3"].Merge = true;
                workSheet.Cells["Y2:Y3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["Y2:Y3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["Y2:Y3"].Value = "น้ำหนักออก";
                workSheet.Cells["Y2:Y3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["Y2:Y3"].Style.Font.Size = 14;
                workSheet.Cells["Y2:Y3"].Style.Font.Bold = true;
                workSheet.Cells["Y2:Y3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["Y2:Y3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["Y2:Y3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["Y2:Y3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(25).Width = 18;

                workSheet.Cells["Z2:Z3"].Merge = true;
                workSheet.Cells["Z2:Z3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["Z2:Z3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["Z2:Z3"].Value = "น้ำหนักสุทธิ";
                workSheet.Cells["Z2:Z3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["Z2:Z3"].Style.Font.Size = 14;
                workSheet.Cells["Z2:Z3"].Style.Font.Bold = true;
                workSheet.Cells["Z2:Z3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["Z2:Z3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["Z2:Z3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["Z2:Z3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(26).Width = 18;

                workSheet.Cells["AA2:AA3"].Merge = true;
                workSheet.Cells["AA2:AA3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["AA2:AA3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["AA2:AA3"].Value = "รหัสพนักงาน";
                workSheet.Cells["AA2:AA3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["AA2:AA3"].Style.Font.Size = 14;
                workSheet.Cells["AA2:AA3"].Style.Font.Bold = true;
                workSheet.Cells["AA2:AA3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["AA2:AA3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["AA2:AA3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["AA2:AA3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(27).Width = 21;

                workSheet.Cells["AB2:AB3"].Merge = true;
                workSheet.Cells["AB2:AB3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["AB2:AB3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["AB2:AB3"].Value = "รหัสพนักงาน";
                workSheet.Cells["AB2:AB3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["AB2:AB3"].Style.Font.Size = 14;
                workSheet.Cells["AB2:AB3"].Style.Font.Bold = true;
                workSheet.Cells["AB2:AB3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["AB2:AB3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["AB2:AB3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["AB2:AB3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(28).Width = 21;

                using (ExcelRange Rng = workSheet.Cells[2,1,3,1])
                {                   
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 2, 3, 2])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 3, 3, 3])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 4, 3, 4])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 5, 3, 5])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 6, 3, 6])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 7, 3, 7])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 8, 3, 8])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 9, 3, 9])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 10, 3, 10])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 11, 3, 11])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 12, 3, 12])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 13, 3, 13])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 14, 3, 14])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 15, 3, 15])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 16, 3, 16])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 17, 3, 17])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 18, 3, 18])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 19, 3, 19])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 20, 3, 20])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 21, 3, 21])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 22, 3, 22])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 23, 3, 23])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 24, 3, 24])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 25, 3, 25])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 26, 3, 26])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 27, 3, 27])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                using (ExcelRange Rng = workSheet.Cells[2, 28, 3, 28])
                {
                    Rng.Merge = true;
                    Rng.Style.Font.Bold = true;
                    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                }

                #endregion

                #region excel rows
                int row = 0;
                int col = 0;
                for (row = 0; row < totalRows; row++)
                {
                    for (col = 0; col <= totalCols - 1; col++)
                    {
                        workSheet.Cells[row + 4, col + 1].Value = dt.Rows[row][col];
                        workSheet.Cells[row + 4, col + 1].Style.Font.Name = "Angsana New";
                        workSheet.Cells[row + 4, col + 1].Style.Font.Size = 14;
                        workSheet.Cells[row + 4, col + 1].Style.Font.Bold = false;
                        workSheet.Cells[row + 4, col + 1].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[row + 4, col + 1].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[row + 4, col + 1].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[row + 4, col + 1].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[row + 4, col + 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        workSheet.Cells[row + 4, col + 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                        //workSheet.Cells[row + 4, 3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                    }
                }
                #endregion

                #region excel memory saveas
                using (var memoryStream = new MemoryStream())
                {
                    Response.AddHeader("content-disposition", "attachment;  filename=รายงานเครื่องชั่งรายวัน" + sdate + ".xlsx");
                    excel.SaveAs(memoryStream);
                    memoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
                #endregion
            }
            catch (Exception ex)
            {
                string exError = ex.Message;
                Response.Write("<script>alert('พบข้อผิดพลาด..!, "+ exError + "');</script>");
                return;
            }
        }

        protected void truckdailyreport_pdf(string sdate, string edate)
        {
            try
            {               
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/truck/truckdailyreport_pdf.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "truckdailyreport_" + sdate + "_" + edate + ".pdf");
            }
            catch (Exception ex)
            {
                string exError = ex.Message;
                Response.Write("<script>alert('พบข้อผิดพลาด..!, " + exError + "');</script>");
                return;
            }
        }

        protected void truck_ticket_pdf(string rep_ticket, string sdate, string edate) {
            try
            {
                string docno = Request.Params["docno"];

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/truck/truck_ticket_pdf.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@rep_ticket", docno);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "ticket_" + sdate + "_" + docno + ".pdf");
            }
            catch (Exception ex)
            {
                string exError = ex.Message;
                Response.Write("<script>alert('พบข้อผิดพลาด..!, " + exError + "');</script>");
                return;
            }
        }

        protected void truck_report1_pdf(string rep_ticket, string sdate, string edate) {
            try
            {
                string refno = Request.Params["refno"];
                string comp1 = Request.Params["comcode1"];
                string comp2 = Request.Params["comcode2"];

                string prod1 = Request.Params["prod1"];
                string prod2 = Request.Params["prod2"];

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();

                if (refno != "5")
                {
                    rpt.Load(Server.MapPath("../Reports/truck/truck_report1_pdf.rpt"));
                    rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                    rpt.SetParameterValue("@comp1", comp1);
                    rpt.SetParameterValue("@comp2", comp2);
                    rpt.SetParameterValue("@sdate", sdate);
                    rpt.SetParameterValue("@edate", edate);
                }
                else {
                    rpt.Load(Server.MapPath("../Reports/truck/truck_report_product.rpt"));
                    rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                    rpt.SetParameterValue("@comp1", comp1);
                    rpt.SetParameterValue("@comp2", comp2);
                    rpt.SetParameterValue("@sdate", sdate);
                    rpt.SetParameterValue("@edate", edate);
                    rpt.SetParameterValue("@prod1", prod1);
                    rpt.SetParameterValue("@prod2", prod2);
                }
               

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "TruckReport_" + sdate + "_" + edate + ".pdf");
            }
            catch (Exception ex)
            {
                string exError = ex.Message;
                Response.Write("<script>alert('พบข้อผิดพลาด..!, " + exError + "');</script>");
                return;
            }
        }

        protected void truck_report1_excel(string rep_ticket, string sdate, string edate)
        {
            try
            {
                string refno = Request.Params["refno"];
                string comp1 = Request.Params["comcode1"];
                string comp2 = Request.Params["comcode2"];

                string prod1 = Request.Params["prod1"];
                string prod2 = Request.Params["prod2"];

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();

                if (refno != "5")
                {
                    rpt.Load(Server.MapPath("../Reports/truck/truck_report1_pdf.rpt"));
                    rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                    rpt.SetParameterValue("@comp1", comp1);
                    rpt.SetParameterValue("@comp2", comp2);
                    rpt.SetParameterValue("@sdate", sdate);
                    rpt.SetParameterValue("@edate", edate);
                }
                else
                {
                    rpt.Load(Server.MapPath("../Reports/truck/truck_report_product.rpt"));
                    rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                    rpt.SetParameterValue("@comp1", comp1);
                    rpt.SetParameterValue("@comp2", comp2);
                    rpt.SetParameterValue("@sdate", sdate);
                    rpt.SetParameterValue("@edate", edate);
                    rpt.SetParameterValue("@prod1", prod1);
                    rpt.SetParameterValue("@prod2", prod2);
                }

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.Excel, Response, false, "TruckReport_" + sdate + "_" + edate + ".xlsx");
            }
            catch (Exception ex)
            {
                string exError = ex.Message;
                Response.Write("<script>alert('พบข้อผิดพลาด..!, " + exError + "');</script>");
                return;
            }
        }

        protected void truck_reportamount_pdf(string rep_ticket, string sdate, string edate)
        {
            try
            {
                string refno = Request.Params["refno"];
                string comp1 = Request.Params["comcode1"];
                string comp2 = Request.Params["comcode2"];

                string prod1 = Request.Params["prod1"];
                string prod2 = Request.Params["prod2"];

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();

                rpt.Load(Server.MapPath("../Reports/truck/truck_reportamount_pdf.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.SetParameterValue("@custcode", comp1);
                rpt.SetParameterValue("@prodcode", prod1);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "TruckReportAmountTrip_" + sdate + "_" + edate + ".pdf");
            }
            catch (Exception ex)
            {
                string exError = ex.Message;
                Response.Write("<script>alert('พบข้อผิดพลาด..!, " + exError + "');</script>");
                return;
            }
        }

        protected void truck_reportamount_excel(string rep_ticket, string sdate, string edate)
        {
            try
            {
                string custcode = Request.Params["comcode1"];
                string prodcode = Request.Params["prod1"];

                SqlCommand comm = new SqlCommand("sptw_GetProductAmountBydateExcel", dbConn.OpenConn());
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@sdate", sdate);
                comm.Parameters.AddWithValue("@edate", edate);
                comm.Parameters.AddWithValue("@custcode", custcode);
                comm.Parameters.AddWithValue("@prodcode", prodcode);
                comm.CommandTimeout = 1200;

                SqlDataAdapter da = new SqlDataAdapter();
                da = new SqlDataAdapter(comm);

                dt = new DataTable();
                da.Fill(dt);

                ExcelPackage excel = new ExcelPackage();
                var workSheet = excel.Workbook.Worksheets.Add("รายงานจำนวนเที่ยว(ตัน)/บริษัท");
                var totalCols = dt.Columns.Count;
                var totalRows = dt.Rows.Count;
                var totalFooter = dt.Columns.Count;
                var productname = dt.Rows[0]["PRODUCTNAME"].ToString();

                Color DeepBlueHexCode = ColorTranslator.FromHtml("#254061");

                #region excel header

                workSheet.Cells["A1:H1"].Merge = true;
                workSheet.Cells["A1:H1"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["A1:H1"].Style.Font.Name = "Angsana New";
                workSheet.Cells["A1:H1"].Style.Font.Size = 18;
                workSheet.Cells["A1:H1"].Style.Font.Bold = true;
                workSheet.Cells["A1:H1"].Value = "รายงานจำนวนเที่ยว(ตัน)/บริษัท";
                //workSheet.View.FreezePanes(4, 3);

                workSheet.Cells["A2:H2"].Merge = true;
                workSheet.Cells["A2:H2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["A2:H2"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["A2:H2"].Value = "ประจำวันที่ " + sdate + "  ถึง  " + edate ;
                workSheet.Cells["A2:H2"].Style.Font.Name = "Angsana New";
                workSheet.Cells["A2:H2"].Style.Font.Size = 18;
                workSheet.Cells["A2:H2"].Style.Font.Bold = true;
                workSheet.Cells["A2:H2"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A2:H2"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A2:H2"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A2:H2"].Style.Border.Left.Style = ExcelBorderStyle.Thin;

                workSheet.Cells["A3:H3"].Merge = true;
                workSheet.Cells["A3:H3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["A3:H3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["A3:H3"].Value = "ประเภทสินค้า " + productname ;
                workSheet.Cells["A3:H3"].Style.Font.Name = "Angsana New";
                workSheet.Cells["A3:H3"].Style.Font.Size = 18;
                workSheet.Cells["A3:H3"].Style.Font.Bold = true;
                workSheet.Cells["A3:H3"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A3:H3"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A3:H3"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A3:H3"].Style.Border.Left.Style = ExcelBorderStyle.Thin;

                //workSheet.Column(1).Width = 18;

                workSheet.Cells["A4"].Merge = true;
                workSheet.Cells["A4"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["A4"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["A4"].Value = "ลำดับ";
                workSheet.Cells["A4"].Style.Font.Name = "Angsana New";
                workSheet.Cells["A4"].Style.Font.Size = 18;
                workSheet.Cells["A4"].Style.Font.Bold = true;
                workSheet.Cells["A4"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A4"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A4"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["A4"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(1).Width = 20;

                workSheet.Cells["B4"].Merge = true;
                workSheet.Cells["B4"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["B4"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["B4"].Value = "ชื่อลูกค้า";
                workSheet.Cells["B4"].Style.Font.Name = "Angsana New";
                workSheet.Cells["B4"].Style.Font.Size = 18;
                workSheet.Cells["B4"].Style.Font.Bold = true;
                workSheet.Cells["B4"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["B4"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["B4"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["B4"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(2).Width = 40;

                workSheet.Cells["C4"].Merge = true;
                workSheet.Cells["C4"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["C4"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["C4"].Value = "ประเภทสินค้า";
                workSheet.Cells["C4"].Style.Font.Name = "Angsana New";
                workSheet.Cells["C4"].Style.Font.Size = 18;
                workSheet.Cells["C4"].Style.Font.Bold = true;
                workSheet.Cells["C4"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["C4"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["C4"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["C4"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(3).Width = 30;

                workSheet.Cells["D4"].Merge = true;
                workSheet.Cells["D4"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["D4"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["D4"].Value = "จำนวนเที่ยว";
                workSheet.Cells["D4"].Style.Font.Name = "Angsana New";
                workSheet.Cells["D4"].Style.Font.Size = 18;
                workSheet.Cells["D4"].Style.Font.Bold = true;
                workSheet.Cells["D4"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["D4"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["D4"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["D4"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(4).Width = 20;

                workSheet.Cells["E4"].Merge = true;
                workSheet.Cells["E4"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["E4"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["E4"].Value = "น้ำหนักรวม (ตัน)";
                workSheet.Cells["E4"].Style.Font.Name = "Angsana New";
                workSheet.Cells["E4"].Style.Font.Size = 18;
                workSheet.Cells["E4"].Style.Font.Bold = true;
                workSheet.Cells["E4"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["E4"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["E4"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["E4"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(5).Width = 20;

                workSheet.Cells["F4"].Merge = true;
                workSheet.Cells["F4"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["F4"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["F4"].Value = "ทรายถม (ตัน)";
                workSheet.Cells["F4"].Style.Font.Name = "Angsana New";
                workSheet.Cells["F4"].Style.Font.Size = 18;
                workSheet.Cells["F4"].Style.Font.Bold = true;
                workSheet.Cells["F4"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["F4"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["F4"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["F4"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(6).Width = 20;

                workSheet.Cells["G4"].Merge = true;
                workSheet.Cells["G4"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["G4"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["G4"].Value = "ทรายหยาบ (ตัน)";
                workSheet.Cells["G4"].Style.Font.Name = "Angsana New";
                workSheet.Cells["G4"].Style.Font.Size = 18;
                workSheet.Cells["G4"].Style.Font.Bold = true;
                workSheet.Cells["G4"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["G4"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["G4"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["G4"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(7).Width = 20;

                workSheet.Cells["H4"].Merge = true;
                workSheet.Cells["H4"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                workSheet.Cells["H4"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                workSheet.Cells["H4"].Value = "ทรายละเอียด (ตัน)";
                workSheet.Cells["H4"].Style.Font.Name = "Angsana New";
                workSheet.Cells["H4"].Style.Font.Size = 18;
                workSheet.Cells["H4"].Style.Font.Bold = true;
                workSheet.Cells["H4"].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["H4"].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["H4"].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                workSheet.Cells["H4"].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                workSheet.Column(8).Width = 20;

                //using (ExcelRange Rng = workSheet.Cells[2, 1, 3, 1])
                //{
                //    Rng.Merge = true;
                //    Rng.Style.Font.Bold = true;
                //    Rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                //    Rng.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
                //}



                #endregion

                #region excel rows
                int row = 0;
                int col = 0;
                for (row = 0; row < totalRows; row++)
                {
                    for (col = 0; col <= totalCols - 1; col++)
                    {
                        workSheet.Cells[row + 5, col + 1].Value = dt.Rows[row][col];
                        workSheet.Cells[row + 5, col + 1].Style.Font.Name = "Angsana New";
                        workSheet.Cells[row + 5, col + 1].Style.Font.Size = 18;
                        workSheet.Cells[row + 5, col + 1].Style.Font.Bold = false;
                        workSheet.Cells[row + 5, col + 1].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[row + 5, col + 1].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[row + 5, col + 1].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[row + 5, col + 1].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[row + 5, col + 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        workSheet.Cells[row + 5, col + 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                        //workSheet.Cells[row + 4, 3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                    }
                }
                #endregion

                #region excel memory saveas
                using (var memoryStream = new MemoryStream())
                {
                    Response.AddHeader("content-disposition", "attachment;  filename=รายงานจำนวนเที่ยว" + sdate + ".xlsx");
                    excel.SaveAs(memoryStream);
                    memoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
                #endregion
            }
            catch (Exception ex)
            {
                string exError = ex.Message;
                Response.Write("<script>alert('พบข้อผิดพลาด..!, " + exError + "');</script>");
                return;
            }
        }
    }
}