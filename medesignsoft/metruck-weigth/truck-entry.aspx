<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="truck-entry.aspx.cs" Inherits="medesignsoft.metruck_weigth.truck_entry" %>
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

            #tblTruckDetails tbody tr:hover {
                color: red;
                background-color: rgba(252, 241, 154, 0.63);
            }

            #tblTruckDetails td {
                vertical-align: middle;
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
            .mycenter {
                text-align: center;            
            }
        </style>

        <script>
            $(document).ready(function () {

               $('#divloader').hide();

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var ddd = String(today.getDate() - 0).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var firstdate = yyyy + '-' + mm + '-' + '01';
                var nowdate = yyyy + '-' + mm + '-' + ddd;
                               
                $('#datestart').val(firstdate);
                $('#datestop').val(nowdate);

                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report_1031
                    var sdate = $('#datestart').val();
                    var edate = $('#datestop').val();

                    getTruckDaily(sdate, edate)
                });


                var btnPrintExcel = $('#btnPrintExcel');
                btnPrintExcel.click(function () {

                    var rpt_id = "truck_report_excel";
                    var sdate = $('#datestart').val();;
                    var edate = $('#datestop').val();;


                    pdfReportRender(rpt_id, sdate, edate)
                    return false;
                });


                var btnPrintPDF = $('#btnPrintPDF');
                btnPrintPDF.click(function () {

                    var rpt_id = "truck_report_pdf";
                    var sdate = $('#datestart').val();;
                    var edate = $('#datestop').val();;
                    
                    pdfReportRender(rpt_id, sdate, edate)
                    return false;
                });

                var btnPrintTicket = $('#btnPrintTicket');
                btnPrintTicket.click(function () {
                    var rpt_id = "truck_ticket_pdf";
                    var docno = $('#txtticket2').val();
                    var sdate = $('#datestart').val();;
                    var edate = $('#datestop').val();;
                    
                    pdfReportRenderBill(rpt_id, docno, sdate, edate)
                    return false;
                });

            });

            

            function getTruckDaily(sdate, edate) {
                $.ajax({
                    url: 'servicetruck.asmx/GetTruckDaily',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblTruckDetails tr td").remove(); 
                        $("#divloader").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblTruckDetails').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].stat, data[i].truck, data[i].truckname, data[i].weight, data[i].cartype, data[i].typename, data[i].company, data[i].comname, data[i].product,
                                    data[i].proname, data[i].subcon, data[i].subname, data[i].remark1, data[i].remark2, data[i].remark3, data[i].factor, data[i].vatcase, data[i].price, data[i].rate,
                                    data[i].vat_r, data[i].ticket1, data[i].dayin, data[i].dayin2, data[i].tmin, data[i].w1, data[i].ticket2, data[i].dayout, data[i].dayout2, data[i].tmout,
                                    data[i].w2, data[i].wnet, data[i].adj_w1, data[i].adj_w2, data[i].adj_m, data[i].staff, data[i].usrname, data[i].process, data[i].print1, data[i].print2,
                                    data[i].scalein, data[i].scaleout, data[i].link, data[i].billstatus, data[i].btnaction, data[i].refid]);
                            });
                        }
                        table.draw();                        

                        $('#tblTruckDetails tbody').on('click', 'td', function (e) {
                            e.preventDefault();

                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;

                           if (rIndex != 0 & cIndex == 42) {
                                var strlnk = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(44)');

                                console.log(strlnk.text());
                               window.open('../../ayutthayaland/mesales-order/so-quotation-edit.aspx?opt=optsoe&mod=edit&gid='+strlnk.text() +'', '_blank');

                            }

                            if (rIndex != 0 & cIndex == 43) {
                                var strticket1 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(20)');




                                var stat = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                var truck = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var truckname = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var weight = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(3)');
                                var cartype = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(4)');
                                var typename = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(5)');
                                var company = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(6)');
                                var comname = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(7)');
                                var product = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(8)');
                                var proname = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(9)');
                                var subcon = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(10)');
                                var subname = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(11)');
                                var remark1 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(12)');
                                var remark2 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(13)');
                                var remark3 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(14)');
                                var factor = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(15)');
                                var vatcase = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(16)');
                                var price = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(17)');
                                var rate = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(18)');
                                var vat_r = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(19)');
                                var ticket1 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(20)');
                                var dayin = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(21)');
                                var dayin2 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(22)');
                                var tmin = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(23)');
                                var w1 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(24)');
                                var ticket2 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(25)');
                                var dayout = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(26)');
                                var dayout2 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(27)');
                                var tmout = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(28)');
                                var w2 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(29)');
                                var wnet = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(30)');
                                var adj_w1 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(31)');
                                var adj_w2 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(32)');
                                var adj_m = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(33)');
                                var staff = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(34)');
                                var usrname = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(35)');
                                var process = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(36)');
                                var print1 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(37)');
                                var print2 = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(38)');
                                var scalein = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(39)');
                                var scaleout = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(40)');
                                var link = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(41)');
                                var billstatus = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(42)');
                                var btnaction = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(43)');
                                var refid = $("#tblTruckDetails").find('tr:eq(' + rIndex + ')').find('td:eq(44)');
                                                                                               
                                console.log(strticket1.text());

                                
                                $('#txtdatetrans').val('');
                                $('#txtticket2').val('');
                                $('#txttransport').val('');
                                $('#txttruckcode').val('');
                                $('#txttrucktype').val('');
                                $('#txtcompname').val('');
                                $('#txtproduct').val('');                                
                                $('#txttimein').val('');
                                $('#txtweigthin').val('');
                                $('#txttimeout').val('');
                                $('#txtweigthout').val('');
                                $('#txtweigthnet').val('');
                                $('#txtpricelist').val('0.00');
                                $('#txttotalamout').val('0.00');

                                $('#txtdatetrans').val(dayin2.text());
                                $('#txtticket2').val(ticket2.text());
                                $('#txttransport').val(subname.text() + ' ( ' + subcon.text() + ' ) ');
                                $('#txttruckcode').val(truck.text());
                                $('#txttrucktype').val(typename.text() + ' ( ' + cartype.text() + ' ) ');
                                $('#txtcompname').val(comname.text() + ' ( ' + company.text() + ' ) ');
                                $('#txtproduct').val(proname.text() + ' ( ' + product.text() + ' ) ');
                                $('#txttimein').val(tmin.text());
                                $('#txtweigthin').val(w1.text());
                                $('#txttimeout').val(tmout.text());
                                $('#txtweigthout').val(w2.text());
                                $('#txtweigthnet').val(wnet.text());
                                $('#txtpricelist').val('0.00');
                                $('#txttotalamout').val('0.00');

                                if (ticket2.text() == '') {
                                    Swal.fire(
                                        '<span class="txtLabel">ข้อมูลรายการชั่งยังไม่สมบูรณ์..!</span>',
                                        '',
                                        'error'
                                    )
                                    return;
                                } else {
                                    $("#modal-reportdetail").modal({ backdrop: false });
                                    $("#modal-reportdetail").modal("show");
                                }

                            }                            
                        });

                        $("#divloader").hide();
                    }
                });
            }

            function popupWindow(url, windowName, win, w, h) {
                const y = win.top.outerHeight / 2 + win.top.screenY - (h / 2);
                const x = win.top.outerWidth / 2 + win.top.screenX - (w / 2);
                return win.open(url, windowName, `toolbar=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=${w}, height=${h}, top=${y}, left=${x}`);
            }

            function pdfReportRender(rpt_id, sdate, edate) {
                window.open('report-render.aspx?id=' + rpt_id + '&sdate=' + sdate + '&edate=' + edate, '_blank');
            }

            function pdfReportRenderBill(rpt_id, docno, sdate, edate) {
                window.open('report-render.aspx?id=' + rpt_id + '&docno=' + docno + '&sdate=' + sdate + '&edate=' + edate, '_blank');
            }

          
            jQuery(function ($) {
                $(document).ajaxSend(function () {
                    $("#overlay").fadeIn(300);
                });

                $('#btnViewReport').click(function () {
                    $.ajax({
                        type: 'GET',
                        success: function (data) {
                            console.log(data);
                        }
                    }).done(function () {
                        setTimeout(function () {
                            $("#overlay").fadeOut(300);
                        }, 500);
                    });
                });
            });

            function pdfReportRender(rpt_id, sdate, edate) {
                //document.location = "report-render.aspx?id=" + a;
                window.open('report-render.aspx?id=' + rpt_id + '&sdate=' + sdate + '&edate=' + edate, '_blank');
            }

            setTimeout(function () {
                     $('#overlay').hide();
            }, 5000);       

        </script>

            <h1><i class="fa fa-truck text-orange"></i>
                <label class="txtLabel">ข้อมูลรายการเครื่องชั่ง</label>
            </h1>
    </section>

    <section class="content">
        <div id="overlay">
            <div class="cv-spinner">
                <span class="spinner"></span>
            </div>
        </div>

        <div class="row">
            

            <div class="col-md-12">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-body">
                            
                            <span class="btn-group pull-right">
                                <button type="button" id="btnrefresh" class="btn btn-default btn-sm"  title="รีเฟรท"><i class="fa fa-refresh text-orange"></i></button>                         
                                <button type="button" id="btnPrintPDF" name="btnPrintPDF" class="btn btn-default btn-sm"  title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnPrintExcel" class="btn btn-default btn-sm"  title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            

                            <div class="col-md-2">
                                <div class="form-group">
                                   <%-- <label class="txtLabel">วันที่เริ่มต้น:</label>--%>
                                    <div class="input-group date">
                                        <input type="text" class="form-control pull-right" autocomplete="off" id="datestart">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                   <%-- <label class="txtLabel">วันที่สิ้นสุด:</label>--%>
                                    <div class="input-group date">
                                        <input type="text" class="form-control pull-right" autocomplete="off" id="datestop">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div> 

                            <div class="col-md-2">
                                <span id="btnViewReport" class="btn btn-info btn-block "><i class="fa fa-refresh"></i> ตรวจสอบข้อมูล</span>
                            </div>
                            
                        </div>
                        <div class="box-body" >
                             

                            <%--<div class="cv-spinner" id="divloader">
                                <span class="spinner"></span>
                            </div>--%>
                            <table id="tblTruckDetails" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead style="background-color: #00c0ef; color: white;">
                                    <tr>                                        
                                        <th class="">เที่ยว</th>	
                                        <th class="">ทะเบียนรถ</th>	
                                        <th class="">ชื่อรถ</th>	
                                        <th class="">WEIGHT</th>	
                                        <th class="">CARTYPE</th>	
                                        <th class="">ประเภทรถ</th>	
                                        <th class="">COMPANY</th>	
                                        <th class="">ชื่อลูกค้า</th>	
                                        <th class="">PRODUCT</th>	
                                        <th class="">ชื่อสินค้า</th>	
                                        <th class="">SUBCON</th>	
                                        <th class="">ผู้ติดต่อ</th>	
                                        <th class="">REMARK1</th>	
                                        <th class="">REMARK2</th>	
                                        <th class="">REMARK3</th>	
                                        <th class="">FACTOR</th>	
                                        <th class="">VATCASE</th>	
                                        <th class="">PRICE</th>	
                                        <th class="">RATE</th>	
                                        <th class="">VAT_R</th>	
                                        <th class="">ตั๋วขาเข้า</th>	
                                        <th class="">วันที่ชั่งเข้า</th>	
                                        <th class="">DAYIN2</th>	
                                        <th class="">เวลาเข้า</th>	
                                        <th class="">น้ำหนักขาเข้า</th>	
                                        <th class="">ตั๋วขาออก</th>	
                                        <th class="">วันทีี่ชั่งออก</th>	
                                        <th class="">DAYOUT2</th>	
                                        <th class="">เวลาออก</th>	
                                        <th class="">น้ำหนักขาออก</th>	
                                        <th class="">น้ำหนักสุทธิ</th>	
                                        <th class="">ADJ_W1</th>	
                                        <th class="">ADJ_W2</th>	
                                        <th class="">ADJ_M</th>	
                                        <th class="">STAFF</th>	
                                        <th class="">USRNAME</th>	
                                        <th class="">PROCESS</th>	
                                        <th class="">PRINT1</th>	
                                        <th class="">PRINT2</th>	
                                        <th class="">SCALEIN</th>	
                                        <th class="">SCALEOUT</th>	
                                        <th class="">LINK</th>	
                                        <th class="">สถานะ</th>	
                                        <th style="width: 50px; text-align: center;">#</th>
                                        <th class="">RefID</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            

                        </div>
                    </div>
                </div>
            </div>
        </div>

       

        <div class="modal fade" id="modal-reportdetail">
                <div class="modal-dialog" style="width: 700px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">สร้างใบเสนอราคา (Quotation)                           
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">วันที่ทำรายการ</div>
                                <div class="col-md-6"><input id="txtdatetrans" class="form-control input-md" type="text" readonly value="" /></div>
                            </div>
                             <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">เลขที่ตั๋วออก</div>
                                <div class="col-md-6"><input id="txtticket2" class="form-control input-md" type="text" readonly value="" /></div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">การขนส่ง</div>
                                <div class="col-md-6"><input id="txttransport" class="form-control input-md" type="text" readonly value="" /></div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">ทะเบียนรถ</div>
                                <div class="col-md-6"><input id="txttruckcode" class="form-control input-md" type="text" readonly value="" /></div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">ประเภทรถบรรทุก</div>
                               <div class="col-md-6"><input id="txttrucktype" class="form-control input-md" type="text" readonly value="" /></div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">ชื่อลูกค้า</div>
                                <div class="col-md-6"><input id="txtcompname" class="form-control input-md" type="text" readonly value="" /></div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">ชื่อสินค้า</div>
                                <div class="col-md-6"><input id="txtproduct" class="form-control input-md" type="text" readonly value="" /></div>
                            </div>                          
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">น้ำหนักชั่งเข้า</div>
                                <div class="col-md-3"><input id="txttimein" class="form-control input-md" type="text" readonly value="" /></div>
                                <div class="col-md-3"><input id="txtweigthin" class="form-control input-md" type="text" readonly value="" /></div>
                            </div>     
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">น้ำหนักชั่งออก</div>
                                <div class="col-md-3"><input id="txttimeout" class="form-control input-md" type="text" readonly value="" /></div>
                                <div class="col-md-3"><input id="txtweigthout" class="form-control input-md" type="text" readonly value="" /></div>
                            </div>  
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">น้ำหนักสุทธิ</div>
                                <div class="col-md-6"><input id="txtweigthnet" class="form-control input-md" type="text" readonly value="" /></div>
                            </div> 
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">ราคา / ตัน</div>
                                <div class="col-md-6"><input id="txtpricelist" class="form-control input-md" type="text" value="0.00" /></div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">ราคาเงินรวม</div>
                                <div class="col-md-6"><input id="txttotalamout" class="form-control input-md" type="text" value="0.00" /></div>
                            </div>
                            	                       
                        </div>

                        <div class="modal-footer">
                            <div class="row">
                                <div class="col-md-4 text-left">
                                    <button type="button" class="btn btn-danger outline " data-dismiss="modal">ออกจากหน้าจอ</button>
                                </div>
                                <div class="col-md-6 text-left">
                                    <button type="button" class="btn btn-primary outline " id="btnPrintTicket">พิมพ์ใบชั่งน้ำหนัก</button>
                                    <button type="button" class="btn btn-primary outline " id="btnGetSaleorder">สร้างใบสั่งขายสินค้า</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

    </section>
</asp:Content>
