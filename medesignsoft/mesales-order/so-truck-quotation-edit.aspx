<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="so-truck-quotation-edit.aspx.cs" Inherits="medesignsoft.mesales_order.so_truck_quotation_edit" %>

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

            #tblsoquotationitem tbody tr:hover {
                color: red;
                background-color: rgba(252, 241, 154, 0.63);
            }

            #tblgoodcodeselectitem tbody tr:hover {
                color: red;
                background-color: rgba(252, 241, 154, 0.63);
            }
                        
            #tblreftrucktrip tbody tr:hover {
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

            .myright {
                text-align: right;
            }

            .mycenter {
                text-align: center;
            }

            @keyframes sp-anime {
                100% {
                    transform: rotate(360deg);
                }
            }

            .is-hide {
                display: none;
            }

            .myclassblue {
                text-align: right;
                color: blue;
            }

            .fitwidth {
                width: 1px;
                white-space: nowrap;
            }
        </style>

        <script>
            $(document).ready(function () {
                //$('#loaderdiv1011').hide();

                $('input').on("keypress", function (e) {
                    /* ENTER PRESSED*/
                    if (e.keyCode == 13) {
                        /* FOCUS ELEMENT */
                        var inputs = $(this).parents("form").eq(0).find(":input");
                        var idx = inputs.index(this);

                        if (idx == inputs.length - 1) {
                            inputs[0].select()
                        } else {
                            inputs[idx + 1].focus(); //  handles submit buttons
                            inputs[idx + 1].select();
                        }
                        return false;
                    }
                });

                var employeeid = '<%= Session["imEmployeeGid"] %>';

                var empfullname = '<%= Session["FirstName"] %>' + ' ' + '<%= Session["LastName"] %>';

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

                $('#datestarttruck').val(ssdate);
                $('#datestoptruck').val(eedate);

                var btncancel = $('#btncancel');
                btncancel.click(function () {
                    window.location.href = "so-truck-quotation-view.aspx?opt=optsoe";
                });

                var param = getQueryStrings();
                var gid = param["gid"];
                var mod = param["mod"];

                if (mod == 'new') {

                    $('#datestart').val(nowdate);
                    $('#datestop').val(nowdate);

                    $('#overlay').show();

                    //getRunningDocuNo('QT');                   

                    setTimeout(function () {
                       
                        getBranch();
                        getProject();
                        getCustomerList();
                        getTermsList();
                        getApprovalLevelList();
                        getGoodCodeSelectList();
                        getSourceList();
                        getGoodUnit();

                        $('#overlay').hide();
                    }, 3000);


                    //getEmployeeUser();

                    $('#btnadditemnew').attr("disabled", true);

                    $('#btncancel').attr("disabled", false);
                    $('#btnprint').attr("disabled", true);

                    $('#btnsendmail').attr("disabled", true);

                    $('#btnsavedoc').attr("disabled", false);
                    $('#btnsavedoc').removeClass('hidden');

                    $('#btnupdatedoc').attr("disabled", true);
                    $('#btnupdatedoc').addClass('hidden');

                    $('#btndeldoc').attr("disabled", true);

                } else if (mod == 'edit') {

                    $('#overlay').show();

                    getBranch();
                    getProject();
                    getCustomerList();
                    getTermsList();
                    getApprovalLevelList();
                    getGoodCodeSelectList();
                    getSourceList();
                    getGoodUnit();

                    setTimeout(function () {

                        (async () => {
                            await getQuotationOrderById(gid);
                            await getQuotationDetails(gid);

                            $('#overlay').hide();
                        })();

                    }, 4000);

                    // $('#selectcompany').prop('disabled', true);

                    $('#btnadditemnew').attr("disabled", false);

                    $('#btncancel').attr("disabled", false);
                    $('#btnprint').attr("disabled", false);

                    $('#btnsendmail').attr("disabled", false);

                    $('#btnsavedoc').attr("disabled", true);
                    $('#btnsavedoc').addClass('hidden');

                    $('#btnupdatedoc').attr("disabled", false);
                    $('#btnupdatedoc').removeClass('hidden');

                    $('#btndeldoc').attr("disabled", false);

                } else if (mod == 'del') {

                    $('#overlay').show();

                    getBranch();
                    getProject();
                    getCustomerList();
                    getTermsList();
                    getApprovalLevelList();
                    getGoodCodeSelectList();
                    getSourceList();
                    getGoodUnit();

                    setTimeout(function () {

                        (async () => {
                            await getQuotationOrderById(gid);
                            await getQuotationDetails(gid);
                        })();

                        $('#overlay').hide();

                    }, 3000);

                    $('#btnadditemnew').attr("disabled", false);

                    $('#btncancel').attr("disabled", false);
                    $('#btnprint').attr("disabled", false);

                    $('#btnsendmail').attr("disabled", false);

                    $('#btnsavedoc').attr("disabled", true);
                    $('#btnsavedoc').addClass('hidden');

                    $('#btnupdatedoc').attr("disabled", false);
                    $('#btnupdatedoc').removeClass('hidden');

                    $('#btndeldoc').attr("disabled", false);
                } else {

                    //$('#btncancel').addClass('hidden');
                    //$('#btnsavenew').addClass('hidden');
                    //$('#btnsavechange').addClass('hidden');
                    //$('#btndelete').addClass('hidden');
                }

                async function getRunningDocuNo(docuno) {
                    const result = await $.ajax({
                        url: 'saleorder-services.asmx/getRunningDocuNo',
                        method: 'post',
                        data: {
                            docuno: docuno
                        },
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            var obj = jQuery.parseJSON(JSON.stringify(data));
                            if (obj != '') {
                                $.each(obj, function (i, data) {
                                    var docuno = data["DocuNo"];
                                    $('#docuno').text(docuno);
                                })
                            }
                        }
                    });
                    return result;
                }

                var selectbranch = $('#selectbranch');
                async function getBranch() {
                    var result = await $.ajax({
                        url: '../meenterprise-management/general-services.asmx/getBranch',
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
                    return result;
                };

                var selectproject = $('#selectproject');
                async function getProject() {
                    var result = await $.ajax({
                        url: '../meenterprise-management/general-services.asmx/getProjectType',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectproject.empty();
                            selectproject.append($('<option/>', { value: -1, text: 'กรุณาระบุประเภทโครงการ' }));
                            $(data).each(function (index, item) {
                                selectproject.append($('<option/>', { value: item.ProjectID, text: item.ProjectDesc }));
                            });
                        }
                    });
                    return result;
                };

                var selectcustomer = $('#selectcustomer');
                async function getCustomerList() {
                    var result = await $.ajax({
                        url: '../meenterprise-management/general-services.asmx/getCustomerList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectcustomer.empty();
                            selectcustomer.append($('<option/>', { value: -1, text: 'กรุณาระบุชื่อลูกค้า' }));
                            $(data).each(function (index, item) {
                                selectcustomer.append($('<option/>', { value: item.VendorID, text: item.VendorName }));
                            });
                        }
                    });
                    return result;
                };

                var selectsource = $('#selectsource');
                async function getSourceList() {
                    var result = await $.ajax({
                        url: '../meenterprise-management/general-services.asmx/getSourceList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectsource.empty();
                            selectsource.append($('<option/>', { value: -1, text: 'กรุณาระบุแหล่งอ้างอิง' }));
                            $(data).each(function (index, item) {
                                selectsource.append($('<option/>', { value: item.Gid, text: item.SourceName }));
                            });
                        }
                    });
                    return result;
                };

                //var selectcustomer = $('#selectcustomer');
                selectcustomer.change(function () {

                    if (mod == 'new') {
                        var gid = $('#selectcustomer').val();
                        getCustomerById(gid);
                    }

                    else if (mod == 'edit') {
                        var gid = $('#selectcustomer').val();
                        getCustomerById(gid);
                    }
                })

                var selectpayment = $('#selectpayment');
                async function getTermsList() {
                    var result = await $.ajax({
                        url: '../meenterprise-management/general-services.asmx/getTermsList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectpayment.empty();
                            selectpayment.append($('<option/>', { value: -1, text: 'ระบุการชำระเงิน' }));
                            $(data).each(function (index, item) {
                                selectpayment.append($('<option/>', { value: item.adPaymentTypeID, text: item.PaymentTypeDesc }));
                            });
                        }
                    });
                    return result;
                };

                var selectapproval = $('#selectapproval');
                async function getApprovalLevelList() {
                    var result = await $.ajax({
                        url: '../meenterprise-management/general-services.asmx/getSoApprovalLevelList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectapproval.empty();
                            selectapproval.append($('<option/>', { value: -1, text: 'ระบุผู้อนุมัติรายการ' }));
                            $(data).each(function (index, item) {
                                selectapproval.append($('<option/>', { value: item.imEmployeeGid, text: item.FullName }));
                            });
                        }
                    });
                    return result;
                };

                var selectgoodunit = $('#selectgoodunit');
                async function getGoodUnit() {
                    var result = await $.ajax({
                        url: '../meenterprise-management/general-services.asmx/getGoodUnitList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectgoodunit.empty();
                            selectgoodunit.append($('<option/>', { value: -1, text: 'ระบุหน่วยสินค้า' }));
                            $(data).each(function (index, item) {
                                selectgoodunit.append($('<option/>', { value: item.GoodUnitID, text: item.GoodUnitDesc }));
                            });
                        }
                    });
                    return result;
                }

                function getGoodCodeSelectList() {
                    $.ajax({
                        url: 'saleorder-services.asmx/getGoodCodeSelectList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {
                            $('#loader').show();
                            $("#tblgoodcodeselectitem tr td").remove();

                        },
                        success: function (data) {
                            var table;
                            table = $('#tblgoodcodeselectitem').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].GoodCodeID, data[i].GoodGroupID, data[i].GoodGroupDesc, data[i].GoodTypeID, data[i].GoodTypeDesc, data[i].GoodCode,
                                    data[i].GoodName, data[i].GoodColorID, data[i].GoodColorDesc, data[i].GoodUnitID, data[i].GoodUnitDesc, data[i].Price1, data[i].Price2, data[i].Price3,
                                    data[i].PurLeadTime, data[i].GoodWeight, data[i].GoodWidth, data[i].GoodLength, data[i].GoodHeight, data[i].GoodStatID, data[i].GoodStatDesc,
                                    data[i].activeid, data[i].activename, data[i].UserCreate, data[i].CreateDate, data[i].UserUpdate, data[i].LasteDate, data[i].edit]);
                                });
                            }
                            table.draw();
                            $('#loader').hide();

                            $('#tblgoodcodeselectitem tbody').on('click', 'td', function (e) {
                                e.preventDefault();

                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;

                                //console.log(rIndex + ':' + cIndex);
                                var goodcodeid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                var goodgroupid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var goodgroupdesc = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var goodtypeid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(3)');
                                var goodtypedesc = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(4)');
                                var goodcode = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(5)');
                                var goodname = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(6)');
                                var goodcolorid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(7)');
                                var goodcolordesc = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(8)');
                                var goodunitid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(9)');
                                var goodunitdesc = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(10)');
                                var price1 = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(11)');
                                var price2 = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(12)');
                                var price3 = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(13)');
                                var purleadtime = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(14)');
                                var goodweight = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(15)');
                                var goodwidth = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(15)');
                                var goodlength = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(17)');
                                var goodheight = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(18)');
                                var goodstatid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(19)');
                                var goodstatdesc = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                //console.log(gid.text());
                                if (rIndex != 0 & cIndex == 27) {
                                    // alert(goodcodeid.text())
                                    //window.location.href = "so-quotation-edit.aspx?opt=optsoe&mod=edit&gid=" + gid.text();
                                    //getQuotationAddnewItem();
                                }
                            });

                            $('#tblgoodcodeselectitem tbody').on('dblclick', 'td', function (e) {
                                e.preventDefault();

                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;

                                //console.log(rIndex + ':' + cIndex);
                                var pgoodcodeid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                var goodgroupid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var goodgroupdesc = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var goodtypeid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(3)');
                                var goodtypedesc = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(4)');
                                var goodcode = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(5)');
                                var pgoodname = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(6)');
                                var goodcolorid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(7)');
                                var goodcolordesc = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(8)');
                                var pgoodunitid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(9)');
                                var pgoodunitdesc = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(10)');
                                var price1 = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(11)');
                                var price2 = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(12)');
                                var price3 = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(13)');
                                var purleadtime = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(14)');
                                var goodweight = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(15)');
                                var goodwidth = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(16)');
                                var goodlength = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(17)');
                                var goodheight = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(18)');
                                var goodstatid = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(19)');
                                var goodstatdesc = $("#tblgoodcodeselectitem").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                $('#pgoodcodeid').val(pgoodcodeid.text());
                                $('#pgoodname').val(pgoodname.text());
                                $('#pgoodunitid').val(pgoodunitid.text());
                                $('#pgoodunitdesc').val(pgoodunitdesc.text());





                                Swal.fire({
                                    title: '<span class="txtLabel">ต้องการเพิ่มข้อมูล ใช่หรือไม่..?</span>',
                                    //text: "You won't be able to revert this!",
                                    icon: 'warning',
                                    showCancelButton: true,
                                    cancelButtonColor: '#d33',
                                    confirmButtonColor: '#449d44',
                                    cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>',
                                    confirmButtonText: '<span class="txtLabel">บันทึกข้อมูล..!</span>'

                                }).then((result) => {
                                    if (result.isConfirmed) {

                                        //    getQuotationAddnewItem(pgid, pimbranchgid, pseqno, pqtgid, padqtno, pgoodcodeid, pgoodname, pgoodunitid, pgoodunitdesc, pquantity,
                                        //        ppriceperunit, pamount, pvatamount, pamountexcludevat, pdiscpercent, pdiscamount, pamountafterdisc, pnetamount, punitcostid,
                                        //punitcost, premark, paduserid, plastdate);
                                        getQuotationAddnewItem();

                                    }
                                })

                            });
                        }
                    })
                }

                function getQuotationAddnewItem() {
                    try {

                        var pgid = '0';
                        var pimbranchgid = $('#selectbranch').val();
                        var pseqno = '0';
                        var pqtgid = gid;
                        var padqtno = $('#docuno').text();
                        var pqtyunit = '-1';
                        var pqtyrema = '1.00';
                        var pquantity = '1.00';
                        var ppriceperunit = '0.00';
                        var pamount = '0.00';
                        var pvatamount = '0.00';
                        var pamountexcludevat = '0.00';
                        var pdiscpercent = '0.00';
                        var pdiscamount = '0.00';
                        var pamountafterdisc = '0.00';
                        var pnetamount = '0.00';
                        var punitcostid = '0.00';
                        var punitcost = '0.00';
                        var premark = null;
                        var paduserid = employeeid;
                        var plastdate = null;
                        var pattern = '-1';
                        var qtyextra = '1.00';

                        $.ajax({
                            url: 'saleorder-services.asmx/getQuotationAddnewItem',
                            method: 'post',
                            data: {
                                gid: pgid,
                                imbranchgid: pimbranchgid,
                                seqno: pseqno,
                                qtgid: pqtgid,
                                adqtno: padqtno,
                                goodcodeid: $('#pgoodcodeid').val(),
                                goodname: $('#pgoodname').val(),
                                goodunitid: $('#pgoodunitid').val(),
                                goodunitdesc: $('#pgoodunitdesc').val(),
                                qtyunit: pqtyunit,
                                qtyrema: pqtyrema,
                                quantity: pquantity,
                                priceperunit: ppriceperunit,
                                amount: pamount,
                                vatamount: pvatamount,
                                amountexcludevat: pamountexcludevat,
                                discpercent: pdiscpercent,
                                discamount: pdiscamount,
                                amountafterdisc: pamountafterdisc,
                                netamount: pnetamount,
                                unitcostid: punitcostid,
                                unitcost: punitcost,
                                remark: premark,
                                aduserid: paduserid,
                                lastdate: plastdate,
                                pattern: pattern,
                                qtyextra: qtyextra
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

                                getQuotationDetails(pqtgid);

                                $("#modalgoodcode").modal({ backdrop: false });
                                $('[id=modalgoodcode]').modal('hide');

                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                    }
                    catch (ex) {
                        console.log(ex.message);
                    }
                }

                async function getQuotationOrderById(id) {
                    try {

                        const result = await $.ajax({
                            url: 'saleorder-services.asmx/getQuotationOrderById',
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

                                        $('#selectbranch').val(data["imBranchGid"]);
                                        $('#selectbranch').change();

                                        $('#selectproject').val(data["ProjectID"]);
                                        $('#selectproject').change();

                                        $('#txtrefqtno').val(data["RefQTNO"]);

                                        $('#selectcustomer').val(data["VendorID"]);
                                        $('#selectcustomer').change();

                                        $('#vendoraddress').val(data["VendorAddr"]);
                                        $('#vendortaxid').val(data["VendorTaxID"]);
                                        $('#vendorbranchno').val(data["VendorBranchNo"]);

                                        $('#contactname').val(data["ContactName"]);
                                        $('#contacttel').val(data["ContactTel"]);

                                        $('#txtprojectname').val(data["ProjectName"]);
                                        $('#vendoremail').val(data["VendorEmail"]);

                                        $('#datestart').val(data["DocuDate"]);
                                        $('#datestop').val(data["DeliveryDate"]);

                                        $('#selectpayment').val(data["adPaymentTypeID"]);
                                        $('#selectpayment').change();

                                        $('#referdocuno').val(data["ReferDocuNo"]);

                                        $('#selectsource').val(data["SourceGid"])
                                        $('#selectsource').change();

                                        $('#selectapproval').val(data["ApproveID"])
                                        $('#selectapproval').change();

                                        var flagid = data["FlagID"];
                                        $('#hidflagid').val(flagid);

                                        if ((flagid == '3004') || (flagid == '3005')) {
                                            $('#docuno').addClass("text-red");
                                            $('#docstatus').addClass("text-red");
                                        }

                                        $('#txtamount').val(data["TotalAmount"]);
                                        $('#txtdispercenct').val(data["DiscPercent"]);
                                        $('#txtdisamount').val(data["DiscAmount"]);

                                        $('#txtafterdisamount').val(data["AmountExtraDisc"]);

                                        $('#txtvatpercent').val(data["VATAmount"]);
                                        $('#txtvatamount').val(data["TotalAmountExcludeVAT"]);
                                        $('#txttotalamount').val(data["TotalAmountAfterDisc"]);

                                        $('#docuno').text(data["adQTNO"]);
                                        $('#docstatus').text(data["FlagDesc"]);
                                        $('#qtremark').text(data["QTRemark"]);
                                        $('#qtcomment').text(data["QTComment"]);

                                        $('#hidqtgid').val(data["QtGid"]);
                                        $('#hiddocuno').val(data["adQTNO"]);

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

                async function getQuotationDetails(qtgid) {
                    try {

                        const result = await $.ajax({
                            url: 'saleorder-services.asmx/getQuotationDetails',
                            method: 'post',
                            data: {
                                qtgid: qtgid,
                            },
                            datatype: 'json',
                            beforeSend: function () {
                                $('#overlay').show();
                            },
                            success: function (data) {

                                var table;
                                table = $('#tblsoquotationitem').DataTable();
                                table.clear();

                                if (data != '') {
                                    $.each(data, function (i, item) {
                                        table.row.add([data[i].Gid, data[i].imBranchGid, data[i].SeqNO, data[i].QtGid, data[i].adQTNO, data[i].GoodGroupID, data[i].GoodGroupDesc,
                                        data[i].GoodCodeID, data[i].GoodCode, data[i].GoodName, data[i].GoodUnitID, data[i].GoodUnitDesc, data[i].Quantity, data[i].QtyUnit,
                                        data[i].QtyUnitDesc, data[i].QtyRema, data[i].Pattern, data[i].QtyExtra, data[i].PricePerUnit,
                                        data[i].Amount, data[i].VATAmount, data[i].AmountExcludeVAT, data[i].DiscPercent, data[i].DiscAmount, data[i].AmountAfterDisc, data[i].NetAmount,
                                        data[i].UnitCostID, data[i].UnitCost, data[i].Remark, data[i].adUserID, data[i].Lastdate, data[i].edit, data[i].trash]);
                                    });
                                }
                                table.draw();
                                $('#tblsoquotationitem td:nth-of-type(21)').addClass('text-red');
                                $('#tblsoquotationitem td:nth-of-type(22)').addClass('text-red');

                                $('#loader').hide();
                                $('#overlay').hide();

                                $('#tblsoquotationitem tbody').on('click', 'td', function (e) {
                                    e.preventDefault();

                                    rIndex = this.parentElement.rowIndex;
                                    cIndex = this.cellIndex;

                                    var gid = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                    var no = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                    var group = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(6)');
                                    var goodcode = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(8)');
                                    var goodname = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(9)');
                                    var unit = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(11)');
                                    var quantity = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(12)');

                                    var qtyunit = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(13)');
                                    var qtyunitdesc = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(14)');
                                    var qtyrema = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(15)');

                                    var pattern = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(16)');
                                    var amoutextra = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(17)');

                                    var unitprice = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(18)');
                                    var amount = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(19)');
                                    var percentdiscount = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(22)');
                                    var discount = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(23)');
                                    var amountafterdisc = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(24)');
                                    var remark = $("#tblsoquotationitem").find('tr:eq(' + rIndex + ')').find('td:eq(28)');



                                    if (rIndex != 0 & cIndex == 31) {
                                        console.log(gid.text());

                                        $('#hidgid').val(gid.text());
                                        $('#txtno').val(no.text());
                                        $('#txtgroup').val(group.text());
                                        $('#txtgoodcode').val(goodcode.text());
                                        $('#txtgoodname').val(goodname.text());

                                        $('#txtunit').val(unit.text().replace(',', ''));
                                        $('#txtquantity').val(quantity.text().replace(',', ''));


                                        $('#selectgoodunit').val(qtyunit.text());
                                        $('#selectgoodunit').change();
                                        $('#txtQtyRema').val(qtyrema.text().replace(',', ''));



                                        $('#txtunitprice').val(unitprice.text().replace(',', ''));
                                        $('#txtitemamount').val(amount.text().replace(',', ''));


                                        $('#txtitemprecentdiscount').val(percentdiscount.text().replace(',', ''));

                                        $('#txtitemdiscount').val(discount.text().replace(',', ''));
                                        $('#txtitemtotalamount').val(amountafterdisc.text().replace(',', ''));
                                        $('#txtitemremark').val(remark.text());

                                        $('#selectpattern').val(pattern.text());
                                        $('#selectpattern').change();

                                        $('#txtQtyExtra').val(amoutextra.text());


                                        $('#btnupdateitem').removeClass('hidden');
                                        $('#btndeleteitem').addClass('hidden');


                                        getQtRefItems($('#hidgid').val());


                                        $("#modaledititem").modal({ backdrop: false });
                                        $('#modaledititem').modal('show');

                                    }
                                    if (rIndex != 0 & cIndex == 32) {

                                        console.log(gid.text());

                                        $('#hidgid').val(gid.text());
                                        $('#txtno').val(no.text());
                                        $('#txtgroup').val(group.text());
                                        $('#txtgoodcode').val(goodcode.text());
                                        $('#txtgoodname').val(goodname.text());

                                        $('#txtunit').val(unit.text().replace(',', ''));

                                        $('#txtquantity').val(quantity.text().replace(',', ''));
                                        $('#txtunitprice').val(unitprice.text().replace(',', ''));
                                        $('#txtitemamount').val(amount.text().replace(',', ''));
                                        $('#txtitemdiscount').val(discount.text().replace(',', ''));
                                        $('#txtitemtotalamount').val(amountafterdisc.text().replace(',', ''));

                                        $('#selectpattern').val(pattern.text());
                                        $('#selectpattern').change();

                                        $('#txtitemtotalamountextra').val(amoutextra.text());

                                        $('#txtitemremark').val(remark.text());

                                        $('#btnupdateitem').addClass('hidden');
                                        $('#btndeleteitem').removeClass('hidden');

                                        getQtRefItems($('#hidgid').val());

                                        $("#modaledititem").modal({ backdrop: false });
                                        $('#modaledititem').modal('show');

                                    }

                                });
                            }
                        });

                        return result;
                    }
                    catch (error) {
                        console.log(error.message);
                    }
                }

                function getCustomerById(gid) {
                    $.ajax({
                        url: '../meenterprise-management/general-services.asmx/getVendorById',
                        method: 'post',
                        data: {
                            gid: gid
                        },
                        datatype: 'json',
                        beforeSend: function () {
                        },
                        success: function (data) {
                            var obj = jQuery.parseJSON(JSON.stringify(data));
                            if (obj != '') {
                                $.each(obj, function (i, data) {
                                    var vendoraddr1 = data["VendorAddr1"];
                                    var vendoraddr2 = data["VendorAddr2"];
                                    var district = data["District"];
                                    var taxid = data["TaxId"];

                                    $('#vendoraddress').val('');
                                    $('#vendoraddress').val(vendoraddr1 + ' ' + vendoraddr2 + ' ' + district);

                                    $('#vendortaxid').val('');
                                    $('#vendortaxid').val(taxid);

                                })
                            }

                        }
                    });

                };

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

                var btnsavedoc = $('#btnsavedoc');
                btnsavedoc.click(function () {
                    //validate input
                    var selectbranch = $('#selectbranch').val();
                    if (selectbranch == '-1') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุสาขา..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var selectproject = $('#selectproject').val();
                    if (selectproject == '-1') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุประเภทโครงการ..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var selectcustomer = $('#selectcustomer').val();
                    if (selectcustomer == '-1') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุชื่อลูกค้า..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var selectsource = $('#selectsource').val();
                    if (selectsource == '-1') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุแหล่งข้อมูล..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var contacttel = $('#contacttel').val();
                    if (contacttel == '') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุชื่อผู้ติดต่อ..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var txtprojectname = $('#txtprojectname').val();
                    if (txtprojectname == '') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุชื่อโครงการ..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var selectapproval = $('#selectapproval').val();
                    if (selectapproval == '-1') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุชื่อผู้อนุมัติรายการ..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    Swal.fire({

                        title: '<span class="txtLabel">ต้องการบันทึกข้อมูล ใช่หรือไม่..?</span>',
                        //text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonColor: '#d33',
                        confirmButtonColor: '#449d44',
                        cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>',
                        confirmButtonText: '<span class="txtLabel">บันทึกข้อมูล..!</span>'

                    }).then((result) => {
                        if (result.isConfirmed) {

                            $.ajax({
                                url: 'saleorder-services.asmx/getQuotationOrder',
                                method: 'post',
                                data: {
                                    acttrans: 'new',
                                    qtgid: null,
                                    imbranchgid: $('#selectbranch').val(),
                                    adqtno: null,
                                    refqtno: $('#txtrefqtno').val(),
                                    projectname: $('#txtprojectname').val(),
                                    projectid: $('#selectproject').val(),
                                    deliverydate: $('#datestop').val(),
                                    docudate: $('#datestart').val(),
                                    inyear: yyyy,
                                    vendorid: $('#selectcustomer').val(),
                                    vendorname: $('#selectcustomer option:selected').text(),
                                    vendoraddr: $('#vendoraddress').val(),
                                    vendortaxid: $('#vendortaxid').val(),
                                    sourcegid: $('#selectsource').val(),
                                    vendorbranchno: $('#vendorbranchno').val(),
                                    vendoremail: $('#vendoremail').val(),
                                    contactname: $('#contactname').val(),
                                    contacttel: $('#contacttel').val(),
                                    currencyrate: '1.00',
                                    adcurrencyid: '-1',
                                    currencydesc: 'บาท',
                                    totalamount: $('#txtamount').val(),
                                    vatamount: '0.00',
                                    totalamountexcludevat: '0.00',
                                    discpercent: $('#txtdispercenct').val(),
                                    discamount: $('#txtdisamount').val(),
                                    discextendpercent: '0.00',
                                    discextendamount: '0.00',
                                    amountextradisc: $('#txttotalamount').val(),
                                    totalamountafterdisc: '0.00',
                                    qtremark: $('#qtremark').val(),
                                    qtcomment: $('#qtcomment').val(),
                                    imdeliveryid: '-1',
                                    adpaymenttypeid: $('#selectpayment').val(),
                                    imemployeegid: employeeid,
                                    salepositionname: null,
                                    approveid: $('#selectapproval').val(),
                                    approvename: $('#selectapproval option:selected').text(),
                                    approvepositionid: null,
                                    approvepositionname: null,
                                    isdelete: '0',
                                    flagid: '3000',
                                    createdby: employeeid,
                                    createddate: null,
                                    updatedby: employeeid,
                                    updatedate: null,
                                    saleemail: '',
                                    referdocuno: $('#referdocuno').val()
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

                                    var obj = jQuery.parseJSON(JSON.stringify(data));
                                    var gid;
                                    if (obj != '') {
                                        $.each(obj, function (i, data) {
                                            gid = data["QtGid"];
                                        })
                                    }

                                    console.log(gid);

                                    setTimeout(function () {
                                        window.location.href = "so-truck-quotation-edit.aspx?opt=optsoe&mod=edit&gid=" + gid;
                                    }, 2000);
                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    })

                });

                var btnupdatedoc = $('#btnupdatedoc');
                btnupdatedoc.click(function () {
                    //validate input
                    var hidflagid = $('#hidflagid').val();
                    if (hidflagid == '3002') {
                        Swal.fire(
                            '<span class="txtLabel">เอกสารผ่านการอนุมัติแล้วไม่สามารถแก้ไขได้..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var selectbranch = $('#selectbranch').val();
                    if (selectbranch == '-1') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุสาขา..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var selectproject = $('#selectproject').val();
                    if (selectproject == '-1') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุประเภทโครงการ..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var selectcustomer = $('#selectcustomer').val();
                    if (selectcustomer == '-1') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุชื่อลูกค้า..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var selectsource = $('#selectsource').val();
                    if (selectsource == '-1') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุแหล่งข้อมูล..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var contacttel = $('#contacttel').val();
                    if (contacttel == '') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุชื่อผู้ติดต่อ..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var txtprojectname = $('#txtprojectname').val();
                    if (txtprojectname == '') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุชื่อโครงการ..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var selectapproval = $('#selectapproval').val();
                    if (selectapproval == '-1') {
                        Swal.fire(
                            '<span class="txtLabel">กรุณาระบุชื่อผู้อนุมัติรายการ..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    Swal.fire({

                        title: '<span class="txtLabel">ต้องการบันทึกข้อมูล ใช่หรือไม่..?</span>',
                        //text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonColor: '#d33',
                        confirmButtonColor: '#449d44',
                        cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>',
                        confirmButtonText: '<span class="txtLabel">บันทึกข้อมูล..!</span>'

                    }).then((result) => {
                        if (result.isConfirmed) {

                            $.ajax({
                                url: 'saleorder-services.asmx/getQuotationOrder',
                                method: 'post',
                                data: {
                                    acttrans: 'edit',
                                    qtgid: gid,
                                    imbranchgid: $('#selectbranch').val(),
                                    adqtno: $('#docuno').val(),
                                    refqtno: $('#txtrefqtno').val(),
                                    projectname: $('#txtprojectname').val(),
                                    projectid: $('#selectproject').val(),
                                    deliverydate: $('#datestop').val(),
                                    docudate: $('#datestart').val(),
                                    inyear: yyyy,
                                    vendorid: $('#selectcustomer').val(),
                                    vendorname: $('#selectcustomer option:selected').text(),
                                    vendoraddr: $('#vendoraddress').val(),
                                    vendortaxid: $('#vendortaxid').val(),
                                    sourcegid: $('#selectsource').val(),
                                    vendorbranchno: $('#vendorbranchno').val(),
                                    vendoremail: $('#vendoremail').val(),
                                    contactname: $('#contactname').val(),
                                    contacttel: $('#contacttel').val(),
                                    currencyrate: '1.00',
                                    adcurrencyid: '-1',
                                    currencydesc: 'บาท',
                                    totalamount: $('#txtamount').val(),
                                    vatamount: $('#txtvatpercent').val(),
                                    totalamountexcludevat: $('#txtvatamount').val(),
                                    discpercent: $('#txtdispercenct').val(),
                                    discamount: $('#txtdisamount').val(),
                                    discextendpercent: '0.00',
                                    discextendamount: '0.00',
                                    amountextradisc: $('#txtafterdisamount').val(),
                                    totalamountafterdisc: $('#txttotalamount').val(),
                                    qtremark: $('#qtremark').val(),
                                    qtcomment: $('#qtcomment').val(),
                                    imdeliveryid: '-1',
                                    adpaymenttypeid: $('#selectpayment').val(),
                                    imemployeegid: employeeid,
                                    salepositionname: null,
                                    approveid: $('#selectapproval').val(),
                                    approvename: $('#selectapproval option:selected').text(),
                                    approvepositionid: null,
                                    approvepositionname: null,
                                    isdelete: '0',
                                    flagid: '3000',
                                    createdby: employeeid,
                                    createddate: null,
                                    updatedby: employeeid,
                                    updatedate: null,
                                    saleemail: '',
                                    referdocuno: $('#referdocuno').val()
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

                                        //window.location.href = "so-quotation-edit.aspx?opt=optsoe&mod=edit&gid=" + gid;
                                        (async () => {
                                            await getQuotationOrderById(gid);
                                            await getQuotationDetails(gid);
                                        })();

                                    }, 1000);

                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    })
                })

                var btndeldoc = $('#btndeldoc');
                btndeldoc.click(function () {

                    var hidflagid = $('#hidflagid').val();
                    if (hidflagid == '3002') {
                        Swal.fire(
                            '<span class="txtLabel">เอกสารผ่านการอนุมัติแล้วไม่สามารถแก้ไขได้..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    Swal.fire({

                        title: '<span class="txtLabel">ต้องการลบข้อมูล ใช่หรือไม่..?</span>',
                        //text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonColor: '#d33',
                        confirmButtonColor: '#449d44',
                        cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>',
                        confirmButtonText: '<span class="txtLabel">ยืนยัน, ลบข้อมูล!</span>'

                    }).then((result) => {
                        if (result.isConfirmed) {

                            $.ajax({
                                url: 'saleorder-services.asmx/getQuotationOrder',
                                method: 'post',
                                data: {
                                    acttrans: 'del',
                                    qtgid: gid,
                                    imbranchgid: $('#selectbranch').val(),
                                    adqtno: $('#docuno').val(),
                                    refqtno: $('#txtrefqtno').val(),
                                    projectname: $('#txtprojectname').val(),
                                    projectid: $('#selectproject').val(),
                                    deliverydate: $('#datestop').val(),
                                    docudate: $('#datestart').val(),
                                    inyear: yyyy,
                                    vendorid: $('#selectcustomer').val(),
                                    vendorname: $('#selectcustomer option:selected').text(),
                                    vendoraddr: $('#vendoraddress').val(),
                                    vendortaxid: $('#vendortaxid').val(),
                                    sourcegid: $('#selectsource').val(),
                                    vendorbranchno: $('#vendorbranchno').val(),
                                    vendoremail: $('#vendoremail').val(),
                                    contactname: $('#contactname').val(),
                                    contacttel: $('#contacttel').val(),
                                    currencyrate: '1.00',
                                    adcurrencyid: '-1',
                                    currencydesc: 'บาท',
                                    totalamount: $('#txtamount').val(),
                                    vatamount: $('#txtvatpercent').val(),
                                    totalamountexcludevat: $('#txtvatamount').val(),
                                    discpercent: $('#txtdispercenct').val(),
                                    discamount: $('#txtdisamount').val(),
                                    discextendpercent: '0.00',
                                    discextendamount: '0.00',
                                    amountextradisc: $('#txtafterdisamount').val(),
                                    totalamountafterdisc: $('#txttotalamount').val(),
                                    qtremark: $('#qtremark').val(),
                                    qtcomment: $('#qtcomment').val(),
                                    imdeliveryid: '-1',
                                    adpaymenttypeid: $('#selectpayment').val(),
                                    imemployeegid: employeeid,
                                    salepositionname: null,
                                    approveid: $('#selectapproval').val(),
                                    approvename: $('#selectapproval option:selected').text(),
                                    approvepositionid: null,
                                    approvepositionname: null,
                                    isdelete: '0',
                                    flagid: '3000',
                                    createdby: employeeid,
                                    createddate: null,
                                    updatedby: employeeid,
                                    updatedate: null,
                                    saleemail: '',
                                    referdocuno: $('#referdocuno').val()

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
                                        window.location.href = "../mesales-order/so-truck-quotation-view.aspx?opt=optsoe";
                                    }, 2000);

                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    });
                })

                var btnsendmail = $('#btnsendmail');
                btnsendmail.click(function () {
                    var hidflagid = $('#hidflagid').val();
                    if (hidflagid == '3002') {
                        Swal.fire(
                            '<span class="txtLabel">เอกสารผ่านการอนุมัติแล้วไม่สามารถแก้ไขได้..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    Swal.fire({

                        title: '<span class="txtLabel">ต้องการส่งขออนุมัติรายการ ใช่หรือไม่..?</span>',
                        //text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonColor: '#d33',
                        confirmButtonColor: '#449d44',
                        cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>',
                        confirmButtonText: '<span class="txtLabel">ยืนยัน, ขออนุมัติ.!</span>'

                    }).then((result) => {
                        if (result.isConfirmed) {

                            $.ajax({
                                url: 'saleorder-services.asmx/getQuotationOrderStatus',
                                method: 'post',
                                data: {
                                    gid: gid,
                                    flagid: '3001'
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

                                        //window.location.href = "so-quotation-edit.aspx?opt=optsoe&mod=edit&gid=" + gid;
                                        (async () => {
                                            await getQuotationOrderById(gid);
                                            await getQuotationDetails(gid);
                                        })();

                                    }, 2000);

                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    })
                });

                var btnadditemnew = $('#btnadditemnew');
                btnadditemnew.click(function () {

                    var hidflagid = $('#hidflagid').val();
                    if (hidflagid == '3002') {
                        Swal.fire(
                            '<span class="txtLabel">เอกสารผ่านการอนุมัติแล้วไม่สามารถแก้ไขได้..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    $("#modalgoodcode").modal({ backdrop: false });
                    $('[id=modalgoodcode]').modal('show');
                });
                                
                var btnadditemtruck = $('#btnadditemtruck');
                btnadditemtruck.click(function () {

                    var hidflagid = $('#hidflagid').val();
                    if (hidflagid == '3002') {
                        Swal.fire(
                            '<span class="txtLabel">เอกสารผ่านการอนุมัติแล้วไม่สามารถแก้ไขได้..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    var cusname = $('#selectcustomer option:selected').text();

                    $('#txtsearch').val(cusname);

                    var refid = $('#hidgid').val();

                    //alert(refid);


                    $("#modalrefitemtruck").modal({ backdrop: false });
                    $('[id=modalrefitemtruck]').modal('show');

                })

                var btnloadticket = $('#btnloadticket');
                btnloadticket.click(function () {

                    var hidflagid = $('#hidflagid').val();
                    if (hidflagid == '3002') {
                        Swal.fire(
                            '<span class="txtLabel">เอกสารผ่านการอนุมัติแล้วไม่สามารถแก้ไขได้..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    //alert('you click');   

                    $.ajax({
                        url: 'saleorder-services.asmx/GetTruckRefItems',
                        method: 'post',
                        data: {
                            sdate: $('#datestarttruck').val(),
                            edate: $('#datestoptruck').val(),
                            search: $('#txtsearch').val()                          
                        },
                        datatype: 'json',
                        beforSend: function () {

                             $('#loader').show();
                        },
                        success: function (data) {
                           var table;
                            table = $('#tblreftrucktrip').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].COMNAME, data[i].TICKET2, data[i].TRUCK, data[i].DAYOUT2, data[i].TMOUT, data[i].PRODUCT, data[i].PRONAME,
                                    data[i].W1, data[i].W2, data[i].WNET, data[i].PRICE, data[i].AMOUNT, data[i].CHK]);
                                });
                            }
                            table.draw();
                            $('#loader').hide();
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                });

                var chkall = $('#chkall');
                chkall.click(function () {
                    //alert('check..');


                    var chk = $('#chkall').is(':checked');
                    //alert(chk);

                    var table = $('#tblreftrucktrip').DataTable();

                    if (chk == true) {
                        $("input", table.rows({ search: 'applied' }).nodes()).each(function () {
                            $(this).prop("checked", true);
                        });
                    }
                    else {
                        $("input", table.rows({ search: 'applied' }).nodes()).each(function () {
                            $(this).prop("checked", false);
                        });
                    }
                    
                });

                var btnadditemreftruck = $('#btnadditemreftruck');
                btnadditemreftruck.click(function () {
                    var table = $('#tblreftrucktrip').DataTable();

                    var arr = [];
                    var arrname = [];

                    var chkvalues = table.$('input:checked').each(function () {
                        arr.push($(this).attr('id'));
                        arrname.push($(this).attr('name'));
                    });

                    arr = arr.toString();
                    arrname = arrname.toString();

                    var result = arr.split(",");

                    var qtgid = param["gid"];
                    var hidgid = $('#hidgid').val();
                    var empgid = '<%= Session["imEmployeeGid"] %>';

                    $('#txttruckrefno').val(result);
                    //alert(result);                                        

                    // todo somthing here......                   
                                        
                        Swal.fire({
                            title: '<span class="txtLabel">ต้องการบันทึกข้อมูล ใช่หรือไม่..?</span>',
                            //text: "You won't be able to revert this!",
                            icon: 'warning',
                            showCancelButton: true,
                            cancelButtonColor: '#d33',
                            confirmButtonColor: '#449d44',
                            cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>',
                            confirmButtonText: '<span class="txtLabel">เพิ่มข้อมูลอ้างอิง</span>'

                        }).then((result) => {
                            if (result.isConfirmed) {
                                $.ajax({
                                    url: 'saleorder-services.asmx/GetUpdateTruckRefItems',
                                    method: 'post',
                                    data: {
                                        acttrans: 'edit',
                                        qtgid: qtgid,
                                        gid: hidgid,
                                        refno:  $('#txttruckrefno').val(),
                                        usrupdate: empfullname
                                    },
                                    datatype: 'json',
                                    beforSend: function () {
                                        $('#overlay').show();
                                    },
                                    success: function (data) {
                                        Swal.fire(
                                            '<span class="txtLabel">บันทึกข้อมูลสำเร็จ..!</span>',
                                            '',
                                            'success'
                                        );

                                        //(async () => {
                                        //    await getQuotationOrderById(gid);
                                        //    await getQuotationDetails(gid);
                                        //})();



                                        //get sum total weight...
                                        getQtrefItemsSumWeight(hidgid);

                                        //show item details....
                                        getQtRefItems(hidgid);



                                        $("#modalrefitemtruck").modal({ backdrop: false });
                                        $('[id=modalrefitemtruck]').modal('hide');

                                        $('#overlay').hide();

                                    },
                                    error: function (xhr, ajaxOptions, thrownError) {
                                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                    }
                                });
                            }
                        })

                              
                });


                var btnupdateitem = $('#btnupdateitem');
                btnupdateitem.click(function () {

                    var hidflagid = $('#hidflagid').val();
                    if (hidflagid == '3002') {
                        Swal.fire(
                            '<span class="txtLabel">เอกสารผ่านการอนุมัติแล้วไม่สามารถแก้ไขได้..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    Swal.fire({

                        title: '<span class="txtLabel">ต้องการบันทึกข้อมูล ใช่หรือไม่..?</span>',
                        //text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonColor: '#d33',
                        confirmButtonColor: '#449d44',
                        cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>',
                        confirmButtonText: '<span class="txtLabel">บันทึกข้อมูล..!</span>'

                    }).then((result) => {
                        if (result.isConfirmed) {

                            $.ajax({
                                url: 'saleorder-services.asmx/getQuotationItemUpdate',
                                method: 'post',
                                data: {
                                    acttrans: 'edit',
                                    QtGid: gid,
                                    gid: $('#hidgid').val(),
                                    seqno: $('#txtno').val(),
                                    QtyUnit: $('#selectgoodunit').val(),
                                    QtyRema: $('#txtQtyRema').val(),
                                    Quantity: $('#txtquantity').val(),
                                    PricePerUnit: $('#txtunitprice').val(),
                                    Amount: $('#txtitemamount').val(),
                                    DiscPercent: $('#txtitemprecentdiscount').val(),
                                    DiscAmount: $('#txtitemdiscount').val(),
                                    AmountAfterDisc: $('#txtitemtotalamount').val(),
                                    Remark: $('#txtitemremark').val(),
                                    adUserID: employeeid,
                                    Lastdate: null,
                                    Pattern: $('#selectpattern').val(),
                                    QtyExtra: $('#txtQtyExtra').val()

                                },
                                datatype: 'json',
                                beforSend: function () {

                                },
                                success: function (data) {
                                    Swal.fire(
                                        '<span class="txtLabel">บันทึกข้อมูลสำเร็จ..!</span>',
                                        '',
                                        'success'
                                    );

                                    (async () => {
                                        await getQuotationOrderById(gid);
                                        await getQuotationDetails(gid);
                                    })();

                                    $("#modaledititem").modal({ backdrop: false });
                                    $("#modaledititem").modal('hide');

                                    //setTimeout(function () {
                                    //    window.location.href = "so-quotation-edit.aspx?opt=optsoe&mod=edit&gid=" + gid;
                                    //}, 2000);
                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    })
                })

                var btndeleteitem = $('#btndeleteitem');
                btndeleteitem.click(function () {

                    var hidflagid = $('#hidflagid').val();
                    if (hidflagid == '3002') {
                        Swal.fire(
                            '<span class="txtLabel">เอกสารผ่านการอนุมัติแล้วไม่สามารถแก้ไขได้..!</span>',
                            '',
                            'error'
                        )
                        return;
                    }

                    Swal.fire({

                        title: '<span class="txtLabel">ต้องการลบข้อมูลรายการ ใช่หรือไม่..?</span>',
                        //text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonColor: '#d33',
                        confirmButtonColor: '#449d44',
                        cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>',
                        confirmButtonText: '<span class="txtLabel">บันทึกข้อมูล..!</span>'

                    }).then((result) => {
                        if (result.isConfirmed) {

                            $.ajax({
                                url: 'saleorder-services.asmx/getQuotationItemUpdate',
                                method: 'post',
                                data: {
                                    acttrans: 'del',
                                    QtGid: gid,
                                    gid: $('#hidgid').val(),
                                    seqno: $('#txtno').val(),

                                    QtyUnit: $('#selectgoodunit').val(),
                                    QtyRema: $('#txtQtyRema').val(),

                                    Quantity: $('#txtquantity').val(),
                                    PricePerUnit: $('#txtunitprice').val(),
                                    Amount: $('#txtitemamount').val(),
                                    DiscPercent: $('#txtitemprecentdiscount').val(),
                                    DiscAmount: $('#txtitemdiscount').val(),
                                    AmountAfterDisc: $('#txtitemtotalamount').val(),
                                    Remark: $('#txtitemremark').val(),
                                    adUserID: employeeid,
                                    Lastdate: null,
                                    Pattern: $('#selectpattern').val(),
                                    QtyExtra: $('#txtQtyExtra').val()

                                },
                                datatype: 'json',
                                beforSend: function () {

                                },
                                success: function (data) {
                                    Swal.fire(
                                        '<span class="txtLabel">บันทึกข้อมูลสำเร็จ..!</span>',
                                        '',
                                        'success'
                                    );

                                    (async () => {
                                        await getQuotationOrderById(gid);
                                        await getQuotationDetails(gid);
                                    })();

                                    $("#modaledititem").modal({ backdrop: false });
                                    $("#modaledititem").modal('hide');

                                    //setTimeout(function () {
                                    //    window.location.href = "so-quotation-edit.aspx?opt=optsoe&mod=edit&gid=" + gid;
                                    //}, 2000);
                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    })
                })

                var btncopydocuno = $('#btncopydocuno');
                btncopydocuno.click(function () {
                    var qtgid = gid;
                    var docuno = $('#docuno').text();
                    //alert(docuno);

                    Swal.fire({

                        title: '<span class="txtLabel">ต้องการคัดลอกใบเสนอราคา ' + docuno + ' ใช่หรือไม่..?</span>',
                        //text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonColor: '#d33',
                        confirmButtonColor: '#449d44',
                        cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>',
                        confirmButtonText: '<span class="txtLabel">บันทึกข้อมูล..!</span>'

                    }).then((result) => {
                        if (result.isConfirmed) {
                            $.ajax({
                                url: 'saleorder-services.asmx/getQuotationCopyTrans',
                                method: 'post',
                                data: {
                                    qtgid: qtgid,
                                    docuno: docuno
                                },
                                datatype: 'json',
                                beforSend: function () {

                                },
                                success: function (data) {
                                    Swal.fire(
                                        '<span class="txtLabel">บันทึกข้อมูลสำเร็จ..!</span>',
                                        '',
                                        'success'
                                    );
                                    setTimeout(function () {
                                        window.location.href = "../mesales-order/so-quotation-view.aspx?opt=optsoe";
                                    }, 2000);
                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    })

                });

                var chkdisc = $('#chkdisc');
                chkdisc.click(function () {
                    var chk = $('#chkdisc').is(':checked');
                    //alert('click check discount.. : ' + chk);

                    if (chk == true) {
                        //alert('true');
                        $('#txtdisamount').removeAttr('disabled');
                        $('#txtdispercenct').attr('disabled', 'disabled');
                        myCalcTotal();

                    } else {
                        //alert('false');
                        $('#txtdisamount').attr('disabled', 'disabled');
                        $('#txtdispercenct').removeAttr('disabled');
                        myCalcTotal();
                    }

                });

                var txtquantity = document.getElementById('txtquantity');
                var txtunitprice = document.getElementById('txtunitprice');
                var txtitemamount = document.getElementById('txtitemamount');
                var txtitemdiscount = document.getElementById('txtitemdiscount');
                var txtitemtotalamount = document.getElementById('txtitemtotalamount');

                var txtdispercenct = document.getElementById('txtdispercenct');
                var txtamount = document.getElementById('txtamount');

                txtquantity.addEventListener('keyup', myFunc);
                txtunitprice.addEventListener('keyup', myFunc);
                txtitemamount.addEventListener('keyup', myFunc);
                txtitemdiscount.addEventListener('keyup', myFunc);
                txtitemtotalamount.addEventListener('keyup', myFunc);

                txtdispercenct.addEventListener('keyup', myFunc);
                txtamount.addEventListener('keyup', myFunc);

                function myFunc(e) {
                    var val = this.value;
                    var re = /^([0-9]+[\.]?[0-9]?[0-9]?|[0-9]+)$/g;
                    var re1 = /^([0-9]+[\.]?[0-9]?[0-9]?|[0-9]+)/g;
                    if (re.test(val)) {
                        //do something here

                    } else {
                        val = re1.exec(val);
                        if (val) {
                            this.value = val[0];

                        } else {
                            this.value = "";
                        }
                    }
                }

                var chkdiscount = $('#chkitemdiscount');
                chkdiscount.click(function () {

                    //var chk = $('#chkitemdiscount').prop('checked');
                    //if (chk == true) {
                    //    alert('checked');
                    //}
                    $('#txtitemprecentdiscount').val('0.00');
                    $('#txtitemdiscount').val('0.00');

                    myCalc();

                })

                var selectpattern = $('#selectpattern');
                selectpattern.change(function () {
                    var itemrema = $('#txtQtyRema').val();
                    var selectpattern = $('#selectpattern');
                    var selpatt = selectpattern.val();
                    var itemextra;

                    if (selpatt == 'R') {
                        //Random -- > 5%
                        itemextra = parseFloat(itemrema) + (parseFloat(itemrema) * 0.05);

                    } else if (selpatt == 'B') {
                        //Brick -- > 10%
                        itemextra = parseFloat(itemrema) + (parseFloat(itemrema) * 0.10);
                    } else if (selpatt == 'H') {
                        //Herringbone -- > 20%
                        itemextra = parseFloat(itemrema) + (parseFloat(itemrema) * 0.20);
                    } else if (selpatt == 'C') {
                        //Chevron -- > 20%
                        itemextra = parseFloat(itemrema) + (parseFloat(itemrema) * 0.20);
                    }
                    else {

                        itemextra = parseFloat(itemrema);
                    }

                    $('#txtQtyExtra').val(itemextra.toFixed(2));

                    myCalc();

                });

            });

            function myCalc() {
                try {
                    //console.log($('#txtquantity').val());
                    //txtunitprice.val();
                    //txtitemamount.val();
                    //txtitemdiscount.val();
                    //txtitemtotalamount.val();

                    var quantity = $('#txtquantity').val();

                    var qtyrema = $('#txtQtyRema').val();
                    var unitprice = $('#txtunitprice').val();


                    var itemrema = $('#txtQtyRema').val();
                    var selectpattern = $('#selectpattern');
                    var selpatt = selectpattern.val();
                    var itemextra;

                    if (selpatt == 'R') {
                        //Random -- > 5%
                        itemextra = parseFloat(itemrema) + (parseFloat(itemrema) * 0.05);

                    } else if (selpatt == 'B') {
                        //Brick -- > 10%
                        itemextra = parseFloat(itemrema) + (parseFloat(itemrema) * 0.10);
                    } else if (selpatt == 'H') {
                        //Herringbone -- > 20%
                        itemextra = parseFloat(itemrema) + (parseFloat(itemrema) * 0.20);
                    } else if (selpatt == 'C') {
                        //Chevron -- > 20%
                        itemextra = parseFloat(itemrema) + (parseFloat(itemrema) * 0.20);
                    }
                    else {

                        itemextra = parseFloat(itemrema);
                    }

                    $('#txtQtyExtra').val(itemextra.toFixed(2));


                    var amount = parseFloat(itemextra) * parseFloat(unitprice); // $('#txtitemamount').val();
                    $('#txtitemamount').val(amount.toFixed(2));

                    var chk = $('#chkitemdiscount').prop('checked');
                    console.log(chk);

                    var perdiscount = $('#txtitemprecentdiscount').val();
                    var caldiscount = 0;

                    if (chk == true) {

                        caldiscount = parseFloat(amount) * (parseFloat(perdiscount) / 100);
                        $('#txtitemdiscount').val(caldiscount.toFixed(2));
                        //console.log(caldiscount);
                    }
                    else {
                        $('#txtitemprecentdiscount').val(0.00);
                    }



                    var discount = $('#txtitemdiscount').val();

                    var totalmount = parseFloat(amount) - parseFloat(discount);
                    $('#txtitemtotalamount').val(totalmount.toFixed(2));

                    // console.log(totalmount.toLocaleString());


                }
                catch {

                }

            }

            function myCalcTotal() {
                try {
                    var chk = $('#chkdisc').is(':checked');

                    if (chk == false) {
                        //case cal percentage discount...
                        console.log(chk);

                        var amount = $('#txtamount').val().replace(',', '');
                        var amount = $('#txtamount').val().replace(',', '');
                        var dispercent = $('#txtdispercenct').val().replace(',', '');
                        var dispamount = parseFloat(amount) * (parseFloat(dispercent) / 100);
                        var dispamount2 = dispamount.toFixed(2);
                        $('#txtdisamount').val(dispamount2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));


                        var afterdisamount = parseFloat(amount) - parseFloat(dispamount);
                        var afterdisamount2 = afterdisamount.toFixed(2);
                        $('#txtafterdisamount').val(afterdisamount2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

                        var vatpercent = $('#txtvatpercent').val();
                        var vatamount = parseFloat(afterdisamount) - (parseFloat(afterdisamount) * 100 / 107); // * (parseFloat(vatpercent) / 100);
                        var vatamount2 = vatamount.toFixed(2);
                        $('#txtvatamount').val(vatamount2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

                        var totalamount = parseFloat(afterdisamount) - parseFloat(vatamount);  //parseFloat(afterdisamount) + parseFloat(vatamount);
                        var totalamount2 = totalamount.toFixed(2);
                        $('#txttotalamount').val(totalamount2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

                    } else {
                        //case cal from amount discount...
                        console.log(chk);

                        var amount = $('#txtamount').val().replace(',', '');
                        var discount = $('#txtdisamount').val().replace(',', '');

                        //var dispamount = parseFloat(amount) - parseFloat(discount);
                        //var dispamount2 = dispamount.toFixed(2);
                        $('#txtdisamount').val(discount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

                        //$('#txtdispercenct').val('0.00');

                        var afterdisamount = parseFloat(amount) - parseFloat(discount);
                        var afterdisamount2 = afterdisamount.toFixed(2);
                        $('#txtafterdisamount').val(afterdisamount2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

                        var vatpercent = $('#txtvatpercent').val();
                        var vatamount = parseFloat(afterdisamount) * (parseFloat(vatpercent) / 100);
                        var vatamount2 = vatamount.toFixed(2);
                        $('#txtvatamount').val(vatamount2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

                        var totalamount = parseFloat(afterdisamount) + parseFloat(vatamount);
                        var totalamount2 = totalamount.toFixed(2);
                        $('#txttotalamount').val(totalamount2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

                    }



                }
                catch{

                }
            }

            function getQtrefItemsSumWeight(gid) {
                $.ajax({
                    url: 'saleorder-services.asmx/GetQtRefItemsSumWeight',
                    method: 'post',
                    data: {
                        gid: gid
                    },
                    datatype: 'json',
                    beforSend: function () {
                        $('#loader').show();
                    },
                    success: function (data) {
                        var obj = jQuery.parseJSON(JSON.stringify(data));
                        if (obj != '') {
                            $.each(obj, function (i, data) {
                                $('#txtquantity').val(data["WNET"]);
                                $('#txtQtyRema').val(data["WNET"]);
                            })
                        }

                        myCalc();
                        myCalcTotal();

                        $('#loader').hide();
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }

            function getQtRefItems(gid) {
                $.ajax({
                        url: 'saleorder-services.asmx/GetQtRefItems',
                        method: 'post',
                        data: {
                            gid: gid                        
                        },
                        datatype: 'json',
                        beforSend: function () {

                             $('#loader').show();
                        },
                        success: function (data) {
                           var table;
                            table = $('#tbltrucktrip').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].ID, data[i].COMNAME, data[i].TICKET2, data[i].TRUCK, data[i].DAYOUT, data[i].TMOUT, data[i].PRODUCT, data[i].PRODUCTNAME,
                                    data[i].W1, data[i].W2, data[i].WNET, data[i].PRICE, data[i].AMOUNT, data[i].CHK]);
                                });
                            }
                            table.draw();
                            $('#loader').hide();

                            $('#tbltrucktrip tbody').on('click', 'td', function (e) {
                                e.preventDefault();

                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;

                                var id = $("#tbltrucktrip").find('tr:eq(' + rIndex + ')').find('td:eq(0)');

                                if (rIndex != 0 & cIndex == 13) {

                                    //console.log(gid.text());

                                    //$('#hidgid').val(gid.text());

                                    $.ajax({
                                        url: 'saleorder-services.asmx/GetQtRefItemsDelete',
                                        method: 'post',
                                        data: {
                                            gid: id.text()
                                        },
                                        datatype: 'json',
                                        beforSend: function () {
                                            $('#loader').show();
                                        },
                                        success: function (data) {
                                            getQtrefItemsSumWeight(gid);
                                            getQtRefItems(gid);

                                            myCalc();
                                            myCalcTotal();
                                        },
                                        error: function (xhr, ajaxOptions, thrownError) {
                                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                        }
                                    });
                                }
                            });
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
            };
        </script>

        <h1>ใบเสนอราคาสินค้า           
            <span>
                <input type="hidden" id="hidflagid" name="hidflagid" />
                <input type="hidden" id="hidqtgid" name="hidqtgid" />
                <input type="hidden" id="hiddocuno" name="hiddocuno" />
                <span class="btn btn-docuno outline btn-lg pull-right text-bold " style="margin-right: 0px"><span id="docuno">QT0000000</span></span>
            </span>
            <span>
                <span class="btn btn-docuno outline btn-lg pull-right text-bold " style="margin-right: 5px"><span id="docstatus">กำลังดำเนินการ</span></span>
            </span>
        </h1>
    </section>

    <section class="content">
        <div id="overlay">
            <div class="cv-spinner">
                <span class="spinner"></span>

            </div>
        </div>
        <%-- section customer--%>
        <div class="row">
            <div class="col-md-12">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-gears text-orange"></i>

                            <span class="btn-group pull-right">

                                <button type="button" id="btnPdf1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">ข้อมูลลูกค้า</label>
                        </div>

                        <div class="box-body">
                           
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="txtLabel">บริษัทฯ/สาขา</label>
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectbranch" class="form-control input-sm " style="width: 100%">
                                                <option value="-1">กรุณาระบุชื่อสาขา</option>
                                            </select>
                                        </span>

                                    </div>

                                    <div class="form-group" style="margin-top: -10px">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectproject" class="form-control input-sm " style="width: 100%">
                                                <option value="-1">กรุณาระบุประเภทโครงการ</option>
                                            </select>
                                        </span>
                                    </div>

                                    <div class="form-group" style="margin-top: -10px">
                                        <input type="text" class="form-control" id="txtrefqtno" name="txtrefqtno" value="" placeholder="เลขที่ใบเสนอราคา" autocomplete="off">
                                    </div>
                                    <div class="form-group" style="margin-top: -10px">

                                        <input type="button" id="btncopydocuno" class="btn btn-primary outline btn-block text-bold " style="padding: 5px 10px" name="name" value=" # คัดลอกใบเสนอราคา" />
                                    </div>

                                </div>

                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="txtLabel">เลือกลูกค้า</label>
                                        <input type="hidden" id="hiddencustomer" />
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectcustomer" name="selectcustomer" class="form-control input-sm " style="width: 100%">
                                                <option value="-1">กรุณาระบุชื่อลูกค้า</option>
                                            </select>
                                        </span>
                                    </div>

                                    <div class="form-group" style="margin-top: -10px">
                                        <%--<input type="text" class="form-control input-md" name="name" value="" placeholder="ที่อยู่ลูกค้า" autocomplete="off" />--%>
                                        <textarea class="form-control input-md txtLabel" id="vendoraddress" name="vendoraddress" rows="3" placeholder="ที่อยู่ลูกค้า"></textarea>
                                    </div>

                                    <div class="row" style="margin-top: -10px;">
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="vendortaxid" name="vendortaxid" value="" placeholder="เลขที่ผู้เสียภาษี" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="vendorbranchno" name="vendorbranchno" value="" placeholder="สำนักงาน/สาขาเลขที่" autocomplete="off">
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="col-md-3">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="txtLabel">ชื่อผู้ติดต่อ</label>
                                                <input type="text" class="form-control" id="contactname" name="contactname" value="" placeholder="ชื่อผู้ติดต่อ" autocomplete="off">
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="txtLabel">เบอร์ติดต่อ</label>
                                                <input type="text" class="form-control" id="contacttel" name="contacttel" value="" placeholder="เบอร์ติดต่อ" autocomplete="off">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group" style="margin-top: -10px;">
                                                <textarea class="form-control input-md txtLabel" id="txtprojectname" name="txtprojectname" rows="1" placeholder="ชื่อโครงการ / รายละเอียด"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group" style="margin-top: -10px;">
                                                <span class="txtLabel " style="width: 100%">
                                                    <select id="selectsource" name="selectsource" class="form-control input-sm " style="width: 100%">
                                                        <option value="-1">กรุณาระบุแหล่งอ้างอิง</option>
                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group" style="margin-top: -10px;">
                                                <input type="text" class="form-control" id="vendoremail" name="vendoremail" value="" placeholder="อีเมล์แอดเดรส" autocomplete="off">
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="txtLabel">วันที่ทำรายการ</label>
                                                <div class="input-group date">
                                                    <input type="text" class="form-control input-md pull-left txtLabel" id="datestart" name="datestart" value="" autocomplete="off">
                                                    <div class="input-group-addon input-sm">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="txtLabel">วันที่ครบกำหนด</label>
                                                <div class="input-group date">
                                                    <input type="text" class="form-control input-md pull-left txtLabel" id="datestop" name="datestop" value="" autocomplete="off">
                                                    <div class="input-group-addon input-sm">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group" style="margin-top: -10px">
                                                <span class="txtLabel ">
                                                    <select id="selectpayment" class="form-control input-sm " style="width: 100%">
                                                        <option value="-1">ระบุการชำระเงิน</option>
                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group" style="margin-top: -10px">
                                                <input type="text" class="form-control" id="referdocuno" name="referdocuno" value="" placeholder="เลขที่เอกสารอ้างอิง" autocomplete="off">
                                            </div>
                                        </div>

                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group" style="margin-top: -10px">
                                                <span class="txtLabel ">
                                                    <select id="selectapproval" class="form-control input-sm " style="width: 100%">
                                                        <option value="-1">ผู้อนุมัติรายการ</option>
                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                </div>



                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--section items--%>
        <div class="row">
            <div class="col-md-12">
                <div class="">
                    <div class="box box-solid">

                        <div class="box-body">
                            <%--<div class="cv-spinner" id="loader">
                                <span class="spinner"></span>
                            </div>--%>
                            <input type="button" class="btn btn-primary outline text-bold " id="btnadditemnew" style="padding: 2px 10px" name="name" value=" + เพิ่มรายการ" />
                            <table id="tblsoquotationitem" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <%--<th style="width: 50px; text-align: center;">ลำดับ</th>
                                        <th style="width: 150px; text-align: center;">ประเภท</th>
                                        <th style="width: 150px; text-align: center;">สินค้า</th>
                                        <th style="text-align: center;">รายละเอียด</th>
                                        <th style="width: 80px; text-align: right;">จำนวน</th>
                                        <th style="width: 80px; text-align: right;">หน่วย</th>
                                        <th style="width: 80px; text-align: right;">ราคาต่อหน่วย</th>
                                        <th style="width: 80px; text-align: right;">ส่วนลด</th>
                                        <th style="width: 100px; text-align: right;">รวมเป็นเงิน</th>
                                        <th style="width: 30px; text-align: right;">#</th>
                                        <th style="width: 30px; text-align: right;">#</th>--%>

                                        <th style="width: 50px; text-align: center;">Gid</th>
                                        <th style="width: 50px; text-align: center;">imBranchGid</th>
                                        <th style="width: 50px; text-align: center;">ลำดับ</th>
                                        <th style="width: 50px; text-align: center;">QtGid</th>
                                        <th style="width: 50px; text-align: center;">adQTNO</th>
                                        <th style="width: 50px; text-align: center;">GoodGroupID</th>
                                        <th style="width: 100px; text-align: center;">กลุ่ม</th>
                                        <th style="width: 50px; text-align: center;">GoodCodeID</th>
                                        <th style="width: 100px; text-align: center;">รหัสสินค้า</th>
                                        <th class="" style="width: 100%; text-align: center;">ชื่อสินค้า</th>
                                        <th style="width: 50px; text-align: center;">GoodUnitID</th>
                                        <th style="width: 50px; text-align: center;">หน่วย</th>
                                        <th style="width: 100px; text-align: right;">จำนวน</th>

                                        <th style="width: 50px; text-align: center;">QTYUNIT</th>
                                        <th style="width: 50px; text-align: center;">หน่วย</th>
                                        <th style="width: 100px; text-align: right;">จำนวนซื้อ</th>
                                        <th style="width: 50px; text-align: center;">Pattern</th>
                                        <th style="width: 50px; text-align: right;">จำนวนเพิ่ม</th>

                                        <th style="width: 100px; text-align: right;">ราคา/หน่วย</th>
                                        <th style="width: 100px; text-align: right;">จำนวนรวม</th>
                                        <th style="width: 50px; text-align: center;">VATAmount</th>
                                        <th style="width: 50px; text-align: center;">AmountExcludeVAT</th>
                                        <th style="width: 50px; text-align: center;">ส่วนลด(%)</th>
                                        <th style="width: 100px; text-align: right;">ส่วนลด</th>
                                        <th style="width: 100px; text-align: right;">ยอดเงินรวม</th>
                                        <th style="width: 50px; text-align: center;">NetAmount</th>
                                        <th style="width: 50px; text-align: center;">UnitCostID</th>
                                        <th style="width: 50px; text-align: center;">UnitCost</th>
                                        <th style="width: 50px; text-align: center;">Remark</th>
                                        <th style="width: 50px; text-align: center;">adUserID</th>
                                        <th style="width: 50px; text-align: center;">Lastdate</th>

                                        <th style="width: 30px; text-align: center;">#</th>
                                        <th style="width: 30px; text-align: center;">#</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <%-- <tr>
                                        <td style="width: 50px; text-align: center;">1</td>
                                        <td style="text-align: center;">วัสดุติดตั้ง</td>
                                        <td style="text-align: center;">100-MO-1523-8</td>
                                        <td style="text-align: center;">Multilayer OakMO-1523-8</td>
                                        <td style="width: 80px; text-align: right;">2</td>
                                        <td style="width: 80px; text-align: right;">ตรม.</td>
                                        <td style="width: 80px; text-align: right;">1,500.00</td>
                                        <td style="width: 80px; text-align: right;">0.00</td>
                                        <td style="width: 100px; text-align: right;">1,500.00</td>
                                        <td style="width: 30px; text-align: center;"><input type="button" class="btn btn-success outline text-bold " style="padding: 2px 10px" name="name" value=" + " /></td>
                                        <td style="width: 30px; text-align: center;"><input type="button" class="btn btn-danger outline text-bold " style="padding: 2px 10px" name="name" value=" - " /></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 50px; text-align: center;">2</td>
                                        <td style="text-align: center;">วัสดุติดตั้ง</td>
                                        <td style="text-align: center;">100-MO-1523-8</td>
                                        <td style="text-align: center;">Multilayer OakMO-1523-8</td>
                                        <td style="width: 80px; text-align: right;">2</td>
                                        <td style="width: 80px; text-align: right;">ตรม.</td>
                                        <td style="width: 80px; text-align: right;">1,500.00</td>
                                        <td style="width: 80px; text-align: right;">0.00</td>
                                        <td style="width: 100px; text-align: right;">1,500.00</td>
                                        <td style="width: 30px; text-align: center;"><input type="button" class="btn btn-success outline text-bold " style="padding: 2px 10px" name="name" value=" + " /></td>
                                        <td style="width: 30px; text-align: center;"><input type="button" class="btn btn-danger outline text-bold " style="padding: 2px 10px" name="name" value=" - " /></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 50px; text-align: center;">3</td>
                                        <td style="text-align: center;">วัสดุติดตั้ง</td>
                                        <td style="text-align: center;">100-MO-1523-8</td>
                                        <td style="text-align: center;">Multilayer OakMO-1523-8</td>
                                        <td style="width: 80px; text-align: right;">2</td>
                                        <td style="width: 80px; text-align: right;">ตรม.</td>
                                        <td style="width: 80px; text-align: right;">1,500.00</td>
                                        <td style="width: 80px; text-align: right;">0.00</td>
                                        <td style="width: 100px; text-align: right;">1,500.00</td>
                                        <td style="width: 30px; text-align: center;"><input type="button" class="btn btn-success outline text-bold " style="padding: 2px 10px" name="name" value=" + " /></td>
                                        <td style="width: 30px; text-align: center;"><input type="button" class="btn btn-danger outline text-bold " style="padding: 2px 10px" name="name" value=" - " /></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 50px; text-align: center;">4</td>
                                        <td style="text-align: center;">บริการ</td>
                                        <td style="text-align: center;">F-SK-FJP2</td>
                                        <td style="text-align: center;">ค่าทำสีบัว FJ2",3" สีทึบ/ใส                                           </td>
                                        <td style="width: 80px; text-align: right;">1</td>
                                        <td style="width: 80px; text-align: right;">ชุด</td>
                                        <td style="width: 80px; text-align: right;">1,500.00</td>
                                        <td style="width: 80px; text-align: right;">0.00</td>
                                        <td style="width: 100px; text-align: right;">1,500.00</td>
                                        <td style="width: 30px; text-align: center;"><input type="button" class="btn btn-success outline text-bold " style="padding: 2px 10px" name="name" value=" + " /></td>
                                        <td style="width: 30px; text-align: center;"><input type="button" class="btn btn-danger outline text-bold " style="padding: 2px 10px" name="name" value=" - " /></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 50px; text-align: center;">5</td>
                                        <td style="text-align: center;">บริการ              </td>
                                        <td style="text-align: center;">F-UN-FL-SM</td>
                                        <td style="text-align: center;">ค่าแรงรื้อ+ติดตั้งไม้พื้นแบบเป็นกลุ่ม</td>
                                        <td style="width: 80px; text-align: right;">1</td>
                                        <td style="width: 80px; text-align: right;">ชุด</td>
                                        <td style="width: 80px; text-align: right;">1,500.00</td>
                                        <td style="width: 80px; text-align: right;">0.00</td>
                                        <td style="width: 100px; text-align: right;">1,500.00</td>
                                        <td style="width: 30px; text-align: center;"><input type="button" class="btn btn-success outline text-bold " style="padding: 2px 10px" name="name" value=" + " /></td>
                                        <td style="width: 30px; text-align: center;"><input type="button" class="btn btn-danger outline text-bold " style="padding: 2px 10px" name="name" value=" - " /></td>
                                    </tr>--%>
                                </tbody>
                            </table>

                            <hr />
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group" style="margin-top: -10px;">
                                            <label class="txtLabel">หมายเหตุ</label>
                                            <textarea class="form-control input-md txtLabel" id="qtremark" name="qtremark" rows="2" placeholder="หมายเหตุ"></textarea>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group" style="margin-top: -10px;">
                                            <label class="txtLabel">โน็ตใช้ภายในบริษัทฯ</label>
                                            <textarea class="form-control input-md txtLabel" id="qtcomment" name="qtcomment" rows="2" placeholder="บันทึกภายใน"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">

                                <div class="row">

                                    <div class="col-md-6">
                                        <label class="txtLabelFooter pull-right ">รวมเป็นเงิน</label>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="txtLabelFooter pull-right "></label>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="input-group">
                                            <input type="text" class="form-control text-right txtLabelFooter" id="txtamount" name="txtamount" value="0.00" readonly autocomplete="off">
                                            <span class="input-group-addon"><i class="fa fa-calculator"></i></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="padding-top: 5px">

                                    <div class="col-md-6">
                                        <label class="txtLabelFooter pull-right ">ส่วนลด</label>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="input-group">
                                            <input type="text" class="form-control text-right txtLabelFooter" id="txtdispercenct" name="txtdispercenct" value="0.00" onkeyup="myCalcTotal()">
                                            <span class="input-group-addon"><i class="fa fa-percent"></i></span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group">
                                            <input type="text" class="form-control text-right txtLabelFooter" id="txtdisamount" name="txtdisamount" value="0.00" disabled autocomplete="off" onkeyup="myCalcTotal()">
                                            <span class="input-group-addon">
                                                <input id="chkdisc" type="checkbox"></span>
                                        </div>
                                    </div>

                                </div>

                                <div class="row" style="padding-top: 5px">

                                    <div class="col-md-6">
                                        <label class="txtLabelFooter pull-right ">หลังหักส่วนลด</label>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="txtLabelFooter pull-right "></label>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="input-group">
                                            <input type="text" class="form-control text-right txtLabelFooter" id="txtafterdisamount" name="txtafterdisamount" value="0.00" readonly autocomplete="off">
                                            <span class="input-group-addon"><i class="fa fa-calculator"></i></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="padding-top: 5px">

                                    <div class="col-md-6">
                                        <label class="txtLabelFooter pull-right ">ภาษีมูลค่าเพิ่ม</label>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="input-group">
                                            <input type="text" class="form-control text-right txtLabelFooter" id="txtvatpercent" name="txtvatpercent" value="7.00" onkeyup="myCalcTotal()">
                                            <span class="input-group-addon"><i class="fa fa-percent"></i></span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group">
                                            <input type="text" class="form-control text-right txtLabelFooter" id="txtvatamount" name="txtvatamount" value="0.00" readonly autocomplete="off">
                                            <span class="input-group-addon"><i class="fa fa-calculator"></i></span>
                                        </div>
                                    </div>

                                </div>

                                <div class="row" style="padding-top: 5px">

                                    <div class="col-md-6">
                                        <label class="txtLabelFooter pull-right ">จำนวนเงินรวม</label>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="txtLabelFooter pull-right "></label>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="input-group">
                                            <input type="text" class="form-control text-right txtLabelFooter" id="txttotalamount" name="txttotalamount" value="0.00" readonly autocomplete="off">
                                            <span class="input-group-addon"><i class="fa fa-calculator"></i></span>
                                        </div>
                                    </div>
                                </div>


                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <hr />
                                    <div class="col-md-6">
                                        <button type="button" id="btncancel" class="btn btn-primary outline text-bold " style="padding: 5px 10px" name="name" > <i class="fa fa-home" aria-hidden="true"></i> กลับหน้าหลัก</button>
                                        <input type="button" id="btnprint" runat="server" onserverclick="btnprint_click" class="btn btn-primary outline text-bold " style="padding: 5px 10px" name="name" value="พิมพ์เอกสาร" />
                                    </div>

                                    <div class="col-md-6 ">
                                        <span class="pull-right">

                                            <input type="button" id="btnsendmail" class="btn btn-primary outline text-bold  " style="padding: 5px 10px" name="name" value="ส่งขออนุมัติรายการ" />
                                            <input type="button" id="btnsavedoc" class="btn btn-primary outline text-bold  " style="padding: 5px 10px" name="name" value="บันทึกรายการ" />
                                            <input type="button" id="btnupdatedoc" class="btn btn-primary outline text-bold  " style="padding: 5px 10px" name="name" value="อัฟเดทรายการ" />

                                            <input type="button" id="btndeldoc" class="btn btn-danger outline text-bold  " style="padding: 5px 10px" name="name" value="ลบข้อมูลรายการ" />

                                        </span>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- /.modal mymodalitems -->
        <div class="modal  fade" id="modalgoodcode">
            <div class="modal-dialog modal-dialog-center" style="width: 1000px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">รายการสินค้า</h4>
                    </div>

                    <div class="modal-body">

                        <table id="tblgoodcodeselectitem" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>GoodCodeID</th>
                                    <th>GoodGroupID</th>
                                    <th>GoodGroupDesc</th>
                                    <th>GoodTypeID</th>
                                    <th>GoodTypeDesc</th>
                                    <th>GoodCode</th>
                                    <th>GoodName</th>
                                    <th>GoodColorID</th>
                                    <th>GoodColorDesc</th>
                                    <th>GoodUnitID</th>
                                    <th>GoodUnitDesc</th>
                                    <th>Price1</th>
                                    <th>Price2</th>
                                    <th>Price3</th>
                                    <th>PurLeadTime</th>
                                    <th>GoodWeight</th>
                                    <th>GoodWidth</th>
                                    <th>GoodLength</th>
                                    <th>GoodHeight</th>
                                    <th>GoodStatID</th>
                                    <th>GoodStatDesc</th>
                                    <th>activeid</th>
                                    <th>activename</th>
                                    <th>UserCreate</th>
                                    <th>CreateDate</th>
                                    <th>UserUpdate</th>
                                    <th>LasteDate</th>
                                    <th>#</th>

                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>


                    </div>

                    <input type="hidden" id="pgoodcodeid" />
                    <input type="hidden" id="pgoodname" />
                    <input type="hidden" id="pgoodunitid" />
                    <input type="hidden" id="pgoodunitdesc" />


                    <%-- <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            
                            <button type="button" class="btn btn-primary " id="Button3" runat="server">Save Changes</button>
                        </div>--%>
                </div>
            </div>
        </div>

        <%-- /.modal  modaledititem--%>
        <div class="modal  fade" id="modaledititem">
            <div class="modal-dialog " style="width:1200px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">แก้ไขรายการสินค้า</h4>
                    </div>

                    <div class="modal-body txtLabel">
                        
                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">ลำดับ</span>
                            </div>
                            <div class="col-md-3">
                                <input type="hidden" id="hidgid" name="hidgid" class="form-control input-sm txtLabel" />
                                <input type="text" id="txtno" class="form-control input-sm txtLabel" />
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">กลุ่มสินค้า / รหัสสินค้า</span>
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="txtgroup" class="form-control input-sm txtLabel" disabled />
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="txtgoodcode" class="form-control input-sm txtLabel" disabled />
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="txtgoodname" class="form-control input-sm txtLabel" disabled />
                            </div>


                        </div>

                        <div class="row hidden" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">รหัสสินค้า</span>
                            </div>
                            <div class="col-md-3">
                                
                            </div>

                            <div class="col-md-3">
                                
                            </div>
                        </div>

                        <div class="row hidden" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">จำนวน</span>
                            </div>

                            <div class="col-md-3">
                                <input type="text" id="txtunit" class="form-control input-sm txtLabel" readonly />
                            </div>

                            <div class="col-md-3">
                                <input type="text" id="txtquantity" class="form-control input-sm txtLabel text-right" onkeyup="myCalc();" />
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">จำนวน</span>
                            </div>
                            <div class="col-md-3">
                                <span class="txtLabel ">
                                    <select id="selectgoodunit" class="form-control input-sm " style="width: 100%">
                                        <option value="-1">ระบุหน่วยสินค้า</option>
                                    </select>
                                </span>
                            </div>

                            <div class="col-md-3">
                                <input type="text" id="txtQtyRema" name="txtQtyRema" class="form-control input-sm txtLabel text-right" onkeyup="myCalc();" />
                            </div>
                        </div>

                        <div class="row hidden" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">รูปแบบ/แพทเทิร์น</span>
                            </div>
                            <div class="col-md-6">
                                <span class="txtLabel ">
                                    <select id="selectpattern" class="form-control input-sm " style="width: 100%">
                                        <option value="-1">ไม่ระบุรูปแบบ</option>
                                        <%--<option value="R">Random</option>
                                        <option value="B">Brick</option>
                                        <option value="H">Herringbone</option>
                                        <option value="C">Chevron</option>--%>
                                    </select>
                                </span>
                            </div>
                        </div>

                        <div class="row hidden" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">จำนวนเงินเพิ่ม</span>
                            </div>

                            <div class="col-md-6">
                                <input type="text" id="txtQtyExtra" class="form-control input-sm txtLabel text-right" disabled />
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">ราคาต่อหน่วย</span>
                            </div>

                            <div class="col-md-6">
                                <input type="text" id="txtunitprice" class="form-control input-sm txtLabel text-right" onkeyup="myCalc();" />
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">จำนวนเงินรวม</span>
                            </div>

                            <div class="col-md-6">
                                <input type="text" id="txtitemamount" class="form-control input-sm txtLabel text-right" disabled />
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">เปอร์เซ็นต์ / ส่วนลด</span>
                            </div>

                            <div class="col-md-3">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <input type="checkbox" id="chkitemdiscount">
                                    </span>
                                    <input type="text" id="txtitemprecentdiscount" class="form-control input-sm txtLabel text-right" value="0.00" onkeyup="myCalc();" />
                                </div>
                            </div>

                            <div class="col-md-3">
                                <input type="text" id="txtitemdiscount" class="form-control input-sm txtLabel text-right text-right" onkeyup="myCalc();" />
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">จำนวนเงินรวมสุทธิ</span>
                            </div>

                            <div class="col-md-6">
                                <input type="text" id="txtitemtotalamount" class="form-control input-sm txtLabel text-right" disabled />
                            </div>
                        </div>

                        <div class="row hidden" style="margin-top: 5px;">
                            <div class="col-md-3">
                                <span class=" pull-right">หมายเหตุ</span>
                            </div>

                            <div class="col-md-6">
                                <input type="text" id="txtitemremark" class="form-control input-sm txtLabel" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <input type="button" class="btn btn-primary outline text-bold " id="btnadditemtruck" style="padding: 2px 10px" name="name" value=" + เลือกรายการ" />
                            </div>
                            <div class="col-md-12">
                                <table id="tbltrucktrip" class="table table-striped table-bordered table-hover"  style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th>ลำดับ</th>
                                            <th>ชื่อบริษัท</th>
                                            <th>เลขที่</th>
                                            <th>ทะเบียนรถ</th>
                                            <th>วันที่</th>
                                            <th>เวลา</th>
                                            <th>รหัสสินค้า</th>
                                            <th>สินค้า</th>
                                            <th>นน.เข้า</th>
                                            <th>นน.ออก</th>
                                            <th>นน.สุทธิ</th>
                                            <th>ราคา</th>
                                            <th>จำนวนเงิน</th>
                                            <th class="text-center">                                               
                                                <i class="fa fa-trash-o" aria-hidden="true"></i>                                             
                                               </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>

                    </div>

                    <div class="modal-footer">
                        <div class="container-fluid">
                            <button type="button" class="btn btn-danger outline text-bold txtLabel pull-left " style="padding: 5px 10px" data-dismiss="modal">ยกเลิกรายการ</button>

                            <button type="button" id="btndeleteitem" class="btn btn-danger outline text-bold  txtLabel " style="padding: 5px 10px">ยืนยันลบข้อมูลรายการ</button>
                            <button type="button" id="btnupdateitem" class="btn btn-primary outline text-bold  txtLabel " style="padding: 5px 10px">อัฟเดทข้อมูลรายการ</button>
                        </div>

                    </div>

                </div>
            </div>
        </div>

        
        <div class="modal  fade" id="modalrefitemtruck">
            <div class="modal-dialog " style="width:1200px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">อ้างอิงรายการชั่งน้ำหนัก</h4>
                    </div>

                    <div class="modal-body txtLabel">   
                        <div class="row">
                            <div class="col-md-2">
                                <div class="form-group">
                                   <%-- <label class="txtLabel">วันที่เริ่มต้น:</label>--%>
                                    <input type="text" class="form-control hidden" autocomplete="off" id="txttruckrefno">
                                    <div class="input-group date">
                                        <input type="text" class="form-control pull-right" autocomplete="off" id="datestarttruck">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                   <%-- <label class="txtLabel">วันที่สิ้นสุด:</label>--%>
                                    <div class="input-group date">
                                        <input type="text" class="form-control pull-right" autocomplete="off" id="datestoptruck">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div> 

                            <div class="col-md-3 hidden">
                                 <input type="text" class="form-control pull-right" autocomplete="off" id="txtproduct">
                            </div>

                            <div class="col-md-6">
                                 <input type="text" class="form-control pull-right" autocomplete="off" id="txtsearch" placeholder="โปรดระบุชื่อบริษัท / ชื่อลูกค้า">
                            </div>

                            <div class="col-md-2">
                                <span id="btnloadticket" class="btn btn-info btn-block "><i class="fa fa-refresh"></i> ตรวจสอบข้อมูล</span>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <table id="tblreftrucktrip" class="table table-striped table-bordered table-hover"  style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th>ชื่อบริษัท</th>
                                            <th>เลขที่</th>
                                            <th>ทะเบียนรถ</th>
                                            <th>วันที่</th>
                                            <th>เวลา</th>
                                            <th>รหัสสินค้า</th>
                                            <th>สินค้า</th>
                                            <th>นน.เข้า</th>
                                            <th>นน.ออก</th>
                                            <th>นน.สุทธิ</th>
                                            <th>ราคา</th>
                                            <th>จำนวนเงิน</th>
                                            <th class="text-center">                                               
                                                <input type="checkbox" id="chkall" name="chkall" />                                             
                                               </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                       </div>
                    </div>

                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <button type="button" class="btn btn-danger outline text-bold txtLabel pull-left " style="padding: 5px 10px" data-dismiss="modal">ยกเลิกรายการ</button>
                                <button type="button" id="btnadditemreftruck" class="btn btn-primary outline text-bold  txtLabel " style="padding: 5px 10px">ยืนยันเพิ่มข้อมูลรายการ</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>
</asp:Content>
