<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="gm-employees-edit.aspx.cs" Inherits="medesignsoft.meenterprise_management.gm_employees_edit" %>
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
                $('#overlay').show();
                $('body').on('keydown', 'input, select, textarea', function (e) {
                    var self = $(this)
                        , form = self.parents('form:eq(0)')
                        , focusable
                        , next
                        , prev
                        ;

                    if (e.shiftKey) {
                        if (e.keyCode == 13) {
                            focusable = form.find('input,a,select,button,textarea').filter(':visible');
                            prev = focusable.eq(focusable.index(this) - 1);

                            if (prev.length) {
                                prev.focus();
                            } else {
                                form.submit();
                            }
                        }
                    }
                    else
                        if (e.keyCode == 13) {
                            focusable = form.find('input,a,select,button,textarea').filter(':visible');
                            next = focusable.eq(focusable.index(this) + 1);
                            if (next.length) {
                                next.focus();
                            } else {
                                form.submit();
                            }
                            return false;
                        }
                });

                getBranch();
                getTitleName();
                getPosition();
                getDepartment();
                getSection();
                getDivision();

                getProvince();
                getCountry();
                getMarry();
                getLivingStatus();
                getReligion();
                getSex();

                getActive();

                var param = getQueryStrings();
                var gid = param["gid"];
                var mod = param["mod"];

                if (mod == 'new') {
                     $('#overlay').hide();
                    //alert('mode edit');

                    //$('#selectcompany').prop('disabled', false);

                    $('#btncancel').removeClass('hidden');
                    $('#btnsavenew').removeClass('hidden');
                    $('#btnsavechange').addClass('hidden');
                    $('#btndelete').addClass('hidden');
                } else if (mod == 'edit') {

                    // $('#selectcompany').prop('disabled', true);

                    $('#btncancel').removeClass('hidden');
                    $('#btnsavenew').addClass('hidden');
                    $('#btnsavechange').removeClass('hidden');
                    $('#btndelete').addClass('hidden');
                } else if (mod == 'del') {
                    $('#btncancel').removeClass('hidden');
                    $('#btnsavenew').addClass('hidden');
                    $('#btnsavechange').addClass('hidden');
                    $('#btndelete').removeClass('hidden');
                } else {
                    $('#btncancel').addClass('hidden');
                    $('#btnsavenew').addClass('hidden');
                    $('#btnsavechange').addClass('hidden');
                    $('#btndelete').addClass('hidden');
                }


                if (mod == 'edit' || mod == 'del') {

                    getemployeesbyid(gid);
                }


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

                $('#datestart').val(ssdate);
                $('#datestop').val(eedate);

                var selectbranch = $('#selectbranch');
                function getBranch() {
                    $.ajax({
                        url: 'general-services.asmx/getBranch',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectbranch.empty();
                            selectbranch.append($('<option/>', { value: -1, text: 'กรุณาระบุชื่อสาขา' }));
                            $(data).each(function (index, item) {
                                selectbranch.append($('<option/>', { value: item.imBranchGid, text: item.BranchName }));
                            });
                        }
                    });
                };

                var selecttitlename = $('#selecttitlename');
                function getTitleName() {
                    $.ajax({
                        url: 'general-services.asmx/getTitlename',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selecttitlename.empty();
                            selecttitlename.append($('<option/>', { value: -1, text: 'please select titlename..' }));
                            $(data).each(function (index, item) {
                                selecttitlename.append($('<option/>', { value: item.imTitleGid, text: item.TitleName }));
                            });
                        }
                    });
                };

                var selectposition = $('#selectposition');
                function getPosition() {
                    $.ajax({
                        url: 'general-services.asmx/getPosition',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectposition.empty();
                            selectposition.append($('<option/>', { value: -1, text: 'please select position..' }));
                            $(data).each(function (index, item) {
                                selectposition.append($('<option/>', { value: item.imPositionID, text: item.PositionName }));
                            });
                        }
                    });
                };

                var selectdepartment = $('#selectdepartment');
                function getDepartment() {
                    $.ajax({
                        url: 'general-services.asmx/getDepartmentList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectdepartment.empty();
                            selectdepartment.append($('<option/>', { value: -1, text: 'please select department..' }));
                            $(data).each(function (index, item) {
                                selectdepartment.append($('<option/>', { value: item.imDepartmentID, text: item.DepartmentDesc }));
                            });
                        }
                    });
                }

                var selectsection = $('#selectsection');
                function getSection() {
                    $.ajax({
                        url: 'general-services.asmx/getSectionList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectsection.empty();
                            selectsection.append($('<option/>', { value: -1, text: 'please select section..' }));
                            $(data).each(function (index, item) {
                                selectsection.append($('<option/>', { value: item.imSectionID, text: item.SectionDesc }));
                            });
                        }
                    });
                };

                var selectdivision = $('#selectdivision');
                function getDivision() {
                    $.ajax({
                        url: 'general-services.asmx/getDivision',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectdivision.empty();
                            selectdivision.append($('<option/>', { value: -1, text: 'please select division..' }));
                            $(data).each(function (index, item) {
                                selectdivision.append($('<option/>', { value: item.imDivisionID, text: item.DivisionDesc }));
                            });
                        }
                    });
                };

                var selectprovince = $('#selectprovince');
                function getProvince() {
                    $.ajax({
                        url: 'general-services.asmx/getprovince',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {
                            $('#loadercompany').show();
                            $("#tblcompanylist tr td").remove();

                        },
                        success: function (data) {
                            selectprovince.empty();
                            selectprovince.append($('<option/>', { value: -1, text: 'please select province..' }));
                            $(data).each(function (index, item) {
                                selectprovince.append($('<option/>', { value: item.adProvinceID, text: item.ProvinceName }));
                            });
                        }
                    });
                }

                var selectcountry = $('#selectcountry');
                function getCountry() {
                    $.ajax({
                        url: 'general-services.asmx/getcountry',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectcountry.empty();
                            selectcountry.append($('<option/>', { value: -1, text: 'please select country..' }));
                            $(data).each(function (index, item) {
                                selectcountry.append($('<option/>', { value: item.adCountryID, text: item.CountryName }));
                            });
                        }
                    });
                }

                var selectmarry = $('#selectmarry');
                function getMarry() {
                    $.ajax({
                        url: 'general-services.asmx/getMarry',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectmarry.empty();
                            selectmarry.append($('<option/>', { value: -1, text: 'please select marrital..' }));
                            $(data).each(function (index, item) {
                                selectmarry.append($('<option/>', { value: item.imMaritalStatusID, text: item.MaritalStatusDesc }));
                            });
                        }
                    });
                }

                var selectliving = $('#selectliving');
                function getLivingStatus() {
                    $.ajax({
                        url: 'general-services.asmx/getLivingStatus',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectliving.empty();
                            selectliving.append($('<option/>', { value: -1, text: 'please select living..' }));
                            $(data).each(function (index, item) {
                                selectliving.append($('<option/>', { value: item.imLivingStatusID, text: item.LivingStatusDesc }));
                            });
                        }
                    });
                }

                var selectreligion = $('#selectreligion');
                function getReligion() {
                    $.ajax({
                        url: 'general-services.asmx/getReligion',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectreligion.empty();
                            selectreligion.append($('<option/>', { value: -1, text: 'please select religion..' }));
                            $(data).each(function (index, item) {
                                selectreligion.append($('<option/>', { value: item.imReligionID, text: item.ReligionDesc }));
                            });
                        }
                    });
                }

                var selectsex = $('#selectsex');
                function getSex() {
                    $.ajax({
                        url: 'general-services.asmx/getSex',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectsex.empty();
                            selectsex.append($('<option/>', { value: -1, text: 'please select sex..' }));
                            $(data).each(function (index, item) {
                                selectsex.append($('<option/>', { value: item.imSexID, text: item.SexDesc }));
                            });
                        }
                    });
                }

                var selectactive = $('#selectactive');
                function getActive() {
                    $.ajax({
                        url: 'general-services.asmx/getactive',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectactive.empty();
                            $(data).each(function (index, item) {
                                selectactive.append($('<option/>', { value: item.activeid, text: item.activename }));
                            });
                        }
                    });
                }

                function getemployeesbyid(gid) {
                    $.ajax({
                        url: 'general-services.asmx/getEmployeesById',
                        method: 'post',
                        data: {
                            gid: gid,
                        },
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            var obj = jQuery.parseJSON(JSON.stringify(data));
                            if (obj != '') {
                                $.each(obj, function (i, data) {
                                    $('#hiddengid').val(data["imEmployeeGid"]);

                                    $('#selectbranch').val(data["imBranchGID"]).change();
                                    $('#txtemployeeid').val(data["imEmployeeID"]);
                                    $('#selecttitlename').val(data["imTitleID"]).change();
                                    $('#txtemployeename').val(data["FirstName"]);
                                    $('#txtlastname').val(data["LastName"]);
                                    $('#txtnickname').val(data["NickName"]);
                                    $('#selectposition').val(data["imPositionID"]).change();
                                    $('#selectdepartment').val(data["imDepartmentID"]).change();
                                    $('#selectsection').val(data["imSectionID"]).change();
                                    $('#selectdivision').val(data["imDivisionID"]).change();
                                    $('#txtadd1').val(data["Add1"]);
                                    $('#txtadd2').val(data["Add2"]);
                                    $('#txtadd3').val(data["Add3"]);
                                    $('#selectprovince').val(data["adProvinceID"]).change();
                                    $('#txtpostcode').val(data["PostalCode"]);
                                    $('#selectcountry').val(data["adCountryID"]).change();
                                    $('#txttaxid').val(data["IDCardNO"]);
                                    $('#selectmarry').val(data["imMaritalStatusID"]).change();
                                    $('#selectliving').val(data["imLivingStatusID"]).change();
                                    $('#selectreligion').val(data["imReligionID"]).change();
                                    $('#selectsex').val(data["imSexID"]).change();
                                    $('#datebirthday').val(data["Birthday"]);
                                    $('#txtphone').val(data["Tel"]);
                                    $('#txtmobile').val(data["Mobile"]);
                                    $('#txtemail').val(data["EMail"]);
                                    $('#txtremark').val(data["Remark"]);

                                    $('#selectactive').val(data["Active"]).change();
                                    $('#datestart').val(data["EffecDate"]);
                                    $('#datestop').val(data["ExpireDate"]);
                                })
                            }
                            $('#overlay').hide();
                        }
                    });

                }

                function getQueryStrings() {
                    var assoc = {};
                    var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
                    var queryString = location.search.substring(1);
                    var keyValues = queryString.split('&');

                    for (var i in keyValues) {
                        var key = keyValues[i].split('=');
                        if (key.length > 1) {
                            assoc[decode(key[0])] = decode(key[1]);
                        }
                    }

                    return assoc;
                }

                var btnundo = $('#btnundo');
                btnundo.click(function () {
                    window.location.href = "gm-employees-setup.aspx?opt=optgen";

                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    getbranchbyid(gid);
                });

                //btnsavenew
                //btnsavechange
                //btndelete
                var chkvalidate = 'true';

                var btncancel = $('#btncancel');
                btncancel.click(function () {
                    window.location.href = "gm-employees-setup.aspx?opt=optgen";
                });

                var btnsavenew = $('#btnsavenew');
                btnsavenew.click(function () {
                    getvalidatefield();
                    if (chkvalidate == 'true') {
                        // alert('true');
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
                                    url: 'general-services.asmx/getEmployeesUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'new',
                                        Gid: $('#hiddengid').val(),
                                        imBranchID: $('#selectbranch').val(),
                                        imEmployeeID: $('#txtemployeeid').val(),
                                        imTitleID: $('#selecttitlename').val(),
                                        FirstName: $('#txtemployeename').val(),
                                        LastName: $('#txtlastname').val(),
                                        NickName: $('#txtnickname').val(),
                                        imPositionID: $('#selectposition').val(),
                                        imDepartmentID: $('#selectdepartment').val(),
                                        imSectionID: $('#selectsection').val(),
                                        imDivisionID: $('#selectdivision').val(),
                                        Add1: $('#txtadd1').val(),
                                        Add2: $('#txtadd2').val(),
                                        Add3: $('#txtadd3').val(),
                                        adProvinceID: $('#selectprovince').val(),
                                        PostalCode: $('#txtpostcode').val(),
                                        adCountryID: $('#selectcountry').val(),
                                        IDCardNO: $('#txttaxid').val(),
                                        imMaritalStatusID: $('#selectmarry').val(),
                                        imLivingStatusID: $('#selectliving').val(),
                                        imReligionID: $('#selectreligion').val(),
                                        imSexID: $('#selectsex').val(),
                                        Birthday: $('#datebirthday').val(),
                                        Tel: $('#txtphone').val(),
                                        Mobile: $('#txtmobile').val(),
                                        EMail: $('#txtemail').val(),
                                        Remark: $('#txtremark').val(),

                                        Active: $('#selectactive').val(),
                                        EffecDate: $('#datestart').val(),
                                        ExpireDate: $('#datestop').val()
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
                                            window.location.href = "gm-employees-setup.aspx?opt=optgen";
                                        }, 2000);
                                    },
                                    error: function (xhr, ajaxOptions, thrownError) {
                                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                    }
                                });
                            }
                        })

                    } else {
                        //  alert('false');
                    }

                });

                var btnsavechange = $('#btnsavechange');
                btnsavechange.click(function () {
                    getvalidatefield();

                    if (chkvalidate == 'true') {
                        // alert('true');
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
                                    url: 'general-services.asmx/getEmployeesUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'edit',
                                        //Gid: $('#hiddengid').val(),
                                        Gid: $('#hiddengid').val(),

                                        imBranchID: $('#selectbranch').val(),
                                        imEmployeeID: $('#txtemployeeid').val(),
                                        imTitleID: $('#selecttitlename').val(),
                                        FirstName: $('#txtemployeename').val(),
                                        LastName: $('#txtlastname').val(),
                                        NickName: $('#txtnickname').val(),
                                        imPositionID: $('#selectposition').val(),
                                        imDepartmentID: $('#selectdepartment').val(),
                                        imSectionID: $('#selectsection').val(),
                                        imDivisionID: $('#selectdivision').val(),
                                        Add1: $('#txtadd1').val(),
                                        Add2: $('#txtadd2').val(),
                                        Add3: $('#txtadd3').val(),
                                        adProvinceID: $('#selectprovince').val(),
                                        PostalCode: $('#txtpostcode').val(),
                                        adCountryID: $('#selectcountry').val(),
                                        IDCardNO: $('#txttaxid').val(),
                                        imMaritalStatusID: $('#selectmarry').val(),
                                        imLivingStatusID: $('#selectliving').val(),
                                        imReligionID: $('#selectreligion').val(),
                                        imSexID: $('#selectsex').val(),
                                        Birthday: $('#datebirthday').val(),
                                        Tel: $('#txtphone').val(),
                                        Mobile: $('#txtmobile').val(),
                                        EMail: $('#txtemail').val(),
                                        Remark: $('#txtremark').val(),

                                        Active: $('#selectactive').val(),
                                        EffecDate: $('#datestart').val(),
                                        ExpireDate: $('#datestop').val()
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
                                            window.location.href = "gm-employees-setup.aspx?opt=optgen";
                                        }, 2000);
                                    },
                                    error: function (xhr, ajaxOptions, thrownError) {
                                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                        //Swal.fire(
                                        //    '<span class="txtLabel">บันทึกข้อมูลสำเร็จ..!</span>',
                                        //    '',
                                        //    'error'
                                        //)
                                    }
                                });
                            }
                        })

                    } else {
                        //  alert('false');
                    }
                });

                var btndelete = $('#btndelete');
                btndelete.click(function () {
                    getvalidatefield();

                    if (chkvalidate == 'true') {
                        // alert('true');
                        Swal.fire({

                            title: '<span class="txtLabel">ต้องการลบข้อมูล ใช่หรือไม่..?</span>',
                            //text: "You won't be able to revert this!",
                            icon: 'warning',
                            showCancelButton: true,
                            cancelButtonColor: '#d33',
                            confirmButtonColor: '#449d44',
                            confirmButtonText: '<span class="txtLabel">ยืนยัน, ลบข้อมูล!</span>',
                            cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>'
                        }).then((result) => {
                            if (result.isConfirmed) {


                                $.ajax({
                                    url: 'general-services.asmx/getEmployeesUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'del',
                                        Gid: $('#hiddengid').val(),
                                        imBranchID: $('#selectbranch').val(),
                                        imEmployeeID: $('#txtemployeeid').val(),
                                        imTitleID: $('#selecttitlename').val(),
                                        FirstName: $('#txtemployeename').val(),
                                        LastName: $('#txtlastname').val(),
                                        NickName: $('#txtnickname').val(),
                                        imPositionID: $('#selectposition').val(),
                                        imDepartmentID: $('#selectdepartment').val(),
                                        imSectionID: $('#selectsection').val(),
                                        imDivisionID: $('#selectdivision').val(),
                                        Add1: $('#txtadd1').val(),
                                        Add2: $('#txtadd2').val(),
                                        Add3: $('#txtadd3').val(),
                                        adProvinceID: $('#selectprovince').val(),
                                        PostalCode: $('#txtpostcode').val(),
                                        adCountryID: $('#selectcountry').val(),
                                        IDCardNO: $('#txttaxid').val(),
                                        imMaritalStatusID: $('#selectmarry').val(),
                                        imLivingStatusID: $('#selectliving').val(),
                                        imReligionID: $('#selectreligion').val(),
                                        imSexID: $('#selectsex').val(),
                                        Birthday: $('#datebirthday').val(),
                                        Tel: $('#txtphone').val(),
                                        Mobile: $('#txtmobile').val(),
                                        EMail: $('#txtemail').val(),
                                        Remark: $('#txtremark').val(),
                                        Active: $('#selectactive').val(),
                                        EffecDate: $('#datestart').val(),
                                        ExpireDate: $('#datestop').val()
                                    },
                                    success: function (data) {
                                        Swal.fire(
                                            '<span class="txtLabel">บันทึกข้อมูลสำเร็จ..!</span>',
                                            '',
                                            'success'
                                        )
                                        setTimeout(function () {
                                            window.location.href = "gm-employees-setup.aspx?opt=optgen";
                                        }, 2000);

                                    },
                                    error: function (xhr, ajaxOptions, thrownError) {
                                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                    }
                                });
                            }
                        })

                    } else {
                        //  alert('false');
                    }
                })

                function getvalidatefield() {
                    var gid = $('#hiddengid').val();


                    if (mod == 'edit' && gid == '') {
                        Swal.fire({
                            position: 'center',
                            icon: 'warning',
                            title: 'Warning, Your data gid is incorrect..!',
                            showConfirmButton: false,
                            timer: 1500
                        })
                        chkvalidate = 'false';
                        return;
                    }

                    if (mod == 'del' && gid == '') {
                        Swal.fire({
                            position: 'center',
                            icon: 'warning',
                            title: 'Warning, Your data gid is incorrect..!',
                            showConfirmButton: false,
                            timer: 1500
                        })
                        chkvalidate = 'false';
                        return;
                    }
                }


            });





        </script>

        <h1>Employee Edit <%--step 1 check pages content name--%>
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
                                <button type="button" id="btnundo" class="btn btn-default btn-sm" data-toggle="tooltip" title="undo"><i class="fa fa-undo text-green"></i></button>
                                <button type="button" id="btnreload" class="btn btn-default btn-sm" data-toggle="tooltip" title="reset"><i class="fa fa-refresh text-blue"></i></button>
                                <button type="button" id="btnPdf1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="pdf"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="excek"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">Section Edit</label>
                        </div>

                        <div class="box-body">
                            <div class="col-md-6">
                                <input type="hidden" id="hiddengid" class="form-control ">

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ชื่อสาขา</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectbranch" class="form-control input-sm readonly">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รหัสพนังาน <span id="erremployeescode" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtemployeeid" class="form-control ">
                                    </div>

                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">คำนำหน้าชื่อ</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selecttitlename" class="form-control input-sm readonly">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ชื่อพนักงาน<span id="erremployeename" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtemployeename" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">นามสกุล<span id="errlastname" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtlastname" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ชื่อเล่น<span id="errnickname" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtnickname" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ตำแหน่ง</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectposition" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">แผนก/หน่วยงาน</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectdepartment" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ฝ่าย</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectsection" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">สังกัด</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectdivision" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ที่อยู่พนักงาน<span id="erraddress1" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtadd1" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ที่อยู่พนักงาน<span id="erraddress2" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtadd2" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ที่อยู่พนักงาน<span id="erraddress3" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtadd3" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">จังหวัด</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectprovince" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รหัสไปรษณีย์<span id="errpostcode" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtpostcode" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ประเทศ</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectcountry" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เลขที่ผู้เสียภาษี<span id="errtaxid" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txttaxid" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">สถานะแต่งงาน</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectmarry" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ที่อยู่อาศัย</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectliving" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ศาสนา</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectreligion" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เพศ</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectsex" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">วัน เดือน ปีเกิด</label>
                                    <div class="col-sm-8 ">
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datebirthday" autocomplete="off">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เบอร์โทรศัพท์<span id="errtelophone" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtphone" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เบอร์มือถือ<span id="errmobile" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtmobile" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">อีเมล์<span id="erremail" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtemail" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">หมายเหตุ<span id="errremark" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtremark" class="form-control ">
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">มีผลใช้งาน</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectactive" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">วันที่เริ่มใช้งาน</label>
                                    <div class="col-sm-8 ">
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datestart" autocomplete="off">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">วันที่สิ้นสุด</label>
                                    <div class="col-sm-8 ">
                                        <div class="input-group date">
                                            <input type="text" class="form-control pull-right" id="datestop" autocomplete="off">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-sm-4"></div>
                                    <div class="col-sm-8">
                                        <input type="button" id="btncancel" class="btn btn-default btn-sm hidden" value="ยกเลิกรายการ">
                                        <input type="button" id="btnsavenew" class="btn btn-primary btn-sm hidden" value="บันทึกข้อมูลรายการ">
                                        <input type="button" id="btnsavechange" class="btn btn-success btn-sm hidden" value="บันทึกปรับปรุงรายการ">
                                        <input type="button" id="btndelete" class="btn btn-danger btn-sm hidden" value="ยืนยันลบข้อมูลรายการ">
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
