using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


namespace medesignsoft.meenterprise_management
{
    public partial class gm_company_setup : System.Web.UI.Page
    {
        SqlCommand Comm = new SqlCommand();
        SqlConnection Conn = new SqlConnection();

        dbConnection dbConn = new dbConnection();

        DataTable dt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {

            Conn = dbConn.OpenConn();
            Comm = new SqlCommand("spGetCompanyExcel", Conn);
            Comm.CommandType = CommandType.StoredProcedure;

            //conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = Comm;
            dt = new DataTable();
            adapter.Fill(dt);

            GridView GridviewExport = new GridView();

            if (dt.Rows.Count != 0)
            {

                GridviewExport.DataSource = dt;
                GridviewExport.DataBind();

                Response.Clear();
                Response.AddHeader("content-disposition", "attachment;filename=ExportCompany.xls");
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
            dbConn.CloseConn();
        }
    }
}