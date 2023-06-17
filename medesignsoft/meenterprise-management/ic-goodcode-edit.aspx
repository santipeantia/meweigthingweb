<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="ic-goodcode-edit.aspx.cs" Inherits="medesignsoft.meenterprise_management.ic_goodcode_edit" %>
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
                /*height: 100%;
                
                justify-content: center;
                align-items: center;*/
                position: absolute;
                display: flex;
                top: 45%;
                left: 40%;
                transform: translate(-50%, -50%);
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



                var param = getQueryStrings();
                var gid = param["gid"];
                var mod = param["mod"];

                $('#txtPrice1').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 4)) {
                        event.preventDefault();
                    }
                });

                $('#txtPrice2').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 4)) {
                        event.preventDefault();
                    }
                });

                $('#txtPrice3').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 4)) {
                        event.preventDefault();
                    }
                });

                $('#txtPurLeadTime').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 4)) {
                        event.preventDefault();
                    }
                });

                $('#txtGoodWeight').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 4)) {
                        event.preventDefault();
                    }
                });

                $('#txtGoodWidth').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 4)) {
                        event.preventDefault();
                    }
                });

                 $('#txtGoodLength').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 4)) {
                        event.preventDefault();
                    }
                });

                $('#txtGoodHeight').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 4)) {
                        event.preventDefault();
                    }
                });


                var employeeid = '<%= Session["imEmployeeGid"] %>';

                if (mod == 'new') {
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

                getGoodGroup();
                getGoodType();
                getGoodColor();
                getGoodUnit();
                getGoodStatus();
                getActive();



                if (mod == 'edit' || mod == 'del') {
                    getGoodCodebyid(gid);
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



                var selectgoodgroup = $('#selectGoodGroupID');
                function getGoodGroup() {
                    $.ajax({
                        url: 'general-services.asmx/getGoodGroupList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectgoodgroup.empty();
                            $(data).each(function (index, item) {
                                selectgoodgroup.append($('<option/>', { value: item.GoodGroupID, text: item.GoodGroupDesc }));
                            });
                        }
                    });
                }

                var selectgoodtype = $('#selectGoodTypeID');
                function getGoodType() {
                    $.ajax({
                        url: 'general-services.asmx/getGoodTypeList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectgoodtype.empty();
                            $(data).each(function (index, item) {
                                selectgoodtype.append($('<option/>', { value: item.GoodTypeID, text: item.GoodTypeDesc }));
                            });
                        }
                    });
                }

                var selectgoodcolor = $('#selectGoodColorID');
                function getGoodColor() {
                    $.ajax({
                        url: 'general-services.asmx/getGoodColorList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectgoodcolor.empty();
                            $(data).each(function (index, item) {
                                selectgoodcolor.append($('<option/>', { value: item.GoodColorID, text: item.GoodColorDesc }));
                            });
                        }
                    });
                }

                var selectgoodunit = $('#selectGoodUnitID');
                function getGoodUnit() {
                    $.ajax({
                        url: 'general-services.asmx/getGoodUnitList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectgoodunit.empty();
                            $(data).each(function (index, item) {
                                selectgoodunit.append($('<option/>', { value: item.GoodUnitID, text: item.GoodUnitDesc }));
                            });
                        }
                    });
                }

                var selectgoodstatus = $('#selectGoodStatID');
                function getGoodStatus() {
                    $.ajax({
                        url: 'general-services.asmx/getGoodStatusList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectgoodstatus.empty();
                            $(data).each(function (index, item) {
                                selectgoodstatus.append($('<option/>', { value: item.GoodStatID, text: item.GoodStatDesc }));
                            });
                        }
                    });
                }

                var selectactive = $('#selectactiveid');
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

                function getGoodCodebyid(gid) {
                    $.ajax({
                        url: 'general-services.asmx/getGoodCodeById',
                        method: 'post',
                        data: {
                            gid: gid,
                        },
                        datatype: 'json',
                        beforeSend: function () {
                            $('#overlay').show();
                        },
                        success: function (data) {
                            var obj = jQuery.parseJSON(JSON.stringify(data));
                            if (obj != '') {
                                $.each(obj, function (i, data) {
                                   
                                    $('#hiddengid').val(data["GoodCodeID"]);
                                    $('#selectGoodGroupID').val(data["GoodGroupID"]);
                                    $('#selectGoodGroupID').change();
                                    $('#selectGoodTypeID').val(data["GoodTypeID"]);
                                    $('#selectGoodTypeID').change();
                                    $('#txtGoodCate').val(data["GoodCate"]);
                                    $('#txtGoodCode').val(data["GoodCode"]);
                                    $('#txtGoodName').val(data["GoodName"]);
                                    $('#selectGoodColorID').val(data["GoodColorID"]);
                                    $('#selectGoodColorID').change();
                                    $('#selectGoodUnitID').val(data["GoodUnitID"]);
                                    $('#selectGoodUnitID').change();
                                    $('#txtPrice1').val(data["Price1"]);
                                    $('#txtPrice2').val(data["Price2"]);
                                    $('#txtPrice3').val(data["Price3"]);
                                    $('#txtPurLeadTime').val(data["PurLeadTime"]);
                                    $('#txtGoodWeight').val(data["GoodWeight"]);
                                    $('#txtGoodWidth').val(data["GoodWidth"]);
                                    $('#txtGoodLength').val(data["GoodLength"]);
                                    $('#txtGoodHeight').val(data["GoodHeight"]);
                                    $('#selectGoodStatID').val(data["GoodStatID"]);
                                    $('#selectGoodStatID').change();
                                    $('#selectactiveid').val(data["activeid"]);
                                    $('#selectactiveid').change();
                                    $('#txtRemark').val(data["Remark"]);
                                })
                            }
                            setTimeout(function () {
                                $('#overlay').hide();
                            }, 600);
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
                    window.location.href = "ic-goodcode-setup.aspx?opt=optic";

                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    getGoodCodebyid(gid);
                });

                //btnsavenew
                //btnsavechange
                //btndelete
                var chkvalidate = 'true';

                var btncancel = $('#btncancel');
                btncancel.click(function () {
                    window.location.href = "ic-goodcode-setup.aspx?opt=optic";
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
                                    url: 'general-services.asmx/getGoodCodeUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'new',
                                        gid: $('#hiddengid').val(),
                                        GoodCodeID: $('#hiddengid').val(),
                                        GoodGroupID: $('#selectGoodGroupID').val(),
                                        GoodTypeID: $('#selectGoodTypeID').val(),
                                        GoodCate: $('#txtGoodCate').val(),
                                        GoodCode: $('#txtGoodCode').val(),
                                        GoodName: $('#txtGoodName').val(),
                                        GoodColorID: $('#selectGoodColorID').val(),
                                        GoodColorDesc: $('#selectGoodColorID option:selected').text(),
                                        GoodUnitID: $('#selectGoodUnitID').val(),
                                        GoodUnitDesc: $('#selectGoodUnitID option:selected').text(),
                                        Price1: $('#txtPrice1').val(),
                                        Price2: $('#txtPrice2').val(),
                                        Price3: $('#txtPrice3').val(),
                                        Price4: $('#txtPrice4').val(),
                                        Price5: $('#txtPrice5').val(),
                                        PurLeadTime: $('#txtPurLeadTime').val(),
                                        GoodWeight: $('#txtGoodWeight').val(),
                                        GoodWidth: $('#txtGoodWidth').val(),
                                        GoodLength: $('#txtGoodLength').val(),
                                        GoodHeight: $('#txtGoodHeight').val(),
                                        GoodStatID: $('#selectGoodStatID').val(),
                                        GoodStatDesc: $('#selectGoodStatID option:selected').text(),
                                        activeid: $('#selectactiveid').val(),
                                        UserCreate: employeeid,
                                        CreateDate: null,
                                        UserUpdate: employeeid,
                                        LasteDate: null,
                                        Remark: $('#txtRemark').val()
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
                                            window.location.href = "ic-goodcode-setup.aspx?opt=optic";
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
                                    url: 'general-services.asmx/getGoodCodeUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'edit',
                                        gid: $('#hiddengid').val(),
                                        GoodCodeID: $('#hiddengid').val(),
                                        GoodGroupID: $('#selectGoodGroupID').val(),
                                        GoodTypeID: $('#selectGoodTypeID').val(),
                                        GoodCate: $('#txtGoodCate').val(),
                                        GoodCode: $('#txtGoodCode').val(),
                                        GoodName: $('#txtGoodName').val(),
                                        GoodColorID: $('#selectGoodColorID').val(),
                                        GoodColorDesc: $('#selectGoodColorID option:selected').text(),
                                        GoodUnitID: $('#selectGoodUnitID').val(),
                                        GoodUnitDesc: $('#selectGoodUnitID option:selected').text(),
                                        Price1: $('#txtPrice1').val(),
                                        Price2: $('#txtPrice2').val(),
                                        Price3: $('#txtPrice3').val(),
                                        Price4: $('#txtPrice4').val(),
                                        Price5: $('#txtPrice5').val(),
                                        PurLeadTime: $('#txtPurLeadTime').val(),
                                        GoodWeight: $('#txtGoodWeight').val(),
                                        GoodWidth: $('#txtGoodWidth').val(),
                                        GoodLength: $('#txtGoodLength').val(),
                                        GoodHeight: $('#txtGoodHeight').val(),
                                        GoodStatID: $('#selectGoodStatID').val(),
                                        GoodStatDesc: $('#selectGoodStatID option:selected').text(),
                                        activeid: $('#selectactiveid').val(),
                                        UserCreate: employeeid,
                                        CreateDate: null,
                                        UserUpdate: employeeid,
                                        LasteDate: null,
                                        Remark: $('#txtRemark').val()
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
                                            window.location.href = "ic-goodcode-setup.aspx?opt=optic";
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
                                    url: 'general-services.asmx/getGoodCodeUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'del',
                                        gid: $('#hiddengid').val(),
                                        GoodCodeID: $('#hiddengid').val(),
                                        GoodGroupID: $('#selectGoodGroupID').val(),
                                        GoodTypeID: $('#selectGoodTypeID').val(),
                                        GoodCate: $('#txtGoodCate').val(),
                                        GoodCode: $('#txtGoodCode').val(),
                                        GoodName: $('#txtGoodName').val(),
                                        GoodColorID: $('#selectGoodColorID').val(),
                                        GoodColorDesc: $('#selectGoodColorID option:selected').text(),
                                        GoodUnitID: $('#selectGoodUnitID').val(),
                                        GoodUnitDesc: $('#selectGoodUnitID option:selected').text(),
                                        Price1: $('#txtPrice1').val(),
                                        Price2: $('#txtPrice2').val(),
                                        Price3: $('#txtPrice3').val(),
                                        Price4: $('#txtPrice4').val(),
                                        Price5: $('#txtPrice5').val(),
                                        PurLeadTime: $('#txtPurLeadTime').val(),
                                        GoodWeight: $('#txtGoodWeight').val(),
                                        GoodWidth: $('#txtGoodWidth').val(),
                                        GoodLength: $('#txtGoodLength').val(),
                                        GoodHeight: $('#txtGoodHeight').val(),
                                        GoodStatID: $('#selectGoodStatID').val(),
                                        GoodStatDesc: $('#selectGoodStatID option:selected').text(),
                                        activeid: $('#selectactiveid').val(),
                                        UserCreate: employeeid,
                                        CreateDate: null,
                                        UserUpdate: employeeid,
                                        LasteDate: null,
                                        Remark: $('#txtRemark').val()
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
                                            window.location.href = "ic-goodcode-setup.aspx?opt=optic";
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

        <h1>Warehouse Edit <%--step 1 check pages content name--%>
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
                                <button type="button" id="btnPdf" class="btn btn-default btn-sm" data-toggle="tooltip" title="pdf"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel" class="btn btn-default btn-sm" runat="server"  data-toggle="tooltip" title="excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">Group Edit</label>
                        </div>

                        <div class="box-body">
                            <div class="col-md-6">
                                <input type="hidden" id="hiddengid" class="form-control ">

                                
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">กลุ่มสินค้า <span id="errwhid" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                       <span class="txtLabel " style="width: 100%">
                                            <select id="selectGoodGroupID" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ประเภทสินค้า <span id="errselectGoodTypeID" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                       <span class="txtLabel " style="width: 100%">
                                            <select id="selectGoodTypeID" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">หมวดสินค้า <span id="errwhcate" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtGoodCate" class="form-control ">
                                    </div>

                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รหัสรายการ <span id="errwhcode" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtGoodCode" class="form-control ">
                                    </div>

                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ชื่อรายการ<span id="errwhdesc" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtGoodName" class="form-control ">
                                    </div>
                                </div>                                
                                 <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">สีสินค้า <span id="errselectGoodColorID" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                       <span class="txtLabel " style="width: 100%">
                                            <select id="selectGoodColorID" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>                                
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">หน่วยสินค้า <span id="errselectGoodUnitID" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                       <span class="txtLabel " style="width: 100%">
                                            <select id="selectGoodUnitID" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ราคาที่ 1<span id="errtxtPrice1" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtPrice1" class="form-control " value="0.0000">
                                    </div>
                                </div> 
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ราคาที่ 2<span id="errtxtPrice2" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtPrice2" class="form-control " value="0.0000">
                                    </div>
                                </div> 
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ราคาที่ 3<span id="errtxtPrice3" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtPrice3" class="form-control " value="0.0000"> 
                                    </div>
                                </div> 
                                 <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ราคาที่ 4<span id="errtxtPrice4" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtPrice4" class="form-control " value="0.0000"> 
                                    </div>
                                </div> 
                                 <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ราคาที่ 5<span id="errtxtPrice5" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtPrice5" class="form-control " value="0.0000"> 
                                    </div>
                                </div> 

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ระยะเวลาสั่งสินค้า<span id="errtxtPurLeadTime" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtPurLeadTime" class="form-control " value="0.0000">
                                    </div>
                                </div> 
                               <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">น้ำหนักสินค้า(กก.)<span id="errttxtGoodWeight" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtGoodWeight" class="form-control " value="0.0000">
                                    </div>
                                </div> 
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ความกว้าง(ซม.)<span id="errtxtGoodWidth" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtGoodWidth" class="form-control " value="0.0000">
                                    </div>
                                </div> 
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ความยาว(ซม.)<span id="errtxtGoodLength" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtGoodLength" class="form-control " value="0.0000">
                                    </div>
                                </div> 
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ความสูง(ซม.)<span id="errtxtGoodHeight" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtGoodHeight" class="form-control " value="0.0000">
                                    </div>
                                </div> 
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ลักษณะสินค้า <span id="errselectGoodStatID" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                       <span class="txtLabel " style="width: 100%">
                                            <select id="selectGoodStatID" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">มีผลใช้งาน <span id="errselectactiveid" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                       <span class="txtLabel " style="width: 100%">
                                            <select id="selectactiveid" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>                               
                                

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">หมายเหตุ<span id="errremark" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">

                                        <textarea id="txtRemark" rows="3" class="form-control txtLabel"></textarea>
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
