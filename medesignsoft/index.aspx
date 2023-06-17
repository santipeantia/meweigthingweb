<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="medesignsoft.index" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">     

        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>--%>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../ayutthayaland/bower_components/jquery/dist/jquery.min.js"></script>

        <style>
            .hide_column {
                display: none;
            }

            #tblprojectlists i:hover {
                cursor: pointer;
            }

            #tbltranswithoutsalesconsignee i:hover {
                cursor: pointer;
            }

            #overlay {
                position: fixed;
                top: 0;
                z-index: 100;
                width: 100%;
                height: 100%;
                display: none;
                background: rgba(0,0,0,0.6);
            }

            .cv-spinner {
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .spinner {
                width: 40px;
                height: 40px;
                border: 4px #ddd solid;
                border-top: 4px #2e93e6 solid;
                border-radius: 50%;
                animation: sp-anime 0.8s infinite linear;
            }

            @keyframes sp-anime {
                100% {
                    transform: rotate(360deg);
                }
            }

            .is-hide {
                display: none;
            }

            .myclass {
                text-align: right;
            }

            .myclassblue {
                text-align: right;
                color: blue;
            }
        </style>

        <script>
            $(document).ready(function () {
                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var ddd = String(today.getDate() - 0).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var firstdate = yyyy + '-' + mm + '-' + '01';
                var nowdate = yyyy + '-' + mm + '-' + ddd;

                var ssdate = firstdate;
                var eedate = nowdate;

                $('#datestart').val(ssdate);
                $('#datestop').val(eedate);

            });
        </script>

        <h1 class="">หน้าหลัก <%--step 1 check pages content name--%>
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <div class="row">

          
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <i class="fa fa-bar-chart-o"></i>
                        <h3 class="box-title">ยอดขายลูกค้า (ตัน) TOP 10 จากวันที่ : <asp:Label ID="lbldatestart" Text="" runat="server" /> ถึง <asp:Label ID="lbldatestop" Text="" runat="server" /> </h3>
                    </div>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-2">
                                <div class="input-group date">
                                    <input type="text" class="form-control " autocomplete="off" id="datestart" runat="server" ClientIdMode="static">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="input-group date">
                                    <input type="text" class="form-control " autocomplete="off" id="datestop"  runat="server" ClientIdMode="static">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <button type="button" id="btnGetDataChart" runat="server" onserverclick="GetDataChart" class="btn btn-primary outline btn-block "><i class="fa fa-pie"></i>&nbsp; แสดงกราฟข้อมูล</button>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 text-center">
                                <asp:Chart ID="Chart2" runat="server" BorderlineWidth="0" Height="400px"
                                    Width="1000px" Palette="None" BorderlineColor="253, 103, 0">
                                    <Series>
                                        <asp:Series Name="ทรายหยาบ" ChartType="StackedBar" Color="Red" YValuesPerPoint="5"></asp:Series>
                                        <asp:Series Name="ทรายละเอียด" ChartType="StackedBar" YValuesPerPoint="5"></asp:Series>
                                        <asp:Series Name="ทรายถม" ChartType="StackedBar" YValuesPerPoint="5"></asp:Series>
                                    </Series>
                                    <Legends>
                                        <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="False" Name="Default"
                                            LegendStyle="Row" />
                                    </Legends>
                                    <ChartAreas>
                                        <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                                    </ChartAreas>
                                </asp:Chart>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
  

        <div class="row">
            <div class="col-md-6">
                <!-- Line chart -->
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <i class="fa fa-bar-chart-o"></i>

                        <h3 class="box-title">ยอดขายแยกประเภทสินค้า TOP 10 จากวันที่ : <asp:Label ID="lbldateprodstart" Text="" runat="server" /> ถึง <asp:Label ID="lbldateprodstop" Text="" runat="server" /> </h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                <i class="fa fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                    <div class="box-body text-center">
                        <asp:Chart ID="Chart1" runat="server" BorderlineWidth="0" Height="400px" Width="400px" Palette="None" BorderlineColor="253, 103, 0">
                            <Series>
                                <asp:Series Name="ทรายหยาบ"  ChartType="Pie" BorderColor="White" BorderWidth="1"  YValuesPerPoint="5"></asp:Series>
                                <asp:Series Name="ทรายละเอียด"  ChartType="Pie" YValuesPerPoint="5"></asp:Series>
                                <asp:Series Name="ทรายถม"  ChartType="Pie" YValuesPerPoint="5"></asp:Series>
                            </Series>
                            <%--<Legends>
                                <asp:Legend BackColor="Transparent" Alignment="Far" Docking="Right" Font="Trebuchet MS, 8.25pt, style=Bold"
                                    IsTextAutoFit="true" Name="Default" LegendStyle="Column">
                                </asp:Legend>
                            </Legends>--%>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                    <!-- /.box-body-->
                </div>
                <!-- /.box -->

             
            </div>
           

             <div class="col-md-6">
                <!-- Line chart -->
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <i class="fa fa-bar-chart-o"></i>

                        <h3 class="box-title">ยอดขายแยกประเภทสินค้าสะสมประจำปี ณ วันที่ : <asp:Label ID="lbldateprodamount" Text="" runat="server" /> </h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                <i class="fa fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                    <div class="box-body text-center">
                        <asp:Chart ID="Chart4" runat="server" BorderlineWidth="0" Height="400px" Width="400px" Palette="None" BorderlineColor="253, 103, 0">
                            <Series>
                                <asp:Series Name="ทรายหยาบ"  ChartType="Pie" BorderColor="White" BorderWidth="1"  YValuesPerPoint="5"></asp:Series>
                                <asp:Series Name="ทรายละเอียด"  ChartType="Pie" YValuesPerPoint="5"></asp:Series>
                                <asp:Series Name="ทรายถม"  ChartType="Pie" YValuesPerPoint="5"></asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>

                        
                    </div>
                    <!-- /.box-body-->
                </div>
                <!-- /.box -->

             
            </div>

          
        </div>
        <!-- /.row -->
    </section>


</asp:Content>
