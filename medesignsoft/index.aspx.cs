using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.DataVisualization.Charting;

namespace medesignsoft
{
    public partial class index : System.Web.UI.Page
    {
        dbConnection con = new dbConnection();
        SqlCommand com = new SqlCommand();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    DateTime date = DateTime.Now;
                    var sdate = new DateTime(date.Year, date.Month, 1).ToString("yyyy-MM-dd");
                    string edate = DateTime.Now.ToString("yyy-MM-dd");

                    lbldatestart.Text = sdate;
                    lbldatestop.Text = edate;                   

                    lbldateprodstart.Text = sdate;
                    lbldateprodstop.Text = edate;

                    lbldateprodamount.Text = DateTime.Now.ToString("yyyy-MM-dd");

                    Bindchart(sdate, edate);
                    BindPieChart(sdate, edate);
                    BindPieChartAmount(sdate, edate);
                }
            }
            catch {
            }            
        }

        protected void GetDataChart(object sender, EventArgs e)
        {
            try
            {

                string sdate = datestart.Value.ToString();
                string edate = datestop.Value.ToString();

                lbldatestart.Text = sdate;
                lbldatestop.Text = edate;

                lbldateprodstart.Text = sdate;
                lbldateprodstop.Text = edate;

                lbldateprodamount.Text = DateTime.Now.ToString("yyyy-MM-dd");

                Bindchart(sdate, edate);
                BindPieChart(sdate, edate);
                BindPieChartAmount(sdate, edate);

            }
            catch (Exception ex)
            {
                var msg = ex.Message;
            }
        }

        private void Bindchart(string sdate, string edate)
        {
            //string sdate = Request.Form["datestart"].ToString();
            //string edate = Request.Form["datestop"].ToString(); ;  // Request.Form["datestop"];

            com = new SqlCommand("sptw_GetCharDataLine", con.OpenConn());
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@sdate", sdate);
            com.Parameters.AddWithValue("@edate", edate);

            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DataTable ChartData = ds.Tables[0];

            //storing total rows count to loop on each Record
            string[] XPointMember = new string[ChartData.Rows.Count];
            string[] XPointMember2 = new string[ChartData.Rows.Count];
            string[] XPointMember3 = new string[ChartData.Rows.Count];

            int[] YPointMember = new int[ChartData.Rows.Count];
            int[] YPointMember2 = new int[ChartData.Rows.Count];
            int[] YPointMember3 = new int[ChartData.Rows.Count];

            for (int count = 0; count < ChartData.Rows.Count; count++)
            {
                //storing Values for X axis
                XPointMember[count] = ChartData.Rows[count]["COMNAME"].ToString();
                XPointMember2[count] = ChartData.Rows[count]["COMNAME"].ToString();
                XPointMember3[count] = ChartData.Rows[count]["COMNAME"].ToString();

                //storing values for Y Axis
                YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["ทรายหยาบ"]);
                YPointMember2[count] = Convert.ToInt32(ChartData.Rows[count]["ทรายละเอียด"]);
                YPointMember3[count] = Convert.ToInt32(ChartData.Rows[count]["ทรายถม"]);

            }
            Chart2.ChartAreas[0].AxisX.LabelStyle.Font = new System.Drawing.Font("CSChatThaiUI", 10, FontStyle.Regular);

            Color[] PieColors = { Color.DodgerBlue, Color.Red, Color.Gray };

            Chart2.Series["ทรายหยาบ"].Font = new Font("Arial", 8, FontStyle.Regular);
            Chart2.Series["ทรายละเอียด"].Font = new Font("Arial", 8, FontStyle.Regular);
            Chart2.Series["ทรายถม"].Font = new Font("Arial", 8, FontStyle.Regular);

            //binding chart control
            Chart2.Series[0].Points.DataBindXY(XPointMember, YPointMember);
            Chart2.Series[1].Points.DataBindXY(XPointMember2, YPointMember2);
            Chart2.Series[2].Points.DataBindXY(XPointMember3, YPointMember3);

            Chart2.ChartAreas[0].AxisX.LabelStyle.Interval = 1;

            //Setting width of line
            Chart2.Series[0].BorderWidth = 10;
            //setting Chart type 
            //Chart1.Series[0].ChartType = SeriesChartType.Bar ;
            Chart2.Series[0].ChartType = SeriesChartType.StackedBar;
            Chart2.Series[1].ChartType = SeriesChartType.StackedBar;
            Chart2.Series[2].ChartType = SeriesChartType.StackedBar;

            Chart2.Series[0].IsValueShownAsLabel = true;
            Chart2.Series[1].IsValueShownAsLabel = true;
            Chart2.Series[2].IsValueShownAsLabel = true;

            //Chart2.Series[0].Points[0].Color = PieColors[0];
            //Chart2.Series[1].Points[1].Color = PieColors[1];
            //Chart2.Series[2].Points[2].Color = PieColors[2];

            foreach (Series charts in Chart2.Series)
            {
                foreach (DataPoint point in charts.Points)
                {
                    switch (point.AxisLabel)
                    {
                        case "ทรายหยาบ": point.Color = Color.DodgerBlue; break;
                        case "ทรายละเอียด": point.Color = Color.Red; break;
                        case "ทรายถม": point.Color = Color.Gray; break;
                    }
                    //point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);
                }
            }

            //Chart1.Series("Default").Points(0)("Exploded") = "True";

            //Hide or show chart back GridLines
            Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;

            //Enabled 3D
            //Chart2.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;  


            //Line Chart*******
            Chart3.Series["ทรายหยาบ"].Font = new Font("Arial", 8, FontStyle.Regular);
            Chart3.Series["ทรายละเอียด"].Font = new Font("Arial", 8, FontStyle.Regular);
            Chart3.Series["ทรายถม"].Font = new Font("Arial", 8, FontStyle.Regular);

            //binding chart control
            Chart3.Series[0].Points.DataBindXY(XPointMember, YPointMember);
            Chart3.Series[1].Points.DataBindXY(XPointMember2, YPointMember2);
            Chart3.Series[2].Points.DataBindXY(XPointMember3, YPointMember3);

            Chart3.ChartAreas[0].AxisX.LabelStyle.Interval = 1;

            //Setting width of line
            Chart3.Series[0].BorderWidth = 3;
            Chart3.Series[1].BorderWidth = 3;
            Chart3.Series[2].BorderWidth = 3;

            //setting Chart type 
            //Chart1.Series[0].ChartType = SeriesChartType.Bar ;
            Chart3.Series[0].ChartType = SeriesChartType.Line;
            Chart3.Series[1].ChartType = SeriesChartType.Line;
            Chart3.Series[2].ChartType = SeriesChartType.Line;

            Chart3.Series[0].IsValueShownAsLabel = true;
            Chart3.Series[1].IsValueShownAsLabel = true;
            Chart3.Series[2].IsValueShownAsLabel = true;

            //Chart3.Series[0].Points[0].Color = PieColors[0];
            //Chart3.Series[1].Points[1].Color = PieColors[1];
            //Chart3.Series[2].Points[2].Color = PieColors[2];

            foreach (Series charts in Chart3.Series)
            {
                foreach (DataPoint point in charts.Points)
                {
                    switch (point.AxisLabel)
                    {
                        case "ทรายหยาบ": point.Color = Color.DodgerBlue; break;
                        case "ทรายละเอียด": point.Color = Color.Red; break;
                        case "ทรายถม": point.Color = Color.Gray; break;
                    }
                    //point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);
                }
            }

            //Hide or show chart back GridLines
            Chart3.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;

            //Enabled 3D
            //Chart2.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;

            con.CloseConn();
        }

        private void BindPieChart(string sdate, string edate)
        {

            com = new SqlCommand("sptw_GetChartDataPie", con.OpenConn());
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@sdate", sdate);
            com.Parameters.AddWithValue("@edate", edate);

            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DataTable ChartData = ds.Tables[0];

            //storing total rows count to loop on each Record
            string[] XPointMember = new string[ChartData.Rows.Count];                 

            int[] YPointMember = new int[ChartData.Rows.Count];          

            for (int count = 0; count < ChartData.Rows.Count; count++)
            {
                //storing Values for X axis
                XPointMember[count] = ChartData.Rows[count]["HNAME"].ToString();
               
                //storing values for Y Axis
                YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["WNET"]);

            }
           

            Chart1.ChartAreas[0].AxisX.LabelStyle.Font = new System.Drawing.Font("CSChatThaiUI", 10, FontStyle.Regular);

            Chart1.Series["ทรายหยาบ"].Font = new Font("Arial", 8, FontStyle.Regular);
            Chart1.Series["ทรายละเอียด"].Font = new Font("Arial", 8, FontStyle.Regular);
            Chart1.Series["ทรายถม"].Font = new Font("Arial", 8, FontStyle.Regular);

            //binding chart control    
            Chart1.Series[0].Points.DataBindXY(XPointMember, YPointMember);
            Color[] PieColors = { Color.DodgerBlue, Color.Red, Color.Gray };

            // Chart1.ChartAreas[0].AxisX.LabelStyle.Interval = 1;

            //Setting width of line
            Chart1.Series[0].BorderWidth = 2;
            //setting Chart type 
            Chart1.Series[0].ChartType = SeriesChartType.Pie;

            foreach (Series charts in Chart1.Series)
            {
                foreach (DataPoint point in charts.Points)
                {
                    switch (point.AxisLabel)
                    {
                        case "ทรายหยาบ": point.Color = Color.DodgerBlue; break;
                        case "ทรายละเอียด": point.Color = Color.Red; break;
                        case "ทรายถม": point.Color = Color.Gray; break;
                    }
                    //point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);
                }
            }


            Chart1.Series[0].IsValueShownAsLabel = true;

            Chart1.Series[0].Label = "#PERCENT{P2}\n#VALX\n#VALY";
            //Chart1.Series[1].Label = "ทรายละเอียด";
            //Chart1.Series[2].Label = "ทรายถม";

            //Chart1.Series[0].Points[0].Color = PieColors[0];
            //Chart1.Series[0].Points[1].Color = PieColors[1];
            //Chart1.Series[0].Points[2].Color = PieColors[2];

            

            //Chart1.Series[0].Points[0]["Exploded"] = "True";

            //Hide or show chart back GridLines
            Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;

            //Enabled 3D
            //Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;

            con.CloseConn();
        }

        private void BindPieChartAmount(string sdate, string edate)
        {
            com = new SqlCommand("sptw_GetChartDataPieAmount", con.OpenConn());
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@sdate", sdate);
            com.Parameters.AddWithValue("@edate", edate);

            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DataTable ChartData = ds.Tables[0];

            //storing total rows count to loop on each Record
            string[] XPointMember = new string[ChartData.Rows.Count];

            int[] YPointMember = new int[ChartData.Rows.Count];

            for (int count = 0; count < ChartData.Rows.Count; count++)
            {
                //storing Values for X axis
                XPointMember[count] = ChartData.Rows[count]["HNAME_AMONT"].ToString();

                //storing values for Y Axis
                YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["WNET_AMONT"]);
            }

            Chart4.ChartAreas[0].AxisX.LabelStyle.Font = new System.Drawing.Font("CSChatThaiUI", 10, FontStyle.Regular);

            Color[] PieColors = { Color.DodgerBlue, Color.Red, Color.Gray };

            Chart4.Series["ทรายหยาบ"].Font = new Font("Arial", 8, FontStyle.Regular);
            Chart4.Series["ทรายละเอียด"].Font = new Font("Arial", 8, FontStyle.Regular);
            Chart4.Series["ทรายถม"].Font = new Font("Arial", 8, FontStyle.Regular);

            //binding chart control    
            Chart4.Series[0].Points.DataBindXY(XPointMember, YPointMember);

            //Chart4.Series["ทรายหยาบ"].Points[0].Color = Color.Blue;
            //Chart4.Series["ทรายละเอียด"].Points[0].Color = Color.Red;
            //Chart4.Series["ทรายถม"].Points[0].Color = Color.Orange;

            

            // Chart1.ChartAreas[0].AxisX.LabelStyle.Interval = 1;

            //Setting width of line
            Chart4.Series[0].BorderWidth = 2;
            //setting Chart type 
            Chart4.Series[0].ChartType = SeriesChartType.Pie;

            foreach (Series charts in Chart4.Series)
            {
                foreach (DataPoint point in charts.Points)
                {
                    switch (point.AxisLabel)
                    {
                        case "ทรายหยาบ": point.Color = Color.DodgerBlue; break;
                        case "ทรายละเอียด": point.Color = Color.Red; break;
                        case "ทรายถม": point.Color = Color.Gray; break;
                    }
                    //point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);
                }
            }

            Chart4.Series[0].IsValueShownAsLabel = true;

            Chart4.Series[0].Label = "#PERCENT{P2}\n#VALX\n#VALY";
            //Chart3.Series[1].Label = "ทรายละเอียด";
            //Chart3.Series[2].Label = "ทรายถม";

            //Chart4.Series[0].Points[0].Color = PieColors[0];
            //Chart4.Series[0].Points[1].Color = PieColors[1];
            //Chart4.Series[0].Points[2].Color = PieColors[2];

            //Chart1.Series("Default").Points(0)("Exploded") = "True";

            //Hide or show chart back GridLines
            Chart4.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;

            //Enabled 3D
            //Chart4.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;

            con.CloseConn();
        }
    }
}