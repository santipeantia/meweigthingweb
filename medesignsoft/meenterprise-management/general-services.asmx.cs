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

namespace medesignsoft.meenterprise_management
{
    /// <summary>
    /// Summary description for general_services
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class general_services : System.Web.Services.WebService
    {
        dbConnection conn = new dbConnection();

        [WebMethod]
        public void getCompany()
        {
            List<cCompany> datas = new List<cCompany>();
            SqlCommand comm = new SqlCommand("spGetCompanyList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cCompany data = new cCompany();
                data.Gid = rdr["Gid"].ToString();
                data.adCompanyID = rdr["adCompanyID"].ToString();
                data.CompanyNameTh = rdr["CompanyNameTh"].ToString();
                data.CompanyNameEn = rdr["CompanyNameEn"].ToString();
                data.CompanyShortNameTh = rdr["CompanyShortNameTh"].ToString();
                data.CompanyShortNameEn = rdr["CompanyShortNameEn"].ToString();
                data.AddTh1 = rdr["AddTh1"].ToString();
                data.AddTh2 = rdr["AddTh2"].ToString();
                data.AddTh3 = rdr["AddTh3"].ToString();
                data.AddEn1 = rdr["AddEn1"].ToString();
                data.AddEn2 = rdr["AddEn2"].ToString();
                data.AddEn3 = rdr["AddEn3"].ToString();
                data.adProvinceID = rdr["adProvinceID"].ToString();
                data.ProvinceName = rdr["ProvinceName"].ToString();
                data.PostalCode = rdr["PostalCode"].ToString();
                data.adCountryID = rdr["adCountryID"].ToString();
                data.CountryName = rdr["CountryName"].ToString();
                data.Phone = rdr["Phone"].ToString();
                data.Fax = rdr["Fax"].ToString();
                data.EMail = rdr["EMail"].ToString();
                data.OwnerName = rdr["OwnerName"].ToString();
                data.TaxID = rdr["TaxID"].ToString();
                data.BFAccountBalanceDate = rdr["BFAccountBalanceDate"].ToString();
                data.Logo = rdr["Logo"].ToString();
                data.Active = rdr["Active"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                data.IsHaveBranch = rdr["IsHaveBranch"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getCompanyById(string gid)
        {
            List<cCompany> datas = new List<cCompany>();
            SqlCommand comm = new SqlCommand("spGetCompanyById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cCompany data = new cCompany();
                data.Gid = rdr["Gid"].ToString();
                data.adCompanyID = rdr["adCompanyID"].ToString();
                data.CompanyNameTh = rdr["CompanyNameTh"].ToString();
                data.CompanyNameEn = rdr["CompanyNameEn"].ToString();
                data.CompanyShortNameTh = rdr["CompanyShortNameTh"].ToString();
                data.CompanyShortNameEn = rdr["CompanyShortNameEn"].ToString();
                data.AddTh1 = rdr["AddTh1"].ToString();
                data.AddTh2 = rdr["AddTh2"].ToString();
                data.AddTh3 = rdr["AddTh3"].ToString();
                data.AddEn1 = rdr["AddEn1"].ToString();
                data.AddEn2 = rdr["AddEn2"].ToString();
                data.AddEn3 = rdr["AddEn3"].ToString();
                data.adProvinceID = rdr["adProvinceID"].ToString();
                data.ProvinceName = rdr["ProvinceName"].ToString();
                data.PostalCode = rdr["PostalCode"].ToString();
                data.adCountryID = rdr["adCountryID"].ToString();
                data.CountryName = rdr["CountryName"].ToString();
                data.Phone = rdr["Phone"].ToString();
                data.Fax = rdr["Fax"].ToString();
                data.EMail = rdr["EMail"].ToString();
                data.OwnerName = rdr["OwnerName"].ToString();
                data.TaxID = rdr["TaxID"].ToString();
                data.BFAccountBalanceDate = rdr["BFAccountBalanceDate"].ToString();
                data.Logo = rdr["Logo"].ToString();
                data.Active = rdr["Active"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                data.IsHaveBranch = rdr["IsHaveBranch"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getBranch() {
            List<cBranch> datas = new List<cBranch>();
            SqlCommand comm = new SqlCommand("spGetBranchList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cBranch data = new cBranch();
                data.imBranchGid = rdr["imBranchGid"].ToString();
                data.imBranchID = rdr["imBranchID"].ToString();
                data.BranchName = rdr["BranchName"].ToString();
                data.ShortBranchName = rdr["ShortBranchName"].ToString();
                data.adCompanyID = rdr["adCompanyID"].ToString();
                data.CompanyNameTh = rdr["CompanyNameTh"].ToString();
                data.TaxID = rdr["TaxID"].ToString();
                data.Add1 = rdr["Add1"].ToString();
                data.Add2 = rdr["Add2"].ToString();
                data.Add3 = rdr["Add3"].ToString();
                data.adProvinceID = rdr["adProvinceID"].ToString();
                data.ProvinceName = rdr["ProvinceName"].ToString();
                data.PostalCode = rdr["PostalCode"].ToString();
                data.adCountryID = rdr["adCountryID"].ToString();
                data.CountryName = rdr["CountryName"].ToString();
                data.Phone = rdr["Phone"].ToString();
                data.Fax = rdr["Fax"].ToString();
                data.WebSite = rdr["WebSite"].ToString();
                data.ContactID = rdr["ContactID"].ToString();
                data.ContactTel = rdr["ContactTel"].ToString();
                data.ContactEMail = rdr["ContactEMail"].ToString();
                data.Logo = rdr["Logo"].ToString();
                data.Active = rdr["Active"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();



        }

        [WebMethod]
        public void getBranchById(string gid)
        {
            List<cBranch> datas = new List<cBranch>();
            SqlCommand comm = new SqlCommand("spGetBranchById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cBranch data = new cBranch();
                data.imBranchGid = rdr["imBranchGid"].ToString();
                data.imBranchID = rdr["imBranchID"].ToString();
                data.BranchName = rdr["BranchName"].ToString();
                data.ShortBranchName = rdr["ShortBranchName"].ToString();
                data.adCompanyID = rdr["adCompanyID"].ToString();
                data.CompanyNameTh = rdr["CompanyNameTh"].ToString();
                data.TaxID = rdr["TaxID"].ToString();
                data.Add1 = rdr["Add1"].ToString();
                data.Add2 = rdr["Add2"].ToString();
                data.Add3 = rdr["Add3"].ToString();
                data.adProvinceID = rdr["adProvinceID"].ToString();
                data.ProvinceName = rdr["ProvinceName"].ToString();
                data.PostalCode = rdr["PostalCode"].ToString();
                data.adCountryID = rdr["adCountryID"].ToString();
                data.CountryName = rdr["CountryName"].ToString();
                data.Phone = rdr["Phone"].ToString();
                data.Fax = rdr["Fax"].ToString();
                data.WebSite = rdr["WebSite"].ToString();
                data.ContactID = rdr["ContactID"].ToString();
                data.ContactTel = rdr["ContactTel"].ToString();
                data.ContactEMail = rdr["ContactEMail"].ToString();
                data.Logo = rdr["Logo"].ToString();
                data.Active = rdr["Active"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getemployees()
        {
            List<cEmployees> datas = new List<cEmployees>();
            SqlCommand comm = new SqlCommand("spGetEmployees", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cEmployees data = new cEmployees();
                data.imEmployeeGid = rdr["imEmployeeGid"].ToString();
                data.EmployeeName = rdr["EmployeeName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getEmployeesList() {
            List<cEmployeesList> datas = new List<cEmployeesList>();
            SqlCommand comm = new SqlCommand("spGetEmployeesList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 3600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cEmployeesList data = new cEmployeesList();
                data.imEmployeeGid = rdr["imEmployeeGid"].ToString();

                data.imBranchGID = rdr["imBranchGID"].ToString();
                data.BranchName = rdr["BranchName"].ToString();
                data.imEmployeeID = rdr["imEmployeeID"].ToString();
                data.imTitleID = rdr["imTitleID"].ToString();
                data.TitleName = rdr["TitleName"].ToString();
                data.FirstName = rdr["FirstName"].ToString();
                data.MiddleName = rdr["MiddleName"].ToString();
                data.LastName = rdr["LastName"].ToString();
                data.NickName = rdr["NickName"].ToString();
                data.imPositionID = rdr["imPositionID"].ToString();
                data.PositionName = rdr["PositionName"].ToString();
                data.imDepartmentID = rdr["imDepartmentID"].ToString();
                data.DepartmentDesc = rdr["DepartmentDesc"].ToString();
                data.imSectionID = rdr["imSectionID"].ToString();
                data.SectionDesc = rdr["SectionDesc"].ToString();
                data.imDivisionID = rdr["imDivisionID"].ToString();
                data.DivisionDesc = rdr["DivisionDesc"].ToString();
                data.Add1 = rdr["Add1"].ToString();
                data.Add2 = rdr["Add2"].ToString();
                data.Add3 = rdr["Add3"].ToString();
                data.adProvinceID = rdr["adProvinceID"].ToString();
                data.ProvinceName = rdr["ProvinceName"].ToString();
                data.PostalCode = rdr["PostalCode"].ToString();
                data.adCountryID = rdr["adCountryID"].ToString();
                data.IDCardNO = rdr["IDCardNO"].ToString();
                data.imMaritalStatusID = rdr["imMaritalStatusID"].ToString();
                data.MaritalStatusDesc = rdr["MaritalStatusDesc"].ToString();
                data.imLivingStatusID = rdr["imLivingStatusID"].ToString();
                data.LivingStatusDesc = rdr["LivingStatusDesc"].ToString();
                data.imReligionID = rdr["imReligionID"].ToString();
                data.ReligionDesc = rdr["ReligionDesc"].ToString();
                data.imSexID = rdr["imSexID"].ToString();
                data.Birthday = rdr["Birthday"].ToString();
                data.Tel = rdr["Tel"].ToString();
                data.Mobile = rdr["Mobile"].ToString();
                data.Picture = rdr["Picture"].ToString();
                data.EMail = rdr["EMail"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.Active = rdr["Active"].ToString();
                data.activename = rdr["activename"].ToString();
                data.EffecDate = rdr["EffecDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                data.changpass = rdr["changpass"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getEmployeesById(string gid)
        {
            List<cEmployeesList> datas = new List<cEmployeesList>();
            SqlCommand comm = new SqlCommand("spGetEmployeesById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);
            comm.CommandTimeout = 3600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cEmployeesList data = new cEmployeesList();
                data.imEmployeeGid = rdr["imEmployeeGid"].ToString();
                data.imBranchID = rdr["imBranchID"].ToString();
                data.imBranchGID = rdr["imBranchGID"].ToString();
                data.imEmployeeID = rdr["imEmployeeID"].ToString();
                data.imTitleID = rdr["imTitleID"].ToString();
                data.TitleName = rdr["TitleName"].ToString();
                data.FirstName = rdr["FirstName"].ToString();
                data.MiddleName = rdr["MiddleName"].ToString();
                data.LastName = rdr["LastName"].ToString();
                data.NickName = rdr["NickName"].ToString();
                data.imPositionID = rdr["imPositionID"].ToString();
                data.PositionName = rdr["PositionName"].ToString();
                data.imDepartmentID = rdr["imDepartmentID"].ToString();
                data.DepartmentDesc = rdr["DepartmentDesc"].ToString();
                data.imSectionID = rdr["imSectionID"].ToString();
                data.SectionDesc = rdr["SectionDesc"].ToString();
                data.imDivisionID = rdr["imDivisionID"].ToString();
                data.DivisionDesc = rdr["DivisionDesc"].ToString();
                data.Add1 = rdr["Add1"].ToString();
                data.Add2 = rdr["Add2"].ToString();
                data.Add3 = rdr["Add3"].ToString();
                data.adProvinceID = rdr["adProvinceID"].ToString();
                data.ProvinceName = rdr["ProvinceName"].ToString();
                data.PostalCode = rdr["PostalCode"].ToString();
                data.adCountryID = rdr["adCountryID"].ToString();
                data.IDCardNO = rdr["IDCardNO"].ToString();
                data.imMaritalStatusID = rdr["imMaritalStatusID"].ToString();
                data.MaritalStatusDesc = rdr["MaritalStatusDesc"].ToString();
                data.imLivingStatusID = rdr["imLivingStatusID"].ToString();
                data.LivingStatusDesc = rdr["LivingStatusDesc"].ToString();
                data.imReligionID = rdr["imReligionID"].ToString();
                data.ReligionDesc = rdr["ReligionDesc"].ToString();
                data.imSexID = rdr["imSexID"].ToString();
                data.Birthday = rdr["Birthday"].ToString();
                data.Tel = rdr["Tel"].ToString();
                data.Mobile = rdr["Mobile"].ToString();
                data.Picture = rdr["Picture"].ToString();
                data.EMail = rdr["EMail"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.Active = rdr["Active"].ToString();
                data.activename = rdr["activename"].ToString();
                data.EffecDate = rdr["EffecDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                data.UserName = rdr["UserName"].ToString();
                data.UserTypeID = rdr["UserTypeID"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getEmployeesUpdateEntry(string acttrans, string Gid, string imBranchID, string imEmployeeID, string imTitleID, string FirstName
            , string LastName, string NickName, string imPositionID, string imDepartmentID, string imSectionID, string imDivisionID, string Add1, string Add2
            , string Add3, string adProvinceID, string PostalCode, string adCountryID, string IDCardNO, string imMaritalStatusID, string imLivingStatusID
            , string imReligionID, string imSexID, string Birthday, string Tel, string Mobile, string EMail, string Remark, string Active, string EffecDate, string ExpireDate) {


            SqlCommand comm = new SqlCommand("spGetEmployeesUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@Gid", Gid);
            comm.Parameters.AddWithValue("@imBranchID", imBranchID);
            comm.Parameters.AddWithValue("@imEmployeeID", imEmployeeID);
            comm.Parameters.AddWithValue("@imTitleID", imTitleID);
            comm.Parameters.AddWithValue("@FirstName", FirstName);
            comm.Parameters.AddWithValue("@LastName", LastName);
            comm.Parameters.AddWithValue("@NickName", NickName);
            comm.Parameters.AddWithValue("@imPositionID", imPositionID);
            comm.Parameters.AddWithValue("@imDepartmentID", imDepartmentID);
            comm.Parameters.AddWithValue("@imSectionID", imSectionID);
            comm.Parameters.AddWithValue("@imDivisionID", imDivisionID);
            comm.Parameters.AddWithValue("@Add1", Add1);
            comm.Parameters.AddWithValue("@Add2", Add2);
            comm.Parameters.AddWithValue("@Add3", Add3);
            comm.Parameters.AddWithValue("@adProvinceID", adProvinceID);
            comm.Parameters.AddWithValue("@PostalCode", PostalCode);
            comm.Parameters.AddWithValue("@adCountryID", adCountryID);
            comm.Parameters.AddWithValue("@IDCardNO", IDCardNO);
            comm.Parameters.AddWithValue("@imMaritalStatusID", imMaritalStatusID);
            comm.Parameters.AddWithValue("@imLivingStatusID", imLivingStatusID);
            comm.Parameters.AddWithValue("@imReligionID", imReligionID);
            comm.Parameters.AddWithValue("@imSexID", imSexID);
            comm.Parameters.AddWithValue("@Birthday", Birthday);
            comm.Parameters.AddWithValue("@Tel", Tel);
            comm.Parameters.AddWithValue("@Mobile", Mobile);
            comm.Parameters.AddWithValue("@EMail", EMail);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.Parameters.AddWithValue("@Active", Active);
            comm.Parameters.AddWithValue("@EffecDate", EffecDate);
            comm.Parameters.AddWithValue("@ExpireDate", ExpireDate);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }


        [WebMethod]
        public void getprovince() {
            List<cProvince> datas = new List<cProvince>();
            SqlCommand comm = new SqlCommand("spGetProvince", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cProvince data = new cProvince();
                data.adProvinceID = rdr["adProvinceID"].ToString();
                data.ProvinceName = rdr["ProvinceName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getcountry()
        {
            List<cCountries> datas = new List<cCountries>();
            SqlCommand comm = new SqlCommand("spGetCountry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cCountries data = new cCountries();
                data.adCountryID = rdr["adCountryID"].ToString();
                data.CountryName = rdr["CountryName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getTitlename() {
            List<cTitlename> datas = new List<cTitlename>();
            SqlCommand comm = new SqlCommand("spGetTitleName", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cTitlename data = new cTitlename();
                data.imTitleGid = rdr["imTitleGid"].ToString();
                data.TitleName = rdr["TitleName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getPosition() {
            List<cPosition> datas = new List<cPosition>();
            SqlCommand comm = new SqlCommand("spGetPosition", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cPosition data = new cPosition();
                data.imPositionID = rdr["imPositionID"].ToString();
                data.PositionName = rdr["PositionName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getDivision() {
            List<cDivision> datas = new List<cDivision>();
            SqlCommand comm = new SqlCommand("spGetDivision", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cDivision data = new cDivision();
                data.imDivisionID = rdr["imDivisionID"].ToString();
                data.DivisionDesc = rdr["DivisionDesc"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getMarry()
        {
            List<cMarry> datas = new List<cMarry>();
            SqlCommand comm = new SqlCommand("spGetMarry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cMarry data = new cMarry();
                data.imMaritalStatusID = rdr["imMaritalStatusID"].ToString();
                data.MaritalStatusDesc = rdr["MaritalStatusDesc"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getLivingStatus()
        {
            List<cLivingStatus> datas = new List<cLivingStatus>();
            SqlCommand comm = new SqlCommand("spGetLivingStatus", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cLivingStatus data = new cLivingStatus();
                data.imLivingStatusID = rdr["imLivingStatusID"].ToString();
                data.LivingStatusDesc = rdr["LivingStatusDesc"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getReligion()
        {
            List<cReligion> datas = new List<cReligion>();
            SqlCommand comm = new SqlCommand("spGetReligion", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cReligion data = new cReligion();
                data.imReligionID = rdr["imReligionID"].ToString();
                data.ReligionDesc = rdr["ReligionDesc"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getSex()
        {
            List<cSex> datas = new List<cSex>();
            SqlCommand comm = new SqlCommand("spGetSex", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSex data = new cSex();
                data.imSexID = rdr["imSexID"].ToString();
                data.SexDesc = rdr["SexDesc"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getactive()
        {
            List<cIsActive> datas = new List<cIsActive>();
            SqlCommand comm = new SqlCommand("spGetActive", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cIsActive data = new cIsActive();
                data.activeid = rdr["activeid"].ToString();
                data.activename = rdr["activename"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getSectionList() {
            List<cSectionList> datas = new List<cSectionList>();
            SqlCommand comm = new SqlCommand("spGetSectionList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSectionList data = new cSectionList();
                data.Gid = rdr["Gid"].ToString();
                data.imSectionID = rdr["imSectionID"].ToString();
                data.SectionDesc = rdr["SectionDesc"].ToString();
                data.SectionDesc2 = rdr["SectionDesc2"].ToString();
                data.Active = rdr["Active"].ToString();
                data.ActiveName = rdr["ActiveName"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getSectionById(string gid) {
            List<cSectionList> datas = new List<cSectionList>();
            SqlCommand comm = new SqlCommand("spGetSectionById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSectionList data = new cSectionList();
                data.Gid = rdr["Gid"].ToString();
                data.imSectionID = rdr["imSectionID"].ToString();
                data.SectionDesc = rdr["SectionDesc"].ToString();
                data.SectionDesc2 = rdr["SectionDesc2"].ToString();
                data.Active = rdr["Active"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getSectionUpdateEntry(string acttrans, string Gid, string imSectionID, string SectionDesc, string SectionDesc2, string Active, string EffectDate, string ExpireDate)
        {
            SqlCommand comm = new SqlCommand("spGetSectionUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@Gid", Gid);
            comm.Parameters.AddWithValue("@imSectionID", imSectionID);
            comm.Parameters.AddWithValue("@SectionDesc", SectionDesc);
            comm.Parameters.AddWithValue("@SectionDesc2", SectionDesc2);
            comm.Parameters.AddWithValue("@Active", Active);
            comm.Parameters.AddWithValue("@EffectDate", EffectDate);
            comm.Parameters.AddWithValue("@ExpireDate", ExpireDate);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getDepartmentList()
        {
            List<cDepartmentList> datas = new List<cDepartmentList>();
            SqlCommand comm = new SqlCommand("spGetDepartmentList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cDepartmentList data = new cDepartmentList();
                data.Gid = rdr["Gid"].ToString();
                data.imDepartmentID = rdr["imDepartmentID"].ToString();
                data.DepartmentDesc = rdr["DepartmentDesc"].ToString();
                data.DepartmentDesc2 = rdr["DepartmentDesc2"].ToString();
                data.Active = rdr["Active"].ToString();
                data.ActiveName = rdr["ActiveName"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getDepartmentById(string gid)
        {
            List<cDepartmentList> datas = new List<cDepartmentList>();
            SqlCommand comm = new SqlCommand("spGetDepartmentById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cDepartmentList data = new cDepartmentList();
                data.Gid = rdr["Gid"].ToString();
                data.imDepartmentID = rdr["imDepartmentID"].ToString();
                data.DepartmentDesc = rdr["DepartmentDesc"].ToString();
                data.DepartmentDesc2 = rdr["DepartmentDesc2"].ToString();
                data.Active = rdr["Active"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getDepartmentUpdateEntry(string acttrans, string Gid, string imDepartmentID, string DepartmentDesc, string DepartmentDesc2, string Active, string EffectDate, string ExpireDate) {
            SqlCommand comm = new SqlCommand("spGetDepartmentUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@Gid", Gid);
            comm.Parameters.AddWithValue("@imDepartmentID", imDepartmentID);
            comm.Parameters.AddWithValue("@DepartmentDesc", DepartmentDesc);
            comm.Parameters.AddWithValue("@DepartmentDesc2", DepartmentDesc2);
            comm.Parameters.AddWithValue("@Active", Active);
            comm.Parameters.AddWithValue("@EffectDate", EffectDate);
            comm.Parameters.AddWithValue("@ExpireDate", ExpireDate);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getCompanyUpdateEntry(string acttrans, string Gid, string adCompanyID, string CompanyNameTh, string CompanyNameEn, string CompanyShortNameTh
                                        , string CompanyShortNameEn, string AddTh1, string AddTh2, string AddTh3, string AddEn1, string AddEn2, string AddEn3
                                        , string adProvinceID, string PostalCode, string adCountryID, string Phone, string Fax, string EMail
                                        , string OwnerName, string TaxID, string BFAccountBalanceDate, string Logo, string Active, string EffectDate
                                        , string ExpireDate, string IsHaveBranch)
        {

            SqlCommand comm = new SqlCommand("spGetCompanyUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@Gid", Gid);
            comm.Parameters.AddWithValue("@adCompanyID", adCompanyID);
            comm.Parameters.AddWithValue("@CompanyNameTh", CompanyNameTh);
            comm.Parameters.AddWithValue("@CompanyNameEn", CompanyNameEn);
            comm.Parameters.AddWithValue("@CompanyShortNameTh", CompanyShortNameTh);
            comm.Parameters.AddWithValue("@CompanyShortNameEn", CompanyShortNameEn);
            comm.Parameters.AddWithValue("@AddTh1", AddTh1);
            comm.Parameters.AddWithValue("@AddTh2", AddTh2);
            comm.Parameters.AddWithValue("@AddTh3", AddTh3);
            comm.Parameters.AddWithValue("@AddEn1", AddEn1);
            comm.Parameters.AddWithValue("@AddEn2", AddEn2);
            comm.Parameters.AddWithValue("@AddEn3", AddEn3);
            comm.Parameters.AddWithValue("@adProvinceID", adProvinceID);
            comm.Parameters.AddWithValue("@PostalCode", PostalCode);
            comm.Parameters.AddWithValue("@adCountryID", adCountryID);
            comm.Parameters.AddWithValue("@Phone", Phone);
            comm.Parameters.AddWithValue("@Fax", Fax);
            comm.Parameters.AddWithValue("@EMail", EMail);
            comm.Parameters.AddWithValue("@OwnerName", OwnerName);
            comm.Parameters.AddWithValue("@TaxID", TaxID);
            comm.Parameters.AddWithValue("@BFAccountBalanceDate", BFAccountBalanceDate);
            comm.Parameters.AddWithValue("@Logo", Logo);
            comm.Parameters.AddWithValue("@Active", Active);
            comm.Parameters.AddWithValue("@EffectDate", EffectDate);
            comm.Parameters.AddWithValue("@ExpireDate", ExpireDate);
            comm.Parameters.AddWithValue("@IsHaveBranch", IsHaveBranch);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getBranchUpdateEntry(string acttrans, string Gid, string imBranchID, string BranchName, string ShortBranchName, string adCompanyID, string TaxID, string Add1
                                        , string Add2, string Add3, string adProvinceID, string PostalCode, string adCountryID, string Phone, string Fax, string WebSite
                                        , string ContactID, string ContactTel, string ContactEMail, string Logo, string Active, string EffectDate, string ExpireDate) {
            SqlCommand comm = new SqlCommand("spGetBranchUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@Gid", Gid);
            comm.Parameters.AddWithValue("@imBranchID", imBranchID);
            comm.Parameters.AddWithValue("@BranchName", BranchName);
            comm.Parameters.AddWithValue("@ShortBranchName", ShortBranchName);
            comm.Parameters.AddWithValue("@adCompanyID", adCompanyID);
            comm.Parameters.AddWithValue("@TaxID", TaxID);
            comm.Parameters.AddWithValue("@Add1", Add1);
            comm.Parameters.AddWithValue("@Add2", Add2);
            comm.Parameters.AddWithValue("@Add3", Add3);
            comm.Parameters.AddWithValue("@adProvinceID", adProvinceID);
            comm.Parameters.AddWithValue("@PostalCode", PostalCode);
            comm.Parameters.AddWithValue("@adCountryID", adCountryID);
            comm.Parameters.AddWithValue("@Phone", Phone);
            comm.Parameters.AddWithValue("@Fax", Fax);
            comm.Parameters.AddWithValue("@WebSite", WebSite);
            comm.Parameters.AddWithValue("@ContactID", ContactID);
            comm.Parameters.AddWithValue("@ContactTel", ContactTel);
            comm.Parameters.AddWithValue("@ContactEMail", ContactEMail);
            comm.Parameters.AddWithValue("@Logo", Logo);
            comm.Parameters.AddWithValue("@Active", Active);
            comm.Parameters.AddWithValue("@EffectDate", EffectDate);
            comm.Parameters.AddWithValue("@ExpireDate", ExpireDate);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getAutorunList() {
            List<cAutorunList> datas = new List<cAutorunList>();
            SqlCommand comm = new SqlCommand("spGetAutorunList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cAutorunList data = new cAutorunList();
                data.AutoRunID = rdr["AutoRunID"].ToString();
                data.AutoRunCode = rdr["AutoRunCode"].ToString();
                data.AutoRunDesc = rdr["AutoRunDesc"].ToString();
                data.imBranchGid = rdr["imBranchGid"].ToString();
                data.BranchName = rdr["BranchName"].ToString();
                data.AutoRunFormat = rdr["AutoRunFormat"].ToString();
                data.AutoRunTitle = rdr["AutoRunTitle"].ToString();
                data.AutoRunYear = rdr["AutoRunYear"].ToString();
                data.AutoRunSplit = rdr["AutoRunSplit"].ToString();
                data.AutoRunNo = rdr["AutoRunNo"].ToString();
                data.DocuNo = rdr["DocuNo"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getAutorunById(string gid) {
            List<cAutorunList> datas = new List<cAutorunList>();
            SqlCommand comm = new SqlCommand("spGetAutorunById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cAutorunList data = new cAutorunList();
                data.AutoRunID = rdr["AutoRunID"].ToString();
                data.AutoRunCode = rdr["AutoRunCode"].ToString();
                data.AutoRunDesc = rdr["AutoRunDesc"].ToString();
                data.imBranchGid = rdr["imBranchGid"].ToString();
                data.BranchName = rdr["BranchName"].ToString();
                data.AutoRunFormat = rdr["AutoRunFormat"].ToString();
                data.AutoRunTitle = rdr["AutoRunTitle"].ToString();
                data.AutoRunYear = rdr["AutoRunYear"].ToString();
                data.AutoRunSplit = rdr["AutoRunSplit"].ToString();
                data.AutoRunNo = rdr["AutoRunNo"].ToString();
                data.DocuNo = rdr["DocuNo"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getAutorunUpdateEntry(string acttrans, string Gid, string AutoRunCode, string AutoRunDesc, string imBranchGid, string AutoRunFormat
                                            , string AutoRunTitle, string AutoRunYear, string AutoRunSplit, string AutoRunNo, string CreateUserID
                                            , string CreateDate, string CreateTime, string adUserID, string Lastdate, string LastTime) {
            SqlCommand comm = new SqlCommand("spGetAutorunUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@Gid", Gid);
            comm.Parameters.AddWithValue("@AutoRunCode", AutoRunCode);
            comm.Parameters.AddWithValue("@AutoRunDesc", AutoRunDesc);
            comm.Parameters.AddWithValue("@imBranchGid", imBranchGid);
            comm.Parameters.AddWithValue("@AutoRunFormat", AutoRunFormat);
            comm.Parameters.AddWithValue("@AutoRunTitle", AutoRunTitle);
            comm.Parameters.AddWithValue("@AutoRunYear", AutoRunYear);
            comm.Parameters.AddWithValue("@AutoRunSplit", AutoRunSplit);
            comm.Parameters.AddWithValue("@AutoRunNo", AutoRunNo);
            comm.Parameters.AddWithValue("@CreateUserID", CreateUserID);
            comm.Parameters.AddWithValue("@CreateDate", CreateDate);
            comm.Parameters.AddWithValue("@CreateTime", CreateTime);
            comm.Parameters.AddWithValue("@adUserID", adUserID);
            comm.Parameters.AddWithValue("@Lastdate", Lastdate);
            comm.Parameters.AddWithValue("@LastTime", LastTime);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getUsertype() {
            List<cUserType> datas = new List<cUserType>();
            SqlCommand comm = new SqlCommand("spGetUserType", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cUserType data = new cUserType();
                data.UserTypeID = rdr["UserTypeID"].ToString();
                data.UserTypeDesc = rdr["UserTypeDesc"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getUserLoginUpdateEntry(string acttrans, string Gid, string UserID, string imEmployeeGid, string FirstName, string LastName, string UserName, string UserPassword,
                                            string UserTypeID, string ActiveID, string CreatedBy, string CreatedDate, string UpdatedBy, string UpdateDate) {
            SqlCommand comm = new SqlCommand("spGetUserLoginUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@Gid", Gid);
            comm.Parameters.AddWithValue("@UserID", UserID);
            comm.Parameters.AddWithValue("@imEmployeeGid", imEmployeeGid);
            comm.Parameters.AddWithValue("@FirstName", FirstName);
            comm.Parameters.AddWithValue("@LastName", LastName);
            comm.Parameters.AddWithValue("@UserName", UserName);
            comm.Parameters.AddWithValue("@UserPassword", UserPassword);
            comm.Parameters.AddWithValue("@UserTypeID", UserTypeID);
            comm.Parameters.AddWithValue("@ActiveID", ActiveID);
            comm.Parameters.AddWithValue("@CreatedBy", CreatedBy);
            comm.Parameters.AddWithValue("@CreatedDate", CreatedDate);
            comm.Parameters.AddWithValue("@UpdatedBy", UpdatedBy);
            comm.Parameters.AddWithValue("@UpdateDate", UpdateDate);

            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getTermsList()
        {
            List<cTermsList> datas = new List<cTermsList>();
            SqlCommand comm = new SqlCommand("spGetTermsList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cTermsList data = new cTermsList();
                data.adPaymentTypeID = rdr["adPaymentTypeID"].ToString();
                data.PaymentTypeDesc = rdr["PaymentTypeDesc"].ToString();
                data.PaymentTypeDesc2 = rdr["PaymentTypeDesc2"].ToString();
                data.Active = rdr["Active"].ToString();
                data.activename = rdr["activename"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getTermsById(string gid) {
            List<cTermsList> datas = new List<cTermsList>();
            SqlCommand comm = new SqlCommand("spGetTermsById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cTermsList data = new cTermsList();
                data.adPaymentTypeID = rdr["adPaymentTypeID"].ToString();
                data.PaymentTypeDesc = rdr["PaymentTypeDesc"].ToString();
                data.PaymentTypeDesc2 = rdr["PaymentTypeDesc2"].ToString();
                data.Active = rdr["Active"].ToString();
                data.activename = rdr["activename"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getTermsUpdateEntry(string acttrans, string Gid, string adPaymentTypeID, string PaymentTypeDesc, string PaymentTypeDesc2,
                                        string Active, string EffectDate, string ExpireDate) {

            SqlCommand comm = new SqlCommand("spGetTermsUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@Gid", Gid);
            comm.Parameters.AddWithValue("@adPaymentTypeID", adPaymentTypeID);
            comm.Parameters.AddWithValue("@PaymentTypeDesc", PaymentTypeDesc);
            comm.Parameters.AddWithValue("@PaymentTypeDesc2", PaymentTypeDesc2);
            comm.Parameters.AddWithValue("@Active", Active);
            comm.Parameters.AddWithValue("@EffectDate", EffectDate);
            comm.Parameters.AddWithValue("@ExpireDate", ExpireDate);
            comm.ExecuteNonQuery();
            conn.CloseConn();

        }

        [WebMethod]
        public void getOndeliveryList() {
            List<cDeliveryList> datas = new List<cDeliveryList>();
            SqlCommand comm = new SqlCommand("spGetDeliveryList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cDeliveryList data = new cDeliveryList();
                data.imDeliveryID = rdr["imDeliveryID"].ToString();
                data.DeliveryName = rdr["DeliveryName"].ToString();
                data.DeliveryName2 = rdr["DeliveryName2"].ToString();
                data.Active = rdr["Active"].ToString();
                data.activename = rdr["activename"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getDeliveryById(string gid) {
            List<cDeliveryList> datas = new List<cDeliveryList>();
            SqlCommand comm = new SqlCommand("spGetDeliveryById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cDeliveryList data = new cDeliveryList();
                data.imDeliveryID = rdr["imDeliveryID"].ToString();
                data.DeliveryName = rdr["DeliveryName"].ToString();
                data.DeliveryName2 = rdr["DeliveryName2"].ToString();
                data.Active = rdr["Active"].ToString();
                data.activename = rdr["activename"].ToString();
                data.EffectDate = rdr["EffectDate"].ToString();
                data.ExpireDate = rdr["ExpireDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getDeliveryUpdateEntry(string acttrans, string Gid, string imDeliveryID, string DeliveryName, string DeliveryName2,
                                        string Active, string EffectDate, string ExpireDate)
        {
            SqlCommand comm = new SqlCommand("spGetDeliveryUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@Gid", Gid);
            comm.Parameters.AddWithValue("@imDeliveryID", imDeliveryID);
            comm.Parameters.AddWithValue("@DeliveryName", DeliveryName);
            comm.Parameters.AddWithValue("@DeliveryName2", DeliveryName2);
            comm.Parameters.AddWithValue("@Active", Active);
            comm.Parameters.AddWithValue("@EffectDate", EffectDate);
            comm.Parameters.AddWithValue("@ExpireDate", ExpireDate);
            comm.ExecuteNonQuery();
            conn.CloseConn();

        }

        [WebMethod]
        public void getVendorGroupList() {
            List<cVendorGroupList> datas = new List<cVendorGroupList>();
            SqlCommand comm = new SqlCommand("spGetVendorGroupList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cVendorGroupList data = new cVendorGroupList();
                data.VendorGroupID = rdr["VendorGroupID"].ToString();
                data.VendorGroupCode = rdr["VendorGroupCode"].ToString();
                data.VendorGroupName = rdr["VendorGroupName"].ToString();
                data.VendorGroupNameEng = rdr["VendorGroupNameEng"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getVendorGroupById(string gid) {
            List<cVendorGroupList> datas = new List<cVendorGroupList>();
            SqlCommand comm = new SqlCommand("spGetVendorGroupById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cVendorGroupList data = new cVendorGroupList();
                data.VendorGroupID = rdr["VendorGroupID"].ToString();
                data.VendorGroupCode = rdr["VendorGroupCode"].ToString();
                data.VendorGroupName = rdr["VendorGroupName"].ToString();
                data.VendorGroupNameEng = rdr["VendorGroupNameEng"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

       [WebMethod]
        public void getVendorGroupUpdateEntry(string acttrans, string gid, string VendorGroupID, string VendorGroupCode, string VendorGroupName, string VendorGroupNameEng, string Remark) {
            SqlCommand comm = new SqlCommand("spGetVendorGroupUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@VendorGroupID", VendorGroupID);
            comm.Parameters.AddWithValue("@VendorGroupCode", VendorGroupCode);
            comm.Parameters.AddWithValue("@VendorGroupName", VendorGroupName);
            comm.Parameters.AddWithValue("@VendorGroupNameEng", VendorGroupNameEng);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getVendorList() {
            List<cVendorList> datas = new List<cVendorList>();
            SqlCommand comm = new SqlCommand("spGetVendorList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cVendorList data = new cVendorList();
                data.VendorID = rdr["VendorID"].ToString();
                data.VendorCode = rdr["VendorCode"].ToString();
                data.VendorName = rdr["VendorName"].ToString();
                data.VendorNameEng = rdr["VendorNameEng"].ToString();
                data.ShortName = rdr["ShortName"].ToString();
                data.VendorStartDate = rdr["VendorStartDate"].ToString();
                data.VendorGroupID = rdr["VendorGroupID"].ToString();
                data.VendorGroupName = rdr["VendorGroupName"].ToString();
                data.Active = rdr["Active"].ToString();
                data.activename = rdr["activename"].ToString();
                data.InactiveDate = rdr["InactiveDate"].ToString();
                data.adPaymentTypeID = rdr["adPaymentTypeID"].ToString();
                data.PaymentTypeDesc = rdr["PaymentTypeDesc"].ToString();
                data.VendorTypeID = rdr["VendorTypeID"].ToString();
                data.VendorTypeName = rdr["VendorTypeName"].ToString();
                data.TaxId = rdr["TaxId"].ToString();
                data.VendorAddr1 = rdr["VendorAddr1"].ToString();
                data.VendorAddr2 = rdr["VendorAddr2"].ToString();
                data.District = rdr["District"].ToString();
                data.Amphur = rdr["Amphur"].ToString();
                data.adProvinceID = rdr["adProvinceID"].ToString();
                data.ProvinceName = rdr["ProvinceName"].ToString();
                data.PostCode = rdr["PostCode"].ToString();
                data.ContAddr1 = rdr["ContAddr1"].ToString();
                data.ContAddr2 = rdr["ContAddr2"].ToString();
                data.ContDistrict = rdr["ContDistrict"].ToString();
                data.ContAmphur = rdr["ContAmphur"].ToString();
                data.ContProvince = rdr["ContProvince"].ToString();
                data.ContPostCode = rdr["ContPostCode"].ToString();
                data.ContHomePage = rdr["ContHomePage"].ToString();
                data.ContTel = rdr["ContTel"].ToString();
                data.ContFax = rdr["ContFax"].ToString();
                data.CardNo = rdr["CardNo"].ToString();
                data.VATGroupID = rdr["VATGroupID"].ToString();
                data.VATGroupDesc = rdr["VATGroupDesc"].ToString();
                data.Birthdate = rdr["Birthdate"].ToString();
                data.ContTelExtend1 = rdr["ContTelExtend1"].ToString();
                data.ContTelExtend2 = rdr["ContTelExtend2"].ToString();
                data.imBranchID = rdr["imBranchID"].ToString();
                data.BranchCode = rdr["BranchCode"].ToString();
                data.BranchName = rdr["BranchName"].ToString();
                data.CreditDays = rdr["CreditDays"].ToString();
                data.CreditAmnt = rdr["CreditAmnt"].ToString();
                data.CreatedBy = rdr["CreatedBy"].ToString();
                data.CreatedDate = rdr["CreatedDate"].ToString();
                data.UpdatedBy = rdr["UpdatedBy"].ToString();
                data.UpdateDate = rdr["UpdateDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getVendorType()
        {
            List<cVendorType> datas = new List<cVendorType>();
            SqlCommand comm = new SqlCommand("spGetVendorType", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cVendorType data = new cVendorType();
                data.VendorTypeID = rdr["VendorTypeID"].ToString();
                data.VendorTypeCode = rdr["VendorTypeCode"].ToString();
                data.VendorTypeName = rdr["VendorTypeName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getVendorTypeList()
        {
            List<cVendorType> datas = new List<cVendorType>();
            SqlCommand comm = new SqlCommand("spGetVendorTypeList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cVendorType data = new cVendorType();
                data.VendorTypeID = rdr["VendorTypeID"].ToString();
                data.VendorTypeCode = rdr["VendorTypeCode"].ToString();
                data.VendorTypeName = rdr["VendorTypeName"].ToString();
                data.VendorTypeNameEng = rdr["VendorTypeNameEng"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getVendorTypeById(string gid) {
            List<cVendorType> datas = new List<cVendorType>();
            SqlCommand comm = new SqlCommand("spGetVendorTypeById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cVendorType data = new cVendorType();
                data.VendorTypeID = rdr["VendorTypeID"].ToString();
                data.VendorTypeCode = rdr["VendorTypeCode"].ToString();
                data.VendorTypeName = rdr["VendorTypeName"].ToString();
                data.VendorTypeNameEng = rdr["VendorTypeNameEng"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getVendorTypeUpdateEntry(string acttrans, string gid, string VendorTypeID, string VendorTypeCode, string VendorTypeName, string VendorTypeNameEng, string Remark) {
            SqlCommand comm = new SqlCommand("spGetVendorTypeUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@VendorTypeID", VendorTypeID);
            comm.Parameters.AddWithValue("@VendorTypeCode", VendorTypeCode);
            comm.Parameters.AddWithValue("@VendorTypeName", VendorTypeName);
            comm.Parameters.AddWithValue("@VendorTypeNameEng", VendorTypeNameEng);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getVendorById(string gid)
        {
            List<cVendorsById> datas = new List<cVendorsById>();
            SqlCommand comm = new SqlCommand("spGetVendorById2", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cVendorsById data = new cVendorsById();

                data.VendorID = rdr["VendorID"].ToString();
                data.VendorGroupID = rdr["VendorGroupID"].ToString();
                data.VendorGroupName = rdr["VendorGroupName"].ToString();
                data.VendorCode = rdr["VendorCode"].ToString();
                data.VendorName = rdr["VendorName"].ToString();
                data.VendorNameEng = rdr["VendorNameEng"].ToString();
                data.ShortName = rdr["ShortName"].ToString();
                data.VendorStartDate = rdr["VendorStartDate"].ToString();
                data.Active = rdr["Active"].ToString();
                data.activename = rdr["activename"].ToString();
                data.InactiveDate = rdr["InactiveDate"].ToString();
                data.adPaymentTypeID = rdr["adPaymentTypeID"].ToString();
                data.PaymentTypeDesc = rdr["PaymentTypeDesc"].ToString();
                data.VendorTypeID = rdr["VendorTypeID"].ToString();
                data.VendorTypeName = rdr["VendorTypeName"].ToString();
                data.TaxId = rdr["TaxId"].ToString();
                data.VendorAddr1 = rdr["VendorAddr1"].ToString();
                data.VendorAddr2 = rdr["VendorAddr2"].ToString();
                data.District = rdr["District"].ToString();
                data.Amphur = rdr["Amphur"].ToString();
                data.adProvinceID = rdr["adProvinceID"].ToString();
                data.ProvinceName = rdr["ProvinceName"].ToString();
                data.PostCode = rdr["PostCode"].ToString();
                data.ContAddr1 = rdr["ContAddr1"].ToString();
                data.ContAddr2 = rdr["ContAddr2"].ToString();
                data.ContDistrict = rdr["ContDistrict"].ToString();
                data.ContAmphur = rdr["ContAmphur"].ToString();
                data.ContProvince = rdr["ContProvince"].ToString();
                data.ConProvinceName = rdr["ConProvinceName"].ToString();
                data.ContPostCode = rdr["ContPostCode"].ToString();
                data.ContHomePage = rdr["ContHomePage"].ToString();
                data.ContTel = rdr["ContTel"].ToString();
                data.ContFax = rdr["ContFax"].ToString();
                data.CardNo = rdr["CardNo"].ToString();
                data.VATGroupID = rdr["VATGroupID"].ToString();
                data.VATGroupDesc = rdr["VATGroupDesc"].ToString();
                data.imBranchID = rdr["imBranchID"].ToString();
                data.Birthdate = rdr["Birthdate"].ToString();
                data.ContTelExtend1 = rdr["ContTelExtend1"].ToString();
                data.ContTelExtend2 = rdr["ContTelExtend2"].ToString();
                data.BranchCode = rdr["BranchCode"].ToString();
                data.BranchName = rdr["BranchName"].ToString();
                data.CreditDays = rdr["CreditDays"].ToString();
                data.CreditAmnt = rdr["CreditAmnt"].ToString();
                data.CreatedBy = rdr["CreatedBy"].ToString();
                data.CreatedDate = rdr["CreatedDate"].ToString();
                data.UpdatedBy = rdr["UpdatedBy"].ToString();
                data.UpdateDate = rdr["UpdateDate"].ToString();
                data.SalesCode = rdr["SalesCode"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getVatGroup()
        {
            List<cVatGroup> datas = new List<cVatGroup>();
            SqlCommand comm = new SqlCommand("spGetVatGroup", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cVatGroup data = new cVatGroup();
                data.VATGroupID = rdr["VATGroupID"].ToString();
                data.VATGroupDesc = rdr["VATGroupDesc"].ToString();
                data.VatRate = rdr["VatRate"].ToString();
                data.VatType = rdr["VatType"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getVendorUpdateEntry(string acttrans, string gid, string VendorID, string VendorGroupID, string VendorCode, string VendorName, string VendorNameEng, string ShortName, string VendorStartDate
                    , string Active, string InactiveDate, string adPaymentTypeID, string VendorTypeID, string TaxId, string VendorAddr1, string VendorAddr2, string District, string Amphur, string adProvinceID
                    , string PostCode, string ContAddr1, string ContAddr2, string ContDistrict, string ContAmphur, string ContProvince, string ContPostCode, string ContHomePage, string ContTel, string ContFax
                    , string CardNo, string VATGroupID, string imBranchID, string Birthdate, string ContTelExtend1, string ContTelExtend2, string BranchCode, string BranchName, string CreditDays, string CreditAmnt
                    , string CreatedBy, string CreatedDate, string UpdatedBy, string UpdateDate, string SalesCode)
        {
            SqlCommand comm = new SqlCommand("spGetVendorUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            //comm.Parameters.AddWithValue("@acttrans", acttrans);
            //comm.Parameters.AddWithValue("@Gid", gid);

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@VendorID", VendorID);
            comm.Parameters.AddWithValue("@VendorGroupID", VendorGroupID);
            comm.Parameters.AddWithValue("@VendorCode", VendorCode);
            comm.Parameters.AddWithValue("@VendorName", VendorName);
            comm.Parameters.AddWithValue("@VendorNameEng", VendorNameEng);
            comm.Parameters.AddWithValue("@ShortName", ShortName);
            comm.Parameters.AddWithValue("@VendorStartDate", VendorStartDate);
            comm.Parameters.AddWithValue("@Active", Active);
            comm.Parameters.AddWithValue("@InactiveDate", InactiveDate);
            comm.Parameters.AddWithValue("@adPaymentTypeID", adPaymentTypeID);
            comm.Parameters.AddWithValue("@VendorTypeID", VendorTypeID);
            comm.Parameters.AddWithValue("@TaxId", TaxId);
            comm.Parameters.AddWithValue("@VendorAddr1", VendorAddr1);
            comm.Parameters.AddWithValue("@VendorAddr2", VendorAddr2);
            comm.Parameters.AddWithValue("@District", District);
            comm.Parameters.AddWithValue("@Amphur", Amphur);
            comm.Parameters.AddWithValue("@adProvinceID", adProvinceID);
            comm.Parameters.AddWithValue("@PostCode", PostCode);
            comm.Parameters.AddWithValue("@ContAddr1", ContAddr1);
            comm.Parameters.AddWithValue("@ContAddr2", ContAddr2);
            comm.Parameters.AddWithValue("@ContDistrict", ContDistrict);
            comm.Parameters.AddWithValue("@ContAmphur", ContAmphur);
            comm.Parameters.AddWithValue("@ContProvince", ContProvince);
            comm.Parameters.AddWithValue("@ContPostCode", ContPostCode);
            comm.Parameters.AddWithValue("@ContHomePage", ContHomePage);
            comm.Parameters.AddWithValue("@ContTel", ContTel);
            comm.Parameters.AddWithValue("@ContFax", ContFax);
            comm.Parameters.AddWithValue("@CardNo", CardNo);
            comm.Parameters.AddWithValue("@VATGroupID", VATGroupID);
            comm.Parameters.AddWithValue("@imBranchID", imBranchID);
            comm.Parameters.AddWithValue("@Birthdate", Birthdate);
            comm.Parameters.AddWithValue("@ContTelExtend1", ContTelExtend1);
            comm.Parameters.AddWithValue("@ContTelExtend2", ContTelExtend2);
            comm.Parameters.AddWithValue("@BranchCode", BranchCode);
            comm.Parameters.AddWithValue("@BranchName", BranchName);
            comm.Parameters.AddWithValue("@CreditDays", CreditDays);
            comm.Parameters.AddWithValue("@CreditAmnt", CreditAmnt);
            comm.Parameters.AddWithValue("@CreatedBy", CreatedBy);
            comm.Parameters.AddWithValue("@CreatedDate", CreatedDate);
            comm.Parameters.AddWithValue("@UpdatedBy", UpdatedBy);
            comm.Parameters.AddWithValue("@UpdateDate", UpdateDate);
            comm.Parameters.AddWithValue("@SalesCode", SalesCode);

            comm.ExecuteNonQuery();
            conn.CloseConn();

        }

        [WebMethod]
        public void getShipmentList()
        {
            List<cShipment> datas = new List<cShipment>();
            SqlCommand comm = new SqlCommand("spGetShipmentList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cShipment data = new cShipment();
                data.ShipmentID = rdr["ShipmentID"].ToString();
                data.ShipmentCode = rdr["ShipmentCode"].ToString();
                data.ShipmentName = rdr["ShipmentName"].ToString();
                data.ShipmentNameEng = rdr["ShipmentNameEng"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getShipmentById(string gid)
        {
            List<cShipment> datas = new List<cShipment>();
            SqlCommand comm = new SqlCommand("spGetShipmentById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cShipment data = new cShipment();
                data.ShipmentID = rdr["ShipmentID"].ToString();
                data.ShipmentCode = rdr["ShipmentCode"].ToString();
                data.ShipmentName = rdr["ShipmentName"].ToString();
                data.ShipmentNameEng = rdr["ShipmentNameEng"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getShipmentUpdateEntry(string acttrans, string gid, string ShipmentID, string ShipmentCode, string ShipmentName, string ShipmentNameEng, string Remark)
        {
            SqlCommand comm = new SqlCommand("spGetShipmentUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@ShipmentID", ShipmentID);
            comm.Parameters.AddWithValue("@ShipmentCode", ShipmentCode);
            comm.Parameters.AddWithValue("@ShipmentName", ShipmentName);
            comm.Parameters.AddWithValue("@ShipmentNameEng", ShipmentNameEng);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getWarehouseList() {
            List<cWarehouseList> datas = new List<cWarehouseList>();
            SqlCommand comm = new SqlCommand("spGetWarehouseList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cWarehouseList data = new cWarehouseList();
                data.WhID = rdr["WhID"].ToString();
                data.WhCode = rdr["WhCode"].ToString();
                data.WhDesc = rdr["WhDesc"].ToString();              
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getWarehouseById(string gid) {
            List<cWarehouseList> datas = new List<cWarehouseList>();
            SqlCommand comm = new SqlCommand("spGetWarehouseById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cWarehouseList data = new cWarehouseList();
                data.WhID = rdr["WhID"].ToString();
                data.WhCode = rdr["WhCode"].ToString();
                data.WhDesc = rdr["WhDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getWarehouseUpdateEntry(string acttrans, string gid, string WhID, string WhCode, string WhDesc, string Remark)
        {
            SqlCommand comm = new SqlCommand("spGetWarehouseUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@WhID", WhID);
            comm.Parameters.AddWithValue("@WhCode", WhCode);
            comm.Parameters.AddWithValue("@WhDesc", WhDesc);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getWarehouseZoneList()
        {
            List<cWarehouseZoneList> datas = new List<cWarehouseZoneList>();
            SqlCommand comm = new SqlCommand("spGetWarehouseZoneList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cWarehouseZoneList data = new cWarehouseZoneList();
                data.WhZoneID = rdr["WhZoneID"].ToString();
                data.WhID = rdr["WhID"].ToString();
                data.WhDesc = rdr["WhDesc"].ToString();
                data.WhZoneCode = rdr["WhZoneCode"].ToString();
                data.WhZoneDesc = rdr["WhZoneDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
        
        [WebMethod]
        public void getWarehouseZoneById(string gid)
        {
            List<cWarehouseZoneList> datas = new List<cWarehouseZoneList>();
            SqlCommand comm = new SqlCommand("spGetWarehouseZoneById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cWarehouseZoneList data = new cWarehouseZoneList();
                data.WhZoneID = rdr["WhZoneID"].ToString();
                data.WhID = rdr["WhID"].ToString();
                data.WhZoneCode = rdr["WhZoneCode"].ToString();
                data.WhZoneDesc = rdr["WhZoneDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getWarehouseZoneUpdateEntry(string acttrans, string gid, string WhZoneID, string WhID, string WhZoneCode, string WhZoneDesc, string Remark)
        {
            SqlCommand comm = new SqlCommand("spGetWarehouseZoneUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@WhZoneID", WhZoneID);
            comm.Parameters.AddWithValue("@WhID", WhID);
            comm.Parameters.AddWithValue("@WhZoneCode", WhZoneCode);
            comm.Parameters.AddWithValue("@WhZoneDesc", WhZoneDesc);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
        
        [WebMethod]
        public void getGoodGroupList()
        {
            List<cGoodGroupList> datas = new List<cGoodGroupList>();
            SqlCommand comm = new SqlCommand("spGetGoodGroupList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodGroupList data = new cGoodGroupList();
                data.GoodGroupID = rdr["GoodGroupID"].ToString();
                data.GoodGroupCode = rdr["GoodGroupCode"].ToString();
                data.GoodGroupDesc = rdr["GoodGroupDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodGroupById(string gid)
        {
            List<cGoodGroupList> datas = new List<cGoodGroupList>();
            SqlCommand comm = new SqlCommand("spGetGoodGroupById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodGroupList data = new cGoodGroupList();
                data.GoodGroupID = rdr["GoodGroupID"].ToString();
                data.GoodGroupCode = rdr["GoodGroupCode"].ToString();
                data.GoodGroupDesc = rdr["GoodGroupDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodGroupUpdateEntry(string acttrans, string gid, string GoodGroupID, string GoodGroupCode, string GoodGroupDesc, string Remark)
        {
            SqlCommand comm = new SqlCommand("spGetGoodGroupUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@GoodGroupID", GoodGroupID);
            comm.Parameters.AddWithValue("@GoodGroupCode", GoodGroupCode);
            comm.Parameters.AddWithValue("@GoodGroupDesc", GoodGroupDesc);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
        
        [WebMethod]
        public void getGoodTypeList()
        {
            List<cGoodTypeList> datas = new List<cGoodTypeList>();
            SqlCommand comm = new SqlCommand("spGetGoodTypeList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodTypeList data = new cGoodTypeList();
                data.GoodTypeID = rdr["GoodTypeID"].ToString();
                data.GoodGroupID = rdr["GoodGroupID"].ToString();
                data.GoodGroupDesc = rdr["GoodGroupDesc"].ToString();
                data.GoodTypeCode = rdr["GoodTypeCode"].ToString();
                data.GoodTypeDesc = rdr["GoodTypeDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodTypeById(string gid)
        {
            List<cGoodTypeList> datas = new List<cGoodTypeList>();
            SqlCommand comm = new SqlCommand("spGetGoodTypeById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodTypeList data = new cGoodTypeList();
                data.GoodTypeID = rdr["GoodTypeID"].ToString();
                data.GoodGroupID = rdr["GoodGroupID"].ToString();
                data.GoodGroupDesc = rdr["GoodGroupDesc"].ToString();
                data.GoodTypeCode = rdr["GoodTypeCode"].ToString();
                data.GoodTypeDesc = rdr["GoodTypeDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodTypeUpdateEntry(string acttrans, string gid, string GoodTypeID, string GoodGroupID, string GoodTypeCode, string GoodTypeDesc, string Remark)
        {
            SqlCommand comm = new SqlCommand("spGetGoodTypeUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@GoodTypeID", GoodTypeID);
            comm.Parameters.AddWithValue("@GoodGroupID", GoodGroupID);
            comm.Parameters.AddWithValue("@GoodTypeCode", GoodTypeCode);
            comm.Parameters.AddWithValue("@GoodTypeDesc", GoodTypeDesc);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
        
        [WebMethod]
        public void getGoodUnitList()
        {
            List<cGoodUnitList> datas = new List<cGoodUnitList>();
            SqlCommand comm = new SqlCommand("spGetGoodUnitList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodUnitList data = new cGoodUnitList();
                data.GoodUnitID = rdr["GoodUnitID"].ToString();
                data.GoodUnitCode = rdr["GoodUnitCode"].ToString();
                data.GoodUnitDesc = rdr["GoodUnitDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodUnitById(string gid)
        {
            List<cGoodUnitList> datas = new List<cGoodUnitList>();
            SqlCommand comm = new SqlCommand("spGetGoodUnitById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodUnitList data = new cGoodUnitList();
                data.GoodUnitID = rdr["GoodUnitID"].ToString();
                data.GoodUnitCode = rdr["GoodUnitCode"].ToString();
                data.GoodUnitDesc = rdr["GoodUnitDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodUnitUpdateEntry(string acttrans, string gid, string GoodUnitID, string GoodUnitCode, string GoodUnitDesc, string Remark)
        {
            SqlCommand comm = new SqlCommand("spGetGoodUnitUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@GoodUnitID", GoodUnitID);
            comm.Parameters.AddWithValue("@GoodUnitCode", GoodUnitCode);
            comm.Parameters.AddWithValue("@GoodUnitDesc", GoodUnitDesc);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
        
        [WebMethod]
        public void getGoodStatusList()
        {
            List<cGoodStatusList> datas = new List<cGoodStatusList>();
            SqlCommand comm = new SqlCommand("spGetGoodStatusList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodStatusList data = new cGoodStatusList();
                data.GoodStatID = rdr["GoodStatID"].ToString();
                data.GoodStatCode = rdr["GoodStatCode"].ToString();
                data.GoodStatDesc = rdr["GoodStatDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodStatusById(string gid)
        {
            List<cGoodStatusList> datas = new List<cGoodStatusList>();
            SqlCommand comm = new SqlCommand("spGetGoodStatusById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodStatusList data = new cGoodStatusList();
                data.GoodStatID = rdr["GoodStatID"].ToString();
                data.GoodStatCode = rdr["GoodStatCode"].ToString();
                data.GoodStatDesc = rdr["GoodStatDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodStatusUpdateEntry(string acttrans, string gid, string GoodStatID, string GoodStatCode, string GoodStatDesc, string Remark)
        {
            SqlCommand comm = new SqlCommand("spGetGoodStatusUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@GoodStatID", GoodStatID);
            comm.Parameters.AddWithValue("@GoodStatCode", GoodStatCode);
            comm.Parameters.AddWithValue("@GoodStatDesc", GoodStatDesc);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
        
        [WebMethod]
        public void getGoodColorList()
        {
            List<cGoodColorList> datas = new List<cGoodColorList>();
            SqlCommand comm = new SqlCommand("spGetGoodColorList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodColorList data = new cGoodColorList();
                data.GoodColorID = rdr["GoodColorID"].ToString();
                data.GoodColorCode = rdr["GoodColorCode"].ToString();
                data.GoodColorDesc = rdr["GoodColorDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodColorById(string gid)
        {
            List<cGoodColorList> datas = new List<cGoodColorList>();
            SqlCommand comm = new SqlCommand("spGetGoodColorById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodColorList data = new cGoodColorList();
                data.GoodColorID = rdr["GoodColorID"].ToString();
                data.GoodColorCode = rdr["GoodColorCode"].ToString();
                data.GoodColorDesc = rdr["GoodColorDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodColorUpdateEntry(string acttrans, string gid, string GoodColorID, string GoodColorCode, string GoodColorDesc, string Remark)
        {
            SqlCommand comm = new SqlCommand("spGetGoodColorUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@GoodColorID", GoodColorID);
            comm.Parameters.AddWithValue("@GoodColorCode", GoodColorCode);
            comm.Parameters.AddWithValue("@GoodColorDesc", GoodColorDesc);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
        
        [WebMethod]
        public void getGoodCodeList()
        {
            List<cGoodCodeList> datas = new List<cGoodCodeList>();
            SqlCommand comm = new SqlCommand("spGetGoodCodeList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodCodeList data = new cGoodCodeList();                
                data.GoodCodeID = rdr["GoodCodeID"].ToString();
                data.GoodGroupID = rdr["GoodGroupID"].ToString();
                data.GoodGroupDesc = rdr["GoodGroupDesc"].ToString();
                data.GoodTypeID = rdr["GoodTypeID"].ToString();
                data.GoodTypeDesc = rdr["GoodTypeDesc"].ToString();
                data.GoodCate = rdr["GoodCate"].ToString();
                data.GoodCode = rdr["GoodCode"].ToString();
                data.GoodName = rdr["GoodName"].ToString();
                data.GoodColorID = rdr["GoodColorID"].ToString();
                data.GoodColorDesc = rdr["GoodColorDesc"].ToString();
                data.GoodUnitID = rdr["GoodUnitID"].ToString();
                data.GoodUnitDesc = rdr["GoodUnitDesc"].ToString();
                data.Price1 = rdr["Price1"].ToString();
                data.Price2 = rdr["Price2"].ToString();
                data.Price3 = rdr["Price3"].ToString();
                data.Price4 = rdr["Price4"].ToString();
                data.Price5 = rdr["Price5"].ToString();
                data.PurLeadTime = rdr["PurLeadTime"].ToString();
                data.GoodWeight = rdr["GoodWeight"].ToString();
                data.GoodWidth = rdr["GoodWidth"].ToString();
                data.GoodLength = rdr["GoodLength"].ToString();
                data.GoodHeight = rdr["GoodHeight"].ToString();
                data.GoodStatID = rdr["GoodStatID"].ToString();
                data.GoodStatDesc = rdr["GoodStatDesc"].ToString();
                data.activeid = rdr["activeid"].ToString();
                data.activename = rdr["activename"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        
        [WebMethod]
        public void getGoodCodeById(string gid)
        {
            List<cGoodCodeList> datas = new List<cGoodCodeList>();
            SqlCommand comm = new SqlCommand("spGetGoodCodeById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodCodeList data = new cGoodCodeList();
                data.GoodCodeID = rdr["GoodCodeID"].ToString();
                data.GoodGroupID = rdr["GoodGroupID"].ToString();
                data.GoodGroupDesc = rdr["GoodGroupDesc"].ToString();
                data.GoodTypeID = rdr["GoodTypeID"].ToString();
                data.GoodTypeDesc = rdr["GoodTypeDesc"].ToString();
                data.GoodCate = rdr["GoodCate"].ToString();
                data.GoodCode = rdr["GoodCode"].ToString();
                data.GoodName = rdr["GoodName"].ToString();
                data.GoodColorID = rdr["GoodColorID"].ToString();
                data.GoodColorDesc = rdr["GoodColorDesc"].ToString();
                data.GoodUnitID = rdr["GoodUnitID"].ToString();
                data.GoodUnitDesc = rdr["GoodUnitDesc"].ToString();
                data.Price1 = rdr["Price1"].ToString();
                data.Price2 = rdr["Price2"].ToString();
                data.Price3 = rdr["Price3"].ToString();
                data.PurLeadTime = rdr["PurLeadTime"].ToString();
                data.GoodWeight = rdr["GoodWeight"].ToString();
                data.GoodWidth = rdr["GoodWidth"].ToString();
                data.GoodLength = rdr["GoodLength"].ToString();
                data.GoodHeight = rdr["GoodHeight"].ToString();
                data.GoodStatID = rdr["GoodStatID"].ToString();
                data.GoodStatDesc = rdr["GoodStatDesc"].ToString();
                data.activeid = rdr["activeid"].ToString();
                data.activename = rdr["activename"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                data.Remark = rdr["Remark"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodCodeUpdateEntry(string acttrans, string gid, string GoodCodeID, string GoodGroupID, string GoodTypeID, string GoodCate, string GoodCode, string GoodName, string GoodColorID, 
            string GoodColorDesc, string GoodUnitID, string GoodUnitDesc, string Price1, string Price2, string Price3, string Price4, string Price5, string PurLeadTime, string GoodWeight, string GoodWidth, 
            string GoodLength, string GoodHeight, string GoodStatID, string GoodStatDesc, string activeid, string UserCreate, string CreateDate, string UserUpdate, string LasteDate, string Remark)
        {
            SqlCommand comm = new SqlCommand("spGetGoodCodeUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@GoodCodeID", GoodCodeID);
            comm.Parameters.AddWithValue("@GoodGroupID", GoodGroupID);
            comm.Parameters.AddWithValue("@GoodTypeID", GoodTypeID);
            comm.Parameters.AddWithValue("@GoodCate", GoodCate);
            comm.Parameters.AddWithValue("@GoodCode", GoodCode);
            comm.Parameters.AddWithValue("@GoodName", GoodName);
            comm.Parameters.AddWithValue("@GoodColorID", GoodColorID);
            comm.Parameters.AddWithValue("@GoodColorDesc", GoodColorDesc);
            comm.Parameters.AddWithValue("@GoodUnitID", GoodUnitID);
            comm.Parameters.AddWithValue("@GoodUnitDesc", GoodUnitDesc);
            comm.Parameters.AddWithValue("@Price1", Price1);
            comm.Parameters.AddWithValue("@Price2", Price2);
            comm.Parameters.AddWithValue("@Price3", Price3);
            comm.Parameters.AddWithValue("@Price4", Price4);
            comm.Parameters.AddWithValue("@Price5", Price5);
            comm.Parameters.AddWithValue("@PurLeadTime", PurLeadTime);
            comm.Parameters.AddWithValue("@GoodWeight", GoodWeight);
            comm.Parameters.AddWithValue("@GoodWidth", GoodWidth);
            comm.Parameters.AddWithValue("@GoodLength", GoodLength);
            comm.Parameters.AddWithValue("@GoodHeight", GoodHeight);
            comm.Parameters.AddWithValue("@GoodStatID", GoodStatID);
            comm.Parameters.AddWithValue("@GoodStatDesc", GoodStatDesc);
            comm.Parameters.AddWithValue("@activeid", activeid);
            comm.Parameters.AddWithValue("@UserCreate", UserCreate);
            comm.Parameters.AddWithValue("@CreateDate", CreateDate);
            comm.Parameters.AddWithValue("@UserUpdate", UserUpdate);
            comm.Parameters.AddWithValue("@LasteDate", LasteDate);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getSoApprovalList()
        {
            List<cSOApproveList> datas = new List<cSOApproveList>();
            SqlCommand comm = new SqlCommand("spGetSOApprovalList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSOApproveList data = new cSOApproveList();
                data.SoApproveID = rdr["SoApproveID"].ToString();
                data.imEmployeeGidU = rdr["imEmployeeGidU"].ToString();
                data.UFullName = rdr["UFullName"].ToString();
                data.UPositionName = rdr["UPositionName"].ToString();
                data.imEmployeeGidH = rdr["imEmployeeGidH"].ToString();
                data.HFullName = rdr["HFullName"].ToString();
                data.HPositionName = rdr["HPositionName"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getSOApprovalById(string gid)
        {
            List<cSOApproveList> datas = new List<cSOApproveList>();
            SqlCommand comm = new SqlCommand("spGetSOApprovalById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSOApproveList data = new cSOApproveList();
                data.SoApproveID = rdr["SoApproveID"].ToString();
                data.imEmployeeGidU = rdr["imEmployeeGidU"].ToString();
                data.UFullName = rdr["UFullName"].ToString();
                data.UPositionName = rdr["UPositionName"].ToString();
                data.imEmployeeGidH = rdr["imEmployeeGidH"].ToString();
                data.HFullName = rdr["HFullName"].ToString();
                data.HPositionName = rdr["HPositionName"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getSOApprovalUpdateEntry(string acttrans, string gid, string SoApproveID, string imEmployeeGidU, string imEmployeeGidH, string Remark, 
            string UserCreate, string CreateDate, string UserUpdate, string LasteDate)
        {
            SqlCommand comm = new SqlCommand("spGetSOApprovalUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@SoApproveID", SoApproveID);
            comm.Parameters.AddWithValue("@imEmployeeGidU", imEmployeeGidU);
            comm.Parameters.AddWithValue("@imEmployeeGidH", imEmployeeGidH);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.Parameters.AddWithValue("@UserCreate", UserCreate);
            comm.Parameters.AddWithValue("@CreateDate", CreateDate);
            comm.Parameters.AddWithValue("@UserUpdate", UserUpdate);
            comm.Parameters.AddWithValue("@LasteDate", LasteDate);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getSoLevelList()
        {
            List<cSOLevelList> datas = new List<cSOLevelList>();
            SqlCommand comm = new SqlCommand("spGetSOLevelList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSOLevelList data = new cSOLevelList();
                data.SoLevelID = rdr["SoLevelID"].ToString();
                data.SoLevelCode = rdr["SoLevelCode"].ToString();
                data.SoLevelDesc = rdr["SoLevelDesc"].ToString();                
                data.Remark = rdr["Remark"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        
        [WebMethod]
        public void getSoApprovalLevelList()
        {
            List<cSOApproveLevelList> datas = new List<cSOApproveLevelList>();
            SqlCommand comm = new SqlCommand("spGetSOApprovalLevelList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSOApproveLevelList data = new cSOApproveLevelList();
                
                data.SoAppLevelID = rdr["SoAppLevelID"].ToString();
                data.imEmployeeGid = rdr["imEmployeeGid"].ToString();
                data.FullName = rdr["FullName"].ToString();
                data.SoLevelID = rdr["SoLevelID"].ToString();
                data.SoLevelCode = rdr["SoLevelCode"].ToString();
                data.SoLevelDesc = rdr["SoLevelDesc"].ToString();
                data.PositionName = rdr["PositionName"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getSOApprovalLevelById(string gid)
        {
            List<cSOApproveLevelList> datas = new List<cSOApproveLevelList>();
            SqlCommand comm = new SqlCommand("spGetSOApprovalLevelById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSOApproveLevelList data = new cSOApproveLevelList();

                data.SoAppLevelID = rdr["SoAppLevelID"].ToString();
                data.imEmployeeGid = rdr["imEmployeeGid"].ToString();
                data.FullName = rdr["FullName"].ToString();
                data.SoLevelID = rdr["SoLevelID"].ToString();
                data.SoLevelCode = rdr["SoLevelCode"].ToString();
                data.SoLevelDesc = rdr["SoLevelDesc"].ToString();
                data.PositionName = rdr["PositionName"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getSoApprovalLevelUpdateEntry(string acttrans, string gid, string SoAppLevelID, string imEmployeeGid, string SoLevelID, string Remark,
            string UserCreate, string CreateDate, string UserUpdate, string LasteDate)
        {
            SqlCommand comm = new SqlCommand("spGetSOApprovalLevelUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@SoAppLevelID", SoAppLevelID);
            comm.Parameters.AddWithValue("@imEmployeeGid", imEmployeeGid);
            comm.Parameters.AddWithValue("@SoLevelID", SoLevelID);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.Parameters.AddWithValue("@UserCreate", UserCreate);
            comm.Parameters.AddWithValue("@CreateDate", CreateDate);
            comm.Parameters.AddWithValue("@UserUpdate", UserUpdate);
            comm.Parameters.AddWithValue("@LasteDate", LasteDate);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        
        [WebMethod]
        public void getSOOptionList()
        {
            List<cSOOptionList> datas = new List<cSOOptionList>();
            SqlCommand comm = new SqlCommand("spGetSOOptionList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSOOptionList data = new cSOOptionList();
                data.SoOptionID = rdr["SoOptionID"].ToString();
                data.QtoverCredit = rdr["QtoverCredit"].ToString();
                data.ResoverCredit = rdr["ResoverCredit"].ToString();
                data.SooverCredit = rdr["SooverCredit"].ToString();
                data.AmountOverCredit = rdr["AmountOverCredit"].ToString();
                data.SooverReserv = rdr["SooverReserv"].ToString();
                data.AlertDeposit = rdr["AlertDeposit"].ToString();
                data.ResoverQt = rdr["ResoverQt"].ToString();
                data.SooverQuotation = rdr["SooverQuotation"].ToString();
                data.StockoverSpend = rdr["StockoverSpend"].ToString();
                data.QtacceptApproval = rdr["QtacceptApproval"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
        
        [WebMethod]
        public void getSoOptionUpdateEntry(string acttrans, string gid, string SoOptionID, string QtoverCredit, string ResoverCredit, string SooverCredit, string AmountOverCredit,
            string SooverReserv, string AlertDeposit, string ResoverQt, string SooverQuotation, string StockoverSpend, string QtacceptApproval, string Remark,
            string UserCreate, string CreateDate, string UserUpdate, string LasteDate)
        {
            SqlCommand comm = new SqlCommand("spGetSOOptionUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@SoOptionID", SoOptionID);
            comm.Parameters.AddWithValue("@QtoverCredit", QtoverCredit);
            comm.Parameters.AddWithValue("@ResoverCredit", ResoverCredit);
            comm.Parameters.AddWithValue("@SooverCredit", SooverCredit);
            comm.Parameters.AddWithValue("@AmountOverCredit", AmountOverCredit);
            comm.Parameters.AddWithValue("@SooverReserv", SooverReserv);
            comm.Parameters.AddWithValue("@AlertDeposit", AlertDeposit);
            comm.Parameters.AddWithValue("@ResoverQt", ResoverQt);
            comm.Parameters.AddWithValue("@SooverQuotation", SooverQuotation);
            comm.Parameters.AddWithValue("@StockoverSpend", StockoverSpend);
            comm.Parameters.AddWithValue("@QtacceptApproval", QtacceptApproval);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.Parameters.AddWithValue("@UserCreate", UserCreate);
            comm.Parameters.AddWithValue("@CreateDate", CreateDate);
            comm.Parameters.AddWithValue("@UserUpdate", UserUpdate);
            comm.Parameters.AddWithValue("@LasteDate", LasteDate);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
        
        [WebMethod]
        public void getSoCreditApprovalList()
        {
            List<cSOCreditApprovalList> datas = new List<cSOCreditApprovalList>();
            SqlCommand comm = new SqlCommand("spGetSOCreditApproveList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSOCreditApprovalList data = new cSOCreditApprovalList();
                data.SoAppCreditID = rdr["SoAppCreditID"].ToString();
                data.imEmployeeGid = rdr["imEmployeeGid"].ToString();
                data.FullName = rdr["FullName"].ToString();
                data.PositionName = rdr["PositionName"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
                
        [WebMethod]
        public void getSOCreditApproveById(string gid)
        {
            List<cSOCreditApprovalList> datas = new List<cSOCreditApprovalList>();
            SqlCommand comm = new SqlCommand("spGetSOCreditApproveById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSOCreditApprovalList data = new cSOCreditApprovalList();
                data.SoAppCreditID = rdr["SoAppCreditID"].ToString();
                data.imEmployeeGid = rdr["imEmployeeGid"].ToString();
                data.FullName = rdr["FullName"].ToString();
                data.PositionName = rdr["PositionName"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getSoCreditApprovalUpdateEntry(string acttrans, string gid, string SoAppCreditID, string imEmployeeGid,  string Remark,
           string UserCreate, string CreateDate, string UserUpdate, string LasteDate)
        {
            SqlCommand comm = new SqlCommand("spGetSOCreditApprovalUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@SoAppCreditID", SoAppCreditID);
            comm.Parameters.AddWithValue("@imEmployeeGid", imEmployeeGid);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.Parameters.AddWithValue("@UserCreate", UserCreate);
            comm.Parameters.AddWithValue("@CreateDate", CreateDate);
            comm.Parameters.AddWithValue("@UserUpdate", UserUpdate);
            comm.Parameters.AddWithValue("@LasteDate", LasteDate);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
                
        [WebMethod]
        public void getVendorCreditList()
        {
            List<cVendorList> datas = new List<cVendorList>();
            SqlCommand comm = new SqlCommand("spGetVendorCreditList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cVendorList data = new cVendorList();
                data.VendorID = rdr["VendorID"].ToString();
                data.VendorCode = rdr["VendorCode"].ToString();
                data.VendorName = rdr["VendorName"].ToString();
                data.VendorNameEng = rdr["VendorNameEng"].ToString();
                data.VendorAddr1 = rdr["VendorAddr1"].ToString();
                data.ProvinceName = rdr["ProvinceName"].ToString();
                data.CreditDays = rdr["CreditDays"].ToString();
                data.CreditAmnt = rdr["CreditAmnt"].ToString();
                data.CreditBalance = rdr["CreditBalance"].ToString();
                data.edit = rdr["edit"].ToString();                
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getVendorCreditUpdateEntry(string gid, string CreditDays, string CreditAmnt, string CreditBalance) {
            SqlCommand comm = new SqlCommand("spGetVendorCreditUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@CreditDays", CreditDays);
            comm.Parameters.AddWithValue("@CreditAmnt",  CreditAmnt.Replace(",","") );
            comm.Parameters.AddWithValue("@CreditBalance", CreditBalance.Replace(",",""));
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
                
        [WebMethod]
        public void getGoodCodeStockList()
        {
            List<cGoodCodeStockList> datas = new List<cGoodCodeStockList>();
            SqlCommand comm = new SqlCommand("spGetGoodCodeStockList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodCodeStockList data = new cGoodCodeStockList();
                data.Gid = rdr["Gid"].ToString();
                data.imBranchGid = rdr["imBranchGid"].ToString();
                data.BranchName = rdr["BranchName"].ToString();
                data.WhID = rdr["WhID"].ToString();
                data.WhDesc = rdr["WhDesc"].ToString();
                data.WhZoneID = rdr["WhZoneID"].ToString();
                data.WhZoneDesc = rdr["WhZoneDesc"].ToString();
                data.GoodGroupID = rdr["GoodGroupID"].ToString();
                data.GoodGroupDesc = rdr["GoodGroupDesc"].ToString();
                data.GoodTypeID = rdr["GoodTypeID"].ToString();
                data.GoodTypeDesc = rdr["GoodTypeDesc"].ToString();

                data.GoodCodeID = rdr["GoodCodeID"].ToString();
                data.GoodCode = rdr["GoodCode"].ToString();
                data.GoodName = rdr["GoodName"].ToString();
                data.GoodUnitID = rdr["GoodUnitID"].ToString();
                data.GoodUnitDesc = rdr["GoodUnitDesc"].ToString();
                data.ControlNo = rdr["ControlNo"].ToString();
                data.LotNo = rdr["LotNo"].ToString();
                data.AdjustQty = rdr["AdjustQty"].ToString();
                data.QCQty = rdr["QCQty"].ToString();
                data.InvQty = rdr["InvQty"].ToString();
                data.OrderQty = rdr["OrderQty"].ToString();
                data.BorrowQty = rdr["BorrowQty"].ToString();
                data.ReserveQty = rdr["ReserveQty"].ToString();
                data.DestroyQty = rdr["DestroyQty"].ToString();
                data.RepairQty = rdr["RepairQty"].ToString();
                data.ReturnQty = rdr["ReturnQty"].ToString();
                data.CNQty = rdr["CNQty"].ToString();
                data.PurCost = rdr["PurCost"].ToString();
                data.AddCost1 = rdr["AddCost1"].ToString();
                data.AddCost2 = rdr["AddCost2"].ToString();
                data.AddCost3 = rdr["AddCost3"].ToString();
                data.UnitCost = rdr["UnitCost"].ToString();
                data.AVCost = rdr["AVCost"].ToString();
                data.AVCost2 = rdr["AVCost2"].ToString();
                data.MinimumPrice = rdr["MinimumPrice"].ToString();
                data.MaximumPrice = rdr["MaximumPrice"].ToString();
                data.UnitPrice = rdr["UnitPrice"].ToString();
                data.DiscPercent = rdr["DiscPercent"].ToString();
                data.DiscCash = rdr["DiscCash"].ToString();
                data.NetPrice = rdr["NetPrice"].ToString();
                data.ReceiveDate = rdr["ReceiveDate"].ToString();
                data.ExpiredDate = rdr["ExpiredDate"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserUpdate = rdr["UserUpdate"].ToString();
                data.LasteDate = rdr["LasteDate"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getGoodCodeBeginStockUpdateEntry(string acttrans, string gid, string imBranchGid, string WhID, string WhZoneID, string GoodGroupID, string GoodCodeID, string ControlNo, string LotNo,
                            string AdjustQty, string QCQty, string InvQty, string OrderQty, string BorrowQty, string ReserveQty, string DestroyQty, string RepairQty, string ReturnQty, string CNQty,
                            string PurCost, string AddCost1, string AddCost2, string AddCost3, string UnitCost, string AVCost, string AVCost2, string MinimumPrice, string MaximumPrice,
                            string UnitPrice, string DiscPercent, string DiscCash, string NetPrice, string ReceiveDate, string ExpiredDate, string UserCreate, string CreateDate, 
                            string UserUpdate, string LasteDate, string Remark) {
            SqlCommand comm = new SqlCommand("spGetGoodCodeBeginStockUpdateEntry", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            
            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@imBranchGid", imBranchGid);
            comm.Parameters.AddWithValue("@WhID", WhID);
            comm.Parameters.AddWithValue("@WhZoneID", WhZoneID);
            comm.Parameters.AddWithValue("@GoodGroupID", GoodGroupID);
            comm.Parameters.AddWithValue("@GoodCodeID", GoodCodeID);
            comm.Parameters.AddWithValue("@ControlNo", ControlNo);
            comm.Parameters.AddWithValue("@LotNo", LotNo);
            comm.Parameters.AddWithValue("@AdjustQty", AdjustQty);
            comm.Parameters.AddWithValue("@QCQty", QCQty);
            comm.Parameters.AddWithValue("@InvQty", InvQty);
            comm.Parameters.AddWithValue("@OrderQty", OrderQty);
            comm.Parameters.AddWithValue("@BorrowQty", BorrowQty);
            comm.Parameters.AddWithValue("@ReserveQty", ReserveQty);
            comm.Parameters.AddWithValue("@DestroyQty", DestroyQty);
            comm.Parameters.AddWithValue("@RepairQty", RepairQty);
            comm.Parameters.AddWithValue("@ReturnQty", ReturnQty);
            comm.Parameters.AddWithValue("@CNQty", CNQty);
            comm.Parameters.AddWithValue("@PurCost", PurCost);
            comm.Parameters.AddWithValue("@AddCost1", AddCost1);
            comm.Parameters.AddWithValue("@AddCost2", AddCost2);
            comm.Parameters.AddWithValue("@AddCost3", AddCost3);
            comm.Parameters.AddWithValue("@UnitCost", UnitCost);
            comm.Parameters.AddWithValue("@AVCost", AVCost);
            comm.Parameters.AddWithValue("@AVCost2", AVCost2);
            comm.Parameters.AddWithValue("@MinimumPrice", MinimumPrice);
            comm.Parameters.AddWithValue("@MaximumPrice", MaximumPrice);
            comm.Parameters.AddWithValue("@UnitPrice", UnitPrice);
            comm.Parameters.AddWithValue("@DiscPercent", DiscPercent);
            comm.Parameters.AddWithValue("@DiscCash", DiscCash);
            comm.Parameters.AddWithValue("@NetPrice", NetPrice);
            comm.Parameters.AddWithValue("@ReceiveDate", ReceiveDate);
            comm.Parameters.AddWithValue("@ExpiredDate", ExpiredDate);
            comm.Parameters.AddWithValue("@UserCreate", UserCreate);
            comm.Parameters.AddWithValue("@CreateDate", CreateDate);
            comm.Parameters.AddWithValue("@UserUpdate", UserUpdate);
            comm.Parameters.AddWithValue("@LasteDate", LasteDate);
            comm.Parameters.AddWithValue("@Remark", Remark);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getProjectType() {
            List<cProjectType> datas = new List<cProjectType>();
            SqlCommand comm = new SqlCommand("spGetProjectType", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cProjectType data = new cProjectType();
                data.ProjectID = rdr["ProjectID"].ToString();
                data.ProjectCode = rdr["ProjectCode"].ToString();
                data.ProjectDesc = rdr["ProjectDesc"].ToString();               
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getSourceList() {
            List<cSourceList> datas = new List<cSourceList>();
            SqlCommand comm = new SqlCommand("spGetSourceList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cSourceList data = new cSourceList();
                data.Gid = rdr["Gid"].ToString();
                data.SourceCode = rdr["SourceCode"].ToString();
                data.SourceName = rdr["SourceName"].ToString();
                data.UserCreate = rdr["UserCreate"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UserCreate = rdr["UserUpdate"].ToString();
                data.UserUpdate = rdr["LasteDate"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.edit = rdr["edit"].ToString();
                data.trash = rdr["trash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getFlagStatus() {
            
            List<cFlagStatus> datas = new List<cFlagStatus>();
            SqlCommand comm = new SqlCommand("spGetFlagStatus", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cFlagStatus data = new cFlagStatus();
                data.FlagID = rdr["FlagID"].ToString();
                data.FlagDesc = rdr["FlagDesc"].ToString();
                data.Remark = rdr["Remark"].ToString();
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
