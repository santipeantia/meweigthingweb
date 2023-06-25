﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using CrystalDecisions.CrystalReports.Engine;
using System.Security.Cryptography;
using CrystalDecisions.Shared;

namespace medesignsoft.mesales_order
{
    public partial class so_truck_quotation_edit : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();
        bahttext bahttext = new bahttext();

        ReportDocument rpt = new ReportDocument();

        public string strUser = "sa";
        public string strPassword = "AmpelCloud@2020";
        public string strServer = "147.50.150.243";
        public string strSource = "ThantharaCo";
        string ssql;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnprint_click(object sender, EventArgs e)
        {
            try
            {
                string qtgid = Request.Form["hidqtgid"];
                string docuno = Request.Form["hiddocuno"];
                double totalamount = Convert.ToDouble(Request.Form["txttotalamount"].Replace(",", ""));

                string xbahttext = bahttext.ToBahtText(totalamount);


                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/Quotation/rptQuotation.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@qtgid", qtgid);
                rpt.SetParameterValue("xbahttext", xbahttext);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, docuno);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }
    }
}