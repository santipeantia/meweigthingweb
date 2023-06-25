<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="so-truck-quotation-view.aspx.cs" Inherits="medesignsoft.mesales_order.so_truck_quotation_view" %>
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

           

            #tblsoquotationlist tbody tr:hover {
                color: red;
                background-color: rgba(252, 241, 154, 0.63);
            }

            th {
                text-align: center;
            }

            #tblsoquotationlist tbody tr td {
                vertical-align: middle;
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
                    window.location.href = "so-truck-quotation-edit.aspx?opt=optsoe&mod=new";
                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    reloaddata()
                });

                function reloaddata() {
                    var empid = '<%= Session["imEmployeeGid"] %>';

                    $.ajax({
                        url: 'saleorder-services.asmx/getQuotationList',
                        method: 'post',
                        data: {
                            empid: empid                        
                        },
                        datatype: 'json',
                        beforeSend: function () {
                            $('#loader').show();
                            $("#tblsoquotationlist tr td").remove();

                        },
                        success: function (data) {
                            var table;
                            table = $('#tblsoquotationlist').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].QtGid, data[i].imBranchGid, data[i].BranchName, data[i].adQTNO, data[i].RefQTNO, data[i].ProjectName, data[i].ProjectID,
                                        data[i].ProjectDesc, data[i].DocuDate, data[i].DeliveryDate, data[i].InYear, data[i].VendorID, data[i].VendorName, data[i].ContactName, data[i].ContactTel,
                                        data[i].CurrencyRate, data[i].adCurrencyID, data[i].CurrencyDesc, data[i].TotalAmount, data[i].VATAmount, data[i].TotalAmountExcludeVAT, data[i].DiscPercent,
                                        data[i].DiscAmount, data[i].DiscExtendPercent, data[i].DiscExtendAmount, data[i].AmountExtraDisc, data[i].TotalAmountAfterDisc, data[i].QTRemark,
                                        data[i].QTComment, data[i].imDeliveryID, data[i].DeliveryName, data[i].adPaymentTypeID, data[i].PaymentTypeDesc, data[i].imEmployeeGid, data[i].empFullName,
                                        data[i].SalePositionName, data[i].ApproveID, data[i].ApproveName, data[i].ApprovePositionID, data[i].ApprovePositionName, data[i].IsDelete, data[i].FlagID,
                                        data[i].FlagDesc, data[i].CreatedBy, data[i].CreateName, data[i].CreateDate, data[i].UpdatedBy, data[i].UpdateDate, data[i].SaleEMail, data[i].edit, data[i].trash]);
                                });
                            }
                            table.draw();
                            $('#loader').hide();

                            $('#tblsoquotationlist td:nth-of-type(49)').addClass('column_hover');
                            $('#tblsoquotationlist td:nth-of-type(50)').addClass('column_hover');

                            $('#tblsoquotationlist tbody').on('click', 'td', function (e) {
                                e.preventDefault();
                                
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;

                                //console.log(rIndex + ':' + cIndex);
                                var gid = $("#tblsoquotationlist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');

                                //console.log(gid.text());
                                if (rIndex != 0 & cIndex == 49) {
                                    window.location.href = "so-truck-quotation-edit.aspx?opt=optsoe&mod=edit&gid=" + gid.text();
                                }

                                if (rIndex != 0 & cIndex == 50) {
                                    window.location.href = "so-truck-quotation-edit.aspx?opt=optsoe&mod=del&gid=" + gid.text();
                                }
                            });
                        }
                    });
                }
            });                                

        </script>

        <h1>Quotation Views <%--step 1 check pages content name--%>
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
                                <button type="button" id="btnPdf1" class="btn btn-default btn-sm" data-toggle="tooltip" title="pdf"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel" class="btn btn-default btn-sm" data-toggle="tooltip" title="excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">Quotation Lists</label>
                        </div>

                        <div class="box-body">
                            <div class="cv-spinner" id="loader">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblsoquotationlist" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>QtGid</th>                                        
                                        <th>imBranchGid</th>
                                        <th>ชื่อสาขา</th>
                                        <th width="100px" style="text-align: left;">เลขที่เอกสาร</th>
                                        <th>เลขที่อ้างอิง</th>
                                        <th>ประเภทโครงการ</th>
                                        <th>รหัสโครงการ</th>
                                        <th>ชื่อโครงการ</th>
                                        <th width="100px" style="text-align: left;">วันที่เอกสาร</th>
                                        <th>วันที่ส่งสินค้า</th>
                                        <th>ปีรายการ</th>
                                        <th>รหัสลูกค้า</th>
                                        <th style="text-align: left;">ชื่อลูกค้า</th>
                                        <th>ชื่อผู้ติดต่อ</th>
                                        <th>เบอร์โทร</th>
                                        <th>อัตราแลกเปลี่ยน</th>
                                        <th>adCurrencyID</th>
                                        <th>CurrencyDesc</th>
                                        <th>TotalAmount</th>
                                        <th>VATAmount</th>
                                        <th>TotalAmountExcludeVAT</th>
                                        <th>DiscPercent</th>
                                        <th>DiscAmount</th>
                                        <th>DiscExtendPercent</th>
                                        <th>DiscExtendAmount</th>
                                        <th>AMOUNT</th>
                                        <th>TotalAmountAfterDisc</th>
                                        <th>QTRemark</th>
                                        <th>QTComment</th>
                                        <th>imDeliveryID</th>
                                        <th>DeliveryName</th>
                                        <th>adPaymentTypeID</th>
                                        <th>PaymentTypeDesc</th>
                                        <th>imEmployeeGid</th>
                                        <th>OWN.NAME</th>
                                        <th>SalePositionName</th>
                                        <th>ApproveID</th>
                                        <th>ApproveName</th>
                                        <th>ApprovePositionID</th>
                                        <th>ApprovePositionName</th>
                                        <th>IsDelete</th>
                                        <th>FlagID</th>
                                        <th width="100px" style="text-align: center;">สถานะ</th>
                                        <th>CreatedBy</th>
                                        <th>CreateName</th>
                                        <th>CreateDate</th>
                                        <th>UpdatedBy</th>
                                        <th>UpdateDate</th>
                                        <th>SaleEMail</th>
                                        <th width="30px" style="text-align: center;">#</th>
                                        <th width="30px" style="text-align: center;">#</th>
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
    </section>
</asp:Content>
