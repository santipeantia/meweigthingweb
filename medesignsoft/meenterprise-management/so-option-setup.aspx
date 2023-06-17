<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="so-option-setup.aspx.cs" Inherits="medesignsoft.meenterprise_management.so_option_setup" %>
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

                if (mod == 'new') {
                    
                    $('#btncancel').removeClass('hidden');
                    $('#btnsavenew').removeClass('hidden');
                    $('#btnsavechange').addClass('hidden');
                    $('#btndelete').addClass('hidden');

                } else if (mod == 'edit') {

                    (async () => {
                       await getSOOptionList();
                    })();                 

                    $('#btncancel').removeClass('hidden');
                    $('#btnsavenew').addClass('hidden');
                    $('#btnsavechange').removeClass('hidden');
                    $('#btndelete').addClass('hidden');
                } else if (mod == 'del') {

                    //(async () => {
                    //   await getSOApproveLevelbyid(gid);
                    //})();

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


                var employeeid = '<%= Session["imEmployeeGid"] %>';

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



                //var selectemployeeuser = $('#selectemployeeuser');
                //async function getEmployeeUser() {
                //    var result = await $.ajax({
                //        url: 'general-services.asmx/getEmployeesList',
                //        method: 'post',
                //        datatype: 'json',
                //        beforeSend: function () {

                //        },
                //        success: function (data) {
                //            selectemployeeuser.empty();
                //            selectemployeeuser.append($('<option/>', { value: -1, text: 'Please select sales owner..' }));

                //            $(data).each(function (index, item) {
                //                selectemployeeuser.append($('<option/>', { value: item.imEmployeeGid, text: item.FirstName + ' ' + item.LastName }));
                //            });     

                             
                //        }
                //    });
                //    return result;
                //}
                
                //var selectsoapprovelevel = $('#selectsoapprovelevel');
                //async function getSOLevel() {   
                   
                //    // go do that thing
                //   var result = await $.ajax({
                //        url: 'general-services.asmx/getSoLevelList',
                //        method: 'post',
                //        datatype: 'json',
                //        beforeSend: function () {

                //        },
                //        success: function (data) {
                //            selectsoapprovelevel.empty();
                //            selectsoapprovelevel.append($('<option/>', { value: -1, text: 'Please select approve level..' }));

                //            $(data).each(function (index, item) {
                //                selectsoapprovelevel.append($('<option/>', { value: item.SoLevelID, text: item.SoLevelDesc }));
                //            });
                //        }
                //    });
                //    return result;
                //}

                async function getSOOptionList() {
                    try {
                        
                        var result = await $.ajax({
                            url: 'general-services.asmx/getSOOptionList',
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
                                        $('#hiddengid').val(data["SoOptionID"]);
                                        $('#selectqtovercredit').val(data["QtoverCredit"]);
                                        $('#selectqtovercredit').change();

                                        $('#selectresovercredit').val(data["ResoverCredit"]);
                                        $('#selectresovercredit').change();

                                        $('#selectsoovercredit').val(data["SooverCredit"]);
                                        $('#selectsoovercredit').change();

                                        $('#selectamountovercredit').val(data["AmountOverCredit"]);
                                        $('#selectamountovercredit').change();

                                        $('#selectsooverreserv').val(data["SooverReserv"]);
                                        $('#selectsooverreserv').change();

                                        $('#selectalertdeposit').val(data["AlertDeposit"]);
                                        $('#selectalertdeposit').change();

                                        $('#selectresoverqt').val(data["ResoverQt"]);
                                        $('#selectresoverqt').change();

                                        $('#selectsooverquotation').val(data["SooverQuotation"]);
                                        $('#selectsooverquotation').change();

                                        $('#selectstockoverspend').val(data["StockoverSpend"]);
                                        $('#selectstockoverspend').change();

                                        $('#selectqtacceptapproval').val(data["QtacceptApproval"]);
                                        $('#selectqtacceptapproval').change();

                                        $('#txtRemark').val(data["Remark"]);
                                    })
                                }
                                setTimeout(function () {
                                    $('#overlay').hide();
                                }, 600);
                            }
                        });

                        return result;
                    }
                    catch (error) {
                        console.log(error.message);
                    }
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
                    window.location.href = "so-setup.aspx?opt=optso";

                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    getSOApproveLevelbyid(gid);
                });

                //btnsavenew
                //btnsavechange
                //btndelete
                var chkvalidate = 'true';

                var btncancel = $('#btncancel');
                btncancel.click(function () {
                    window.location.href = "so-setup.aspx?opt=optso";
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
                                    url: 'general-services.asmx/getSoApprovalLevelUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'new',
                                        gid: $('#hiddengid').val(),
                                        SoAppLevelID: $('#hiddengid').val(),
                                        imEmployeeGid: $('#selectemployeeuser').val(),
                                        SoLevelID: $('#selectsoapprovelevel').val(),
                                        Remark: $('#txtRemark').val(),
                                        UserCreate: employeeid,
                                        CreateDate: null,
                                        UserUpdate: employeeid,
                                        LasteDate: null
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
                                            window.location.href = "so-approvelevel-setup.aspx?opt=optso";
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
                                    url: 'general-services.asmx/getSoOptionUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'edit',
                                        gid: $('#hiddengid').val(),
                                        SoOptionID: $('#hiddengid').val(),                                      
                                        QtoverCredit: $('#selectqtovercredit').val(),
                                        ResoverCredit: $('#selectresovercredit').val(),
                                        SooverCredit: $('#selectsoovercredit').val(),
                                        AmountOverCredit: $('#selectamountovercredit').val(),
                                        SooverReserv: $('#selectsooverreserv').val(),
                                        AlertDeposit: $('#selectalertdeposit').val(),
                                        ResoverQt: $('#selectresoverqt').val(),
                                        SooverQuotation: $('#selectsooverquotation').val(),
                                        StockoverSpend: $('#selectstockoverspend').val(),
                                        QtacceptApproval: $('#selectqtacceptapproval').val(),

                                        Remark: $('#txtRemark').val(),
                                        UserCreate: employeeid,
                                        CreateDate: null,
                                        UserUpdate: employeeid,
                                        LasteDate: null
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
                                            window.location.href = "so-setup.aspx?opt=optso";
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
                                    url: 'general-services.asmx/getSoApprovalLevelUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'del',
                                        gid: $('#hiddengid').val(),
                                        SoAppLevelID: $('#hiddengid').val(),
                                        imEmployeeGid: $('#selectemployeeuser').val(),
                                        SoLevelID: $('#selectsoapprovelevel').val(),
                                        Remark: $('#txtRemark').val(),
                                        UserCreate: employeeid,
                                        CreateDate: null,
                                        UserUpdate: employeeid,
                                        LasteDate: null
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
                                            window.location.href = "so-approvelevel-setup.aspx?opt=optso";
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
        <h1>SO Option Edit <%--step 1 check pages content name--%>
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

                            <label class="txtLabel">Group Edit</label>
                        </div>

                        <div class="box-body">
                            <div class="col-md-6">
                                <input type="hidden" id="hiddengid" class="form-control ">


                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">เสนอราคาได้เกินวงเงินเครดิต <span id="erremployeeuser" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectqtovercredit" class="form-control input-sm " style="width: 100%">
                                                <option value="Y">ใช่</option>
                                                <option value="N">ไม่ใช่</option>
                                            </select>
                                        </span>
                                    </div>

                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">สั่งจองสินค้าได้เกินวงเงินเครดิต <span id="erremployeehead" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectresovercredit" class="form-control input-sm " style="width: 100%">
                                                <option value="Y">ใช่</option>
                                                <option value="N">ไม่ใช่</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">สั่งขายสินค้าได้เกินวงเงินอนุมัติเครดิต <span id="erremployeehead" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectsoovercredit" class="form-control input-sm " style="width: 100%">
                                                <option value="Y">ใช่</option>
                                                <option value="N">ไม่ใช่</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">แสดงจำนวนที่เกินวงเงินอนุมัติเครดิต <span id="amountovercredit" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectamountovercredit" class="form-control input-sm " style="width: 100%">
                                                <option value="Y">ใช่</option>
                                                <option value="N">ไม่ใช่</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">สั่งขายได้เกินจำนวนที่สั่งจองสินค้า <span id="sooverreserv" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectsooverreserv" class="form-control input-sm " style="width: 100%">
                                                <option value="Y">ใช่</option>
                                                <option value="N">ไม่ใช่</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">แจ้งเตือนเมื่อมีเงินมัดจำลูกหนี้ <span id="alertdeposit" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectalertdeposit" class="form-control input-sm " style="width: 100%">
                                                <option value="Y">ใช่</option>
                                                <option value="N">ไม่ใช่</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">สั่งจองสินค้าได้เกินใบเสนอราคา<span id="resoverqt" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectresoverqt" class="form-control input-sm " style="width: 100%">
                                                <option value="Y">ใช่</option>
                                                <option value="N">ไม่ใช่</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">ขายได้เกินใบอนุมัติเสนอราคาสินค้า<span id="sooverquotation" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectsooverquotation" class="form-control input-sm " style="width: 100%">
                                                <option value="Y">ใช่</option>
                                                <option value="N">ไม่ใช่</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">ยอมให้จำนวนสินค้าติดลบ<span id="stockoverspend" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectstockoverspend" class="form-control input-sm " style="width: 100%">
                                                <option value="Y">ใช่</option>
                                                <option value="N">ไม่ใช่</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">ผ่านการอนุมัติก่อนส่งเอกสารใบเสนอราคา<span id="qtacceptapproval" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectqtacceptapproval" class="form-control input-sm " style="width: 100%">
                                                <option value="Y">ใช่</option>
                                                <option value="N">ไม่ใช่</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                

                                <div class="form-group row">
                                    <label class="col-sm-6 col-form-label txtLabel text-right">หมายเหตุ<span id="errremark" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-6">

                                        <textarea id="txtRemark" rows="3" class="form-control txtLabel"></textarea>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-sm-6"></div>
                                    <div class="col-sm-6">
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
