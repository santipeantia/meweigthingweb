<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="gm-branch-edit.aspx.cs" Inherits="medesignsoft.meenterprise_management.gm_branch_edit" %>
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

                getCompany();
                getProvince();
                getCountry();
                getEmployees();
                getActive();

                var param = getQueryStrings();
                var gid = param["gid"];
                var mod = param["mod"];

                if (mod == 'new') {
                    //alert('mode edit');

                    $('#selectcompany').prop('disabled', false);

                    $('#btncancel').removeClass('hidden');
                    $('#btnsavenew').removeClass('hidden');
                    $('#btnsavechange').addClass('hidden');
                    $('#btndelete').addClass('hidden');
                } else if (mod == 'edit') {

                    $('#selectcompany').prop('disabled', true);

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
                    getbranchbyid(gid);
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

                var selectcompany = $('#selectcompany');
                function getCompany() {
                    $.ajax({
                        url: 'general-services.asmx/getCompany',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectcompany.empty();
                            $(data).each(function (index, item) {
                                selectcompany.append($('<option/>', { value: item.adCompanyID, text: item.CompanyNameTh }));
                            });

                        }
                    });
                }

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
                            $(data).each(function (index, item) {
                                selectcountry.append($('<option/>', { value: item.adCountryID, text: item.CountryName }));
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

                var selectemployees = $('#selectemployees');
                function getEmployees() {
                    $.ajax({
                        url: 'general-services.asmx/getemployees',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectemployees.empty();
                            $(data).each(function (index, item) {
                                selectemployees.append($('<option/>', { value: item.Gid, text: item.EmployeeName }));
                            });
                        }
                    });
                }


                function getbranchbyid(gid) {
                    $.ajax({
                        url: 'general-services.asmx/getBranchById',
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
                                    $('#hiddengid').val(data["imBranchGid"]);

                                    $('#selectcompany').val(data["adCompanyID"]).change();
                                    $('#txtbranchcode').val(data["imBranchID"]);
                                    $('#txtbranchname').val(data["BranchName"]);


                                    $('#txtshortname').val(data["ShortBranchName"]);
                                    $('#txttaxid').val(data["TaxID"]);
                                    $('#txtaddress1').val(data["Add1"]);
                                    $('#txtaddress2').val(data["Add2"]);
                                    $('#txtaddress3').val(data["Add3"]);
                                    $('#selectprovince').val(data["adProvinceID"]).change();
                                    $('#txtpostcode').val(data["PostalCode"]);
                                    $('#selectcountry').val(data["adCountryID"]).change();
                                    $('#txtphone').val(data["Phone"]);
                                    $('#txtfaxno').val(data["Fax"]);
                                    $('#txtwebsite').val(data["WebSite"]);
                                    $('#selectemployees').val(data["ContactID"]).change();
                                    $('#txtemail').val(data["ContactEMail"]).change();


                                    $('#selectactive').val(data["Active"]).change();
                                    //$('#selectactive').change();

                                    $('#datestart').val(data["EffectDate"]);
                                    $('#datestop').val(data["ExpireDate"]);
                                })
                            }
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
                    window.location.href = "gm-branch-setup.aspx?opt=optgen";

                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    getbranchbyid(gid);
                });

                //btnsavenew
                //btnsavechange
                //btndelete
                var chkvalidate = 'true';

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
                                    url: 'general-services.asmx/getBranchUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'new',
                                        Gid: $('#hiddengid').val(),
                                        imBranchID: $('#txtbranchcode').val(),
                                        BranchName: $('#txtbranchname').val(),
                                        ShortBranchName: $('#txtshortname').val(),
                                        adCompanyID: $('#selectcompany').val(),
                                        TaxID: $('#txttaxid').val(),
                                        Add1: $('#txtaddress1').val(),
                                        Add2: $('#txtaddress2').val(),
                                        Add3: $('#txtaddress3').val(),
                                        adProvinceID: $('#selectprovince').val(),
                                        PostalCode: $('#txtpostcode').val(),
                                        adCountryID: $('#selectcountry').val(),
                                        Phone: $('#txtphone').val(),
                                        Fax: $('#txtfaxno').val(),
                                        WebSite: $('#txtwebsite').val(),
                                        ContactID: $('#selectemployees').val(),
                                        ContactTel: null,
                                        ContactEMail: $('#txtemail').val(),
                                        Logo: null,
                                        Active: $('#selectactive').val(),
                                        EffectDate: $('#datestart').val(),
                                        ExpireDate: $('#datestop').val(),
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
                                            window.location.href = "gm-branch-setup.aspx?opt=optgen";
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
                                    url: 'general-services.asmx/getBranchUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'edit',
                                        Gid: $('#hiddengid').val(),

                                        imBranchID: $('#txtbranchcode').val(),
                                        BranchName: $('#txtbranchname').val(),
                                        ShortBranchName: $('#txtshortname').val(),
                                        adCompanyID: $('#selectcompany').val(),
                                        TaxID: $('#txttaxid').val(),
                                        Add1: $('#txtaddress1').val(),
                                        Add2: $('#txtaddress2').val(),
                                        Add3: $('#txtaddress3').val(),
                                        adProvinceID: $('#selectprovince').val(),
                                        PostalCode: $('#txtpostcode').val(),
                                        adCountryID: $('#selectcountry').val(),
                                        Phone: $('#txtphone').val(),
                                        Fax: $('#txtfaxno').val(),
                                        WebSite: $('#txtwebsite').val(),
                                        ContactID: $('#selectemployees').val(),
                                        ContactTel: null,
                                        ContactEMail: $('#txtemail').val(),
                                        Logo: null,
                                        Active: $('#selectactive').val(),
                                        EffectDate: $('#datestart').val(),
                                        ExpireDate: $('#datestop').val(),
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
                                            window.location.href = "gm-branch-setup.aspx?opt=optgen";
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
                                    url: 'general-services.asmx/getBranchUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'del',
                                        Gid: $('#hiddengid').val(),
                                        imBranchID: $('#txtbranchcode').val(),
                                        BranchName: $('#txtbranchname').val(),
                                        ShortBranchName: $('#txtshortname').val(),
                                        adCompanyID: $('#selectcompany').val(),
                                        TaxID: $('#txttaxid').val(),
                                        Add1: $('#txtaddress1').val(),
                                        Add2: $('#txtaddress2').val(),
                                        Add3: $('#txtaddress3').val(),
                                        adProvinceID: $('#selectprovince').val(),
                                        PostalCode: $('#txtpostcode').val(),
                                        adCountryID: $('#selectcountry').val(),
                                        Phone: $('#txtphone').val(),
                                        Fax: $('#txtfaxno').val(),
                                        WebSite: $('#txtwebsite').val(),
                                        ContactID: $('#selectemployees').val(),
                                        ContactTel: null,
                                        ContactEMail: $('#txtemail').val(),
                                        Logo: null,
                                        Active: $('#selectactive').val(),
                                        EffectDate: $('#datestart').val(),
                                        ExpireDate: $('#datestop').val(),
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
                                            window.location.href = "gm-branch-setup.aspx?opt=optgen";
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
                    var comcode = $('#txtcomcode').val();
                    var fullnameth = $('#txtfullnameth').val();
                    var fullnameen = $('#txtfullnameeng').val();
                    var shortnameth = $('#txtshortnameth').val();
                    var shortnaemen = $('#txtshortnameeng').val();
                    var addressth = $('#txtaddressth1').val();
                    //alert(gid);


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

                    if (comcode == '') {
                        Swal.fire({
                            position: 'center',
                            icon: 'warning',
                            title: 'Warning, Company Code is incorrect..!',
                            showConfirmButton: false,
                            timer: 1500
                        })
                        chkvalidate = 'false';
                        $('#errcomcode').removeClass('hidden');
                        return;
                    } else {
                        $('#errcomcode').addClass('hidden');
                    }

                    if (fullnameth == '') {
                        Swal.fire({
                            position: 'center',
                            icon: 'warning',
                            title: 'Warning, ชื่อบริษัทฯ ไม่สามารถเป็นค่าว่างได้..!',
                            showConfirmButton: false,
                            timer: 1500
                        })
                        chkvalidate = 'false';
                        $('#errfullnameth').removeClass('hidden');
                        return;
                    } else {
                        $('#errfullnameth').addClass('hidden');
                    }

                    if (fullnameen == '') {
                        Swal.fire({
                            position: 'center',
                            icon: 'warning',
                            title: 'Warning, ชื่อบริษัทฯ ไม่สามารถเป็นค่าว่างได้..!',
                            showConfirmButton: false,
                            timer: 1500
                        })
                        chkvalidate = 'false';
                        $('#errfullnameeng').removeClass('hidden');
                        return;
                    } else {
                        $('#errfullnameeng').addClass('hidden');
                    }

                    if (shortnameth == '') {
                        Swal.fire({
                            position: 'center',
                            icon: 'warning',
                            title: 'Warning, ชื่อย่อบริษัทฯ ไม่สามารถเป็นค่าว่างได้..!',
                            showConfirmButton: false,
                            timer: 1500
                        })
                        chkvalidate = 'false';
                        $('#errshortnameth').removeClass('hidden');
                        return;
                    } else {
                        $('#errshortnameth').addClass('hidden');
                    }

                    if (shortnaemen == '') {
                        Swal.fire({
                            position: 'center',
                            icon: 'warning',
                            title: 'Warning, ชื่อย่อบริษัทฯ ไม่สามารถเป็นค่าว่างได้..!',
                            showConfirmButton: false,
                            timer: 1500
                        })
                        chkvalidate = 'false';
                        $('#errshortnameeng').removeClass('hidden');
                        return;
                    } else {
                        $('#errshortnameeng').addClass('hidden');
                    }

                    if (addressth == '') {
                        Swal.fire({
                            position: 'center',
                            icon: 'warning',
                            title: 'Warning, ที่อยู่บริษัทฯ ไม่สามารถเป็นค่าว่างได้..!',
                            showConfirmButton: false,
                            timer: 1500
                        })
                        chkvalidate = 'false';
                        $('#erraddressth1').removeClass('hidden');
                        return;
                    } else {
                        $('#erraddressth1').addClass('hidden');
                    }
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
                                <button type="button" id="btnundo" class="btn btn-default btn-sm" data-toggle="tooltip" title="undo"><i class="fa fa-undo text-green"></i></button>
                                <button type="button" id="btnreload" class="btn btn-default btn-sm" data-toggle="tooltip" title="reset"><i class="fa fa-refresh text-blue"></i></button>
                                <button type="button" id="btnPdf1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="pdf"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="excek"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">Company Edit</label>
                        </div>

                        <div class="box-body">
                            <div class="col-md-6">
                                <input type="hidden" id="hiddengid" class="form-control ">

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ชื่อบริษัทฯ</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectcompany" class="form-control input-sm readonly">
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รหัสสาขา <span id="errbranchcode" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtbranchcode" class="form-control ">
                                    </div>

                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ชื่อเรียกสาขา<span id="errbranchname" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtbranchname" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ชื่อย่อบริษัทฯ (ภาษาไทย)<span id="errshortname" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtshortname" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เลขที่ผู้เสียภาษี<span id="errtaxid" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txttaxid" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ที่อยู่บริษัทฯ1</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtaddress1" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ที่อยู่บริษัทฯ2</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtaddress2" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ที่อยู่บริษัทฯ3</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtaddress3" class="form-control ">
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
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รหัสไปรษณีย์</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtpostcode" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รหัสประเทศ</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectcountry" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เบอร์โทรศัทพ์</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtphone" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เบอร์แฟกซ์</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtfaxno" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เวปไซต์</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtwebsite" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ชื่อผู้ติดต่อ</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectemployees" class="form-control input-sm ">
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">อีเมล์</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtemail" class="form-control ">
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
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datestart">
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
                                            <input type="text" class="form-control pull-right" id="datestop">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-sm-4"></div>
                                    <div class="col-sm-8">
                                        <input type="button" id="btncancel" class="btn btn-default btn-sm" value="ยกเลิกรายการ">
                                        <input type="button" id="btnsavenew" class="btn btn-primary btn-sm" value="บันทึกข้อมูลรายการ">
                                        <input type="button" id="btnsavechange" class="btn btn-success btn-sm" value="บันทึกปรับปรุงรายการ">
                                        <input type="button" id="btndelete" class="btn btn-danger btn-sm" value="ยืนยันลบข้อมูลรายการ">
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
