<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="ar-vendor-edit.aspx.cs" Inherits="medesignsoft.meenterprise_management.ar_vendor_edit" %>
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
                //$('#overlay').show();
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

                getVendorGroup();
                getPaymentType();
                getVendorType();
                getProvince();
                getBranch();
                getVatGroup();
                getActive();
                getSalesCode();

                
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

                    //getvendorbyid(atob(gid));
                    getvendorbyid(gid)
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

                var selectvendorgroup = $('#selectvendorgroup');
                function getVendorGroup() {
                    $.ajax({
                        url: 'general-services.asmx/getVendorGroupList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectvendorgroup.empty();
                            selectvendorgroup.append($('<option/>', { value: -1, text: 'Please choose group..' }));
                            $(data).each(function (index, item) {
                                selectvendorgroup.append($('<option/>', { value: item.VendorGroupID, text: item.VendorGroupName }));
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

                var selectpaymenttype = $('#selectpaymenttype');
                function getPaymentType() {
                    $.ajax({
                        url: 'general-services.asmx/getTermsList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectpaymenttype.empty();
                            selectpaymenttype.append($('<option/>', { value: -1, text: 'Please choose payment type..' }));
                            $(data).each(function (index, item) {
                                selectpaymenttype.append($('<option/>', { value: item.adPaymentTypeID, text: item.PaymentTypeDesc }));
                            });
                        }
                    })
                }

                var selectvendortype = $('#selectvendortype');
                function getVendorType() {
                    $.ajax({
                        url: 'general-services.asmx/getVendorType',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectvendortype.empty();
                            selectvendortype.append($('<option/>', { value: -1, text: 'Please choose vendor type..' }));
                            $(data).each(function (index, item) {
                                selectvendortype.append($('<option/>', { value: item.VendorTypeID, text: item.VendorTypeName }));
                            })
                        }
                    })
                }

                var selectprovince = $('#selectprovince');
                var selectcontprovince = $('#selectcontprovince');
                function getProvince() {
                    $.ajax({
                        url: 'general-services.asmx/getprovince',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectprovince.empty();
                            selectcontprovince.empty();
                            selectprovince.append($('<option/>', { value: -1, text: 'Please choose province..' }));
                            selectcontprovince.append($('<option/>', { value: -1, text: 'Please choose province type..' }));
                            $(data).each(function (index, item) {
                                selectprovince.append($('<option/>', { value: item.adProvinceID, text: item.ProvinceName }));
                                selectcontprovince.append($('<option/>', {value: item.adProvinceID, text: item.ProvinceName}))
                            })
                        }
                    })
                }

                var selectVATGroupID = $('#selectVATGroupID');
                function getVatGroup() {
                    $.ajax({
                        url: 'general-services.asmx/getVatGroup',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectVATGroupID.empty();
                            selectVATGroupID.append($('<option/>', { value: -1, text: 'Please choose vat..' }));
                            $(data).each(function (index, item) {
                                selectVATGroupID.append($('<option/>', { value: item.VATGroupID, text: item.VATGroupDesc }));
                            })
                        }
                    })
                }

                var selectsalecode = $('#selectsalecode');
                function getSalesCode() {
                     $.ajax({
                        url: 'general-services.asmx/getEmployeesList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectsalecode.empty();   
                            selectsalecode.append($('<option/>', { value: -1, text: 'Please choose sales owner..' }));
                            $(data).each(function (index, item) {                                
                                selectsalecode.append($('<option/>', { value: item.imEmployeeID, text: item.FirstName + ' ' + item.LastName }));
                            })
                        }
                    })
                }

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
                            $(data).each(function (index, item) {
                                selectbranch.append($('<option/>', { value: item.imBranchGid, text: item.BranchName}))
                            })
                        }
                    })
                }


                function getvendorbyid(gid) {
                    $.ajax({
                        url: 'general-services.asmx/getVendorById',
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
                                    $('#hiddengid').val(data["VendorID"]);
                                    $('#selectvendorgroup').val(data["VendorGroupID"]);
                                    $('#selectvendorgroup').change();

                                    $('#txtvendorcode').val(data["VendorCode"]);
                                    $('#txtvendorname').val(data["VendorName"]);
                                    $('#txtvendornameeng').val(data["VendorNameEng"]);
                                    $('#txtshortname').val(data["ShortName"]);
                                    $('#datevendorstart').val(data["VendorStartDate"]);                                   
                                    $('#selectpaymenttype').val(data["adPaymentTypeID"]);
                                    $('#selectpaymenttype').change();

                                    $('#selectvendortype').val(data["VendorTypeID"]);
                                    $('#selectvendortype').change();

                                    $('#txttaxid').val(data["TaxId"]);
                                    $('#txtvendoraddr1').val(data["VendorAddr1"]);
                                    $('#txtvendoraddr2').val(data["VendorAddr2"]);
                                    $('#txtdistrict').val(data["District"]);
                                    $('#txtamphur').val(data["Amphur"]);
                                    $('#selectprovince').val(data["adProvinceID"]);
                                    $('#selectprovince').change();
                                    
                                    $('#txtpostCode').val(data["PostCode"]);
                                    $('#txtCreditDays').val(data["CreditDays"]);
                                    $('#txtCreditAmnt').val(data["CreditAmnt"]);
                                    $('#selectactive').val(data["Active"]);
                                    $('#selectactive').change();

                                    $('#txtContAddr1').val(data["ContAddr1"]);
                                    $('#txtContAddr2').val(data["ContAddr2"]);
                                    $('#txtcontdistrict').val(data["ContDistrict"]);
                                    $('#txtcontamphur').val(data["ContAmphur"]);
                                    $('#selectcontprovince').val(data["ContProvince"]);
                                    $('#selectcontprovince').change();

                                    $('#txtcontpostCode').val(data["ContPostCode"]);
                                    $('#txtconthomepage').val(data["ContHomePage"]);
                                    $('#txtContTel').val(data["ContTel"]);
                                    $('#txtContFax').val(data["ContFax"]);
                                    $('#txtCardNo').val(data["CardNo"]);

                                    $('#selectVATGroupID').val(data["VATGroupID"]);
                                   

                                    $('#datebirthday').val(data["Birthdate"]);
                                    $('#txtContTelExtend1').val(data["ContTelExtend1"]);
                                    $('#txtContTelExtend2').val(data["ContTelExtend2"]);
                                    $('#selectbranch').val(data["imBranchID"]);
                                    $('#selectbranch').change();
                                    $('#selectsalecode').val(data["SalesCode"]);
                                    $('#selectsalecode').change();


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
                    window.location.href = "ar-vendor-setup.aspx?opt=optap";

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
                    window.location.href = "ar-vendor-setup.aspx?opt=optap";
                });

                var btnsavenew = $('#btnsavenew');
                btnsavenew.click(function () {
                    getvalidatefield();

                    var username = '<%= Session["UserName"] ?? "" %>';

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
                                    url: 'general-services.asmx/getVendorUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'new',
                                        gid: $('#hiddengid').val(),

                                        VendorID: $('#hiddengid').val(),
                                        VendorGroupID: $('#selectvendorgroup').val(),
                                        VendorCode: $('#txtvendorcode').val(),
                                        VendorName: $('#txtvendorname').val(),
                                        VendorNameEng: $('#txtvendornameeng').val(),
                                        ShortName: $('#txtshortname').val(),
                                        VendorStartDate: $('#datevendorstart').val(),
                                        Active: $('#selectactive').val(),
                                        InactiveDate: $('#datestop').val(),
                                        adPaymentTypeID: $('#selectpaymenttype').val(),
                                        VendorTypeID: $('#selectvendortype').val(),
                                        TaxId: $('#txttaxid').val(),
                                        VendorAddr1: $('#txtvendoraddr1').val(),
                                        VendorAddr2: $('#txtvendoraddr2').val(),
                                        District: $('#txtdistrict').val(),
                                        Amphur: $('#txtamphur').val(),
                                        adProvinceID: $('#selectprovince').val(),
                                        PostCode: $('#txtpostCode').val(),
                                        ContAddr1: $('#txtContAddr1').val(),
                                        ContAddr2: $('#txtContAddr2').val(),
                                        ContDistrict: $('#txtcontdistrict').val(),
                                        ContAmphur: $('#txtcontamphur').val(),
                                        ContProvince: $('#selectcontprovince').val(),
                                        ContPostCode: $('#txtcontpostCode').val(),
                                        ContHomePage: $('#txtconthomepage').val(),
                                        ContTel: $('#txtContTel').val(),
                                        ContFax: $('#txtContFax').val(),
                                        CardNo: $('#txtCardNo').val(),
                                        VATGroupID: $('#selectVATGroupID').val(),
                                        imBranchID: $('#selectbranch').val(),
                                        Birthdate: $('#datebirthday').val(),
                                        ContTelExtend1: $('#txtContTelExtend1').val(),
                                        ContTelExtend2: $('#txtContTelExtend2').val(),
                                        BranchCode: null,
                                        BranchName: null,
                                        CreditDays: $('#txtCreditDays').val(),
                                        CreditAmnt: $('#txtCreditAmnt').val(),
                                        CreatedBy: username,
                                        CreatedDate: null,
                                        UpdatedBy: username,
                                        UpdateDate: null,
                                        SalesCode: $('#selectsalecode').val()

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
                                            window.location.href = "ar-vendor-setup.aspx?opt=optap";
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

                    var username = '<%= Session["UserName"] ?? "" %>';

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
                                    url: 'general-services.asmx/getVendorUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'edit',
                                        gid: $('#hiddengid').val(),

                                        VendorID: $('#hiddengid').val(),
                                        VendorGroupID: $('#selectvendorgroup').val(),
                                        VendorCode: $('#txtvendorcode').val(),
                                        VendorName: $('#txtvendorname').val(),
                                        VendorNameEng: $('#txtvendornameeng').val(),
                                        ShortName: $('#txtshortname').val(),
                                        VendorStartDate: $('#datevendorstart').val(),
                                        Active: $('#selectactive').val(),
                                        InactiveDate: $('#datestop').val(),
                                        adPaymentTypeID: $('#selectpaymenttype').val(),
                                        VendorTypeID: $('#selectvendortype').val(),
                                        TaxId: $('#txttaxid').val(),
                                        VendorAddr1: $('#txtvendoraddr1').val(),
                                        VendorAddr2: $('#txtvendoraddr2').val(),
                                        District: $('#txtdistrict').val(),
                                        Amphur: $('#txtamphur').val(),
                                        adProvinceID: $('#selectprovince').val(),
                                        PostCode: $('#txtpostCode').val(),
                                        ContAddr1: $('#txtContAddr1').val(),
                                        ContAddr2: $('#txtContAddr2').val(),
                                        ContDistrict: $('#txtcontdistrict').val(),
                                        ContAmphur: $('#txtcontamphur').val(),
                                        ContProvince: $('#selectcontprovince').val(),
                                        ContPostCode: $('#txtcontpostCode').val(),
                                        ContHomePage: $('#txtconthomepage').val(),
                                        ContTel: $('#txtContTel').val(),
                                        ContFax: $('#txtContFax').val(),
                                        CardNo: $('#txtCardNo').val(),
                                        VATGroupID: $('#selectVATGroupID').val(),
                                        imBranchID: $('#selectbranch').val(),
                                        Birthdate: $('#datebirthday').val(),
                                        ContTelExtend1: $('#txtContTelExtend1').val(),
                                        ContTelExtend2: $('#txtContTelExtend2').val(),
                                        BranchCode: null,
                                        BranchName: null,
                                        CreditDays: $('#txtCreditDays').val(),
                                        CreditAmnt: $('#txtCreditAmnt').val(),
                                        CreatedBy: username,
                                        CreatedDate: null,
                                        UpdatedBy: username,
                                        UpdateDate: null,
                                        SalesCode: $('#selectsalecode').val()

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
                                            window.location.href = "ar-vendor-setup.aspx?opt=optap";
                                        }, 600);
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
                    }
                    else {
                        //  alert('false');
                    }
                });

                var btndelete = $('#btndelete');
                btndelete.click(function () {
                    getvalidatefield();

                    var username = '<%= Session["UserName"] ?? "" %>';

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
                                    url: 'general-services.asmx/getVendorUpdateEntry',
                                    method: 'post',
                                    data: {
                                        acttrans: 'del',
                                        gid: $('#hiddengid').val(),

                                        VendorID: $('#hiddengid').val(),
                                        VendorGroupID: $('#selectvendorgroup').val(),
                                        VendorCode: $('#txtvendorcode').val(),
                                        VendorName: $('#txtvendorname').val(),
                                        VendorNameEng: $('#txtvendornameeng').val(),
                                        ShortName: $('#txtshortname').val(),
                                        VendorStartDate: $('#datevendorstart').val(),
                                        Active: $('#selectactive').val(),
                                        InactiveDate: $('#datestop').val(),
                                        adPaymentTypeID: $('#selectpaymenttype').val(),
                                        VendorTypeID: $('#selectvendortype').val(),
                                        TaxId: $('#txttaxid').val(),
                                        VendorAddr1: $('#txtvendoraddr1').val(),
                                        VendorAddr2: $('#txtvendoraddr2').val(),
                                        District: $('#txtdistrict').val(),
                                        Amphur: $('#txtamphur').val(),
                                        adProvinceID: $('#selectprovince').val(),
                                        PostCode: $('#txtpostCode').val(),
                                        ContAddr1: $('#txtContAddr1').val(),
                                        ContAddr2: $('#txtContAddr2').val(),
                                        ContDistrict: $('#txtcontdistrict').val(),
                                        ContAmphur: $('#txtcontamphur').val(),
                                        ContProvince: $('#selectcontprovince').val(),
                                        ContPostCode: $('#txtcontpostCode').val(),
                                        ContHomePage: $('#txtconthomepage').val(),
                                        ContTel: $('#txtContTel').val(),
                                        ContFax: $('#txtContFax').val(),
                                        CardNo: $('#txtCardNo').val(),
                                        VATGroupID: $('#selectVATGroupID').val(),
                                        imBranchID: $('#selectbranch').val(),
                                        Birthdate: $('#datebirthday').val(),
                                        ContTelExtend1: $('#txtContTelExtend1').val(),
                                        ContTelExtend2: $('#txtContTelExtend2').val(),
                                        BranchCode: null,
                                        BranchName: null,
                                        CreditDays: $('#txtCreditDays').val(),
                                        CreditAmnt: $('#txtCreditAmnt').val(),
                                        CreatedBy: username,
                                        CreatedDate: null,
                                        UpdatedBy: username,
                                        UpdateDate: null

                                    },
                                    success: function (data) {
                                        Swal.fire(
                                            '<span class="txtLabel">บันทึกข้อมูลสำเร็จ..!</span>',
                                            '',
                                            'success'
                                        )
                                        setTimeout(function () {
                                            window.location.href = "ar-vendor-setup.aspx?opt=optap";
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

                

            })





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

                            <label class="txtLabel">Customer Edit</label>
                        </div>

                        <div class="box-body">


                            <div class="col-md-6">
                                <input type="hidden" id="hiddengid" class="form-control ">

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">กลุ่มเจ้าหนี้</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectvendorgroup" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รหัสเจ้าหนี้ <span id="errVendorCode" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtvendorcode" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">บริษัท/ห้างหุ้นส่วน (Th) <span id="errVendorName" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtvendorname" class="form-control ">
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">บริษัท/ห้างหุ้นส่วน (En) <span id="errVendorNameEng" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtvendornameeng" class="form-control ">
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">บริษัท/ห้างหุ้นส่วน (En) <span id="errShortName" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtshortname" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">วันที่เริ่ม</label>
                                    <div class="col-sm-8 ">
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datevendorstart" autocomplete="off">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ประเภทการชำระเงิน</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectpaymenttype" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ประเภทเจ้าหนี้</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectvendortype" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เลขที่ผู้เสียภาษี<span id="errTaxId" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txttaxid" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เลขที่ตั้ง อาคาร / ที่อยู่ (1)<span id="errVendorAddr1" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtvendoraddr1" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เลขที่ตั้ง อาคาร / ที่อยู่ (2)<span id="errVendorAddr2" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtvendoraddr2" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ตำบล / แขวง<span id="errDistrict" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtdistrict" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">อำเภอ / เขต<span id="errAmphur" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtamphur" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">จังหวัด</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectprovince" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รหัสไปรษณีย์<span id="errPostCode" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtpostCode" class="form-control ">
                                    </div>
                                </div>

                                 <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ระยะเวลา / วงเงินเครดิต<span id="errCreditDays" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-4">
                                        <input type="text" id="txtCreditDays" class="form-control " disabled>
                                    </div>

                                    <div class="col-sm-4">
                                        <input type="text" id="txtCreditAmnt" class="form-control " disabled>
                                    </div>

                                </div>

                               <%-- <div class="form-group row">
                                    <label class="col-sm-2 col-form-label txtLabel">วงเงินเครดิต<span id="errCreditAmnt" class="text-red txtLabel hidden">***</span></label>
                                    
                                </div>--%>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">มีผลใช้งาน</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectactive" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">วันที่เริ่ม / สิ้นสุด</label>
                                    <div class="col-sm-4 ">
                                        <div class="input-group date">
                                            <input type="text" class="form-control input-sm pull-left txtLabel" id="datestart" autocomplete="off">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4 ">
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


                            <div class="col-md-6">       
                                
                                <div class="form-group row">
                                    
                                    <a href="#!" class="col-sm-4 col-form-label txtLabel text-red"><i class="fa fa-copy"></i> คัดลอก-->ข้อมูลผู้ติดต่อ</a>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ที่อยู่สำหรับติดต่อ(1)<span id="errContAddr1" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtContAddr1" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ที่อยู่สำหรับติดต่อ(2)<span id="errContAddr2" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtContAddr2" class="form-control ">
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ตำบล/แขวง ผู้ติดต่อ<span id="errcontDistrict" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtcontdistrict" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">อำเภอ / เขต ผู้ติดต่อ<span id="errcontAmphur" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtcontamphur" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">จังหวัด  ผู้ติดต่อ</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectcontprovince" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">รหัสไปรษณีย์ ผู้ติดต่อ <span id="errcontPostCode" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtcontpostCode" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เวปไซต์<span id="errContHomePage" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtconthomepage" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เบอร์โทรผู้ติดต่อ <span id="errContTel" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtContTel" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เบอร์แฟกซ์ผู้ติดต่อ <span id="errContFax" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtContFax" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เลขที่บัตรประชาชน<span id="errCardNo" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtCardNo" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">กลุ่มภาษี<span id="errVATGroupID" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">                                       
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectVATGroupID" class="form-control input-sm " style="width: 100%" >
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
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เบอร์ต่อ (1)<span id="errContTelExtend1" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtContTelExtend1" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">เบอร์ต่อ (2)<span id="errContTelExtend2" class="text-red txtLabel hidden">***</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" id="txtContTelExtend2" class="form-control ">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">ลูกค้าสาขา</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectbranch" class="form-control input-sm " style="width: 100%" >
                                            </select>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label txtLabel text-right">พนักงานขาย</label>
                                    <div class="col-sm-8">
                                        <span class="txtLabel " style="width: 100%">
                                            <select id="selectsalecode" class="form-control input-sm " style="width: 100%" >
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

      
    </section>
</asp:Content>
