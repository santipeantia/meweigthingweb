using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.IO;
using System.Text;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
namespace medesignsoft.metruck_weigth
{
    /// <summary>
    /// Summary description for servicetruck
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class servicetruck : System.Web.Services.WebService
    {
        dbConnection conn = new dbConnection();

        [WebMethod]
        public void GetTruckDaily (string sdate, string edate)
        {
            List<cTruckDaily> datas = new List<cTruckDaily>();
            SqlCommand comm = new SqlCommand("spGetTruckDaily", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cTruckDaily data = new cTruckDaily();               
                data.stat = rdr["STAT"].ToString();
                data.truck = rdr["TRUCK"].ToString();
                data.truckname = rdr["TRUCKNAME"].ToString();
                data.weight = rdr["WEIGHT"].ToString();
                data.cartype = rdr["CARTYPE"].ToString();
                data.typename = rdr["TYPENAME"].ToString();
                data.company = rdr["COMPANY"].ToString();
                data.comname = rdr["COMNAME"].ToString();
                data.product = rdr["PRODUCT"].ToString();
                data.proname = rdr["PRONAME"].ToString();
                data.subcon = rdr["SUBCON"].ToString();
                data.subname = rdr["SUBNAME"].ToString();
                data.remark1 = rdr["REMARK1"].ToString();
                data.remark2 = rdr["REMARK2"].ToString();
                data.remark3 = rdr["REMARK3"].ToString();
                data.factor = rdr["FACTOR"].ToString();
                data.vatcase = rdr["VATCASE"].ToString();
                data.price = rdr["PRICE"].ToString();
                data.rate = rdr["RATE"].ToString();
                data.vat_r = rdr["VAT_R"].ToString();
                data.ticket1 = rdr["TICKET1"].ToString();
                data.dayin = rdr["DAYIN"].ToString();
                data.dayin2 = rdr["DAYIN2"].ToString();
                data.tmin = rdr["TMIN"].ToString();
                data.w1 = rdr["W1"].ToString();
                data.ticket2 = rdr["TICKET2"].ToString();
                data.dayout = rdr["DAYOUT"].ToString();
                data.dayout2 = rdr["DAYOUT2"].ToString();
                data.tmout = rdr["TMOUT"].ToString();
                data.w2 = rdr["W2"].ToString();
                data.wnet = rdr["WNET"].ToString();
                data.adj_w1 = rdr["ADJ_W1"].ToString();
                data.adj_w2 = rdr["ADJ_W2"].ToString();
                data.adj_m = rdr["ADJ_M"].ToString();
                data.staff = rdr["STAFF"].ToString();
                data.usrname = rdr["USRNAME"].ToString();
                data.process = rdr["PROCESS"].ToString();
                data.print1 = rdr["PRINT1"].ToString();
                data.print2 = rdr["PRINT2"].ToString();
                data.scalein = rdr["SCALEIN"].ToString();
                data.scaleout = rdr["SCALEOUT"].ToString();
                data.link = rdr["LINK"].ToString();
                data.billstatus = rdr["BillStatus"].ToString();
                data.btnaction = rdr["btnAction"].ToString();
                data.refid = rdr["RefID"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetTwCompanyList()
        {
            List<cGetTwCompanyList> datas = new List<cGetTwCompanyList>();
            SqlCommand comm = new SqlCommand("sptw_CompanyList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetTwCompanyList data = new cGetTwCompanyList();
                data.CompCode = rdr["CompCode"].ToString();
                data.CompName = rdr["CompName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();

        }


        [WebMethod]
        public void GetTwCompanyBydate(string sdate, string edate)
        {
            List<cGetTwCompanyList> datas = new List<cGetTwCompanyList>();
            SqlCommand comm = new SqlCommand("sptw_GetCustomerBydate", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 1200; 

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetTwCompanyList data = new cGetTwCompanyList();
                data.CompCode = rdr["CompCode"].ToString();
                data.CompName = rdr["CompName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();

        }

        [WebMethod]
        public void GetTwProductList() {
            List<cGetTwProductList> datas = new List<cGetTwProductList>();
            SqlCommand comm = new SqlCommand("sptw_ProductList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetTwProductList data = new cGetTwProductList();
                data.productcode = rdr["productcode"].ToString();
                data.productname = rdr["productname"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        
            [WebMethod]
        public void GetTwProducBydate(string sdate, string edate, string custcode)
        {
            List<cGetTwProductList> datas = new List<cGetTwProductList>();
            SqlCommand comm = new SqlCommand("sptw_GetProductBydate", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@custcode", custcode);
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetTwProductList data = new cGetTwProductList();
                data.productcode = rdr["productcode"].ToString();
                data.productname = rdr["productname"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
    }
}
