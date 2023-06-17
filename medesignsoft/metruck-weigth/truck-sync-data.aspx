<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="truck-sync-data.aspx.cs" Inherits="medesignsoft.metruck_weigth.truck_sync_data" %>
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
                
                 $.preload(["../image/loading_bar.gif", "../image/loading_bar.gif"]);
              
                //reloaddata();

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
                    //window.location.href = "gm-company-edit.aspx?opt=optgen&mod=new";
                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    //reloaddata()
                });

                function reloaddata() {
                    $.ajax({
                        url: 'general-services.asmx/getCompany',
                        method: 'post',
                        //data: {
                        //    yearstart: yearstart,
                        //    yearend: yearend,
                        //    monthstart: monthstart,                       
                        //    monthend: monthend
                        //},
                        datatype: 'json',
                        beforeSend: function () {
                            $('#loadercompany').show();
                            $("#tblcompanylist tr td").remove();

                        },
                        success: function (data) {
                            var table;
                            table = $('#tblcompanylist').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].Gid, data[i].adCompanyID, data[i].CompanyNameTh, data[i].CompanyNameEn,
                                    data[i].CompanyShortNameTh, data[i].CompanyShortNameEn, data[i].AddTh1, data[i].AddTh2, data[i].AddTh3,
                                    data[i].AddEn1, data[i].AddEn2, data[i].AddEn3, data[i].adProvinceID, data[i].ProvinceName, data[i].PostalCode, data[i].adCountryID, data[i].CountryName,
                                    data[i].Phone, data[i].Fax, data[i].EMail, data[i].OwnerName, data[i].TaxID, data[i].BFAccountBalanceDate, data[i].Logo,
                                    data[i].Active, data[i].EffectDate, data[i].ExpireDate, data[i].IsHaveBranch, data[i].edit, data[i].trash]);
                                });
                            }
                            table.draw();
                            $('#loadercompany').hide();
                            //$('#tblCompanyList td:nth-of-type(2)').addClass('column_fixed');
                            //$('#tblCompanyList td:nth-of-type(3)').addClass('column_fixed');

                            $('#tblcompanylist td').click(function () {
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;
                                console.log('row : ' + rIndex + ' cell: ' + cIndex)

                                if (rIndex != 0 & cIndex == 28) {
                                    var gid = $("#tblcompanylist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                    console.log(gid.text());

                                    window.location.href = "gm-company-edit.aspx?opt=optgen&mod=edit&gid=" + gid.text();
                                    //$("#modal-company-edit").modal({ backdrop: true });
                                    //$("#modal-company-edit").modal("show");

                                }

                                if (rIndex != 0 & cIndex == 29) {
                                    var gid = $("#tblcompanylist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                    console.log(gid.text());

                                    window.location.href = "gm-company-edit.aspx?opt=optgen&mod=del&gid=" + gid.text();
                                }


                            })
                        }
                    });
                }

                var btnsyncdataall = $('#btnsyncdataall');
                btnsyncdataall.click(function () {
                    $('#icosynccartype').addClass("fa-spin");
                    $('#icocustomer').addClass("fa-spin");
                    $('#icoproduct').addClass("fa-spin");
                    $('#icosubcon').addClass("fa-spin");
                    $('#icocarname').addClass("fa-spin");
                    $('#icotruckweigth').addClass("fa-spin");
                    
                    
                    $('#icorefreshall').addClass("fa-spin");

                    setTimeout(function () {
                        $('#icosynccartype').removeClass("fa-spin");
                        $('#icocustomer').removeClass("fa-spin");
                        $('#icoproduct').removeClass("fa-spin");
                        $('#icosubcon').removeClass("fa-spin");
                        $('#icocarname').removeClass("fa-spin");
                        $('#icotruckweigth').removeClass("fa-spin");

                        $('#icorefreshall').removeClass("fa-spin");

                    }, 5000);

                    
                    
                })

                        

            });

        </script>
    </section>

    <section class="content">
        


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
                                <button type="button" id="btnExportExcel" runat="server" class="btn btn-default btn-sm" data-toggle="tooltip" title="excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">ระบบจัดการข้อมูลเบื้องต้น</label>
                        </div>

                        <div class="box-body">
                            <%--<div class="cv-spinner" id="loadercompany">
                                <span class="spinner"></span>
                            </div>--%>

                            <div class="row">
                                <div class="col-md-6">
                                    <table id="tblsyncdata" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th style="width: 50px;">ลำดับ</th>
                                                <th>รายละเอียด</th>
                                                <th>วันที่อัฟเดทข้อมูลล่าสุด</th>
                                                <th>หมายเหตุ</th>
                                                <th style="width: 50px; text-align: center;">#</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td style="vertical-align: middle;">1</td>
                                                <td style="vertical-align: middle;">อัฟเดทข้อมูลประเภทรถขนส่งสินค้า</td>
                                                <td style="vertical-align: middle;">2023-05-03 08:58:35</td>
                                                <td style="vertical-align: middle;">ปรับปรุงข้อมูลสำเร็จ</td>
                                                <td class=" table-align-center"><span class="btn btn-success outline btn-block "><i id="icosynccartype" class="fa fa-refresh"></i></span></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">2</td>
                                                <td style="vertical-align: middle;">อัฟเดทข้อมูลลูกค้า</td>
                                                <td style="vertical-align: middle;">2023-05-03 08:58:38</td>
                                                <td style="vertical-align: middle;">ปรับปรุงข้อมูลสำเร็จ</td>
                                                <td class=" table-align-center"><span class="btn btn-success outline btn-block "><i id="icocustomer" class="fa fa-refresh"></i></span></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">3</td>
                                                <td style="vertical-align: middle;">อัฟเดทข้อมูลรายการสินค้า</td>
                                                <td style="vertical-align: middle;">2023-05-03 08:59:02</td>
                                                <td style="vertical-align: middle;">ปรับปรุงข้อมูลสำเร็จ</td>
                                                <td class=" table-align-center"><span class="btn btn-success outline btn-block "><i id="icoproduct" class="fa fa-refresh"></i></span></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">4</td>
                                                <td style="vertical-align: middle;">อัฟเดทข้อมูลรายการซัฟคอนแทรค</td>
                                                <td style="vertical-align: middle;">2023-05-03 08:59:04</td>
                                                <td style="vertical-align: middle;">ปรับปรุงข้อมูลสำเร็จ</td>
                                                <td class=" table-align-center"><span class="btn btn-success outline btn-block "><i id="icosubcon" class="fa fa-refresh"></i></span></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">5</td>
                                                <td style="vertical-align: middle;">อัฟเดทข้อมูลรถขนส่งสินค้า</td>
                                                <td style="vertical-align: middle;">2023-05-03 08:59:10</td>
                                                <td style="vertical-align: middle;">ปรับปรุงข้อมูลสำเร็จ</td>
                                                <td class=" table-align-center"><span class="btn btn-success outline btn-block "><i id="icocarname" class="fa fa-refresh"></i></span></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">6</td>
                                                <td style="vertical-align: middle;">อัฟเดทข้อมูลรายการเครื่องชั่ง</td>
                                                <td style="vertical-align: middle;">2023-05-03 08:59:10</td>
                                                <td style="vertical-align: middle;">ปรับปรุงข้อมูลสำเร็จ</td>
                                                <td class=" table-align-center"><span class="btn btn-success outline btn-block "><i id="icotruckweigth" class="fa fa-refresh"></i></span></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">&nbsp;</td>
                                                <td style="vertical-align: middle;">&nbsp;</td>
                                                <td style="vertical-align: middle;">&nbsp;</td>
                                               
                                                <td class=" table-align-center" colspan="2"><span id="btnsyncdataall" class="btn btn-success outline btn-block "><i id="icorefreshall" class="fa fa-refresh"></i>  อัฟเดทข้อมูลทั้งหมด </span></td>
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
    </section>
</asp:Content>
