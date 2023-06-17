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

namespace medesignsoft.mesales_order
{
    /// <summary>
    /// Summary description for saleorder_services
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class saleorder_services : System.Web.Services.WebService
    {
        dbConnection conn = new dbConnection();

        [WebMethod]
        public void getQuotationList(string empid)
        {
            List<cQuotationList> datas = new List<cQuotationList>();
            SqlCommand comm = new SqlCommand("spGetQuotationList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@empid", empid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cQuotationList data = new cQuotationList();
                data.QtGid = rdr["QtGid"].ToString();
                data.imBranchGid = rdr["imBranchGid"].ToString();
                data.BranchName = rdr["BranchName"].ToString();
                data.adQTNO = rdr["adQTNO"].ToString();
                data.RefQTNO = rdr["RefQTNO"].ToString();
                data.ProjectName = rdr["ProjectName"].ToString();
                data.ProjectID = rdr["ProjectID"].ToString();
                data.ProjectDesc = rdr["ProjectDesc"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.DeliveryDate = rdr["DeliveryDate"].ToString();
                data.InYear = rdr["InYear"].ToString();
                data.VendorID = rdr["VendorID"].ToString();
                data.VendorName = rdr["VendorName"].ToString();
                data.ContactName = rdr["ContactName"].ToString();
                data.ContactTel = rdr["ContactTel"].ToString();
                data.CurrencyRate = rdr["CurrencyRate"].ToString();
                data.adCurrencyID = rdr["adCurrencyID"].ToString();
                data.CurrencyDesc = rdr["CurrencyDesc"].ToString();
                data.TotalAmount = rdr["TotalAmount"].ToString();
                data.VATAmount = rdr["VATAmount"].ToString();
                data.TotalAmountExcludeVAT = rdr["TotalAmountExcludeVAT"].ToString();
                data.DiscPercent = rdr["DiscPercent"].ToString();
                data.DiscAmount = rdr["DiscAmount"].ToString();
                data.DiscExtendPercent = rdr["DiscExtendPercent"].ToString();
                data.DiscExtendAmount = rdr["DiscExtendAmount"].ToString();
                data.AmountExtraDisc = rdr["AmountExtraDisc"].ToString();
                data.TotalAmountAfterDisc = rdr["TotalAmountAfterDisc"].ToString();
                data.QTRemark = rdr["QTRemark"].ToString();
                data.QTComment = rdr["QTComment"].ToString();
                data.imDeliveryID = rdr["imDeliveryID"].ToString();
                data.DeliveryName = rdr["DeliveryName"].ToString();
                data.adPaymentTypeID = rdr["adPaymentTypeID"].ToString();
                data.PaymentTypeDesc = rdr["PaymentTypeDesc"].ToString();
                data.imEmployeeGid = rdr["imEmployeeGid"].ToString();
                data.empFullName = rdr["empFullName"].ToString();
                data.SalePositionName = rdr["SalePositionName"].ToString();
                data.ApproveID = rdr["ApproveID"].ToString();
                data.ApproveName = rdr["ApproveName"].ToString();
                data.ApprovePositionID = rdr["ApprovePositionID"].ToString();
                data.ApprovePositionName = rdr["ApprovePositionName"].ToString();
                data.IsDelete = rdr["IsDelete"].ToString();
                data.FlagID = rdr["FlagID"].ToString();
                data.FlagDesc = rdr["FlagDesc"].ToString();
                data.CreatedBy = rdr["CreatedBy"].ToString();
                data.CreateName = rdr["CreateName"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UpdatedBy = rdr["UpdatedBy"].ToString();
                data.UpdateDate = rdr["UpdateDate"].ToString();
                data.SaleEMail = rdr["SaleEMail"].ToString();
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
        public void getQuotationApprovalList(string empid)
        {
            List<cQuotationList> datas = new List<cQuotationList>();
            SqlCommand comm = new SqlCommand("spGetQuotationApprovalList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@empid", empid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cQuotationList data = new cQuotationList();
                data.QtGid = rdr["QtGid"].ToString();
                data.imBranchGid = rdr["imBranchGid"].ToString();
                data.BranchName = rdr["BranchName"].ToString();
                data.adQTNO = rdr["adQTNO"].ToString();
                data.RefQTNO = rdr["RefQTNO"].ToString();
                data.ProjectName = rdr["ProjectName"].ToString();
                data.ProjectID = rdr["ProjectID"].ToString();
                data.ProjectDesc = rdr["ProjectDesc"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.DeliveryDate = rdr["DeliveryDate"].ToString();
                data.InYear = rdr["InYear"].ToString();
                data.VendorID = rdr["VendorID"].ToString();
                data.VendorName = rdr["VendorName"].ToString();
                data.ContactName = rdr["ContactName"].ToString();
                data.ContactTel = rdr["ContactTel"].ToString();
                data.CurrencyRate = rdr["CurrencyRate"].ToString();
                data.adCurrencyID = rdr["adCurrencyID"].ToString();
                data.CurrencyDesc = rdr["CurrencyDesc"].ToString();
                data.TotalAmount = rdr["TotalAmount"].ToString();
                data.VATAmount = rdr["VATAmount"].ToString();
                data.TotalAmountExcludeVAT = rdr["TotalAmountExcludeVAT"].ToString();
                data.DiscPercent = rdr["DiscPercent"].ToString();
                data.DiscAmount = rdr["DiscAmount"].ToString();
                data.DiscExtendPercent = rdr["DiscExtendPercent"].ToString();
                data.DiscExtendAmount = rdr["DiscExtendAmount"].ToString();
                data.AmountExtraDisc = rdr["AmountExtraDisc"].ToString();
                data.TotalAmountAfterDisc = rdr["TotalAmountAfterDisc"].ToString();
                data.QTRemark = rdr["QTRemark"].ToString();
                data.QTComment = rdr["QTComment"].ToString();
                data.imDeliveryID = rdr["imDeliveryID"].ToString();
                data.DeliveryName = rdr["DeliveryName"].ToString();
                data.adPaymentTypeID = rdr["adPaymentTypeID"].ToString();
                data.PaymentTypeDesc = rdr["PaymentTypeDesc"].ToString();
                data.imEmployeeGid = rdr["imEmployeeGid"].ToString();
                data.empFullName = rdr["empFullName"].ToString();
                data.SalePositionName = rdr["SalePositionName"].ToString();
                data.ApproveID = rdr["ApproveID"].ToString();
                data.ApproveName = rdr["ApproveName"].ToString();
                data.ApprovePositionID = rdr["ApprovePositionID"].ToString();
                data.ApprovePositionName = rdr["ApprovePositionName"].ToString();
                data.IsDelete = rdr["IsDelete"].ToString();
                data.FlagID = rdr["FlagID"].ToString();
                data.FlagDesc = rdr["FlagDesc"].ToString();
                data.CreatedBy = rdr["CreatedBy"].ToString();
                data.CreateName = rdr["CreateName"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UpdatedBy = rdr["UpdatedBy"].ToString();
                data.UpdateDate = rdr["UpdateDate"].ToString();
                data.SaleEMail = rdr["SaleEMail"].ToString();
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
        public void getRunningDocuNo(string docuno, string branchid) {
            List<cRunningDocuNo> datas = new List<cRunningDocuNo>();
            SqlCommand comm = new SqlCommand("spGetRunningDocuNo", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@docuno", docuno);
            comm.Parameters.AddWithValue("@imbranchgid", branchid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cRunningDocuNo data = new cRunningDocuNo();                
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
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getQuotationOrder (string acttrans, string qtgid, string imbranchgid, string adqtno, string refqtno, string projectname, string projectid, string deliverydate,
            string docudate, string inyear, string vendorid, string vendorname, string vendoraddr, string vendortaxid, string sourcegid, string vendorbranchno, string vendoremail, string contactname,
            string contacttel, string currencyrate, string adcurrencyid, string currencydesc, string totalamount, string vatamount, string totalamountexcludevat, string discpercent,
            string discamount, string discextendpercent, string discextendamount, string amountextradisc, string totalamountafterdisc, string qtremark, string qtcomment, string imdeliveryid,
            string adpaymenttypeid, string imemployeegid, string salepositionname, string approveid, string approvename, string approvepositionid, string approvepositionname, string isdelete,
            string flagid, string createdby, string createddate, string updatedby, string updatedate, string saleemail, string referdocuno)
        {
            List<cQuotationOrder> datas = new List<cQuotationOrder>();
            SqlCommand comm = new SqlCommand("spGetQuotationOrder", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@acttrans", acttrans);
            comm.Parameters.AddWithValue("@QtGid", qtgid);
            comm.Parameters.AddWithValue("@imBranchGid", imbranchgid);
            comm.Parameters.AddWithValue("@adQTNO", adqtno);
            comm.Parameters.AddWithValue("@RefQTNO", refqtno);
            comm.Parameters.AddWithValue("@ProjectName", projectname);
            comm.Parameters.AddWithValue("@ProjectID", projectid);
            comm.Parameters.AddWithValue("@DeliveryDate", deliverydate);
            comm.Parameters.AddWithValue("@DocuDate", docudate);
            comm.Parameters.AddWithValue("@InYear", inyear);
            comm.Parameters.AddWithValue("@VendorID", vendorid);
            comm.Parameters.AddWithValue("@VendorName", vendorname);
            comm.Parameters.AddWithValue("@VendorAddr", vendoraddr);
            comm.Parameters.AddWithValue("@VendorTaxID", vendortaxid);
            comm.Parameters.AddWithValue("@SourceGid", sourcegid);

            comm.Parameters.AddWithValue("@VendorBranchNo", vendorbranchno);
            comm.Parameters.AddWithValue("@VendorEmail", vendoremail);
            comm.Parameters.AddWithValue("@ContactName", contactname);
            comm.Parameters.AddWithValue("@ContactTel", contacttel);
            comm.Parameters.AddWithValue("@CurrencyRate", currencyrate);
            comm.Parameters.AddWithValue("@adCurrencyID", adcurrencyid);
            comm.Parameters.AddWithValue("@CurrencyDesc", currencydesc);

            comm.Parameters.AddWithValue("@TotalAmount", totalamount.Replace(",", ""));
            comm.Parameters.AddWithValue("@VATAmount", vatamount.Replace(",", ""));
            comm.Parameters.AddWithValue("@TotalAmountExcludeVAT", totalamountexcludevat.Replace(",", ""));
            comm.Parameters.AddWithValue("@DiscPercent", discpercent.Replace(",", ""));
            comm.Parameters.AddWithValue("@DiscAmount", discamount.Replace(",", ""));
            comm.Parameters.AddWithValue("@DiscExtendPercent", discextendpercent.Replace(",", ""));
            comm.Parameters.AddWithValue("@DiscExtendAmount", discextendamount.Replace(",", ""));
            comm.Parameters.AddWithValue("@AmountExtraDisc", amountextradisc.Replace(",", ""));
            comm.Parameters.AddWithValue("@TotalAmountAfterDisc", totalamountafterdisc.Replace(",", ""));

            comm.Parameters.AddWithValue("@QTRemark", qtremark);
            comm.Parameters.AddWithValue("@QTComment", qtcomment);
            comm.Parameters.AddWithValue("@imDeliveryID", imdeliveryid);
            comm.Parameters.AddWithValue("@adPaymentTypeID", adpaymenttypeid);
            comm.Parameters.AddWithValue("@imEmployeeGid", imemployeegid);
            comm.Parameters.AddWithValue("@SalePositionName", salepositionname);
            comm.Parameters.AddWithValue("@ApproveID", approveid);
            comm.Parameters.AddWithValue("@ApproveName", approvename);
            comm.Parameters.AddWithValue("@ApprovePositionID", approvepositionid);
            comm.Parameters.AddWithValue("@ApprovePositionName", approvepositionname);
            comm.Parameters.AddWithValue("@IsDelete", isdelete);
            comm.Parameters.AddWithValue("@FlagID", flagid);
            comm.Parameters.AddWithValue("@CreatedBy", createdby);
            comm.Parameters.AddWithValue("@CreatedDate", createddate);
            comm.Parameters.AddWithValue("@UpdatedBy", updatedby);
            comm.Parameters.AddWithValue("@UpdateDate", updatedate);
            comm.Parameters.AddWithValue("@SaleEMail", saleemail);
            comm.Parameters.AddWithValue("@ReferDocuNo", referdocuno);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cQuotationOrder data = new cQuotationOrder();
                data.QtGid = rdr["QtGid"].ToString();               
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();

        }
        
        [WebMethod]
        public void getQuotationOrderById(string gid)
        {
            List<cQuotationList> datas = new List<cQuotationList>();
            SqlCommand comm = new SqlCommand("spGetQuotationOrderById", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@gid", gid);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cQuotationList data = new cQuotationList();
                data.QtGid = rdr["QtGid"].ToString();
                data.imBranchGid = rdr["imBranchGid"].ToString();
                data.adQTNO = rdr["adQTNO"].ToString();
                data.RefQTNO = rdr["RefQTNO"].ToString();
                data.ProjectName = rdr["ProjectName"].ToString();
                data.ProjectID = rdr["ProjectID"].ToString();
                data.DeliveryDate = rdr["DeliveryDate"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InYear = rdr["InYear"].ToString();
                data.VendorID = rdr["VendorID"].ToString();
                data.VendorName = rdr["VendorName"].ToString();
                data.VendorAddr = rdr["VendorAddr"].ToString();
                data.VendorTaxID = rdr["VendorTaxID"].ToString();
                data.SourceGid = rdr["SourceGid"].ToString();
                data.VendorBranchNo = rdr["VendorBranchNo"].ToString();
                data.VendorEmail = rdr["VendorEmail"].ToString();
                data.ContactName = rdr["ContactName"].ToString();
                data.ContactTel = rdr["ContactTel"].ToString();
                data.CurrencyRate = rdr["CurrencyRate"].ToString();
                data.adCurrencyID = rdr["adCurrencyID"].ToString();
                data.CurrencyDesc = rdr["CurrencyDesc"].ToString();
                data.TotalAmount = rdr["TotalAmount"].ToString();
                data.VATAmount = rdr["VATAmount"].ToString();
                data.TotalAmountExcludeVAT = rdr["TotalAmountExcludeVAT"].ToString();
                data.DiscPercent = rdr["DiscPercent"].ToString();
                data.DiscAmount = rdr["DiscAmount"].ToString();
                data.DiscExtendPercent = rdr["DiscExtendPercent"].ToString();
                data.DiscExtendAmount = rdr["DiscExtendAmount"].ToString();
                data.AmountExtraDisc = rdr["AmountExtraDisc"].ToString();
                data.TotalAmountAfterDisc = rdr["TotalAmountAfterDisc"].ToString();
                data.QTRemark = rdr["QTRemark"].ToString();
                data.QTComment = rdr["QTComment"].ToString();
                data.imDeliveryID = rdr["imDeliveryID"].ToString();
                data.adPaymentTypeID = rdr["adPaymentTypeID"].ToString();
                data.imEmployeeGid = rdr["imEmployeeGid"].ToString();
                data.SalePositionName = rdr["SalePositionName"].ToString();
                data.ApproveID = rdr["ApproveID"].ToString();
                data.ApproveName = rdr["ApproveName"].ToString();
                data.ApprovePositionID = rdr["ApprovePositionID"].ToString();
                data.ApprovePositionName = rdr["ApprovePositionName"].ToString();
                data.IsDelete = rdr["IsDelete"].ToString();
                data.FlagID = rdr["FlagID"].ToString();
                data.FlagDesc = rdr["FlagDesc"].ToString();
                data.CreatedBy = rdr["CreatedBy"].ToString();
                data.CreateDate = rdr["CreateDate"].ToString();
                data.UpdatedBy = rdr["UpdatedBy"].ToString();
                data.UpdateDate = rdr["UpdateDate"].ToString();
                data.SaleEMail = rdr["SaleEMail"].ToString();
                data.ReferDocuNo = rdr["ReferDocuNo"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();

        }

        [WebMethod]
        public void getGoodCodeSelectList() {
            List<cGoodCodeSelectList> datas = new List<cGoodCodeSelectList>();
            SqlCommand comm = new SqlCommand("spGetGoodCodeSelectList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
          
            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGoodCodeSelectList data = new cGoodCodeSelectList();
                data.GoodCodeID = rdr["GoodCodeID"].ToString();
                data.GoodGroupID = rdr["GoodGroupID"].ToString();
                data.GoodGroupDesc = rdr["GoodGroupDesc"].ToString();
                data.GoodTypeID = rdr["GoodTypeID"].ToString();
                data.GoodTypeDesc = rdr["GoodTypeDesc"].ToString();
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
        public void getQuotationAddnewItem(string gid, string imbranchgid, string seqno, string qtgid, string adqtno, string goodcodeid, string  goodname, 
                    string  goodunitid, string  goodunitdesc, string qtyunit, string qtyrema, string  quantity,
                    string  priceperunit, string  amount, string  vatamount, string  amountexcludevat, string  discpercent, 
                    string  discamount, string  amountafterdisc, string  netamount, string  unitcostid, string unitcost, 
                    string  remark, string aduserid, string lastdate, string pattern, string qtyextra) {
            SqlCommand comm = new SqlCommand("spGetQuotationAddnewItem", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
           
            comm.Parameters.AddWithValue("@gid", gid);
            comm.Parameters.AddWithValue("@imbranchgid", imbranchgid);
            comm.Parameters.AddWithValue("@seqno", seqno);
            comm.Parameters.AddWithValue("@qtgid", qtgid);
            comm.Parameters.AddWithValue("@adqtno", adqtno);
            comm.Parameters.AddWithValue("@goodcodeid", goodcodeid);
            comm.Parameters.AddWithValue("@goodname", goodname);
            comm.Parameters.AddWithValue("@goodunitid", goodunitid);
            comm.Parameters.AddWithValue("@goodunitdesc", goodunitdesc);

            comm.Parameters.AddWithValue("@qtyunit", qtyunit);
            comm.Parameters.AddWithValue("@qtyrema", qtyrema);

            comm.Parameters.AddWithValue("@quantity", quantity);
            comm.Parameters.AddWithValue("@priceperunit", priceperunit);
            comm.Parameters.AddWithValue("@amount", amount);
            comm.Parameters.AddWithValue("@vatamount", vatamount);
            comm.Parameters.AddWithValue("@amountexcludevat", amountexcludevat);
            comm.Parameters.AddWithValue("@discpercent", discpercent);
            comm.Parameters.AddWithValue("@discamount", discamount);
            comm.Parameters.AddWithValue("@amountafterdisc", amountafterdisc);
            comm.Parameters.AddWithValue("@netamount", netamount);
            comm.Parameters.AddWithValue("@unitcostid", unitcostid);
            comm.Parameters.AddWithValue("@unitcost", unitcost);
            comm.Parameters.AddWithValue("@remark", remark);
            comm.Parameters.AddWithValue("@aduserid", aduserid);
            comm.Parameters.AddWithValue("@lastdate", lastdate);
            comm.Parameters.AddWithValue("@pattern", pattern);
            comm.Parameters.AddWithValue("@qtyextra", qtyextra);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void getQuotationDetails(string qtgid) {
            List<cQuotationDetails> datas = new List<cQuotationDetails>();
            SqlCommand comm = new SqlCommand("spGetQuotationDetails", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@qtgid", qtgid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cQuotationDetails data = new cQuotationDetails();
               
                data.Gid = rdr["Gid"].ToString();
                data.imBranchGid = rdr["imBranchGid"].ToString();
                data.SeqNO = rdr["SeqNO"].ToString();
                data.QtGid = rdr["QtGid"].ToString();
                data.adQTNO = rdr["adQTNO"].ToString();
                data.GoodGroupID = rdr["GoodGroupID"].ToString();
                data.GoodGroupDesc = rdr["GoodGroupDesc"].ToString();
                data.GoodCodeID = rdr["GoodCodeID"].ToString();
                data.GoodCode = rdr["GoodCode"].ToString();
                data.GoodName = rdr["GoodName"].ToString();
                data.GoodUnitID = rdr["GoodUnitID"].ToString();
                data.GoodUnitDesc = rdr["GoodUnitDesc"].ToString();
                data.Quantity = rdr["Quantity"].ToString();
                data.QtyUnit = rdr["QtyUnit"].ToString();
                data.QtyUnitDesc = rdr["QtyUnitDesc"].ToString();                
                data.QtyRema = rdr["QtyRema"].ToString();

                
                data.PricePerUnit = rdr["PricePerUnit"].ToString();
                data.Amount = rdr["Amount"].ToString();
                data.VATAmount = rdr["VATAmount"].ToString();
                data.AmountExcludeVAT = rdr["AmountExcludeVAT"].ToString();
                data.DiscPercent = rdr["DiscPercent"].ToString();
                data.DiscAmount = rdr["DiscAmount"].ToString();
                data.AmountAfterDisc = rdr["AmountAfterDisc"].ToString();
                data.NetAmount = rdr["NetAmount"].ToString();
                data.UnitCostID = rdr["UnitCostID"].ToString();
                data.UnitCost = rdr["UnitCost"].ToString();
                data.Remark = rdr["Remark"].ToString();
                data.adUserID = rdr["adUserID"].ToString();
                data.Lastdate = rdr["Lastdate"].ToString();
                data.Pattern = rdr["Pattern"].ToString();
                data.QtyExtra = rdr["QtyExtra"].ToString();
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
        public void getQuotationItemUpdate(string acttrans, string QtGid, string gid, string seqno, string QtyUnit, string QtyRema, string  Quantity, 
            string PricePerUnit, string  Amount, string DiscPercent, string DiscAmount, string  AmountAfterDisc, string  Remark, string  adUserID, 
            string Lastdate, string Pattern, string QtyExtra)
        {
            try
            {
                SqlCommand comm = new SqlCommand("spGetQuotationItemUpdate", conn.OpenConn());
                comm.CommandType = CommandType.StoredProcedure;

                comm.Parameters.AddWithValue("@acttrans", acttrans);
                comm.Parameters.AddWithValue("@QtGid", QtGid);
                comm.Parameters.AddWithValue("@gid", gid);
                comm.Parameters.AddWithValue("@seqno", seqno);
                comm.Parameters.AddWithValue("@QtyUnit", QtyUnit);
                comm.Parameters.AddWithValue("@QtyRema", QtyRema);
                comm.Parameters.AddWithValue("@Quantity", Quantity);
                comm.Parameters.AddWithValue("@PricePerUnit", PricePerUnit);
                comm.Parameters.AddWithValue("@Amount", Amount);

                comm.Parameters.AddWithValue("@DiscPercent", DiscPercent);
                comm.Parameters.AddWithValue("@DiscAmount", DiscAmount);
                comm.Parameters.AddWithValue("@AmountAfterDisc", AmountAfterDisc);
                comm.Parameters.AddWithValue("@Remark", Remark);
                comm.Parameters.AddWithValue("@adUserID", adUserID);
                comm.Parameters.AddWithValue("@Lastdate", Lastdate);
                comm.Parameters.AddWithValue("@Pattern", Pattern);
                comm.Parameters.AddWithValue("@QtyExtra", QtyExtra);
                comm.ExecuteNonQuery();

                conn.CloseConn();
            }
            catch (Exception ex) {

            }           

        }

        [WebMethod]
        public void getQuotationOrderStatus(string gid, string flagid)
        {
            try
            {
                SqlCommand comm = new SqlCommand("spGetQuotationOrderStatus", conn.OpenConn());
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@gid", gid);
                comm.Parameters.AddWithValue("@flagid", flagid);
                comm.ExecuteNonQuery();

                conn.CloseConn();
            }
            catch (Exception ex)
            {

            }        
        }

        [WebMethod]
        public void getQuotationCopyTrans(string qtgid, string docuno) {
            SqlCommand comm = new SqlCommand("spGetQuotationCopyTrans", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@qtgid", qtgid);
            comm.Parameters.AddWithValue("@docuno", docuno);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
    }
}
