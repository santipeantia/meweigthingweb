<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="ic-goodcode-setup.aspx.cs" Inherits="medesignsoft.meenterprise_management.ic_goodcode_setup" %>
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

            #tblgoodcodelist tbody tr:hover {
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
                    window.location.href = "ic-goodcode-edit.aspx?opt=optic&mod=new";
                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    reloaddata()
                });

                function reloaddata() {
                    $.ajax({
                        url: 'general-services.asmx/getGoodCodeList',
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
                            $("#tblgoodcodelist tr td").remove();

                        },
                        success: function (data) {
                            var table;
                            table = $('#tblgoodcodelist').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].GoodCodeID, data[i].GoodGroupID, data[i].GoodGroupDesc, data[i].GoodTypeID, data[i].GoodTypeDesc, data[i].GoodCate,
                                        data[i].GoodCode, data[i].GoodName, data[i].GoodColorID, data[i].GoodColorDesc, data[i].GoodUnitID, data[i].GoodUnitDesc,
                                        data[i].Price1, data[i].Price2, data[i].Price3, data[i].Price4, data[i].Price5, data[i].PurLeadTime, data[i].GoodWeight, data[i].GoodWidth,
                                        data[i].GoodLength, data[i].GoodHeight, data[i].GoodStatID, data[i].GoodStatDesc, data[i].activeid, data[i].activename,
                                        data[i].UserCreate, data[i].CreateDate, data[i].UserUpdate, data[i].LasteDate, data[i].edit, data[i].trash]);
                                });
                            }
                            table.draw();
                            $('#loader').hide();

                            $('#tblgoodcodelist td:nth-of-type(30)').addClass('column_hover');
                            $('#tblgoodcodelist td:nth-of-type(31)').addClass('column_hover');

                            //$('#tblgoodcodelist td').click(function () {
                            //    rIndex = this.parentElement.rowIndex;
                            //    cIndex = this.cellIndex;
                            //    console.log('row : ' + rIndex + ' cell: ' + cIndex)

                            //    if (rIndex != 0 & cIndex == 4) {
                            //        var gid = $("#tblgoodcodelist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');

                            //        var encodedGid = btoa(gid.text());
                            //        var decodedGid = atob(encodedGid);
                            //        console.log(encodedGid);
                            //        console.log(decodedGid);

                            //        window.location.href = "ic-goodcode-edit.aspx?opt=optic&mod=edit&gid=" + gid.text();
                            //    }

                            //    if (rIndex != 0 & cIndex == 5) {
                            //        var gid = $("#tblgoodcodelist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                            //        console.log(gid.text());
                            //        window.location.href = "ic-goodcode-edit.aspx?opt=optic&mod=del&gid=" + gid.text();
                            //    }

                            //})

                            $('#tblgoodcodelist tbody').on('click', 'td', function (e) {
                                e.preventDefault();
                                
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;

                                //console.log(rIndex + ':' + cIndex);
                                var gid = $("#tblgoodcodelist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');

                                //console.log(gid.text());
                                if (rIndex != 0 & cIndex == 30) {
                                    window.location.href = "ic-goodcode-edit.aspx?opt=optic&mod=edit&gid=" + gid.text();
                                }

                                if (rIndex != 0 & cIndex == 31) {
                                    window.location.href = "ic-goodcode-edit.aspx?opt=optic&mod=del&gid=" + gid.text();
                                }
                            });


                        }
                    });
                }


            });





        </script>

        <h1>Goods Setup <%--step 1 check pages content name--%>
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
                                <button type="button" id="btnExcel" class="btn btn-default btn-sm" runat="server" onserverclick="btnExportExcel_click" data-toggle="tooltip" title="excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">Warehouse List</label>
                        </div>

                        <div class="box-body">
                            <div class="cv-spinner" id="loader">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblgoodcodelist" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>GROUPCODE</th>
                                        <th>GROUP</th>
                                        <th>GoodTypeID</th>
                                        <th>TYPE</th>
                                        <th>CATE</th>
                                        <th>CODE</th>
                                        <th>GOODNAME</th>
                                        <th>GoodColorID</th>
                                        <th>COLOR</th>
                                        <th>GoodUnitID</th>
                                        <th>UNIT</th>
                                        <th>Price1</th>
                                        <th>Price2</th>
                                        <th>Price3</th>
                                        <th>Price4</th>
                                        <th>Price5</th>
                                        <th>LeadTime</th>
                                        <th>WEIGHT</th>
                                        <th>WIDTH</th>
                                        <th>LENGTH</th>
                                        <th>HEIGHT</th>
                                        <th>STATUSID</th>
                                        <th>STATUS</th>
                                        <th>activeid</th>
                                        <th>ACTIVE</th>
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
    </section>
</asp:Content>
