<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="truck-report.aspx.cs" Inherits="medesignsoft.metruck_weigth.truck_report" %>
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

            #tblcompanylist tbody tr:hover {
                color: red;
                background-color: rgba(252, 241, 154, 0.63);
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

            .table-align-center {
                text-align: center;
            }

            .table-align-right {
                text-align: right;
            }

            .myclassblue {
                text-align: right;
                color: blue;
            }

            td {
                /*height: 50px;*/
                vertical-align: bottom;
            }
        </style>

        <script>
            $(document).ready(function () {
                $('#loadercompany').hide();


                //$('#btnReportTruck7').attr("disabled", true);
                //$('#btnReportTruck8').attr("disabled", true);
                $('#btnReportTruck9').attr("disabled", true);
                $('#btnReportTruck10').attr("disabled", true);
                $('#btnReportTruck11').attr("disabled", true);

                //reloaddata();

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

                $('#datepickerstart').val(ssdate);
                $('#datepickerend').val(eedate);

                $('#datestart7').val(ssdate);
                $('#datestop7').val(eedate);

                $('#datestart8').val(ssdate);
                $('#datestop8').val(eedate);

                getCustomerList();
                getProductList();

                var btnaddnew = $('#btnaddnew');
                btnaddnew.click(function () {
                    //window.location.href = "gm-company-edit.aspx?opt=optgen&mod=new";
                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                   
                });

                var chkrpt1 = $('#chkrpt1');
                var chkrpt2 = $('#chkrpt2');
                chkrpt1.click(function () {
                    var sure = this.checked;
                    if (sure == true) {
                        //alert(sure);
                        //chkrpt2.attr("checked", false);

                        chkrpt2.prop( "checked", false );
                        console.log('chkrpt2 : 1 : ' + sure);
                    } else {
                        //alert(sure);
                        //chkrpt2.attr("checked", true);

                        chkrpt2.prop("checked", true);
                        console.log('chkrpt2 : 2 : ' + sure);
                    }
                });
                
                chkrpt2.click(function () {
                    var sure = this.checked;
                    if (sure == true) {
                        //alert(sure);
                        //chkrpt1.attr("checked", false);

                        chkrpt1.prop( "checked", false );
                        console.log('chkrpt1 : 1 : ' + sure);
                    } else {
                        //alert(sure);
                        //chkrpt1.attr("checked", true);

                        chkrpt1.prop("checked", true);
                        console.log('chkrpt1 : 2 : ' + sure);
                    }
                });




                var btnFilterdata = $('#btnFilterdata');
                btnFilterdata.click(function () {
                    var sdate = $('#datestart7').val();
                    var edate = $('#datestop7').val();

                    if (sdate == '' || edate == '') {

                        //7.รายงานจำนวนเที่ยว(ตัน) / บริษัท
                        Swal.fire(
                            '<span class="txtLabel">กำหนดช่วงเวลาไม่ถูกต้องโปรดตรวจสอบ..!</span>',
                            '',
                            'error'
                        );

                        $('#selectcustomer7').val('-1');
                        $('#selectcustomer7').change();
                        $('#selectproduct7').val('-1');
                        $('#selectproduct7').change();

                        $('#selectcustomer7').attr("disabled", true);
                        $('#selectproduct7').attr("disabled", true);
                        

                        return;
                    } else {

                        getCustomerBydate(sdate, edate);
                        //getProductBydate(sdate, edate);

                        $('#selectcustomer7').attr("disabled", false);
                        //$('#selectproduct7').attr("disabled", false);
                    }
                   
                });

                var btnFilterdata8 = $('#btnFilterdata8');
                btnFilterdata8.click(function () {
                    var sdate = $('#datestart8').val();
                    var edate = $('#datestop8').val();

                    if (sdate == '' || edate == '') {

                        //7.รายงานจำนวนเที่ยว(ตัน) / บริษัท
                        Swal.fire(
                            '<span class="txtLabel">กำหนดช่วงเวลาไม่ถูกต้องโปรดตรวจสอบ..!</span>',
                            '',
                            'error'
                        );

                        $('#selectcustomer8').val('-1');
                        $('#selectcustomer8').change();
                        $('#selectproduct8').val('-1');
                        $('#selectproduct8').change();

                        $('#selectcustomer8').attr("disabled", true);
                        $('#selectproduct8').attr("disabled", true);
                        

                        return;
                    } else {

                        getCustomerBydate(sdate, edate);
                        getProductGroupBydate(sdate, edate);

                        $('#selectcustomer8').attr("disabled", false);
                        $('#selectproduct8').attr("disabled", false);
                    }
                   
                });
                
                var btnReportTicket1 = $('#btnReportTicket1');
                btnReportTicket1.click(function () {

                    $('#selectreport').val(1);
                    $('#selectreport').change();
                    $('#selectreport').attr("disabled", true);

                    $('#selectcustomer').attr("disabled", false);
                    $('#selectcustomer2').attr("disabled", false);

                    $('#selectproduct').attr("disabled", true);
                    $('#selectproduct2').attr("disabled", true);

                    $('#selectcustomer').val(-1);
                    $('#selectcustomer').change();
                    $('#selectcustomer2').val(-1);
                    $('#selectcustomer2').change();

                    $('#selectproduct').val(-1);
                    $('#selectproduct').change();
                    $('#selectproduct2').val(-1);
                    $('#selectproduct2').change();

                    $('#divprod1').addClass("hidden");
                    $('#divprod2').addClass("hidden");

                    $("#modal-reportticket").modal({ backdrop: false });
                    $("#modal-reportticket").modal("show");
                });

                var btnReportTruck2 = $('#btnReportTruck2');
                btnReportTruck2.click(function () {

                    //2.รายงานการชั่งรถแยกตามบริษัท
                    $('#selectreport').val(2);
                    $('#selectreport').change();
                    $('#selectreport').attr("disabled", true);

                    $('#selectcustomer').attr("disabled", true);
                    $('#selectcustomer2').attr("disabled", false);

                    $('#selectproduct').attr("disabled", true);
                    $('#selectproduct2').attr("disabled", true);

                    $('#selectcustomer').val(-1);
                    $('#selectcustomer').change();
                    $('#selectcustomer2').val(-1);
                    $('#selectcustomer2').change();

                    $('#selectproduct').val(-1);
                    $('#selectproduct').change();
                    $('#selectproduct2').val(-1);
                    $('#selectproduct2').change();

                    $('#divprod1').addClass("hidden");
                    $('#divprod2').addClass("hidden");

                    $("#modal-reportticket").modal({ backdrop: false });
                    $("#modal-reportticket").modal("show");
                });

                var btnReportTruck3 = $('#btnReportTruck3');
                btnReportTruck3.click(function () {

                    //3.รายงานการชั่งรถแยกตามวัน
                    $('#selectreport').val(3);
                    $('#selectreport').change();
                    $('#selectreport').attr("disabled", true);

                    $('#selectcustomer').attr("disabled", true);
                    $('#selectcustomer2').attr("disabled", true);

                    $('#selectproduct').attr("disabled", true);
                    $('#selectproduct2').attr("disabled", true);

                    $('#selectcustomer').val(-1);
                    $('#selectcustomer').change();
                    $('#selectcustomer2').val(-1);
                    $('#selectcustomer2').change();

                    $('#selectproduct').val(-1);
                    $('#selectproduct').change();
                    $('#selectproduct2').val(-1);
                    $('#selectproduct2').change();

                    $('#divprod1').addClass("hidden");
                    $('#divprod2').addClass("hidden");

                    $("#modal-reportticket").modal({ backdrop: false });
                    $("#modal-reportticket").modal("show");
                });

                var btnReportTruck4 = $('#btnReportTruck4');
                btnReportTruck4.click(function () {

                    //4.รายงานการชั่งรถแยกตามเดือน
                    $('#selectreport').val(4);
                    $('#selectreport').change();
                    $('#selectreport').attr("disabled", true);

                    $('#selectcustomer').attr("disabled", true);
                    $('#selectcustomer2').attr("disabled", true);

                    $('#selectproduct').attr("disabled", true);
                    $('#selectproduct2').attr("disabled", true);

                    $('#selectcustomer').val(-1);
                    $('#selectcustomer').change();
                    $('#selectcustomer2').val(-1);
                    $('#selectcustomer2').change();

                    $('#selectproduct').val(-1);
                    $('#selectproduct').change();
                    $('#selectproduct2').val(-1);
                    $('#selectproduct2').change();

                    $('#divprod1').addClass("hidden");
                    $('#divprod2').addClass("hidden");

                    $("#modal-reportticket").modal({ backdrop: false });
                    $("#modal-reportticket").modal("show");
                });

                var btnReportTruck5 = $('#btnReportTruck5');
                btnReportTruck5.click(function () {

                    //5.รายงานแยกตามประเภทสินค้า
                    $('#selectreport').val(5);
                    $('#selectreport').change();
                    $('#selectreport').attr("disabled", true);

                    $('#selectcustomer').attr("disabled", false);
                    $('#selectcustomer2').attr("disabled", false);

                    $('#selectproduct').attr("disabled", false);
                    $('#selectproduct2').attr("disabled", false);

                    $('#selectcustomer').val(-1);
                    $('#selectcustomer').change();
                    $('#selectcustomer2').val(-1);
                    $('#selectcustomer2').change();

                    $('#selectproduct').val(-1);
                    $('#selectproduct').change();
                    $('#selectproduct2').val(-1);
                    $('#selectproduct2').change();

                    $('#divprod1').removeClass("hidden");
                    $('#divprod2').removeClass("hidden");

                    $("#modal-reportticket").modal({ backdrop: false });
                    $("#modal-reportticket").modal("show");
                });

                var btnReportTruck6 = $('#btnReportTruck6');
                btnReportTruck6.click(function () {

                    //6.รายงานการชั่งรูปแบบเงินสด
                    $('#selectreport').val(6);
                    $('#selectreport').change();
                    $('#selectreport').attr("disabled", true);

                    $('#selectcustomer').attr("disabled", true);
                    $('#selectcustomer2').attr("disabled", true);

                    $('#selectproduct').attr("disabled", true);
                    $('#selectproduct2').attr("disabled", true);

                    $('#selectcustomer').val('0001');
                    $('#selectcustomer').change();

                    $('#selectcustomer2').val('0001');
                    $('#selectcustomer2').change();

                    $('#selectproduct').val(-1);
                    $('#selectproduct').change();
                    $('#selectproduct2').val(-1);
                    $('#selectproduct2').change();

                    $('#divprod1').addClass("hidden");
                    $('#divprod2').addClass("hidden");

                    $("#modal-reportticket").modal({ backdrop: false });
                    $("#modal-reportticket").modal("show");
                });

                var btnReportTruck7 = $('#btnReportTruck7');
                btnReportTruck7.click(function () {

                    //7.รายงานจำนวนเที่ยว(ตัน)/บริษัท
                    $('#selectreport7').val(7);
                    $('#selectreport7').change();
                    $('#selectreport7').attr("disabled", true);

                    $('#selectcustomer7').val('-1');
                    $('#selectcustomer7').change();

                    $('#selectproduct7').val(-1);
                    $('#selectproduct7').change();

                    $('#selectcustomer7').attr("disabled", true);
                    $('#selectproduct7').attr("disabled", true);
                    

                    $("#modal-reporttotalamount").modal({ backdrop: false });
                    $("#modal-reporttotalamount").modal("show");
                });

                var btnReportTruck8 = $('#btnReportTruck8');
                btnReportTruck8.click(function () {

                    //8.รายงานแยกประเภทตามกลุ่มสินค้า
                    $('#selectreport8').val(8);
                    $('#selectreport8').change();
                    $('#selectreport8').attr("disabled", true);

                    $('#selectcustomer8').val('-1');
                    $('#selectcustomer8').change();

                    $('#selectproduct8').val(-1);
                    $('#selectproduct8').change();

                    $('#selectcustomer8').attr("disabled", true);
                    $('#selectproduct8').attr("disabled", true);
                    

                    $("#modal-reporttotalgroup").modal({ backdrop: false });
                    $("#modal-reporttotalgroup").modal("show");
                });

                var btnReportTruck9 = $('#btnReportTruck9');
                btnReportTruck9.click(function () {

                    //9.รายงานการชั่งค้างสร้างใบสั่งขาย
                     Swal.fire(
                        '<span class="txtLabel">ข้อมูลรายงานอยู่ระหว่างดำเนินการ..!</span>',
                        '',
                        'error'
                    )
                    return;

                    $('#selectreport').val(9);
                    $('#selectreport').change();
                    $('#selectreport').attr("disabled", true);

                    $("#modal-reportticket").modal({ backdrop: false });
                    $("#modal-reportticket").modal("show");
                });

                var btnReportTruck10 = $('#btnReportTruck10');
                btnReportTruck10.click(function () {

                    //9.รายงานการเรียกเก็บเงินลูกค้า
                     Swal.fire(
                        '<span class="txtLabel">ข้อมูลรายงานอยู่ระหว่างดำเนินการ..!</span>',
                        '',
                        'error'
                    )
                    return;

                    $('#selectreport').val(10);
                    $('#selectreport').change();
                    $('#selectreport').attr("disabled", true);

                    $("#modal-reportticket").modal({ backdrop: false });
                    $("#modal-reportticket").modal("show");
                });

                var btnReportTruck11 = $('#btnReportTruck11');
                btnReportTruck11.click(function () {

                    //9.รายงานการเรียกเก็บเงินลูกค้า
                     Swal.fire(
                        '<span class="txtLabel">ข้อมูลรายงานอยู่ระหว่างดำเนินการ..!</span>',
                        '',
                        'error'
                    )
                    return;

                    $('#selectreport').val(11);
                    $('#selectreport').change();
                    $('#selectreport').attr("disabled", true);

                    $("#modal-reportticket").modal({ backdrop: false });
                    $("#modal-reportticket").modal("show");
                });

                                             
                var selectcustomer = $('#selectcustomer');
                var selectcustomer2 = $('#selectcustomer2');

                var selectproduct = $('#selectproduct');
                var selectproduct2 = $('#selectproduct2');
                var selectproduct8 = $('#selectproduct8');

                function getCustomerList() {
                    $.ajax({
                        url: 'servicetruck.asmx/GetTwCompanyList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectcustomer.empty();
                            selectcustomer2.empty();
                            selectcustomer.append($('<option/>', { value: -1, text: 'เลือกรายชื่อลูกค้าทั้งหมด' }));
                            selectcustomer2.append($('<option/>', { value: -1, text: 'เลือกรายชื่อลูกค้าทั้งหมด' }));

                            $(data).each(function (index, item) {
                                selectcustomer.append($('<option/>', { value: item.CompCode, text: item.CompName }));
                                selectcustomer2.append($('<option/>', { value: item.CompCode, text: item.CompName }));

                            });
                        }
                    });
                   
                };

                function getProductList() {
                    $.ajax({
                        url: 'servicetruck.asmx/GetTwProductList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectproduct.empty();         
                            selectproduct2.empty();
                            selectproduct.append($('<option/>', { value: -1, text: 'เลือกสินค้าทั้งหมด' }));
                            selectproduct2.append($('<option/>', { value: -1, text: 'เลือกสินค้าทั้งหมด' }));
                            $(data).each(function (index, item) {
                                selectproduct.append($('<option/>', { value: item.productcode, text: item.productname }));
                                selectproduct2.append($('<option/>', { value: item.productcode, text: item.productname }));
                            });
                        }
                    });
                   
                };

                function getProductGroupBydate() {
                    $.ajax({
                        url: 'servicetruck.asmx/GetTwProductGroupList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectproduct8.empty();      
                            selectproduct8.append($('<option/>', { value: -1, text: 'เลือกสินค้าทั้งหมด' }));
                            $(data).each(function (index, item) {
                                selectproduct8.append($('<option/>', { value: item.GroupCode, text: item.GroupName }));
                            });
                        }
                    });
                }

                var selectcustomer7 = $('#selectcustomer7');
                var selectcustomer8 = $('#selectcustomer8');
                function getCustomerBydate(sdate, edate) {
                    $.ajax({
                        url: 'servicetruck.asmx/GetTwCompanyBydate',
                        method: 'post',
                        data: {
                            sdate: sdate,
                            edate: edate
                        },
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectcustomer7.empty();                           
                            selectcustomer7.append($('<option/>', { value: -1, text: 'เลือกรายชื่อลูกค้าทั้งหมด' }));                          

                            selectcustomer8.empty();                           
                            selectcustomer8.append($('<option/>', { value: -1, text: 'เลือกรายชื่อลูกค้าทั้งหมด' }));

                            $(data).each(function (index, item) {
                                selectcustomer7.append($('<option/>', { value: item.CompCode, text: item.CompName }));
                                selectcustomer8.append($('<option/>', { value: item.CompCode, text: item.CompName }));
                            });
                        }
                    });
                   
                };

                selectcustomer7.change(function () {
                    var sdate = $('#datestart7').val();
                    var edate = $('#datestop7').val();
                    var custcode = $('#selectcustomer7').val();

                    if (selectcustomer7.val() == '-1') {

                        getProductBydate(sdate, edate, custcode);
                        $('#selectproduct7').attr("disabled", false);
                        $('#selectproduct7').val('-1');
                        //return;
                    } else {                        

                        getProductBydate(sdate, edate, custcode);
                        $('#selectproduct7').attr("disabled", false);
                    }
                });

                var selectproduct7 = $('#selectproduct7');
                function getProductBydate(sdate, edate, custcode) {
                    $.ajax({
                        url: 'servicetruck.asmx/GetTwProducBydate',
                        method: 'post',
                        data: {
                            sdate: sdate,
                            edate: edate,
                            custcode: custcode
                        },
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectproduct7.empty();  
                            selectproduct7.append($('<option/>', { value: -1, text: 'เลือกสินค้าทั้งหมด' }));                            
                            $(data).each(function (index, item) {
                                selectproduct7.append($('<option/>', { value: item.productcode, text: item.productname }));
                               
                            });
                        }
                    });                   
                };

                var btnPrintTruckReport = $('#btnPrintTruckReport');
                btnPrintTruckReport.click(function () {
                    var rpt_no = $('#selectreport').val();

                    //alert(rpt_no);

                    var rpt_id = "truck_report1_pdf";
                   
                    var sdate = $('#datestart').val();
                    var edate = $('#datestop').val();

                    var comcode1 = $('#selectcustomer').val();
                    var comcode2 = $('#selectcustomer2').val();

                    var prod1 = $('#selectproduct').val();
                    var prod2 = $('#selectproduct2').val();

                    console.log(prod1 + ' : ' + prod2);

                   // return;


                    if (rpt_no == 1) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode1, comcode2, prod1, prod2);
                    } else if (rpt_no == 2) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode2, comcode2, prod1, prod2);
                    } else if (rpt_no == 3) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, '00000', '99999', prod1, prod2);
                    } else if (rpt_no == 4) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, '00000', '99999', prod1, prod2);
                    } else if (rpt_no == 5) {
                        pdfReportRenderTruck(rpt_id, rpt_no,  sdate, edate, comcode1, comcode2, prod1, prod2);
                    } else if (rpt_no == 6) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode1, comcode2, prod1, prod2);
                    } else if (rpt_no == 7) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode1, comcode2, prod1, prod2);
                    } else {
                        //pdfReportRenderTruck(rpt_id, sdate, edate, comcode1, comcode2)
                        return false;
                    }
                    
                    return false;
                });

                var btnPrintTruckReportExcel = $('#btnPrintTruckReportExcel');
                btnPrintTruckReportExcel.click(function () {
                    var rpt_no = $('#selectreport').val();

                    //alert(rpt_no);

                    var rpt_id = "truck_report1_excel";
                   
                    var sdate = $('#datestart').val();
                    var edate = $('#datestop').val();

                    var comcode1 = $('#selectcustomer').val();
                    var comcode2 = $('#selectcustomer2').val();

                    var prod1 = $('#selectproduct').val();
                    var prod2 = $('#selectproduct2').val();

                    if (rpt_no == 1) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode1, comcode2, prod1, prod2);
                    } else if (rpt_no == 2) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode2, comcode2, prod1, prod2);
                    } else if (rpt_no == 3) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, '00000', '99999', prod1, prod2);
                    } else if (rpt_no == 4) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, '00000', '99999', prod1, prod2);
                    } else if (rpt_no == 5) {
                        pdfReportRenderTruck(rpt_id, rpt_no,  sdate, edate, comcode1, comcode2, prod1, prod2);
                    } else if (rpt_no == 6) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode1, comcode2, prod1, prod2);
                    } else if (rpt_no == 7) {
                        pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode1, comcode2, prod1, prod2);
                    }else {
                        //pdfReportRenderTruck(rpt_id, sdate, edate, comcode1, comcode2)
                        return false;
                    }
                    
                    return false;
                });


                var btnPrintTruckReport7 = $('#btnPrintTruckReport7');
                btnPrintTruckReport7.click(function () {
                    var rpt_no = $('#selectreport7').val();

                    //alert(rpt_no);

                    var rpt_id = "truck_reportamount_pdf";

                    var sdate = $('#datestart7').val();
                    var edate = $('#datestop7').val();

                    var comcode = $('#selectcustomer7').val();
                    var prod = $('#selectproduct7').val();

                    pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode, comcode, prod, prod);

                });
                               

                var btnPrintTruckReportExcel7 = $('#btnPrintTruckReportExcel7');
                btnPrintTruckReportExcel7.click(function () {
                     var rpt_no = $('#selectreport7').val();

                    //alert(rpt_no);

                    var rpt_id = "truck_reportamount_excel";
                   
                    var sdate = $('#datestart7').val();
                    var edate = $('#datestop7').val();

                    var comcode = $('#selectcustomer7').val();
                    var prod = $('#selectproduct7').val();

                    pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode, comcode, prod, prod);


                })

                var btnPrintTruckReport8 = $('#btnPrintTruckReport8');
                btnPrintTruckReport8.click(function () {
                    //var rpt_no = $('#selectreport8').val();

                    var rpt_no = $('#chkrpt1').prop('checked'); //$('#chkrpt1').val();

                    //alert(rpt_no);
                    //return; 


                    var rpt_id = "truck_reportproductgroup2_pdf";

                    var sdate = $('#datestart8').val();
                    var edate = $('#datestop8').val();

                    var comcode = $('#selectcustomer8').val();
                    var prod = $('#selectproduct8').val();

                    pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode, comcode, prod, prod);

                });

                 var btnPrintTruckReportExcel8 = $('#btnPrintTruckReportExcel8');
                btnPrintTruckReportExcel8.click(function () {
                     var rpt_no = $('#chkrpt1').prop('checked'); //$('#chkrpt1').val();

                    //alert(rpt_no);
                    //return; 

                    var rpt_id = "truck_reportproductgroup2_excel";
                   
                    var sdate = $('#datestart8').val();
                    var edate = $('#datestop8').val();

                    var comcode = $('#selectcustomer8').val();
                    var prod = $('#selectproduct8').val();

                    pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comcode, comcode, prod, prod);


                })

                

                function pdfReportRenderTruck(rpt_id, rpt_no, sdate, edate, comp1, comp2, prod1, prod2) {
                    window.open('report-render.aspx?id=' + rpt_id  + '&refno=' + rpt_no + '&sdate=' + sdate + '&edate=' + edate + '&comcode1='+ comp1 + '&comcode2=' + comp2+ '&prod1=' + prod1+ '&prod2=' + prod2, '_blank');
                }
            });


            
        </script>
    </section>

    <section class="content">
        <%--<div id="overlay">
            <div class="cv-spinner">
                <span class="spinner"></span>

            </div>
        </div>--%>

        <div class="row">
            <div class="col-md-12">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-gears text-orange"></i>


                          <%--  <span class="btn-group pull-right">
                                <button type="button" id="btnaddnew" class="btn btn-default btn-sm" data-toggle="tooltip" title="new"><i class="fa fa-plus text-green"></i></button>
                                <button type="button" id="btnreload" class="btn btn-default btn-sm" data-toggle="tooltip" title="reload"><i class="fa fa-refresh text-blue"></i></button>
                                <button type="button" id="btnPdf1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="pdf"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExportExcel" runat="server" class="btn btn-default btn-sm" data-toggle="tooltip" title="excel"><i class="fa fa-table text-green"></i></button>
                            </span>--%>

                            <label class="txtLabel">ระบบรายงานเครื่องชั่ง</label>
                        </div>

                        <div class="box-body">
                           <%-- <div class="cv-spinner" id="loadercompany">
                                <span class="spinner"></span>
                            </div>--%>

                            <div class="row">
                                <div class="col-md-6">
                                    <table id="tblcompanylist" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th style="width: 50px;  text-align: center;">ลำดับ</th>
                                                <th>รายละเอียด</th>
                                                <th style="width: 50px; text-align: center;">รายงาน</th>
                                                <%--<th style="width: 50px; text-align: center;">#</th>--%>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">1</td>
                                                <td style="vertical-align: middle;">รายงานใบชั่งน้ำหนัก</td>
                                                <td class=" table-align-center"><span id="btnReportTicket1" class="btn btn-primary outline btn-block "><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">2</td>
                                                <td style="vertical-align: middle;">รายงานการชั่งรถแยกตามบริษัท</td>
                                                <td class=" table-align-center"><span id="btnReportTruck2" class="btn btn-primary outline btn-block "><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">3</td>
                                                <td style="vertical-align: middle;">รายงานการชั่งรถแยกตามวัน</td>
                                                <td class=" table-align-center"><span id="btnReportTruck3" class="btn btn-primary outline btn-block "><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">4</td>
                                                <td style="vertical-align: middle;">รายงานการชั่งรถแยกตามเดือน</td>
                                                <td class=" table-align-center"><span id="btnReportTruck4" class="btn btn-primary outline btn-block "><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>

                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">5</td>
                                                <td style="vertical-align: middle;">รายงานแยกตามประเภทสินค้า</td>
                                                <td class=" table-align-center"><span id="btnReportTruck5" class="btn btn-primary outline btn-block "><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">6</td>
                                                <td style="vertical-align: middle;">รายงานการชั่งรูปแบบเงินสด</td>
                                                <td class=" table-align-center"><span id="btnReportTruck6" class="btn btn-primary outline btn-block "><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">7 </td>
                                                <td style="vertical-align: middle;">รายงานจำนวนเที่ยว(ตัน)/บริษัท <span class="pull-right-container">                                                    
                                                <small class="label pull-right bg-orange">ก่อนหน้า 06/06/2023 11:30:03</small></span></td>
                                                <td class=" table-align-center" ><span id="btnReportTruck7" class="btn btn-primary outline btn-block " ><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">8 </td>
                                                <td style="vertical-align: middle;">รายงานแยกประเภทตามกลุ่มสินค้า <span class="pull-right-container">
                                                    <small class="label pull-right bg-green">ล่าสุด 18/06/2023 16:35:00</small>
                                                </span></td>
                                                <td class=" table-align-center" ><span id="btnReportTruck8" class="btn btn-primary outline btn-block " ><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>

                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">9</td>
                                                <td style="vertical-align: middle;">รายงานการชั่งค้างสร้างใบเสนอราคา</td>
                                                <td class=" table-align-center" ><span id="btnReportTruck9" class="btn btn-danger outline btn-block " ><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">10</td>
                                                <td style="vertical-align: middle;">รายงานการชั่งค้างสร้างใบสั่งขาย</td>
                                                <td class=" table-align-center"><span id="btnReportTruck10" class="btn btn-danger outline btn-block "><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle; text-align: center;">11</td>
                                                <td style="vertical-align: middle;">รายงานการเรียกเก็บเงินลูกค้า</td>
                                                <td class=" table-align-center"><span id="btnReportTruck11" class="btn btn-danger outline btn-block "><i class="fa fa-file-text-o"></i> พิมพ์รายงาน</span></td>
                                                <%--<td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i> พิมพ์รายงาน</span></td>--%>
                                            </tr>
                                            
                                        </tbody>
                                    </table>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>


        <%--1.รายงานใบชั่งน้ำหนัก--%>
        <div class="modal fade" id="modal-reportticket">
            <div class="modal-dialog" style="width: 700px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">รายงานใบชั่งน้ำหนัก                        
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="row" style="margin-top: 5px;">

                            <div class="col-md-4 text-right">เลือกข้อมูลรายงาน</div>
                            <div class="col-md-6">
                                <span class="txtLabel " style="width: 100%">
                                    <select id="selectreport" name="selectreport" class="form-control input-sm " style="width: 100%">
                                        <option value="1">1.รายงานใบชั่งน้ำหนัก</option>
                                        <option value="2">2.รายงานการชั่งรถแยกตามบริษัท</option>
                                        <option value="3">3.รายงานการชั่งรถแยกตามวัน</option>
                                        <option value="4">4.รายงานการชั่งรถแยกตามเดือน</option>
                                        <option value="5">5.รายงานแยกตามประเภทสินค้า</option>
                                        <option value="6">6.รายงานการชั่งรูปแบบเงินสด</option>
                                        <option value="7">7.รายงานจำนวนเที่ยว(ตัน)/บริษัท</option>
                                        <option value="8">8.รายงานแยกประเภทตามกลุ่มสินค้า</option>
                                        <option value="9">9.รายงานการชั่งค้างสร้างใบเสนอราคา</option>
                                        <option value="10">10.รายงานการชั่งค้างสร้างใบสั่งขาย</option>
                                        <option value="11">11.รายงานการเรียกเก็บเงินลูกค้า</option>

                                    </select>
                                </span>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">

                            <div class="col-md-4 text-right">ระบุชื่อลูกค้า : 1</div>
                            <div class="col-md-6">
                                <span class="txtLabel " style="width: 100%">
                                    <select id="selectcustomer" name="selectcustomer" class="form-control input-sm " style="width: 100%">
                                        <option value="-1">กรุณาระบุชื่อลูกค้า</option>
                                    </select>
                                </span>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">

                            <div class="col-md-4 text-right">ระบุชื่อลูกค้า : 2</div>
                            <div class="col-md-6">
                                <span class="txtLabel " style="width: 100%">
                                    <select id="selectcustomer2" name="selectcustomer2" class="form-control input-sm " style="width: 100%">
                                        <option value="-1">กรุณาระบุชื่อลูกค้า</option>
                                    </select>
                                </span>
                            </div>
                        </div>

                        <div class="row" id="divprod1" style="margin-top: 5px;">

                            <div class="col-md-4 text-right">ระบุประเภทสินค้า : 1</div>
                            <div class="col-md-6">
                                <span class="txtLabel " style="width: 100%">
                                    <select id="selectproduct" name="selectproduct" class="form-control input-sm " style="width: 100%">
                                        <option value="-1">เลือกสินค้าทั้งหมด</option>
                                    </select>
                                </span>
                            </div>
                        </div>

                        <div class="row" id="divprod2" style="margin-top: 5px;">

                            <div class="col-md-4 text-right">ระบุประเภทสินค้า : 2</div>
                            <div class="col-md-6">
                                <span class="txtLabel " style="width: 100%">
                                    <select id="selectproduct2" name="selectproduct2" class="form-control input-sm " style="width: 100%">
                                        <option value="-1">เลือกสินค้าทั้งหมด</option>
                                    </select>
                                </span>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-4 text-right">วันที่เริ่มต้น</div>
                            <div class="col-md-6">

                                <div class="input-group date">
                                    <input type="text" class="form-control pull-right" autocomplete="off" id="datestart">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-4 text-right">วันที่สิ้นสุด</div>
                            <div class="col-md-6">

                                <div class="input-group date">
                                    <input type="text" class="form-control pull-right" autocomplete="off" id="datestop">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-4 text-right">&nbsp;</div>
                            <div class="col-md-3">
                                <button type="button" id="btnPrintTruckReport" class="btn btn-primary outline btn-block "><i class="fa fa-print"></i>&nbsp; พิมพ์รายงาน (PDF)</button>
                            </div>
                            <div class="col-md-3">
                                <button type="button" id="btnPrintTruckReportExcel" class="btn btn-primary outline btn-block "><i class="fa fa-table"></i>&nbsp; พิมพ์รายงาน (Excel)</button>
                                <%--<button type="button" class="btn btn-danger outline btn-block " data-dismiss="modal"><i class="fa fa-close"></i> ออกจากหน้าจอ</button>  --%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

         <%--7.รายงานจำนวนเที่ยว(ตัน)/บริษัท--%>
        <div class="modal fade" id="modal-reporttotalamount">
                <div class="modal-dialog" style="width: 700px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">รายงานใบชั่งน้ำหนัก                        
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="row" style="margin-top: 5px;">                                
                                <div class="col-md-4 text-right">เลือกข้อมูลรายงาน</div>
                                <div class="col-md-6">
                                    <span class="txtLabel " style="width: 100%">
                                            <select id="selectreport7" name="selectreport7" class="form-control input-sm " style="width: 100%">
                                                <%--<option value="1">1.รายงานใบชั่งน้ำหนัก</option>
                                                <option value="2">2.รายงานการชั่งรถแยกตามบริษัท</option>
                                                <option value="3">3.รายงานการชั่งรถแยกตามวัน</option>
                                                <option value="4">4.รายงานการชั่งรถแยกตามเดือน</option>
                                                <option value="5">5.รายงานแยกตามประเภทสินค้า</option>
                                                <option value="6">6.รายงานการชั่งรูปแบบเงินสด</option>--%>
                                                <option value="7">7.รายงานจำนวนเที่ยว(ตัน)/บริษัท</option>
                                                <%--<option value="8">8.รายงานแยกประเภทตามกลุ่มสินค้า</option>
                                                <option value="9">9.รายงานการชั่งค้างสร้างใบเสนอราคา</option>
                                                <option value="10">10.รายงานการชั่งค้างสร้างใบสั่งขาย</option>
                                                <option value="11">11.รายงานการเรียกเก็บเงินลูกค้า</option>--%>                                                
                                            </select>
                                        </span>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">วันที่เริ่มต้น</div>
                                <div class="col-md-6">
                                    
                                        <div class="input-group date">
                                            <input type="text" class="form-control pull-right" autocomplete="off" id="datestart7">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>                                
                            </div>

                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">วันที่สิ้นสุด</div>
                                <div class="col-md-6">
                                    
                                        <div class="input-group date">
                                            <input type="text" class="form-control pull-right" autocomplete="off" id="datestop7">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>                                    
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">กรองข้อมูลรายงาน</div>
                                <div class="col-md-6">
                                    <button type="button" id="btnFilterdata" class="btn btn-success outline btn-block "><i class="fa fa-sort-amount-desc"></i>&nbsp; กรองข้อมูลรายงาน</button>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 5px;">
                                
                                <div class="col-md-4 text-right">ระบุชื่อลูกค้า</div>
                                <div class="col-md-6">
                                    <span class="txtLabel " style="width: 100%">
                                            <select id="selectcustomer7" name="selectcustomer7" class="form-control input-sm " style="width: 100%">
                                                <option value="-1">กรุณาระบุชื่อลูกค้า</option>
                                            </select>
                                        </span>
                                </div>
                            </div>
                                                        

                            <div class="row" id="divprod7" style="margin-top: 5px;">
                                
                                <div class="col-md-4 text-right">ระบุประเภทสินค้า</div>
                                <div class="col-md-6">
                                    <span class="txtLabel " style="width: 100%">
                                            <select id="selectproduct7" name="selectproduct7" class="form-control input-sm " style="width: 100%">
                                                <option value="-1">เลือกสินค้าทั้งหมด</option>
                                            </select>
                                        </span>
                                </div>
                            </div>
                                                                                         
                        </div>

                        <div class="modal-footer">

                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">&nbsp;</div>
                                <div class="col-md-3">
                                    <button type="button" id="btnPrintTruckReport7" class="btn btn-primary outline btn-block "><i class="fa fa-print"></i>&nbsp; พิมพ์รายงาน (PDF)</button>
                                </div>
                                <div class="col-md-3">
                                    <button type="button" id="btnPrintTruckReportExcel7" class="btn btn-primary outline btn-block "><i class="fa fa-table"></i>&nbsp; พิมพ์รายงาน (Excel)</button>
                                    <%--<button type="button" class="btn btn-danger outline btn-block " data-dismiss="modal"><i class="fa fa-close"></i> ออกจากหน้าจอ</button>  --%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

         <%--8.รายงานแยกประเภทตามกลุ่มสินค้า--%>
        <div class="modal fade" id="modal-reporttotalgroup">
                <div class="modal-dialog" style="width: 700px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">รายงานแยกประเภทตามกลุ่มสินค้า                     
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="row" style="margin-top: 5px;">                                
                                <div class="col-md-4 text-right">เลือกข้อมูลรายงาน</div>
                                <div class="col-md-6">
                                    <span class="txtLabel " style="width: 100%">
                                            <select id="selectreport8" name="selectreport8" class="form-control input-sm " style="width: 100%">
                                                <%--<option value="1">1.รายงานใบชั่งน้ำหนัก</option>
                                                <option value="2">2.รายงานการชั่งรถแยกตามบริษัท</option>
                                                <option value="3">3.รายงานการชั่งรถแยกตามวัน</option>
                                                <option value="4">4.รายงานการชั่งรถแยกตามเดือน</option>
                                                <option value="5">5.รายงานแยกตามประเภทสินค้า</option>
                                                <option value="6">6.รายงานการชั่งรูปแบบเงินสด</option>
                                                <option value="7">7.รายงานจำนวนเที่ยว(ตัน)/บริษัท</option>--%>
                                                <option value="8">8.รายงานแยกประเภทตามกลุ่มสินค้า</option>
                                                 <%--<option value="9">9.รายงานการชั่งค้างสร้างใบเสนอราคา</option>
                                                <option value="10">10.รายงานการชั่งค้างสร้างใบสั่งขาย</option>
                                                <option value="11">11.รายงานการเรียกเก็บเงินลูกค้า</option>--%>                                                
                                            </select>
                                        </span>
                                </div>
                            </div>                           
                            
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">วันที่เริ่มต้น</div>
                                <div class="col-md-6">                                    
                                        <div class="input-group date">
                                            <input type="text" class="form-control pull-right" autocomplete="off" id="datestart8">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>                                
                            </div>

                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">วันที่สิ้นสุด</div>
                                <div class="col-md-6">                                    
                                        <div class="input-group date">
                                            <input type="text" class="form-control pull-right" autocomplete="off" id="datestop8">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>                                    
                                </div>
                            </div>

                             <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">กรองข้อมูลรายงาน</div>
                                <div class="col-md-6">
                                    <button type="button" id="btnFilterdata8" class="btn btn-success outline btn-block "><i class="fa fa-sort-amount-desc"></i>&nbsp; กรองข้อมูลรายงาน</button>
                                </div>
                            </div>   

                            <div class="row" style="margin-top: 5px;">                                
                                <div class="col-md-4 text-right">ระบุชื่อลูกค้า</div>
                                <div class="col-md-6">
                                    <span class="txtLabel " style="width: 100%">
                                            <select id="selectcustomer8" name="selectcustomer7" class="form-control input-sm " style="width: 100%">
                                                <option value="-1">เลือกรายชื่อลูกค้าทั้งหมด</option>
                                            </select>
                                        </span>
                                </div>
                            </div>                                                        

                            <div class="row" id="divprod8" style="margin-top: 5px;">                                
                                <div class="col-md-4 text-right">ระบุกลุ่มสินค้า</div>
                                <div class="col-md-6">
                                    <span class="txtLabel " style="width: 100%">
                                            <select id="selectproduct8" name="selectproduct7" class="form-control input-sm " style="width: 100%">
                                                <option value="-1">เลือกสินค้าทั้งหมด</option>
                                            </select>
                                        </span>
                                </div>
                            </div>  
                            
                            <div class="row" style="margin-top: 5px;">
                                <!-- radio -->
                                <div class="col-md-4 text-right">รูปแบบรายงาน</div>
                                <div class="col-md-6 form-group">
                                    <label>                                        
                                       <input type="checkbox" id="chkrpt1" class="" checked />
                                        <span class="txtLabel">แบบแจกแจง</span>
                                    </label>
                                    &nbsp;&nbsp;
                                    <label>
                                        <input type="checkbox" id="chkrpt2" class="" />
                                        <span class="txtLabel">แบบสรุป</span>
                                    </label>
                                    
                                </div>
                            </div>
                                                                                         
                        </div>

                        <div class="modal-footer">

                            <div class="row" style="margin-top: 5px;">
                                <div class="col-md-4 text-right">&nbsp;</div>
                                <div class="col-md-3">
                                    <button type="button" id="btnPrintTruckReport8" class="btn btn-primary outline btn-block "><i class="fa fa-print"></i>&nbsp; พิมพ์รายงาน (PDF)</button>
                                </div>
                                <div class="col-md-3">
                                    <button type="button" id="btnPrintTruckReportExcel8" class="btn btn-primary outline btn-block "><i class="fa fa-table"></i>&nbsp; พิมพ์รายงาน (Excel)</button>
                                    <%--<button type="button" class="btn btn-danger outline btn-block " data-dismiss="modal"><i class="fa fa-close"></i> ออกจากหน้าจอ</button>  --%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


    </section>
</asp:Content>
