<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="gm-document-edit.aspx.cs" Inherits="medesignsoft.meenterprise_management.gm_document_edit" %>
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
               

                var param = getQueryStrings();
                var gid = param["gid"];
                var mod = param["mod"];

                if (mod == 'new') {
                    $('#overlay').hide();

                    $('#btncancel').removeClass('hidden');
                    $('#btnsavenew').removeClass('hidden');
                    $('#btnsavechange').addClass('hidden');
                    $('#btndelete').addClass('hidden');

                } else if (mod == 'edit') {

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

                    getautorunbyid(gid);
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
                            selectbranch.append($('<option/>', { value: -1, text: 'please select branch..' }));
                            $(data).each(function (index, item) {
                                selectbranch.append($('<option/>', { value: item.imBranchGid, text: item.BranchName }));
                            });
                        }
                    });
                };



                function getautorunbyid(gid) {
                    $.ajax({
                        url: 'general-services.asmx/getAutorunById',
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
                                    $('#hiddengid').val(data["AutoRunID"]);
                                    $('#selectbranch').val(data["imBranchGid"]).change();                                    
                                    $('#txtAutoRunCode').val(data["AutoRunCode"]);
                                    $('#txtAutoRunDesc').val(data["AutoRunDesc"]);                                    
                                    $('#txtAutoRunFormat').val(data["AutoRunFormat"]);
                                    $('#txtAutoRunTitle').val(data["AutoRunTitle"]);
                                    $('#txtAutoRunYear').val(data["AutoRunYear"]);
                                    $('#txtAutoRunSplit').val(data["AutoRunSplit"]);
                                    $('#txtAutoRunNo').val(data["AutoRunNo"]);
                                    $('#txtDocuNo').val(data["DocuNo"]);
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
                    window.location.href = "gm-document-setup.aspx?opt=optgen";

                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    getautorunbyid(gid);
                });

                //btnsavenew
                //btnsavechange
                //btndelete
                var chkvalidate = 'true';

                var username = "<%= Session["UserName"]%>";

                var btncancel = $('#btncancel');
                btncancel.click(function () {
                    window.location.href = "gm-document-setup.aspx?opt=optgen";
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
                                    url: 'general-services.asmx/getAutorunUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'new',
                                        Gid: $('#hiddengid').val(),
                                        imBranchGid: $('#selectbranch').val(),
                                        AutoRunCode: $('#txtAutoRunCode').val(),
                                        AutoRunDesc: $('#txtAutoRunDesc').val(),                                    
                                        AutoRunFormat: $('#txtAutoRunFormat').val(),
                                        AutoRunTitle: $('#txtAutoRunTitle').val(),
                                        AutoRunYear: $('#txtAutoRunYear').val(),
                                        AutoRunSplit: $('#txtAutoRunSplit').val(),
                                        AutoRunNo: $('#txtAutoRunNo').val(),
                                        CreateUserID: username,
                                        CreateDate: yyyy + "-" + mm + "-" + dd + " " + tt,
                                        CreateTime: yyyy + "-" + mm + "-" + dd + " " + tt,
                                        adUserID: username,
                                        Lastdate: yyyy + "-" + mm + "-" + dd + " " + tt,
                                        LastTime: yyyy + "-" + mm + "-" + dd + " " + tt
                                        
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
                                    url: 'general-services.asmx/getAutorunUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'edit',
                                        Gid: $('#hiddengid').val(),

                                        imBranchGid: $('#selectbranch').val(),
                                        AutoRunCode: $('#txtAutoRunCode').val(),
                                        AutoRunDesc: $('#txtAutoRunDesc').val(),                                    
                                        AutoRunFormat: $('#txtAutoRunFormat').val(),
                                        AutoRunTitle: $('#txtAutoRunTitle').val(),
                                        AutoRunYear: $('#txtAutoRunYear').val(),
                                        AutoRunSplit: $('#txtAutoRunSplit').val(),
                                        AutoRunNo: $('#txtAutoRunNo').val(),
                                        CreateUserID: username,
                                        CreateDate: yyyy + "-" + mm + "-" + dd + " " + tt,
                                        CreateTime: yyyy + "-" + mm + "-" + dd + " " + tt,
                                        adUserID: username,
                                        Lastdate: yyyy + "-" + mm + "-" + dd + " " + tt,
                                        LastTime: yyyy + "-" + mm + "-" + dd + " " + tt                                     
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
                                            window.location.href = "gm-document-setup.aspx?opt=optgen";
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
                                    url: 'general-services.asmx/getAutorunUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'del',
                                        Gid: $('#hiddengid').val(),
                                        imBranchGid: $('#selectbranch').val(),
                                        AutoRunCode: $('#txtAutoRunCode').val(),
                                        AutoRunDesc: $('#txtAutoRunDesc').val(),                                    
                                        AutoRunFormat: $('#txtAutoRunFormat').val(),
                                        AutoRunTitle: $('#txtAutoRunTitle').val(),
                                        AutoRunYear: $('#txtAutoRunYear').val(),
                                        AutoRunSplit: $('#txtAutoRunSplit').val(),
                                        AutoRunNo: $('#txtAutoRunNo').val(),
                                        CreateUserID: username,
                                        CreateDate: yyyy + "-" + mm + "-" + dd + " " + tt,
                                        CreateTime: yyyy + "-" + mm + "-" + dd + " " + tt,
                                        adUserID: username,
                                        Lastdate: yyyy + "-" + mm + "-" + dd + " " + tt,
                                        LastTime: yyyy + "-" + mm + "-" + dd + " " + tt
                                        
                                    },
                                    success: function (data) {
                                        Swal.fire(
                                            '<span class="txtLabel">บันทึกข้อมูลสำเร็จ..!</span>',
                                            '',
                                            'success'
                                        )
                                        setTimeout(function () {
                                            window.location.href = "gm-document-setup.aspx?opt=optgen";
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

                            <label class="txtLabel">Autorun Edit</label>
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
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รหัสเอกสาร <span id="errautoruncode" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtAutoRunCode" class="form-control ">
                                    </div>

                                </div>                               

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">คำอธิบาย<span id="errautorundesc" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtAutoRunDesc" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รูปแบบเอกสาร<span id="errautorunformat" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtAutoRunFormat" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">คำขึ้นต้นเอกสาร<span id="errautoruntitle" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtAutoRunTitle" class="form-control ">
                                    </div>
                                </div>

                               

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เลขที่ปีเอกสาร<span id="errautorunyear" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtAutoRunYear" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">อักษรขั้น<span id="errautorunsplit" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtAutoRunSplit" class="form-control ">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เลขที่เอกสารล่าสุด<span id="errautorunno" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtAutoRunNo" class="form-control ">
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
