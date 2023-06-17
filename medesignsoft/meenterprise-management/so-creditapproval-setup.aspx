<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="so-creditapproval-setup.aspx.cs" Inherits="medesignsoft.meenterprise_management.so_creditapproval_setup" %>
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

            #tblsocreditapprovelist tbody tr:hover {
                color: red;
                background-color: rgba(252, 241, 154, 0.63);
            }

            #tblsocreditlist tbody tr:hover {
                color: red;
                background-color: rgba(252, 241, 154, 0.63);
            }

            

            .column_hover {
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
                $('#loader').hide();

                reloaddata();
                getVendorCreditList();

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var ddd = String(today.getDate() - 1).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var firstdate = yyyy + '-' + mm + '-' + '01';
                var nowdate = yyyy + '-' + mm + '-' + ddd;

                var ssdate = firstdate;
                var eedate = nowdate;

                $('#datepickerstart').val(ssdate);
                $('#datepickerend').val(eedate);

                var btnaddnew = $('#btnaddnew');
                btnaddnew.click(function () {
                    window.location.href = "so-creditapproval-edit.aspx?opt=optso&mod=new";
                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    reloaddata();
                    getVendorCreditList();
                });

                function reloaddata() {
                    $.ajax({
                        url: 'general-services.asmx/getSoCreditApprovalList',
                        method: 'post',
                        //data: {
                        //    yearstart: yearstart,
                        //    yearend: yearend,
                        //    monthstart: monthstart,                       
                        //    monthend: monthend
                        //},
                        datatype: 'json',
                        beforeSend: function () {
                            $('#loader').show();
                            $("#tblsocreditapprovelist tr td").remove();

                        },
                        success: function (data) {
                            var table;
                            table = $('#tblsocreditapprovelist').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].SoAppCreditID, data[i].imEmployeeGid, data[i].FullName, data[i].PositionName,
                                    data[i].Remark, data[i].UserCreate, data[i].CreateDate, data[i].UserUpdate, data[i].LasteDate, data[i].edit, data[i].trash]);
                                });
                            }
                            table.draw();
                            $('#loader').hide();

                            $('#tblsocreditapprovelist td:nth-of-type(4)').addClass('column_hover');
                            $('#tblsocreditapprovelist td:nth-of-type(5)').addClass('column_hover');

                            $('#tblsocreditapprovelist tbody').on('click', 'td', function (e) {
                                e.preventDefault();
                                
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;

                                //console.log(rIndex + ':' + cIndex);
                                var gid = $("#tblsocreditapprovelist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');

                                //console.log(gid.text());
                                if (rIndex != 0 & cIndex == 9) {
                                    window.location.href = "so-creditapproval-edit.aspx?opt=optso&mod=edit&gid=" + gid.text();
                                }

                                if (rIndex != 0 & cIndex == 10) {
                                    window.location.href = "so-creditapproval-edit.aspx?opt=optso&mod=del&gid=" + gid.text();
                                }
                            });
                        }
                    });
                }

                function getVendorCreditList() {
                    $.ajax({
                        url: 'general-services.asmx/getVendorCreditList',
                        method: 'post',                       
                        datatype: 'json',
                        beforeSend: function () {
                            $('#loader').show();
                            $("#tblsocreditlist tr td").remove();

                        },
                        success: function (data) {
                            var table;
                            table = $('#tblsocreditlist').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].VendorID, data[i].VendorCode, data[i].VendorName, data[i].VendorNameEng,
                                    data[i].VendorAddr1, data[i].ProvinceName, data[i].CreditDays, data[i].CreditAmnt, data[i].CreditBalance, data[i].edit]);
                                });
                            }
                            table.draw();
                            $('#loader').hide();

                            $('#tblsocreditlist td:nth-of-type(4)').addClass('column_hover');
                            $('#tblsocreditlist td:nth-of-type(3)').addClass('column_hover');

                            $('#tblsocreditlist tbody').on('click', 'td', function (e) {
                                e.preventDefault();
                                
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;

                                //console.log(rIndex + ':' + cIndex);
                                var gid = $("#tblsocreditlist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                var vendorcode = $("#tblsocreditlist").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var vendorname = $("#tblsocreditlist").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var vendornameeng = $("#tblsocreditlist").find('tr:eq(' + rIndex + ')').find('td:eq(3)');
                                var vendoraddr1 = $("#tblsocreditlist").find('tr:eq(' + rIndex + ')').find('td:eq(4)');
                                var provincename = $("#tblsocreditlist").find('tr:eq(' + rIndex + ')').find('td:eq(5)');
                                var creditdays = $("#tblsocreditlist").find('tr:eq(' + rIndex + ')').find('td:eq(6)');
                                var creditamnt = $("#tblsocreditlist").find('tr:eq(' + rIndex + ')').find('td:eq(7)');
                                var creditbalance = $("#tblsocreditlist").find('tr:eq(' + rIndex + ')').find('td:eq(8)');

                                //console.log(gid.text());
                                if (rIndex != 0 & cIndex == 9) {
                                   // alert('open modal edit here...' + gid.text() + ' : ' + vendorname.text());

                                    $('#VendorID').val(gid.text());
                                    $('#VendorName').val(vendorname.text());
                                    $('#VendorNameEng').val(vendornameeng.text());
                                    $('#VendorAddress').val(vendoraddr1.text());
                                    $('#CreditDays').val(creditdays.text());
                                    $('#CreditAmnt').val(creditamnt.text());
                                    $('#CreditBalance').val(creditbalance.text());

                                    $("#modalcredit").modal({ backdrop: false });
                                    $('[id=modalcredit]').modal('show');
                                    //window.location.href = "so-creditapproval-edit.aspx?opt=optso&mod=edit&gid=" + gid.text();
                                }

                                if (rIndex != 0 & cIndex == 10) {
                                    //window.location.href = "so-creditapproval-edit.aspx?opt=optso&mod=del&gid=" + gid.text();
                                }
                            });
                        }
                    });
                }

                var btnsavechange = $('#btnsavechange');
                btnsavechange.click(function () {

                    Swal.fire({

                        title: '<span class="txtLabel">ต้องการบันทึกข้อมูล ใช่หรือไม่..?</span>',
                        //text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonColor: '#d33',
                        confirmButtonColor: '#449d44',
                        confirmButtonText: '<span class="txtLabel">บันทึกข้อมูล..!</span>',
                        cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>'
                    }).then((result) => {
                        if (result.isConfirmed) {

                            $.ajax({
                                url: 'general-services.asmx/getVendorCreditUpdateEntry',
                                method: 'post',
                                data: {
                                    gid: $('#VendorID').val(),                                    
                                    CreditDays: $('#CreditDays').val(),
                                    CreditAmnt: $('#CreditAmnt').val(),
                                    CreditBalance: $('#CreditBalance').val()                                    
                                },
                                datatype: 'json',
                                beforSend: function () {

                                },
                                success: function (data) {
                                    Swal.fire(
                                        '<span class="txtLabel">บันทึกข้อมูลสำเร็จ..!</span>',
                                        '',
                                        'success'
                                    )
                                    setTimeout(function () {
                                        reloaddata();
                                        getVendorCreditList();
                                        $('[id=modalcredit]').modal('hide');
                                    }, 2000);
                                    
                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    })
                });


                //$('#CreditDay').keypress(function (event) {
                //    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                //        event.preventDefault();
                //    }
                //    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 2)) {
                //        event.preventDefault();
                //    }
                //});

                function isInputNumber(evt) {
                    var ch = String.fromCharCode(evt.which);
                    if (!(/[0-9]/.test(ch))) {
                        evt.preventDefault();
                    }
                }
                
                $('#CreditAmnt').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 2)) {
                        event.preventDefault();
                    }
                });

                $('#CreditBalance').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 2)) {
                        event.preventDefault();
                    }
                });


            });
                       


        </script>

        <h1>SO Credit Approval Setup <%--step 1 check pages content name--%>
            <small>Control panel</small>
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
                        <div class="box-header with-border">
                            <i class="fa fa-gears text-orange"></i>


                            <span class="btn-group pull-right">
                                <button type="button" id="btnaddnew" class="btn btn-default btn-sm" data-toggle="tooltip" title="new"><i class="fa fa-plus text-green"></i></button>
                                <button type="button" id="btnreload" class="btn btn-default btn-sm" data-toggle="tooltip" title="reload"><i class="fa fa-refresh text-blue"></i></button>
                                <button type="button" id="btnPdf1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="pdf"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExportExcel" class="btn btn-default btn-sm" data-toggle="tooltip" title="excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">Credit Approval List</label>
                        </div>

                        <div class="box-body">
                            <div class="cv-spinner" id="loader">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblsocreditapprovelist" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>EmpGid</th>
                                        <th>FullName</th>                                      
                                        
                                        <th>POSITION</th>
                                        <th>REMARK</th>
                                        <th>UserCreate</th>
                                        <th>CreateDate</th>
                                        <th>UserUpdate</th>
                                        <th>LasteDate</th>                               
                                        <th style="width: 30px; text-align: right;">#</th>
                                        <th style="width: 30px; text-align: right;">#</th>
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

        <div class="row">
            <div class="col-md-12">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-credit-card text-orange"></i>                        
                            <label class="txtLabel">Credit Approval List</label>
                        </div>

                        <div class="box-body">                           
                            <table id="tblsocreditlist" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>CODE</th>
                                        <th>NAME</th>
                                        <th>NAME*Eng</th>
                                        <th>ADDRESS</th>
				                        <th>PROVINCE</th>
                                        <th>CREDIT</th>
                                        <th>AMOUNT</th>
                                        <th>BALANCE</th>                      
                                        <th style="width: 30px; text-align: right;">#</th>
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

         <!-- /.modal myModalCompany -->
            <div class="modal modal-default fade" id="modalcredit">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Update Vendor Credit</h4>
                        </div>

                        <div class="modal-body">
                            <div class="container-fluid">
                                <div class="row hidden" style="margin-bottom: 5px">
                                    <div class="col-md-4">VendorID</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input txtLabel" id="VendorID" name="VendorID" placeholder="" value="" autocomplete="off" required disabled>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel text-right">ชื่อบริษัทฯ</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input txtLabel" id="VendorName" name="VendorName" placeholder="" value="" autocomplete="off" required disabled>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel text-right">ชื่อบริษัทฯ</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input txtLabel" id="VendorNameEng" name="VendorNameEng" placeholder="" value="" autocomplete="off" required disabled>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel text-right">ที่อยู่บริษัทฯ</div>
                                    <div class="col-md-8">
                                        <textarea cols="40" rows="3" id="VendorAddress" name="VendorAddress" class="form-control input txtLabel" disabled></textarea>
                                        <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel text-right">ระยะเวลาเครดิต</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input txtLabel" id="CreditDays" name="CreditDays"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel text-right">วงเงินเครดิต</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input txtLabel" id="CreditAmnt" name="CreditAmnt" placeholder="" value="" autocomplete="off" required>
                                    </div>
                                </div>

                                <div class="row" style="margin-bottom: 5px">
                                    <div class="col-md-4 txtLabel text-right">วงเงินคงเหลือ</div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control input txtLabel" id="CreditBalance" name="CreditBalance" placeholder="" value="" autocomplete="off" required>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default txtLabel" data-dismiss="modal">ยกเลิกรายการ</button>
                            <button type="button" id="btnsavechange" class="btn btn-success txtLabel"> บันทึกปรับปรุงรายการ </button>                                      
                        </div>
                    </div>
                </div>
            </div>


    </section>
</asp:Content>
