<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="truck-analysis.aspx.cs" Inherits="medesignsoft.metruck_weigth.truck_analysis" %>
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


                            <span class="btn-group pull-right">
                                <button type="button" id="btnaddnew" class="btn btn-default btn-sm" data-toggle="tooltip" title="new"><i class="fa fa-plus text-green"></i></button>
                                <button type="button" id="btnreload" class="btn btn-default btn-sm" data-toggle="tooltip" title="reload"><i class="fa fa-refresh text-blue"></i></button>
                                <button type="button" id="btnPdf1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="pdf"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExportExcel" runat="server" class="btn btn-default btn-sm" data-toggle="tooltip" title="excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">ระบบรายงานวิเคราะห์</label>
                        </div>

                        <div class="box-body">
                            <%--<div class="cv-spinner" id="loadercompany">
                                <span class="spinner"></span>
                            </div>--%>

                            <div class="row">
                                <div class="col-md-6">
                                    <table id="tblcompanylist" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th style="width: 50px;">ลำดับ</th>
                                                <th>รายละเอียด</th>
                                                <th style="width: 30px; text-align: center;">#</th>
                                                <th style="width: 30px; text-align: center;">#</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td style="vertical-align: middle;">1</td>
                                                <td style="vertical-align: middle;">รายงานการชั่ง เปรียบเทียบรายเดือน</td>
                                                <td class=" table-align-center"><span class="btn btn-primary outline btn-block "><i class="fa fa-file-text-o"></i></span></td>
                                                <td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i></span></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">2</td>
                                                <td style="vertical-align: middle;">รายงานการชั่ง เปรียบเทียบประเภทสินค้า</td>
                                                <td class=" table-align-center"><span class="btn btn-primary outline btn-block "><i class="fa fa-file-text-o"></i></span></td>
                                                <td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i></span></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">3</td>
                                                <td style="vertical-align: middle;">รายงานการชั่ง ยอดขายสูงสุด</td>
                                                <td class=" table-align-center"><span class="btn btn-primary outline btn-block "><i class="fa fa-file-text-o"></i></span></td>
                                                <td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i></span></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">4</td>
                                                <td style="vertical-align: middle;">รายงานการชั่ง เปรียบเทีบรายลูกค้า</td>
                                                <td class=" table-align-center"><span class="btn btn-primary outline btn-block "><i class="fa fa-file-text-o"></i></span></td>
                                                <td class=" table-align-center"><span class="btn btn-success outline btn-block "><i class="fa fa-print"></i></span></td>
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
