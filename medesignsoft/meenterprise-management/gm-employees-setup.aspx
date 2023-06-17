<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="gm-employees-setup.aspx.cs" Inherits="medesignsoft.meenterprise_management.gm_employees_setup" %>

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

           
            #tblemployeeslist tbody tr:hover {
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
                $('#loaderemployee').hide();

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
                    window.location.href = "gm-employees-edit.aspx?opt=optgen&mod=new";
                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    reloaddata()
                });

                function reloaddata() {
                    $.ajax({
                        url: 'general-services.asmx/getEmployeesList',
                        method: 'post',
                        //data: {
                        //    yearstart: yearstart,
                        //    yearend: yearend,
                        //    monthstart: monthstart,                       
                        //    monthend: monthend
                        //},
                        datatype: 'json',
                        beforeSend: function () {
                            $('#loaderemployee').show();
                            $("#tblemployeeslist tr td").remove();

                        },
                        success: function (data) {
                            var table;
                            table = $('#tblemployeeslist').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].imEmployeeGid, data[i].BranchName, data[i].imEmployeeID, data[i].imTitleID, data[i].TitleName, data[i].FirstName
                                        , data[i].MiddleName, data[i].LastName, data[i].NickName, data[i].imPositionID, data[i].PositionName, data[i].imDepartmentID
                                        , data[i].DepartmentDesc, data[i].imSectionID, data[i].SectionDesc, data[i].imDivisionID, data[i].DivisionDesc, data[i].Add1
                                        , data[i].Add2, data[i].Add3, data[i].adProvinceID, data[i].ProvinceName, data[i].PostalCode, data[i].adCountryID, data[i].IDCardNO
                                        , data[i].imMaritalStatusID, data[i].MaritalStatusDesc, data[i].imLivingStatusID, data[i].LivingStatusDesc, data[i].imReligionID
                                        , data[i].ReligionDesc, data[i].imSexID, data[i].Birthday, data[i].Tel, data[i].Mobile, data[i].Picture, data[i].EMail, data[i].Remark
                                        , data[i].Active, data[i].activename, data[i].EffecDate, data[i].ExpireDate, data[i].edit, data[i].trash, data[i].changpass]);
                                });
                            }
                            table.draw();
                            $('#loaderemployees').hide();

                            $('#tblemployeeslist td:nth-of-type(6)').addClass('column_hover');
                            $('#tblemployeeslist td:nth-of-type(8)').addClass('column_hover');

                            //$('#tblemployeeslist td').click(function () {
                            //    rIndex = this.parentElement.rowIndex;
                            //    cIndex = this.cellIndex;
                            //    console.log('row : ' + rIndex + ' cell: ' + cIndex)

                            //    if (rIndex != 0 & cIndex == 5 || cIndex == 7 || cIndex == 42) {
                            //        var gid = $("#tblemployeeslist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                            //        console.log(gid.text());
                            //        window.location.href = "gm-employees-edit.aspx?opt=optgen&mod=edit&gid=" + gid.text();
                            //    }

                            //    if (rIndex != 0 & cIndex == 5 || cIndex == 7 || cIndex == 43) {
                            //        var gid = $("#tblemployeeslist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                            //        console.log(gid.text());
                            //        window.location.href = "gm-employees-edit.aspx?opt=optgen&mod=del&gid=" + gid.text();
                            //    }

                            //    if (rIndex != 0 & cIndex == 44) {
                            //        var gid = $("#tblemployeeslist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                            //        console.log(gid.text());
                            //        window.location.href = "gm-changepassword-edit.aspx?opt=optgen&mod=edit&gid=" + gid.text();
                            //    }

                            //})

                            $('#tblemployeeslist tbody').on('click', 'td', function (e) {
                                e.preventDefault();
                                
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;

                                //console.log(rIndex + ':' + cIndex);
                                var gid = $("#tblemployeeslist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');

                                //console.log(gid.text());
                                if (rIndex != 0 & cIndex == 42) {
                                    window.location.href = "gm-employees-edit.aspx?opt=optgen&mod=edit&gid=" + gid.text();
                                }

                                if (rIndex != 0 & cIndex == 43) {
                                    window.location.href = "gm-employees-edit.aspx?opt=optgen&mod=del&gid=" + gid.text();
                                }

                                if (rIndex != 0 & cIndex == 44) {
                                    window.location.href = "gm-changepassword-edit.aspx?opt=optgen&mod=edit&gid=" + gid.text();
                                }
                            });
                        }
                    });
                }


            });





        </script>

        <h1>Employee Setup <%--step 1 check pages content name--%>
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

                            <label class="txtLabel">Employees List</label>
                        </div>

                        <div class="box-body">
                            <div class="cv-spinner" id="loaderemployees">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblemployeeslist" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>Gid</th>
                                        <%--0--%>
                                        <th>Branch</th>
                                        <%--1--%>
                                        <th>EmployeeID</th>
                                        <%--2--%>
                                        <th>imTitleID</th>
                                        <%--3--%>
                                        <th>TitleName</th>
                                        <%--4--%>
                                        <th>FirstName</th>
                                        <%--5--%>
                                        <th>MiddleName</th>
                                        <%--6--%>
                                        <th>LastName</th>
                                        <%--7--%>
                                        <th>NickName</th>
                                        <%--8--%>
                                        <th>imPositionID</th>
                                        <%--9--%>
                                        <th>Position</th>
                                        <%--10--%>
                                        <th>imDepartmentID</th>
                                        <%--11--%>
                                        <th>Department</th>
                                        <%--12--%>
                                        <th>imSectionID</th>
                                        <%--13--%>
                                        <th>SectionDesc</th>
                                        <%--14--%>
                                        <th>imDivisionID</th>
                                        <%--15--%>
                                        <th>Division</th>
                                        <%--16--%>
                                        <th>Add1</th>
                                        <%--17--%>
                                        <th>Add2</th>
                                        <%--18--%>
                                        <th>Add3</th>
                                        <%--19--%>
                                        <th>adProvinceID</th>
                                        <%--20--%>
                                        <th>ProvinceName</th>
                                        <%--21--%>
                                        <th>PostalCode</th>
                                        <%--22--%>
                                        <th>adCountryID</th>
                                        <%--23--%>
                                        <th>IDCardNO</th>
                                        <%--24--%>
                                        <th>imMaritalStatusID</th>
                                        <%--25--%>
                                        <th>MaritalStatusDesc</th>
                                        <%--26--%>
                                        <th>imLivingStatusID</th>
                                        <%--27--%>
                                        <th>LivingStatusDesc</th>
                                        <%--28--%>
                                        <th>imReligionID</th>
                                        <%--29--%>
                                        <th>ReligionDesc</th>
                                        <%--30--%>
                                        <th>imSexID</th>
                                        <%--31--%>
                                        <th>Birthday</th>
                                        <%--32--%>
                                        <th>Tel</th>
                                        <%--33--%>
                                        <th>Mobile</th>
                                        <%--34--%>
                                        <th>Picture</th>
                                        <%--35--%>
                                        <th>EMail</th>
                                        <%--36--%>
                                        <th>Remark</th>
                                        <%--37--%>
                                        <th>Active</th>
                                        <%--38--%>
                                        <th>Status</th>
                                        <%--39--%>
                                        <th>EffecDate</th>
                                        <%--40--%>
                                        <th>ExpireDate</th>
                                        <%--41--%>
                                        <th style="width: 30px; text-align: right;">#</th>
                                        <%--edit	42--%>
                                        <th style="width: 30px; text-align: right;">#</th>
                                        <%--trash	43--%>
                                        <th style="width: 30px; text-align: right;">#</th>
                                        <%--trash	44--%>
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
