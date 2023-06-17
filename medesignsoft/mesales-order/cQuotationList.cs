using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace medesignsoft
{
    public class cQuotationList
    {
        public string QtGid { get; set; }
        public string imBranchGid { get; set; }
        public string BranchName { get; set; }
        public string adQTNO { get; set; }
        public string RefQTNO { get; set; }
        public string ProjectName { get; set; }
        public string ProjectID { get; set; }
        public string ProjectDesc { get; set; }
        public string DocuDate { get; set; }
        public string DeliveryDate { get; set; }
        public string InYear { get; set; }
        public string VendorID { get; set; }
        public string VendorName { get; set; }
        public string VendorAddr { get; set; }
        public string VendorTaxID { get; set; }
        public string SourceGid { get; set; }
        public string VendorBranchNo { get; set; }
        public string VendorEmail { get; set; }

        public string ContactName { get; set; }
        public string ContactTel { get; set; }
        public string CurrencyRate { get; set; }
        public string adCurrencyID { get; set; }
        public string CurrencyDesc { get; set; }
        public string TotalAmount { get; set; }
        public string VATAmount { get; set; }
        public string TotalAmountExcludeVAT { get; set; }
        public string DiscPercent { get; set; }
        public string DiscAmount { get; set; }
        public string DiscExtendPercent { get; set; }
        public string DiscExtendAmount { get; set; }
        public string AmountExtraDisc { get; set; }
        public string TotalAmountAfterDisc { get; set; }
        public string QTRemark { get; set; }
        public string QTComment { get; set; }
        public string imDeliveryID { get; set; }
        public string DeliveryName { get; set; }
        public string adPaymentTypeID { get; set; }
        public string PaymentTypeDesc { get; set; }
        public string imEmployeeGid { get; set; }
        public string empFullName { get; set; }
        public string SalePositionName { get; set; }
        public string ApproveID { get; set; }
        public string ApproveName { get; set; }
        public string ApprovePositionID { get; set; }
        public string ApprovePositionName { get; set; }
        public string IsDelete { get; set; }
        public string FlagID { get; set; }
        public string FlagDesc { get; set; }
        public string CreatedBy { get; set; }
        public string CreatedDate { get; set; }
        public string CreateName { get; set; }
        public string CreateDate { get; set; }
        public string UpdatedBy { get; set; }
        public string UpdateDate { get; set; }
        public string SaleEMail { get; set; }
        public string ReferDocuNo { get; set; }
        public string edit { get; set; }
        public string trash { get; set; }
    }
}