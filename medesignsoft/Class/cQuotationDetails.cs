using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace medesignsoft
{
    public class cQuotationDetails
    {
        public string Gid { get; set; }
        public string imBranchGid { get; set; }
        public string SeqNO { get; set; }
        public string QtGid { get; set; }
        public string adQTNO { get; set; }
        public string GoodGroupID { get; set; }
        public string GoodGroupDesc { get; set; }
        public string GoodCodeID { get; set; }
        public string GoodCode { get; set; }
        public string GoodName { get; set; }
        public string GoodUnitID { get; set; }
        public string GoodUnitDesc { get; set; }

        public string QtyUnit { get; set; }
        public string QtyUnitDesc { get; set; }        
        public string QtyRema { get; set; }

        public string Quantity { get; set; }
        public string PricePerUnit { get; set; }
        public string Amount { get; set; }
        public string VATAmount { get; set; }
        public string AmountExcludeVAT { get; set; }
        public string DiscPercent { get; set; }
        public string DiscAmount { get; set; }
        public string AmountAfterDisc { get; set; }
        public string NetAmount { get; set; }
        public string UnitCostID { get; set; }
        public string UnitCost { get; set; }
        public string Remark { get; set; }
        public string adUserID { get; set; }
        public string Lastdate { get; set; }
        public string Pattern { get; set; }
        public string QtyExtra { get; set; }
        public string edit { get; set; }
        public string trash { get; set; }

    }
}