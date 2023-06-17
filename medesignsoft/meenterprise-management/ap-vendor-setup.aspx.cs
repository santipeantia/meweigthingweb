using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.IO;
using System.Text;
using CrystalDecisions.CrystalReports.Engine;
using System.Security.Cryptography;
using System.Net;
using System.Net.Mail;

namespace medesignsoft.meenterprise_management
{
    public partial class ap_vendor_setup : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        ReportDocument rpt = new ReportDocument();

        string ssql;
        DataTable dt = new DataTable();

        public static string strErorConn = "";

        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlTransaction transac;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnExportExcel_click(object sender, EventArgs e)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spGetVendorExcleList", Conn);
                Comm.CommandType = CommandType.StoredProcedure;

                da = new SqlDataAdapter();
                da.SelectCommand = Comm;
                dt = new DataTable();
                da.Fill(dt);
                               
                GridView GridviewExport = new GridView();

                if (dt.Rows.Count != 0)
                {
                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=ExportVendorList.xls");
                    Response.ContentType = "application/ms-excel";
                    Response.ContentEncoding = System.Text.Encoding.Unicode;
                    Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

                    System.IO.StringWriter sw = new System.IO.StringWriter();
                    System.Web.UI.HtmlTextWriter hw = new HtmlTextWriter(sw);

                    GridviewExport.RenderControl(hw);
                    string style = @"<style> td { mso-number-format:\@;} </style>";
                    Response.Write(style);
                    Response.Write(sw.ToString());
                    Response.End();

                }
                Response.Write("<script>alert('Data find not found please check...')</script>");

            }
            catch (Exception ex)
            {

            }
        }
    }
}