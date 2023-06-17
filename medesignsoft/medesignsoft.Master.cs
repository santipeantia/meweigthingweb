using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace medesignsoft
{
    public partial class medesignsoft : System.Web.UI.MasterPage
    {

        public string mnusystem = "";


        public string mnutestsystemmenu = "";
        public string mnutestsystemmenu2 = "";


        public string stropt = "";
        public string optenterprise = "";
        public string optgen = "";
        public string optap = "";
        public string optar = "";
        public string optcq = "";
        public string optgl = "";
        public string optic = "";
        public string optmc = "";
        public string optcrm = "";
        public string optso = "";
        public string opttax = "";
        public string optwh = "";

        public string optaccoutspayment = "";
        public string optape = "";
        public string optapc = "";
        public string optapr = "";
        public string optapa = "";
        public string optaph = "";

        public string optaccoutsreceivable = "";
        public string optare = "";
        public string optarc = "";
        public string optarr = "";
        public string optara = "";
        public string optarh = "";

        public string optbudgetcontrol = "";
        public string optbge = "";
        public string optbgr = "";

        public string optchequerec = "";
        public string optcqr = "";
        public string optcqp = "";
        public string optcqb = "";
        public string optcqc = "";
        public string optcqre = "";
        public string optcqa = "";
        public string optcqh = "";

        public string optfinancial = "";
        public string optfma = "";
        public string optfmr = "";

        public string optgeneralledger = "";
        public string optgle = "";
        public string optglr = "";
        public string optglf = "";
        public string optglh = "";

        public string optinventory = "";
        public string optice = "";
        public string opticr = "";
        public string optica = "";
        public string opticc = "";
        public string optics = "";

        public string optlettercredit = "";
        public string optlce = "";
        public string optlcr = "";

        public string optpettycash = "";
        public string optpce = "";
        public string optpcr = "";

        public string optpurchaseorder = "";
        public string optpoe = "";
        public string optpoc = "";
        public string optpor = "";
        public string optpoa = "";
        public string optpoh = "";

        public string optsalesorder = "";
        public string optsoe = "";
        public string optsoc = "";
        public string optsor = "";
        public string optsoa = "";
        public string optsoh = "";

        public string optmessanger = "";
        public string optmms = "";
        public string optmme = "";
        public string optmmc = "";
        public string optmmr = "";
        public string optmma = "";

        public string optcrmsys = "";
        public string optcrme = "";
        public string optcrmc = "";
        public string optcrmr = "";
        public string optcrma = "";

        public string optadvsys = "";
        public string optadve = "";
        public string optadvr = "";

        public string optwhms = "";
        public string optwhme = "";
        public string optwhmc = "";
        public string optwhmr = "";
        public string optwhma = "";
        public string optwhml = "";

        public string optweigth = "";
        public string optweigthic = "";
        public string optweigthrep = "";
        public string optweigthana = "";
        public string optweigthset = "";

        public string strUserID = "";
        public string strimEmployeeGid = "";
        public string strFirstName = "";
        public string strLastName = "";
        public string strUserName = "";
        public string strUserPassword = "";
        public string strUserTypeID = "";
        public string strUserTypeDesc = "";
        public string strActiveID = "";
        public string stractivename = "";
        public string strCreatedBy = "";
        public string strCreatedDate = "";
        public string strUpdatedBy = "";
        public string strUpdateDate = "";
        public string strimPositionID = "";
        public string strPositionName = "";
        public string strimDepartmentID = "";
        public string strDepartmentDesc = "";
        public string strimSectionID = "";
        public string strSectionDesc = "";
        public string strEMail = "";
        public string strimBranchGID = "";
        public string strBranchName = "";
        public string stradCompanyID = "";
        public string strCompanyNameTh = "";

        public string strusr = "";
        public string strpwd = "";

        public string struserid = "";
        public string strpwdid = "";

        public_variable pv = new public_variable();

        dbConnection dbConn = new dbConnection();

        string ssql;
        DataTable dt = new DataTable();

        public static string strErorConn = "";

        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();

        protected void Page_Load(object sender, EventArgs e)
        {         
            try
            {
                if (!this.IsPostBack)
                {
                    strUserID = Session["UserID"].ToString();
                    strimEmployeeGid = Session["imEmployeeGid"].ToString();
                    strFirstName = Session["FirstName"].ToString();
                    strLastName = Session["LastName"].ToString();
                    strUserName = Session["UserName"].ToString();
                    strUserPassword = Session["UserPassword"].ToString();
                    strUserTypeID = Session["UserTypeID"].ToString();
                    strUserTypeDesc = Session["UserTypeDesc"].ToString();
                    strActiveID = Session["ActiveID"].ToString();
                    stractivename = Session["activename"].ToString();
                    strCreatedBy = Session["CreatedBy"].ToString();
                    strCreatedDate = Session["CreatedDate"].ToString();
                    strUpdatedBy = Session["UpdatedBy"].ToString();
                    strUpdateDate = Session["UpdateDate"].ToString();
                    strimPositionID = Session["imPositionID"].ToString();
                    strPositionName = Session["PositionName"].ToString();
                    strimDepartmentID = Session["imDepartmentID"].ToString();
                    strDepartmentDesc = Session["DepartmentDesc"].ToString();
                    strimSectionID = Session["imSectionID"].ToString();
                    strSectionDesc = Session["SectionDesc"].ToString();
                    strEMail = Session["EMail"].ToString();
                    strimBranchGID = Session["imBranchGID"].ToString();
                    strBranchName = Session["BranchName"].ToString();
                    stradCompanyID = Session["adCompanyID"].ToString();
                    strCompanyNameTh = Session["CompanyNameTh"].ToString();

                    //mnutestsystemmenu = Session["mnutestsystemmenu"].ToString();

                    //strUserID = dt.Rows[0]["UserID"].ToString();
                    //strimEmployeeGid = dt.Rows[0]["imEmployeeGid"].ToString();
                    //strFirstName = dt.Rows[0]["FirstName"].ToString();
                    //strLastName = dt.Rows[0]["LastName"].ToString();
                    //strUserName = dt.Rows[0]["UserName"].ToString();
                    //strUserPassword = dt.Rows[0]["UserPassword"].ToString();
                    //strUserTypeID = dt.Rows[0]["UserTypeID"].ToString();
                    //strUserTypeDesc = dt.Rows[0]["UserTypeDesc"].ToString();
                    //strActiveID = dt.Rows[0]["ActiveID"].ToString();
                    //stractivename = dt.Rows[0]["activename"].ToString();
                    //strCreatedBy = dt.Rows[0]["CreatedBy"].ToString();
                    //strCreatedDate = dt.Rows[0]["CreatedDate"].ToString();
                    //strUpdatedBy = dt.Rows[0]["UpdatedBy"].ToString();
                    //strUpdateDate = dt.Rows[0]["UpdateDate"].ToString();
                    //strimPositionID = dt.Rows[0]["imPositionID"].ToString();
                    //strPositionName = dt.Rows[0]["PositionName"].ToString();
                    //strimDepartmentID = dt.Rows[0]["imDepartmentID"].ToString();
                    //strDepartmentDesc = dt.Rows[0]["DepartmentDesc"].ToString();
                    //strimSectionID = dt.Rows[0]["imSectionID"].ToString();
                    //strSectionDesc = dt.Rows[0]["SectionDesc"].ToString();
                    //strEMail = dt.Rows[0]["EMail"].ToString();
                    //strimBranchGID = dt.Rows[0]["imBranchGID"].ToString();
                    //strBranchName = dt.Rows[0]["BranchName"].ToString();
                    //stradCompanyID = dt.Rows[0]["adCompanyID"].ToString();
                    //strCompanyNameTh = dt.Rows[0]["CompanyNameTh"].ToString();               

                    //strUserID = Request.Cookies["UserID"].Value;
                    //strimEmployeeGid = Request.Cookies["imEmployeeGid"].Value;
                    //strFirstName = Request.Cookies["FirstName"].Value;
                    //strLastName = Request.Cookies["LastName"].Value;

                    //getPermissionMenu(strUserName);

                    //mnusystem = Session["mnusystem"].ToString();

                    getPointer();
                }
            }
            catch {
                Response.Redirect("~/signin.aspx");
            }            
        }

        protected void getPermissionMenu(string user) {
            try
            {      
                ssql = "exec spGetPermissionMenu '" + user + "' ";
                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count > 0) {
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

                    string submenu = "";

                    if (smnusystem == "True") {
                        ssql = "select * from adSystemPagesMenu where menu_name = 'mnusystem' ";
                        dt = new DataTable();
                        dt = dbConn.GetDataTable(ssql);

                        mnusystem = dt.Rows[0]["menu_source"].ToString();

                        ssql = "select * from adSystemPageSubMenu where menu_name = 'mnusystem' and isactive = 'true' order by menu_seqno ";
                        dt = new DataTable();
                        dt = dbConn.GetDataTable(ssql);

                        if (dt.Rows.Count > 0) {
                            for (int i = 0; i < dt.Rows.Count; i++) {
                                submenu += dt.Rows[i]["menu_source"].ToString();
                            }
                        }

                        mnusystem = mnusystem.Replace("mnusystem", submenu);

                        //submenu = dt.Rows[0]["menu_source"].ToString();
                    }






                    //string menusourceen = "";

                    //for (int i = 0; i < dt.Rows.Count; i++)
                    //{
                    //    menuname = dt.Rows[i]["menu_name"].ToString();
                    //    menusource = dt.Rows[i]["menu_souce"].ToString();

                    //    if (menuname == "mnutestsystemmenu")
                    //    {


                    //        mnutestsystemmenu = menusource.Replace("mnutestsystemmenu", "12346789");
                    //    }
                    //    else if (menuname == "mnutestsystemmenu2")
                    //    {
                    //        mnutestsystemmenu2 = menusource;
                    //    }                      
                    //}
                }
            }
            catch (Exception ex)
            {
            }
        }

        protected void getPointer()
        {
            try
            {
                stropt = Request.QueryString["opt"].ToString();
                // Enterprise master
                if (stropt == "optgen") { optenterprise = "active"; optgen = "active text-red"; }
                else if (stropt == "optap") { optenterprise = "active  "; optap = "active text-red"; }
                else if (stropt == "optar") { optenterprise = "active  "; optar = "active text-red"; }
                else if (stropt == "optcq") { optenterprise = "active  "; optcq = "active text-red"; }
                else if (stropt == "optgl") { optenterprise = "active  "; optgl = "active text-red"; }
                else if (stropt == "optic") { optenterprise = "active  "; optic = "active text-red"; }
                else if (stropt == "optmc") { optenterprise = "active  "; optmc = "active text-red"; }
                else if (stropt == "optcrm") { optenterprise = "active  "; optcrm = "active text-red"; }
                else if (stropt == "optso") { optenterprise = "active  "; optso = "active text-red"; }
                else if (stropt == "opttax") { optenterprise = "active  "; opttax = "active text-red"; }
                else if (stropt == "optwh") { optenterprise = "active  "; optwh = "active text-red"; }
                else { optenterprise = ""; optgen = ""; optap = ""; optar = ""; optcq = ""; optgl = ""; optic = ""; optmc = ""; optcrm = ""; optso = ""; opttax = ""; optwh = ""; }


                // Truck Weigth System
                if (stropt == "optweigth") { optweigth = "active  "; optweigth = "active text-red"; }
                else if (stropt == "optweigthic") { optweigth = "active  "; optweigthic = "active text-red"; }
                else if (stropt == "optweigthrep") { optweigth = "active  "; optweigthrep = "active text-red"; }
                else if (stropt == "optweigthana") { optweigth = "active  "; optweigthana = "active text-red"; }
                else if (stropt == "optweigthset") { optweigth = "active  "; optweigthset = "active text-red"; }
                else { optweigth = ""; optweigthic = ""; optweigthrep = ""; optweigthana = ""; optweigthset = "";  }


                // Accounts Paymentable
                if (stropt == "optape") { optaccoutspayment = "active  "; optape = "active text-red"; }
                else if (stropt == "optapc") { optaccoutspayment = "active  "; optapc = "active text-red"; }
                else if (stropt == "optapr") { optaccoutspayment = "active  "; optapr = "active text-red"; }
                else if (stropt == "optapa") { optaccoutspayment = "active  "; optapa = "active text-red"; }
                else if (stropt == "optaph") { optaccoutspayment = "active  "; optaph = "active text-red"; }
                else { optaccoutspayment = ""; optape = ""; optapc = ""; optapr = ""; optapa = ""; optaph = ""; }

                // Accounts Receivable
                if (stropt == "optare") { optaccoutsreceivable = "active  "; optare = "active text-red"; }
                else if (stropt == "optarc") { optaccoutsreceivable = "active  "; optarc = "active text-red"; }
                else if (stropt == "optarr") { optaccoutsreceivable = "active  "; optarr = "active text-red"; }
                else if (stropt == "optara") { optaccoutsreceivable = "active  "; optara = "active text-red"; }
                else if (stropt == "optarh") { optaccoutsreceivable = "active  "; optarh = "active text-red"; }
                else { optaccoutsreceivable = ""; optare = ""; optarc = ""; optarr = ""; optara = ""; optarh = ""; }

                // Budger Control
                if (stropt == "optbge") { optbudgetcontrol = "active  "; optbge = "active text-red"; }
                else if (stropt == "optbgr") { optbudgetcontrol = "active  "; optbgr = "active text-red"; }
                else { optbudgetcontrol = ""; optbge = ""; optbgr = ""; }

                // Cheque and Bank
                if (stropt == "optcqr") { optchequerec = "active  "; optcqr = "active text-red"; }
                else if (stropt == "optcqp") { optchequerec = "active  "; optcqp = "active text-red"; }
                else if (stropt == "optcqb") { optchequerec = "active  "; optcqb = "active text-red"; }
                else if (stropt == "optcqc") { optchequerec = "active  "; optcqc = "active text-red"; }
                else if (stropt == "optcqre") { optchequerec = "active  "; optcqre = "active text-red"; }
                else if (stropt == "optcqa") { optchequerec = "active  "; optcqa = "active text-red"; }
                else if (stropt == "optcqh") { optchequerec = "active  "; optcqh = "active text-red"; }
                else { optchequerec = ""; optcqr = ""; optcqp = ""; optcqb = ""; optcqc = ""; optcqre = ""; optcqa = ""; optcqh = ""; }

                // Financial Management
                if (stropt == "optfma") { optfinancial = "active  "; optfma = "active text-red"; }
                else if (stropt == "optfmr") { optfinancial = "active  "; optfmr = "active text-red"; }
                else { optfinancial = ""; optfma = ""; optfmr = ""; }

                // General Ledger
                if (stropt == "optgle") { optgeneralledger = "active  "; optgle = "active text-red"; }
                else if (stropt == "optglr") { optgeneralledger = "active  "; optglr = "active text-red"; }
                else if (stropt == "optglf") { optgeneralledger = "active  "; optglf = "active text-red"; }
                else if (stropt == "optglh") { optgeneralledger = "active  "; optglh = "active text-red"; }
                else { optgeneralledger = ""; optgle = ""; optglr = ""; optglf = ""; optglh = ""; }

                // Inventory Control
                if (stropt == "optice") { optinventory = "active  "; optice = "active text-red"; }
                else if (stropt == "opticr") { optinventory = "active  "; opticr = "active text-red"; }
                else if (stropt == "optica") { optinventory = "active  "; optica = "active text-red"; }
                else if (stropt == "opticc") { optinventory = "active  "; opticc = "active text-red"; }
                else if (stropt == "optics") { optinventory = "active  "; optics = "active text-red"; }
                else { optinventory = ""; optice = ""; opticr = ""; optica = ""; opticc = ""; optics = ""; }

                // Letter Of Credit
                if (stropt == "optlce") { optlettercredit = "active  "; optlce = "active text-red"; }
                else if (stropt == "optlcr") { optlettercredit = "active  "; optlcr = "active text-red"; }
                else { optlettercredit = ""; optlce = ""; optlcr = ""; }

                // petty cash
                if (stropt == "optpce") { optpettycash = "active  "; optpce = "active text-red"; }
                else if (stropt == "optpcr") { optpettycash = "active  "; optpcr = "active text-red"; }
                else { optpettycash = ""; optpce = ""; optpcr = ""; }

                // purchase order
                if (stropt == "optpoe") { optpurchaseorder = "active  "; optpoe = "active text-red"; }
                else if (stropt == "optpoc") { optpurchaseorder = "active  "; optpoc = "active text-red"; }
                else if (stropt == "optpor") { optpurchaseorder = "active  "; optpor = "active text-red"; }
                else if (stropt == "optpoa") { optpurchaseorder = "active  "; optpoa = "active text-red"; }
                else if (stropt == "optpoh") { optpurchaseorder = "active  "; optpoh = "active text-red"; }
                else { optpurchaseorder = ""; optpoe = ""; optpoc = ""; optpor = ""; optpoa = ""; optpoh = ""; }

                // sales order
                if (stropt == "optsoe") { optsalesorder = "active  "; optsoe = "active text-red"; }
                else if (stropt == "optsoc") { optsalesorder = "active  "; optsoc = "active text-red"; }
                else if (stropt == "optsor") { optsalesorder = "active  "; optsor = "active text-red"; }
                else if (stropt == "optsoa") { optsalesorder = "active  "; optsoa = "active text-red"; }
                else if (stropt == "optsoh") { optsalesorder = "active  "; optsoh = "active text-red"; }
                else { optsalesorder = ""; optsoe = ""; optsoc = ""; optsor = ""; optsoa = ""; optsoh = ""; }

                // Messenger Management
                if (stropt == "optmms") { optmessanger = "active  "; optmms = "active text-red"; }
                else if (stropt == "optmme") { optmessanger = "active  "; optmme = "active text-red"; }
                else if (stropt == "optmmc") { optmessanger = "active  "; optmmc = "active text-red"; }
                else if (stropt == "optmmr") { optmessanger = "active  "; optmmr = "active text-red"; }
                else if (stropt == "optmma") { optmessanger = "active  "; optmma = "active text-red"; }
                else { optmessanger = ""; optmms = ""; optmme = ""; optmmc = ""; optmmr = ""; optmma = ""; }

                // CRM System
                if (stropt == "optcrme") { optcrmsys = "active  "; optcrme = "active text-red"; }
                else if (stropt == "optcrmc") { optcrmsys = "active  "; optcrmc = "active text-red"; }
                else if (stropt == "optcrmr") { optcrmsys = "active  "; optcrmr = "active text-red"; }
                else if (stropt == "optcrma") { optcrmsys = "active  "; optcrma = "active text-red"; }
                else { optcrmsys = ""; optcrme = ""; optcrmc = ""; optcrmr = ""; optcrma = ""; }

                // Advance System
                if (stropt == "optadve") { optadvsys = "active  "; optadve = "active text-red"; }
                else if (stropt == "optadvr") { optadvsys = "active  "; optadvr = "active text-red"; }
                else { optadvsys = ""; optadve = ""; optadvr = ""; }

                // Warehouse Management System
                if (stropt == "optwhme") { optwhms = "active  "; optwhme = "active text-red"; }
                else if (stropt == "optwhmc") { optwhms = "active  "; optwhmc = "active text-red"; }
                else if (stropt == "optwhmr") { optwhms = "active  "; optwhmr = "active text-red"; }
                else if (stropt == "optwhma") { optwhms = "active  "; optwhma = "active text-red"; }
                else if (stropt == "optwhml") { optwhms = "active  "; optwhml = "active text-red"; }
                else { optwhms = ""; optwhme = ""; optwhmc = ""; optwhmr = ""; optwhma = ""; optwhml = ""; }



            }
            catch
            {
            }
        }
    }
}