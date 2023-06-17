<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="gm-company-setup.aspx.cs" Inherits="medesignsoft.meenterprise_management.gm_company_setup" %>
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
                $('#loadercompany').hide();

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
                     window.location.href = "gm-company-edit.aspx?opt=optgen&mod=new";
                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    reloaddata()
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

                                    window.location.href = "gm-company-edit.aspx?opt=optgen&mod=edit&gid="+gid.text();
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

        <h1>General Setup <%--step 1 check pages content name--%>
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
                                <button type="button" id="btnExportExcel" runat="server" onserverclick="btnExportExcel_Click" class="btn btn-default btn-sm" data-toggle="tooltip" title="excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">Company List</label>
                        </div>

                        <div class="box-body" >
                            <div class="cv-spinner" id="loadercompany">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblcompanylist" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>Gid</th>
                                        <th>ComCode</th>
                                        <th>CompanyNameTH</th>
                                        <th>CompanyNameEn</th>
                                        <th>ShortNameTH</th>
                                        <th>ShortNameEN</th>
                                        <th>AddressTh1</th>
                                        <th>AddressTh2</th>
                                        <th>AddressTh3</th>
                                        <th>AddressEn1</th>
                                        <th>AddressEn2</th>
                                        <th>AddressEn3</th>
                                        <th>ProvinceID</th>
                                        <th>Province</th>
                                        <th>PostCode</th>
                                        <th>CountryID</th>
                                        <th>Country</th>
                                        <th>Phone</th>
                                        <th>Fax</th>
                                        <th>Email</th>
                                        <th>Owner</th>
                                        <th>TaxID</th>
                                        <th>AccountDate</th>
                                        <th>Logo</th>
                                        <th>Active</th>
                                        <th>EffecDate</th>
                                        <th>ExpireDate</th>
                                        <th>Branch</th>
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
    </section>
</asp:Content>
