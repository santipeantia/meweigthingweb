<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="wh-setup.aspx.cs" Inherits="medesignsoft.meenterprise_management.wh_setup" %>
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
                $('#loaderdiv').hide();

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

        <h1>WH Setup <%--step 1 check pages content name--%>
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
                                <button type="button" id="btnPdf1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">Warehouse Setup</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderdiv">
                                <span class="spinner"></span>
                            </div>

                            <div class="col-md-12">
                                <div class="col-md-2">
                                    <a class="btn btn-app" href="wh-beginstock-setup.aspx?opt=optwh" style="width: 100%">
                                        <span class="badge bg-yellow">1</span>
                                        <i class="fa fa-server"></i><span class="txtLabel">บันทึกข้อมูลยอดยกมา</span>
                                    </a>
                                </div>
                                <div class="col-md-2">
                                    <a class="btn btn-app" href="wh-approvelevel-setup.aspx?opt=optwh" style="width: 100%">
                                        <span class="badge bg-yellow">2</span>
                                        <i class="fa fa-users"></i><span class="txtLabel">ผู้อนุมัติทำรายการคลังสินค้า</span>
                                    </a>
                                </div>
                                
                                <div class="col-md-2">
                                    <a class="btn btn-app" href="wh-option-setup.aspx?opt=optwh&mod=edit" style="width: 100%">
                                        <span class="badge bg-yellow">3</span>
                                        <i class="fa fa-delicious"></i><span class="txtLabel">กำหนดเงื่อนไขคลังสินค้า</span>
                                    </a>
                                </div>
                                
                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
