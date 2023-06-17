<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="ic-setup.aspx.cs" Inherits="medesignsoft.meenterprise_management.ic_setup" %>
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

            #tbliclist tbody tr:hover {
                color: red;
                background-color: rgba(252, 241, 154, 0.63);
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
                $('#loaderdiv1011').hide();

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
            });

        </script>

        <h1>จัดการข้อมูลระบบ <%--step 1 check pages content name--%>
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
                                <button type="button" id="btnPdf1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">ระบบควบคุมสินค้าคงคลัง</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderdiv1011">
                                <span class="spinner"></span>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <table id="tbliclist" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th style="width: 50px;">ลำดับ</th>
                                                <th>รายละเอียด</th>
                                                <th style="width: 50px; text-align: center;">#</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td style="vertical-align: middle;">1</td>
                                                <td style="vertical-align: middle;">กำหนดรหัสคลังสินค้า</td>
                                                <td class=" table-align-center">
                                                    <a class="btn btn-primary outline btn-block" href="ic-warehouse-setup.aspx?opt=optic">
                                                        <i class="fa fa-eyedropper"></i>
                                                    </a></td>

                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">2</td>
                                                <td style="vertical-align: middle;">กำหนดรหัสโซนสินค้า</td>
                                                <td class=" table-align-center">
                                                    <a class="btn btn-primary outline btn-block" href="ic-warehousezone-setup.aspx?opt=optic">
                                                        <i class="fa fa-eyedropper"></i>
                                                    </a></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">3</td>
                                                <td style="vertical-align: middle;">กำหนดกลุ่มสินค้า</td>
                                                <td class=" table-align-center">
                                                    <a class="btn btn-primary outline btn-block" href="ic-goodgroup-setup.aspx?opt=optic">
                                                        <i class="fa fa-eyedropper"></i>
                                                    </a></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">4</td>
                                                <td style="vertical-align: middle;">กำหนดประเภทสินค้า</td>
                                                <td class=" table-align-center">
                                                    <a class="btn btn-primary outline btn-block" href="ic-goodtype-setup.aspx?opt=optic">
                                                        <i class="fa fa-eyedropper"></i>
                                                    </a></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">5</td>
                                                <td style="vertical-align: middle;">กำหนดหน่วยนับ</td>
                                                <td class=" table-align-center">
                                                    <a class="btn btn-primary outline btn-block" href="ic-goodunit-setup.aspx?opt=optic">
                                                        <i class="fa fa-eyedropper"></i>
                                                    </a></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">6</td>
                                                <td style="vertical-align: middle;">กำหนดรหัสสินค้า</td>
                                                <td class=" table-align-center">
                                                    <a class="btn btn-primary outline btn-block" href="ic-goodcode-setup.aspx?opt=optic">
                                                        <i class="fa fa-eyedropper"></i>
                                                    </a></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">7</td>
                                                <td style="vertical-align: middle;">กำหนดสถานะสินค้า</td>
                                                <td class=" table-align-center">
                                                    <a class="btn btn-primary outline btn-block" href="ic-goodstatus-setup.aspx?opt=optic">
                                                        <i class="fa fa-eyedropper"></i>
                                                    </a></td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: middle;">8</td>
                                                <td style="vertical-align: middle;">กำหนดสีสินค้า</td>
                                                <td class=" table-align-center">
                                                    <a class="btn btn-primary outline btn-block" href="ic-goodcolor-setup.aspx?opt=optic">
                                                        <i class="fa fa-eyedropper"></i>
                                                    </a></td>
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
