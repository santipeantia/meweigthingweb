using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medesignsoft
{
    public partial class signout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //Session["UserID"] = null;
            //Session["imEmployeeGid"] = null;
            //Session["FirstName"] = null;
            //Session["LastName"] = null;
            //Session["UserName"] = null;
            //Session["UserPassword"] = null;
            //Session["UserTypeID"] = null;
            //Session["UserTypeDesc"] = null;
            //Session["ActiveID"] = null;
            //Session["activename"] = null;
            //Session["CreatedBy"] = null;
            //Session["CreatedDate"] = null;
            //Session["UpdatedBy"] = null;
            //Session["UpdateDate"] = null;
            //Session["imPositionID"] = null;
            //Session["PositionName"] = null;
            //Session["imDepartmentID"] = null;
            //Session["DepartmentDesc"] = null;
            //Session["imSectionID"] = null;
            //Session["SectionDesc"] = null;
            //Session["EMail"] = null;
            //Session["imBranchGID"] = null;
            //Session["BranchName"] = null;
            //Session["adCompanyID"] = null;
            //Session["CompanyNameTh"] = null;

            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Remove("UserID");
            HttpContext.Current.Session.Remove("imEmployeeGid");
            HttpContext.Current.Session.Remove("FirstName");
            HttpContext.Current.Session.Remove("LastName");
            HttpContext.Current.Session.Remove("UserName");
            HttpContext.Current.Session.Remove("UserPassword");
            HttpContext.Current.Session.Remove("UserTypeID");
            HttpContext.Current.Session.Remove("UserTypeDesc");
            HttpContext.Current.Session.Remove("ActiveID");
            HttpContext.Current.Session.Remove("activename");
            HttpContext.Current.Session.Remove("CreatedBy");
            HttpContext.Current.Session.Remove("CreatedDate");
            HttpContext.Current.Session.Remove("UpdateDate");
            HttpContext.Current.Session.Remove("imPositionID");
            HttpContext.Current.Session.Remove("PositionName");
            HttpContext.Current.Session.Remove("imDepartmentID");
            HttpContext.Current.Session.Remove("DepartmentDesc");
            HttpContext.Current.Session.Remove("imSectionID");
            HttpContext.Current.Session.Remove("SectionDesc");
            HttpContext.Current.Session.Remove("EMail");
            HttpContext.Current.Session.Remove("imBranchGID");
            HttpContext.Current.Session.Remove("BranchName");
            HttpContext.Current.Session.Remove("adCompanyID");
            HttpContext.Current.Session.Remove("CompanyNameTh");

            HttpContext.Current.Session.Contents.RemoveAll();
            HttpContext.Current.Session.Abandon();
            HttpContext.Current.Session.RemoveAll();

            Page.Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Response.Redirect("~/signin.aspx");
            //Response.Write("<script>document.location=signin.aspx</script>");
        }
    }
}