using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medesignsoft.mesales_order
{
    public partial class so_entry : System.Web.UI.Page
    {
        bahttext bahttext = new bahttext();

        protected void Page_Load(object sender, EventArgs e)
        {
           //string xbahttext =  bahttext.ToBahtText(15369851.00);

           // Response.Write(xbahttext);

        }
    }
}