<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="gm-document-setup.aspx.cs" Inherits="medesignsoft.meenterprise_management.gm_document_setup" %>
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

            #tbldocumentno tbody tr:hover {
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
                    window.location.href = "gm-document-edit.aspx?opt=optgen&mod=new";
                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    reloaddata()
                });

                function reloaddata() {
                    $.ajax({
                        url: 'general-services.asmx/getAutorunList',
                        method: 'post',
                        //data: {
                        //    yearstart: yearstart,
                        //    yearend: yearend,
                        //    monthstart: monthstart,                       
                        //    monthend: monthend
                        //},
                        datatype: 'json',
                        beforeSend: function () {
                            $('#overlay').show();
                            $("#tbldocumentno tr td").remove();

                        },
                        success: function (data) {
                            var table;
                            table = $('#tbldocumentno').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].AutoRunID, data[i].AutoRunCode, data[i].AutoRunDesc, data[i].imBranchGid, data[i].BranchName, data[i].AutoRunFormat, data[i].AutoRunTitle,
                                                   data[i].AutoRunYear, data[i].AutoRunSplit, data[i].AutoRunNo, data[i].DocuNo, data[i].edit, data[i].trash]);
                                });
                            }
                            table.draw();  
                            setTimeout(function () {
                                $('#overlay').hide();
                            }, 600);
                            
                            //$('#tblCompanyList td:nth-of-type(2)').addClass('column_fixed');
                            //$('#tblCompanyList td:nth-of-type(3)').addClass('column_fixed');

                            $('#tbldocumentno td').click(function () {
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;
                                console.log('row : ' + rIndex + ' cell: ' + cIndex)

                                if (rIndex != 0 & cIndex == 11) {
                                    var gid = $("#tbldocumentno").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                    console.log(gid.text());
                                    window.location.href = "gm-document-edit.aspx?opt=optgen&mod=edit&gid=" + gid.text();
                                }

                                if (rIndex != 0 & cIndex == 12) {
                                    var gid = $("#tbldocumentno").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                    console.log(gid.text());
                                    window.location.href = "gm-document-edit.aspx?opt=optgen&mod=del&gid=" + gid.text();
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
                                <button type="button" id="btnExportExcel" class="btn btn-default btn-sm" data-toggle="tooltip" title="excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">Document Autorun</label>
                        </div>

                        <div class="box-body">
                            
                            <table id="tbldocumentno" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>AutoRunID</th>
                                        <th>AutoRunCode</th>
                                        <th>AutoRunDesc</th>
                                        <th>imBranchGid</th>
                                        <th>BranchName</th>
                                        <th>AutoRunFormat</th>
                                        <th>AutoRunTitle</th>
                                        <th>AutoRunYear</th>
                                        <th>AutoRunSplit</th>
                                        <th>AutoRunNo</th>
                                        <th>DocuNo</th>
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
