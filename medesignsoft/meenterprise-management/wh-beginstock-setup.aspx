<%@ Page Title="" Language="C#" MasterPageFile="~/medesignsoft.Master" AutoEventWireup="true" CodeBehind="wh-beginstock-setup.aspx.cs" Inherits="medesignsoft.meenterprise_management.wh_beginstock_setup" %>

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

            #tblbeginingstocklist tbody tr:hover {
                color: red;
                background-color: rgba(252, 241, 154, 0.63);
            }

             #tblgoodcodeselect tbody tr:hover {
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

            .mypointer:hover {
                cursor: pointer;
                color: red;
                font-weight: bold;
            }

        </style>

        <script>
            $(document).ready(function () {
                $('#loader').hide();

                var employeeid = '<%= Session["imEmployeeGid"] %>';

                getGoodCode();
                getBranchName();
                getWarehouse();
                getWarehouseZone();
                getGoodCodeStockList();

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
                    //alert('modal new begining stock...');
                    clearinputform();

                    $('#btnfindgood').removeClass('hidden');
                    $('#divgoodcode').addClass('input-group');

                    $('#btnsavenew').removeClass('hidden');
                    $('#btnsavechange').addClass('hidden');
                    $('#btndelete').addClass('hidden');

                    $('#txtGoodCode').prop("disabled", true);
                    $('#txtGoodName').prop("disabled", true);
                    $('#txtGoodGroupDesc').prop("disabled", true);
                    $('#txtGoodTypeDesc').prop("disabled", true);
                    $('#txtGoodUnitDesc').prop("disabled", true);
                    $('#selectBranchName').prop("disabled", false);
                    $('#selectWhDesc').prop("disabled", false);
                    $('#selectWhZoneDesc').prop("disabled", false);
                    $('#txtLotNo').prop("disabled", false);
                    $('#txtInvQty').prop("disabled", false);
                    $('#txtPurCost').prop("disabled", false);
                    $('#txtUnitPrice').prop("disabled", false);
                    $('#txtRemark').prop("disabled", false);
                                    
                    $("#modalbeginstock").modal({ backdrop: false });
                    $('[id=modalbeginstock]').modal('show');

                    //window.location.href = "so-creditapproval-edit.aspx?opt=optso&mod=new";
                });

                var btnreload = $('#btnreload');
                btnreload.click(function () {
                    //reloaddata();
                    getGoodCode();
                    getBranchName();
                    getWarehouse();
                    getWarehouseZone();
                    getGoodCodeStockList();
                });

                var btnfindgood = $('#btnfindgood');
                btnfindgood.click(function () {

                    $("#modalgoodcode").modal({ backdrop: false });
                    $('#modalgoodcode').modal('show');
                });

               // var selectGoodCode = $('#selectGoodCode');
                async function getGoodCode() {
                    var result = await $.ajax({
                        url: 'general-services.asmx/getGoodCodeList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            var table;
                            table = $('#tblgoodcodeselect').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].GoodCodeID, data[i].GoodGroupID, data[i].GoodGroupDesc, data[i].GoodTypeID, data[i].GoodTypeDesc,
                                        data[i].GoodCode, data[i].GoodName, data[i].GoodColorID, data[i].GoodColorDesc, data[i].GoodUnitID, data[i].GoodUnitDesc]);
                                });
                            }
                            table.column(4).nodes().to$().addClass('mypointer');
                            table.column(5).nodes().to$().addClass('mypointer');

                            table.draw();
                            $('#loader').hide();

                            $('#tblgoodcodeselect tbody').on('dblclick', 'td', function (e) {
                                e.preventDefault();

                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;

                                var goodid = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                var goodgroupid = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var goodgroupdesc = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var goodtypeid = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(3)');
                                var goodtypedesc = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(4)');
                                var goodcode = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(5)');
                                var goodname = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(6)');
                                var goodcolorid = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(7)');
                                var goodcolordesc = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(8)');
                                var goodunitid = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(9)');
                                var goodunitdesc = $("#tblgoodcodeselect").find('tr:eq(' + rIndex + ')').find('td:eq(10)');
                                
                               // alert(gid.text());

                                //$('#gid').val(goodid.text());
                                $('#txtGoodCodeID').val(goodid.text());
                                $('#txtGoodCode').val(goodcode.text());
                                $('#txtGoodName').val(goodname.text());
                                $('#txtGoodGroupID').val(goodgroupid.text());
                                $('#txtGoodGroupDesc').val(goodgroupdesc.text());
                                $('#txtGoodTypeID').val(goodtypeid.text());
                                $('#txtGoodTypeDesc').val(goodtypedesc.text());
                                $('#txtGoodUnitID').val(goodunitid.text());
                                $('#txtGoodUnitDesc').val(goodunitdesc.text());

                                $('#modalgoodcode').modal('hide');
                            });

                           

                        }
                    });
                    return result;
                }

                var selectBranchName = $('#selectBranchName');
                async function getBranchName() {
                    var result = await $.ajax({
                        url: 'general-services.asmx/getBranch',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectBranchName.empty();
                            selectBranchName.append($('<option/>', { value: -1, text: 'Please select branch..' }));

                            $(data).each(function (index, item) {
                                selectBranchName.append($('<option/>', { value: item.imBranchGid, text: item.BranchName }));
                            });     

                             
                        }
                    });
                    return result;
                }

                var selectWhDesc = $('#selectWhDesc');
                async function getWarehouse() {
                    var result = await $.ajax({
                        url: 'general-services.asmx/getWarehouseList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectWhDesc.empty();
                            selectWhDesc.append($('<option/>', { value: -1, text: 'Please select warehouse..' }));

                            $(data).each(function (index, item) {
                                selectWhDesc.append($('<option/>', { value: item.WhID, text: item.WhDesc }));
                            });   
                        }
                    });
                    return result;
                }

                var selectWhZoneDesc = $('#selectWhZoneDesc');
                async function getWarehouseZone() {
                    var result = await $.ajax({
                        url: 'general-services.asmx/getWarehouseZoneList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {

                        },
                        success: function (data) {
                            selectWhZoneDesc.empty();
                            selectWhZoneDesc.append($('<option/>', { value: -1, text: 'Please select zone or location..' }));

                            $(data).each(function (index, item) {
                                selectWhZoneDesc.append($('<option/>', { value: item.WhZoneID, text: item.WhZoneDesc }));
                            });   
                        }
                    });
                    return result;
                }

                function reloaddata() {
                    getGoodCode();
                    getBranchName();
                    getWarehouse();
                    getWarehouseZone();

                    getGoodCodeStockList();
                }

                function getGoodCodeStockList() {
                    $.ajax({
                        url: 'general-services.asmx/getGoodCodeStockList',
                        method: 'post',
                        datatype: 'json',
                        beforeSend: function () {
                            $('#loader').show();
                            $("#tblbeginingstocklist tr td").remove();

                        },
                        success: function (data) {
                            var table;
                            table = $('#tblbeginingstocklist').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].Gid, data[i].imBranchGid, data[i].BranchName, data[i].WhID, data[i].WhDesc, data[i].WhZoneID,
                                        data[i].WhZoneDesc, data[i].GoodGroupID, data[i].GoodGroupDesc, data[i].GoodTypeID, data[i].GoodTypeDesc, data[i].GoodCodeID, data[i].GoodCode, data[i].GoodName,
                                        data[i].GoodUnitID, data[i].GoodUnitDesc, data[i].ControlNo, data[i].LotNo, data[i].AdjustQty, data[i].QCQty, data[i].InvQty,
                                        data[i].OrderQty, data[i].BorrowQty, data[i].ReserveQty, data[i].DestroyQty, data[i].RepairQty, data[i].ReturnQty, data[i].CNQty,
                                        data[i].PurCost, data[i].AddCost1, data[i].AddCost2, data[i].AddCost3, data[i].UnitCost, data[i].AVCost, data[i].AVCost2,
                                        data[i].MinimumPrice, data[i].MaximumPrice, data[i].UnitPrice, data[i].DiscPercent, data[i].DiscCash, data[i].NetPrice,
                                        data[i].ReceiveDate, data[i].ExpiredDate, data[i].UserCreate, data[i].CreateDate, data[i].UserUpdate, data[i].LasteDate,
                                        data[i].Remark, data[i].edit, data[i].trash]);
                                });
                            }
                            table.draw();
                            $('#loader').hide();

                            $('#tblbeginingstocklist td:nth-of-type(4)').addClass('column_hover');
                            $('#tblbeginingstocklist td:nth-of-type(3)').addClass('column_hover');

                            $('#tblbeginingstocklist tbody').on('click', 'td', function (e) {
                                e.preventDefault();

                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;

                                //console.log(rIndex + ':' + cIndex);
                                var gid = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                var imBranchGid = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var BranchName = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var WhID = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(3)');
                                var WhDesc = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(4)');
                                var WhZoneID = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(5)');
                                var WhZoneDesc = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(6)');
                                var GoodGroupID = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(7)');
                                var GoodGroupDesc = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(8)');

                                var GoodTypeID = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(9)');
                                var GoodTypeDesc = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(10)');


                                var GoodCodeID = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(11)');
                                var GoodCode = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(12)');
                                var GoodName = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(13)');
                                var GoodUnitID = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(14)');
                                var GoodUnitDesc = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(15)');
                                var ControlNo = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(16)');
                                var LotNo = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(17)');
                                var AdjustQty = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(18)');
                                var QCQty = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(19)');
                                var InvQty = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(20)');
                                var OrderQty = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(21)');
                                var BorrowQty = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(22)');
                                var ReserveQty = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(23)');
                                var DestroyQty = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(24)');
                                var RepairQty = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(25)');
                                var ReturnQty = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(26)');
                                var CNQty = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(27)');
                                var PurCost = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(28)');
                                var AddCost1 = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(29)');
                                var AddCost2 = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(30)');
                                var AddCost3 = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(31)');
                                var UnitCost = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(32)');
                                var AVCost = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(33)');
                                var AVCost2 = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(34)');
                                var MinimumPrice = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(35)');
                                var MaximumPrice = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(36)');
                                var UnitPrice = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(37)');
                                var DiscPercent = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(38)');
                                var DiscCash = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(39)');
                                var NetPrice = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(40)');
                                var ReceiveDate = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(41)');
                                var ExpiredDate = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(42)');
                                var UserCreate = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(43)');
                                var CreateDate = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(44)');
                                var UserUpdate = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(45)');
                                var LasteDate = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(46)');
                                var Remark = $("#tblbeginingstocklist").find('tr:eq(' + rIndex + ')').find('td:eq(47)');

                                //console.log(gid.text());
                                if (rIndex != 0 & cIndex == 48) {
                                    //update function
                                    $('#btnfindgood').addClass('hidden');
                                    $('#divgoodcode').removeClass('input-group');   

                                    $('#btnsavenew').addClass('hidden');
                                    $('#btnsavechange').removeClass('hidden');
                                    $('#btndelete').addClass('hidden');

                                    $('#txtGoodCode').prop("disabled", true);
                                    $('#txtGoodName').prop("disabled", true);
                                    $('#txtGoodGroupDesc').prop("disabled", true);
                                    $('#txtGoodTypeDesc').prop("disabled", true);
                                    $('#txtGoodUnitDesc').prop("disabled", true);
                                    $('#selectBranchName').prop("disabled", false);
                                    $('#selectWhDesc').prop("disabled", false);
                                    $('#selectWhZoneDesc').prop("disabled", false);
                                    $('#txtLotNo').prop("disabled", false);
                                    $('#txtInvQty').prop("disabled", false);
                                    $('#txtPurCost').prop("disabled", false);
                                    $('#txtUnitPrice').prop("disabled", false);
                                    $('#txtRemark').prop("disabled", false);

                                    clearinputform();

                                    $('#gid').val(gid.text());

                                    $('#txtGoodCodeID').val(GoodCodeID.text());
                                    $('#txtGoodCode').val(GoodCode.text());
                                    $('#txtGoodName').val(GoodName.text());
                                    $('#txtGoodGroupID').val(GoodGroupID.text());
                                    $('#txtGoodGroupDesc').val(GoodGroupDesc.text());
                                    $('#txtGoodTypeID').val(GoodTypeID.text());
                                    $('#txtGoodTypeDesc').val(GoodTypeDesc.text());
                                    $('#txtGoodUnitID').val(GoodUnitID.text());
                                    $('#txtGoodUnitDesc').val(GoodUnitDesc.text());
                                    $('#selectBranchName').val(imBranchGid.text());
                                    $('#selectBranchName').change();

                                    $('#selectWhDesc').val(WhID.text());
                                    $('#selectWhDesc').change();

                                    $('#selectWhZoneDesc').val(WhZoneID.text());
                                    $('#selectWhZoneDesc').change();

                                    $('#txtControlNo').val(ControlNo.text());
                                    $('#txtLotNo').val(LotNo.text());
                                    $('#txtInvQty').val(InvQty.text());
                                    $('#txtPurCost').val(PurCost.text());
                                    $('#txtUnitPrice').val(UnitPrice.text());
                                    $('#txtRemark').val(Remark.text());


                                    $("#modalbeginstock").modal({ backdrop: false });
                                    $('[id=modalbeginstock]').modal('show');
                                    //window.location.href = "so-creditapproval-edit.aspx?opt=optso&mod=edit&gid=" + gid.text();
                                }

                                if (rIndex != 0 & cIndex == 49) {

                                    clearinputform();

                                    //delete function
                                    $('#btnfindgood').addClass('hidden');
                                    $('#divgoodcode').removeClass('input-group');

                                    $('#btnsavenew').addClass('hidden');
                                    $('#btnsavechange').addClass('hidden');
                                    $('#btndelete').removeClass('hidden');
                                    
                                    $('#txtGoodCode').prop("disabled", true);
                                    $('#txtGoodName').prop("disabled", true);
                                    $('#txtGoodGroupDesc').prop("disabled", true);
                                    $('#txtGoodTypeDesc').prop("disabled", true);
                                    $('#txtGoodUnitDesc').prop("disabled", true);
                                    $('#selectBranchName').prop("disabled", true);
                                    $('#selectWhDesc').prop("disabled", true);
                                    $('#selectWhZoneDesc').prop("disabled", true);
                                    $('#txtLotNo').prop("disabled", true);
                                    $('#txtInvQty').prop("disabled", true);
                                    $('#txtPurCost').prop("disabled", true);
                                    $('#txtUnitPrice').prop("disabled", true);
                                    $('#txtRemark').prop("disabled", true);
                                    

                                    $('#gid').val(gid.text());

                                    $('#txtGoodCodeID').val(GoodCodeID.text());
                                    $('#txtGoodCode').val(GoodCode.text());
                                    $('#txtGoodName').val(GoodName.text());
                                    $('#txtGoodGroupID').val(GoodGroupID.text());
                                    $('#txtGoodGroupDesc').val(GoodGroupDesc.text());
                                    $('#txtGoodTypeID').val(GoodTypeID.text());
                                    $('#txtGoodTypeDesc').val(GoodTypeDesc.text());
                                    $('#txtGoodUnitID').val(GoodUnitID.text());
                                    $('#txtGoodUnitDesc').val(GoodUnitDesc.text());
                                    $('#selectBranchName').val(imBranchGid.text());
                                    $('#selectBranchName').change();

                                    $('#selectWhDesc').val(WhID.text());
                                    $('#selectWhDesc').change();

                                    $('#selectWhZoneDesc').val(WhZoneID.text());
                                    $('#selectWhZoneDesc').change();

                                    $('#txtControlNo').val(ControlNo.text());
                                    $('#txtLotNo').val(LotNo.text());
                                    $('#txtInvQty').val(InvQty.text());
                                    $('#txtPurCost').val(PurCost.text());
                                    $('#txtUnitPrice').val(UnitPrice.text());
                                    $('#txtRemark').val(Remark.text());


                                    $("#modalbeginstock").modal({ backdrop: false });
                                    $('[id=modalbeginstock]').modal('show');
                                    //window.location.href = "so-creditapproval-edit.aspx?opt=optso&mod=edit&gid=" + gid.text();

                                    //window.location.href = "so-creditapproval-edit.aspx?opt=optso&mod=del&gid=" + gid.text();
                                }
                            });
                        }
                    });
                }

                function clearinputform() {
                    $('#gid').val('');
                    $('#txtGoodCodeID').val('');
                    $('#txtGoodCode').val('');
                    $('#txtGoodName').val('');
                    $('#txtGoodGroupID').val('');
                    $('#txtGoodGroupDesc').val('');
                    $('#txtGoodTypeID').val('');
                    $('#txtGoodTypeDesc').val('');
                    $('#txtGoodUnitID').val('');
                    $('#txtGoodUnitDesc').val('');
                    $('#selectBranchName').val('-1');
                    $('#selectBranchName').change();
                    $('#selectWhDesc').val('-1');
                    $('#selectWhDesc').change();
                    $('#selectWhZoneDesc').val('-1');
                    $('#selectWhZoneDesc').change();
                    $('#txtControlNo').val('BG');
                    $('#txtLotNo').val('');
                    $('#txtInvQty').val('');
                    $('#txtPurCost').val('');
                    $('#txtUnitPrice').val('');
                    $('#txtRemark').val('');
                }

                 var btnsavenew = $('#btnsavenew');
                btnsavenew.click(function () {

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
                                url: 'general-services.asmx/getGoodCodeBeginStockUpdateEntry',
                                method: 'post',
                                data: {
                                    acttrans: 'new',
                                    gid: $('#gid').val(),
                                    imBranchGid: $('#selectBranchName').val(),
                                    WhID:  $('#selectWhDesc').val(),
                                    WhZoneID:  $('#selectWhZoneDesc').val(),
                                    GoodGroupID: $('#txtGoodGroupID').val(),
                                    GoodCodeID: $('#txtGoodCodeID').val(),
                                    ControlNo: $('#txtControlNo').val(),
                                    LotNo: $('#txtLotNo').val(),
                                    AdjustQty: 0,
                                    QCQty: 0,
                                    InvQty: $('#txtInvQty').val(),
                                    OrderQty: 0,
                                    BorrowQty: 0,
                                    ReserveQty: 0,
                                    DestroyQty: 0,
                                    RepairQty: 0,
                                    ReturnQty: 0,
                                    CNQty: 0,
                                    PurCost: $('#txtPurCost').val(),
                                    AddCost1: 0,
                                    AddCost2: 0,
                                    AddCost3: 0,
                                    UnitCost: 0,
                                    AVCost: 0,
                                    AVCost2: 0,
                                    MinimumPrice: 0,
                                    MaximumPrice: 0,
                                    UnitPrice: $('#txtUnitPrice').val(),
                                    DiscPercent: 0,
                                    DiscCash: 0,
                                    NetPrice: 0,
                                    ReceiveDate: null,
                                    ExpiredDate: null,
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
                                        reloaddata();                                       
                                        $('[id=modalbeginstock]').modal('hide');
                                    }, 2000);

                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    })
                });

                var btnsavechange = $('#btnsavechange');
                btnsavechange.click(function () {

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
                                url: 'general-services.asmx/getGoodCodeBeginStockUpdateEntry',
                                method: 'post',
                                data: {
                                    acttrans: 'edit',
                                    gid: $('#gid').val(),
                                    imBranchGid: $('#selectBranchName').val(),
                                    WhID:  $('#selectWhDesc').val(),
                                    WhZoneID:  $('#selectWhZoneDesc').val(),
                                    GoodGroupID: $('#txtGoodGroupID').val(),
                                    GoodCodeID: $('#txtGoodCodeID').val(),
                                    ControlNo: $('#txtControlNo').val(),
                                    LotNo: $('#txtLotNo').val(),
                                    AdjustQty: 0,
                                    QCQty: 0,
                                    InvQty: $('#txtInvQty').val(),
                                    OrderQty: 0,
                                    BorrowQty: 0,
                                    ReserveQty: 0,
                                    DestroyQty: 0,
                                    RepairQty: 0,
                                    ReturnQty: 0,
                                    CNQty: 0,
                                    PurCost: $('#txtPurCost').val(),
                                    AddCost1: 0,
                                    AddCost2: 0,
                                    AddCost3: 0,
                                    UnitCost: 0,
                                    AVCost: 0,
                                    AVCost2: 0,
                                    MinimumPrice: 0,
                                    MaximumPrice: 0,
                                    UnitPrice: $('#txtUnitPrice').val(),
                                    DiscPercent: 0,
                                    DiscCash: 0,
                                    NetPrice: 0,
                                    ReceiveDate: null,
                                    ExpiredDate: null,
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
                                        reloaddata();                                        
                                        $('[id=modalbeginstock]').modal('hide');
                                    }, 2000);

                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    })
                });

                var btndelete = $('#btndelete');
                btndelete.click(function () {

                    Swal.fire({
                        title: '<span class="txtLabel">ต้องการบันทึกข้อมูล ใช่หรือไม่..?</span>',
                        //text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonColor: '#d33',
                        confirmButtonColor: '#449d44',
                        confirmButtonText: '<span class="txtLabel">ยืนยัน, ลขข้อมูล.!</span>',
                        cancelButtonText: '<span class="txtLabel">ยกเลิกรายการ</span>'
                    }).then((result) => {
                        if (result.isConfirmed) {

                            $.ajax({
                                url: 'general-services.asmx/getGoodCodeBeginStockUpdateEntry',
                                method: 'post',
                                data: {
                                    acttrans: 'del',
                                    gid: $('#gid').val(),
                                    imBranchGid: $('#selectBranchName').val(),
                                    WhID:  $('#selectWhDesc').val(),
                                    WhZoneID:  $('#selectWhZoneDesc').val(),
                                    GoodGroupID: $('#txtGoodGroupID').val(),
                                    GoodCodeID: $('#txtGoodCodeID').val(),
                                    ControlNo: $('#txtControlNo').val(),
                                    LotNo: $('#txtLotNo').val(),
                                    AdjustQty: 0,
                                    QCQty: 0,
                                    InvQty: $('#txtInvQty').val(),
                                    OrderQty: 0,
                                    BorrowQty: 0,
                                    ReserveQty: 0,
                                    DestroyQty: 0,
                                    RepairQty: 0,
                                    ReturnQty: 0,
                                    CNQty: 0,
                                    PurCost: $('#txtPurCost').val(),
                                    AddCost1: 0,
                                    AddCost2: 0,
                                    AddCost3: 0,
                                    UnitCost: 0,
                                    AVCost: 0,
                                    AVCost2: 0,
                                    MinimumPrice: 0,
                                    MaximumPrice: 0,
                                    UnitPrice: $('#txtUnitPrice').val(),
                                    DiscPercent: 0,
                                    DiscCash: 0,
                                    NetPrice: 0,
                                    ReceiveDate: null,
                                    ExpiredDate: null,
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
                                        reloaddata();                                        
                                        $('[id=modalbeginstock]').modal('hide');
                                    }, 2000);

                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                        }
                    })
                });

                $('#CreditAmnt').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 2)) {
                        event.preventDefault();
                    }
                });

                $('#CreditBalance').keypress(function (event) {
                    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
                    if (($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 2)) {
                        event.preventDefault();
                    }
                });


            });
        </script>

        <h1>Begining Stock <%--step 1 check pages content name--%>
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
                            <i class="fa fa-cube text-orange"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnaddnew" class="btn btn-default btn-sm" data-toggle="tooltip" title="new"><i class="fa fa-plus text-green"></i></button>
                                <button type="button" id="btnreload" class="btn btn-default btn-sm" data-toggle="tooltip" title="reload"><i class="fa fa-refresh text-blue"></i></button>
                                <button type="button" id="btnPdf1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="pdf"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExportExcel" class="btn btn-default btn-sm" data-toggle="tooltip" title="excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">Begining Stock Balance</label>
                        </div>

                        <div class="box-body">
                            <table id="tblbeginingstocklist" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>                                        
                                        <th>imBranchGid</th>
                                        <th>BRANCH</th>
                                        <th>WhID</th>
                                        <th>WAREHOUSE</th>
                                        <th>WhZoneID</th>
                                        <th>ZONE</th>
                                        <th>GoodGroupID</th>
                                        <th>GROUP</th>
                                        <th>TypeID</th>
                                        <th>TypeDesc</th>
                                        <th>GoodCodeID</th>
                                        <th>GOODCODE</th>
                                        <th>GOODNAME</th>
                                        <th>GoodUnitID</th>
                                        <th>UNIT</th>
                                        <th>Control No</th>
                                        <th>LotNo</th>
                                        <th>AdjustQty</th>
                                        <th>QCQty</th>
                                        <th>InvQty</th>
                                        <th>OrderQty</th>
                                        <th>BorrowQty</th>
                                        <th>ReserveQty</th>
                                        <th>DestroyQty</th>
                                        <th>RepairQty</th>
                                        <th>ReturnQty</th>
                                        <th>CNQty</th>
                                        <th>PurCost</th>
                                        <th>AddCost1</th>
                                        <th>AddCost2</th>
                                        <th>AddCost3</th>
                                        <th>UnitCost</th>
                                        <th>AVCost</th>
                                        <th>AVCost2</th>
                                        <th>MinimumPrice</th>
                                        <th>MaximumPrice</th>
                                        <th>UnitPrice</th>
                                        <th>DiscPercent</th>
                                        <th>DiscCash</th>
                                        <th>NetPrice</th>
                                        <th>ReceiveDate</th>
                                        <th>ExpiredDate</th>
                                        <th>UserCreate</th>
                                        <th>CreateDate</th>
                                        <th>UserUpdate</th>
                                        <th>LasteDate</th>
                                        <th>Remark</th>
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

        <!-- /.modal myModalCompany -->
        <div class="modal modal-default fade" id="modalbeginstock">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Update Begining Stock</h4>
                    </div>

                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row hidden" style="margin-bottom: 5px">
                                <div class="col-md-4">GID</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel" id="gid" name="gid" placeholder="" value="" autocomplete="off" required disabled>
                                </div>
                            </div>



                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">รหัสสินค้า</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel hidden" id="txtGoodCodeID" name="txtGoodCodeID" placeholder="" value="" autocomplete="off" required>
                                    <div class="input-group" id="divgoodcode">       
                                        <input type="text" class="form-control input txtLabel" id="txtGoodCode" name="txtGoodCode" placeholder="" value="" autocomplete="off" required readonly>
                                        <div class="input-group-btn">
                                            <button type="button" id="btnfindgood" class="btn btn-success">Find</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">ชื่อสินค้า</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel" id="txtGoodName" name="txtGoodName" placeholder="" value="" autocomplete="off" required readonly>
                                </div>
                            </div>


                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">กลุ่มสินค้า</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel hidden" id="txtGoodGroupID" name="txtGoodGroupID" placeholder="" value="" autocomplete="off" required >
                                    <input type="text" class="form-control input txtLabel" id="txtGoodGroupDesc" name="txtGoodGroupDesc" placeholder="" value="" autocomplete="off" required readonly>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">กลุ่ประเภทสินค้า</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel hidden" id="txtGoodTypeID" name="txtGoodTypeID" placeholder="" value="" autocomplete="off" required >
                                    <input type="text" class="form-control input txtLabel" id="txtGoodTypeDesc" name="txtGoodTypeDesc" placeholder="" value="" autocomplete="off" required readonly>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">กลุ่หน่วยนับสินค้า</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel hidden" id="txtGoodUnitID" name="txtGoodUnitID" placeholder="" value="" autocomplete="off" required >
                                    <input type="text" class="form-control input txtLabel" id="txtGoodUnitDesc" name="txtGoodUnitDesc" placeholder="" value="" autocomplete="off" required  readonly>
                                </div>
                            </div>
               

                            <div class="form-group row" style="margin-bottom: 5px">
                                <label class="col-sm-4 col-form-label txtLabel text-right">รหัสสาขา </label>
                                <div class="col-sm-8">
                                    <span class="txtLabel " style="width: 100%">
                                        <select id="selectBranchName" class="form-control input-sm " style="width: 100%">
                                        </select>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group row" style="margin-bottom: 5px">
                                <label class="col-sm-4 col-form-label txtLabel text-right">คลังสินค้า </label>
                                <div class="col-sm-8">
                                    <span class="txtLabel " style="width: 100%">
                                        <select id="selectWhDesc" class="form-control input-sm " style="width: 100%">
                                        </select>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group row" style="margin-bottom: 5px">
                                <label class="col-sm-4 col-form-label txtLabel text-right">โซนสินค้า </label>
                                <div class="col-sm-8">
                                    <span class="txtLabel " style="width: 100%">
                                        <select id="selectWhZoneDesc" class="form-control input-sm " style="width: 100%">
                                        </select>
                                    </span>
                                </div>
                            </div>                        

                           
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">รหัสควบคุม</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel" id="txtControlNo" name="txtControlNo" placeholder="" value="BG" autocomplete="off" required disabled>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">เลขล็อตสินค้า</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel" id="txtLotNo" name="txtLotNo" placeholder="" value="" autocomplete="off" required >
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">จำนวนสินค้า</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel" id="txtInvQty" name="txtInvQty" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">ต้นทุนซื้อ</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel" id="txtPurCost" name="txtPurCost" placeholder="" value="" autocomplete="off" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">ต้นทุนขาย</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control input txtLabel" id="txtUnitPrice" name="txtUnitPrice" placeholder="" value="" autocomplete="off" required>
                                </div>
                            </div>


                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-md-4 txtLabel text-right">หมายเหตุ</div>
                                <div class="col-md-8">
                                    <textarea cols="40" rows="3" id="txtRemark" name="txtRemark" class="form-control input txtLabel"></textarea>
                                    <%--<input type="text" class="form-control input input-sm" id="txtGradeDetailEdit" name="txtGradeDetailEdit" placeholder="" value="" required>--%>
                                </div>
                            </div>                       

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default txtLabel" data-dismiss="modal">ยกเลิกรายการ</button>
                        <button type="button" id="btnsavenew" class="btn btn-success txtLabel">บันทึกปรับปรุงรายการ </button>
                        <button type="button" id="btnsavechange" class="btn btn-success txtLabel">บันทึกปรับปรุงรายการ </button>
                        <button type="button" id="btndelete" class="btn btn-danger txtLabel">ต้องการลบรายการ </button>
                    </div>
                </div>
            </div>
        </div>


        <!-- /.modal modal goodcode -->
            <div class="modal modal-default fade" id="modalgoodcode">
                <div class="modal-dialog" style="width: 700px;">
                    <div class="modal-content" >
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Goods List</h4>
                        </div>

                        <div class="modal-body">
                            <div class="container-fluid">
                                <table id="tblgoodcodeselect" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>GROUPCODE</th>
                                        <th>GROUP</th>
                                        <th>GoodTypeID</th>
                                        <th>TYPE</th>
                                        <th>CODE</th>
                                        <th>GOODNAME</th>
                                        <th>GoodColorID</th>
                                        <th>COLOR</th>
                                        <th>GoodUnitID</th>
                                        <th>UNIT</th>                                                                           
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
