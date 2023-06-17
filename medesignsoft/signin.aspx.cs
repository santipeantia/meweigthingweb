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
using VFPOLEDBLib;

namespace medesignsoft
{
    public partial class signin : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();

        string ssql;
        DataTable dt = new DataTable();

        DataTable dtx = new DataTable();

        public static string strErorConn = "";

        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlTransaction transac;

        dbConnExpress dbConnExp = new dbConnExpress();

        public_variable pv = new public_variable();

        public string strMsgAlert = "";
        public string strTblDetail = "";
        public string strTblActive = "";
        public string strErrorConn = "";

        protected void Page_Load(object sender, EventArgs e)
        {           
            if (!IsPostBack)
            {
                strErrorConn = "";                
            }
        }

        protected void btnLogin_click (object sender, EventArgs e) {
            try
            {

                //string ConnectionString = @"Provider=vfpoledb;Data Source=D:\Source\Respos2021\meweigthingwin\DataExpress;Collating Sequence=machine;";

                //OleDbConnection exconn = new OleDbConnection();
                //exconn.ConnectionString = ConnectionString;
                //exconn.Open();

                //string sqlex;
                //try
                //{
                //    sqlex = "select * from stmas ";
                //    dtx = dbConnExp.GetDataTable(sqlex);
                //}
                //catch (Exception ex)
                //{
                //    Response.Write(ex.Message);
                //}


                string strUserName = Request.Form["inpUserName"];
                string strPassWord = Request.Form["inpPassWord"];

                //Server.Transfer(strUserName);
                //Server.Transfer("~/index.aspx?pwd="+strPassWord+"&usr="+strUserName);
                //Response.Redirect("~/index.aspx");
                //string encassword = encryptpass(strPassWord);

                ssql = "exec spGetUserLogin '" + strUserName + "', '" + strPassWord + "' ";
                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    Session["UserID"] = null;
                    Session["imEmployeeGid"] = null;
                    Session["FirstName"] = null;
                    Session["LastName"] = null;
                    Session["UserName"] = null;
                    Session["UserPassword"] = null;
                    Session["UserTypeID"] = null;
                    Session["UserTypeDesc"] = null;
                    Session["ActiveID"] = null;
                    Session["activename"] = null;
                    Session["CreatedBy"] = null;
                    Session["CreatedDate"] = null;
                    Session["UpdatedBy"] = null;
                    Session["UpdateDate"] = null;
                    Session["imPositionID"] = null;
                    Session["PositionName"] = null;
                    Session["imDepartmentID"] = null;
                    Session["DepartmentDesc"] = null;
                    Session["imSectionID"] = null;
                    Session["SectionDesc"] = null;
                    Session["EMail"] = null;
                    Session["imBranchGID"] = null;
                    Session["BranchName"] = null;
                    Session["adCompanyID"] = null;
                    Session["CompanyNameTh"] = null;

                    Session["UserID"] = dt.Rows[0]["UserID"].ToString();
                    Session["imEmployeeGid"] = dt.Rows[0]["imEmployeeGid"].ToString();
                    Session["FirstName"] = dt.Rows[0]["FirstName"].ToString();
                    Session["LastName"] = dt.Rows[0]["LastName"].ToString();
                    Session["UserName"] = dt.Rows[0]["UserName"].ToString();
                    Session["UserPassword"] = dt.Rows[0]["UserPassword"].ToString();
                    Session["UserTypeID"] = dt.Rows[0]["UserTypeID"].ToString();
                    Session["UserTypeDesc"] = dt.Rows[0]["UserTypeDesc"].ToString();
                    Session["ActiveID"] = dt.Rows[0]["ActiveID"].ToString();
                    Session["activename"] = dt.Rows[0]["activename"].ToString();
                    Session["CreatedBy"] = dt.Rows[0]["CreatedBy"].ToString();
                    Session["CreatedDate"] = dt.Rows[0]["CreatedDate"].ToString();
                    Session["UpdatedBy"] = dt.Rows[0]["UpdatedBy"].ToString();
                    Session["UpdateDate"] = dt.Rows[0]["UpdateDate"].ToString();
                    Session["imPositionID"] = dt.Rows[0]["imPositionID"].ToString();
                    Session["PositionName"] = dt.Rows[0]["PositionName"].ToString();
                    Session["imDepartmentID"] = dt.Rows[0]["imDepartmentID"].ToString();
                    Session["DepartmentDesc"] = dt.Rows[0]["DepartmentDesc"].ToString();
                    Session["imSectionID"] = dt.Rows[0]["imSectionID"].ToString();
                    Session["SectionDesc"] = dt.Rows[0]["SectionDesc"].ToString();
                    Session["EMail"] = dt.Rows[0]["EMail"].ToString();
                    Session["imBranchGID"] = dt.Rows[0]["imBranchGID"].ToString();
                    Session["BranchName"] = dt.Rows[0]["BranchName"].ToString();
                    Session["adCompanyID"] = dt.Rows[0]["adCompanyID"].ToString();
                    Session["CompanyNameTh"] = dt.Rows[0]["CompanyNameTh"].ToString();


                    //getPermissionMenu(strUserName);


                    Response.Redirect("~/index.aspx?usr=" + Session["UserName"]);
                    //Server.Transfer("~/index.aspx?pwd=" + strPassWord + "&usr=" + strUserName);
                }
                else
                {
                    strErorConn = " <div class=\"fad fad-in alert alert-danger input-sm\"> " +
                                "   <strong>Warning!</strong><br />Find not found username or password please check..!</div> ";
                    return;
                }
            }
            catch (Exception ex)
            {
                strErorConn = " <div class=\"fad fad-in alert alert-danger input-sm\"> " +
                                "   <strong>Warning!</strong><br />Incorrect username or password <br /> " + ex.Message + "</div> ";
                //divWraning.Visible = true;
            }
        }

        protected void getPermissionMenu(string user)
        {
            try
            {
                ssql = "exec spGetPermissionMenu '" + user + "' ";
                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count > 0)
                {
                    string menuname = "";
                    string menusource = "";

                    string smnusystem = dt.Rows[0]["mnusystem"].ToString();
                    string smnutruckweigth = dt.Rows[0]["mnutruckweigth"].ToString();
                    string smnuinventory = dt.Rows[0]["mnuinventory"].ToString();
                    string smnulettercredit = dt.Rows[0]["mnulettercredit"].ToString();
                    string smnupettycash = dt.Rows[0]["mnupettycash"].ToString();
                    string smnupurchaseorder = dt.Rows[0]["mnupurchaseorder"].ToString();
                    string smnusalesorder = dt.Rows[0]["mnusalesorder"].ToString();
                    string smnumessenger = dt.Rows[0]["mnumessenger"].ToString();
                    string smnucrm = dt.Rows[0]["mnucrm"].ToString();
                    string smnuwarehouse = dt.Rows[0]["mnuwarehouse"].ToString();

                    string mnusystem = "";
                    string submenu = "";

                    if (smnusystem == "True")
                    {
                        ssql = "select * from adSystemPagesMenu where menu_name = 'mnusystem' ";
                        dt = new DataTable();
                        dt = dbConn.GetDataTable(ssql);

                        Session["mnusystem"]  = dt.Rows[0]["menu_source"].ToString();

                        ssql = "select * from adSystemPageSubMenu where menu_name = 'mnusystem' and isactive = 'true' order by menu_seqno ";
                        dt = new DataTable();
                        dt = dbConn.GetDataTable(ssql);

                        if (dt.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                submenu += dt.Rows[i]["menu_source"].ToString();
                            }
                        }

                        Session["mnusystem"] = Session["mnusystem"].ToString().Replace("mnusystem", submenu);

                        //submenu = dt.Rows[0]["menu_source"].ToString();
                    }

                }
            }
            catch (Exception ex)
            {
            }
        }

    }
}