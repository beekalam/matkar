<script src="<?php echo base_url('assets/handlebars-v4.0.11.js'); ?>"></script>
<script src="<?php echo base_url('assets/loading-overlay/loadingoverlay.min.js'); ?>"></script>
<script src="<?php echo base_url() ?>assets/js/mansouri.js?id=<?php echo uniqid(); ?>"></script>

<div class="portlet box blue-hoki">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-plus"></i>
            <span class="caption-subject bold uppercase">سفارش ها
           </span>
        </div>
        <div class="actions">
            <!--<a href="--><?php //echo base_url('ui/units/index'); ?><!--" class="btn btn-default btn-sm">-->
            <!--    <i class="fa fa-pencil"></i> مدیریت سفارش ها-->
            <!--</a>-->
            <!--<button class="btn btn-default btn-sm trigger" onclick="loadNewBetModal()">-->
            <!--    <i class="fa fa-plus"></i> افزودن-->
            <!--</button>-->
        </div>
    </div>
    <div class="portlet-body">

        <div class="tabbable-line">
            <ul class="nav nav-tabs">
                <li class="<?php echo $type == 'ORDER_CREATED' ? 'active' : ''; ?>">
                    <a href="<?php echo base_url('ui/orders/index?type=ORDER_CREATED'); ?>"> در انتظار تایید </a>
                </li>
                <li class="<?php echo $type == 'ORDER_CONFIRMED' ? 'active' : ''; ?>">
                    <a href="<?php echo base_url('ui/orders/index?type=ORDER_CONFIRMED'); ?>"> در انتظار پیش پرداخت </a>
                </li>
                <li class="<?php echo $type == 'ORDER_PREPAYMENT_DONE' ? 'active' : ''; ?>">
                    <a href="<?php echo base_url('ui/orders/index?type=ORDER_PREPAYMENT_DONE'); ?>">پیش پرداخت شده</a>
                </li>
                <li class="<?php echo $type == 'ORDER_PAID' ? 'active' : ''; ?>">
                    <a href="<?php echo base_url('ui/orders/index?type=ORDER_PAID'); ?>">پرداخت شده</a>
                </li>
                <li class="<?php echo $type == 'ORDER_SHIPPED' ? 'active' : ''; ?>">
                    <a href="<?php echo base_url('ui/orders/index?type=ORDER_SHIPPED'); ?>">در حال ارسال</a>
                </li>
                <li class="<?php echo $type == 'ORDER_DELIVERED' ? 'active' : ''; ?>">
                    <a href="<?php echo base_url('ui/orders/index?type=ORDER_DELIVERED'); ?>">ارسال شده</a>
                </li>
                <!--<li class="">-->
                <!--    <a href="--><?php //echo base_url('ui/orders/index?type=ORDER_DELIVERED'); ?><!--"-->
                <!--       aria-expanded="false">ارسال شده</a>-->
                <!--</li>-->
            </ul>
            <div class="tab-content">
                <div class="tab-pane active">
                    <div class="row">
                        <table class="table table-responsive table-hover table-striped" id="table-reservations">
                            <thead>
                            <th>سفارش دهنده</th>
                            <th>موبایل</th>
                            <th>تاریخ متقاضی</th>
                            <th>آدرس</th>
                            <th>actions</th>
                            <!--<th>reseller</th>-->
                            <!--<th>actions</th>-->
                            <!--<th>نام آگهی دهنده</th>-->
                            <!--<th>ایمیل</th>-->
                            <!--<th>استان</th>-->
                            <!--<th>is_employer</th>-->
                            <!--<th>emp details</th>-->
                            <!--<th>created_at</th>-->
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<div class="modal fade" id="add_update_product" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title persian-font" id="modalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="new_bet_modal_content">
                <iframe src=""
                        frameborder="0" style="width:100%" height="600px"
                        id="modal_iframe">
                </iframe>
            </div>
            <div class="modal-footer">
                <!--<button type="button" class="btn btn-secondary" data-dismiss="modal">بستن</button>-->
                <!--<button type="submit" class="btn btn-primary">ثبت</button>-->
            </div>
        </div>
    </div>
</div>

<script>
    function closeIFrame() {
        $("#modal_iframe").attr("src", "");
        $("#add_update_product").modal("hide");
    }

    function loadNewBetModal() {
        $.LoadingOverlay("show");
        $("#modal_iframe").attr("src", "<?php echo base_url('ui/products/add_update_product?action=new'); ?>");
        $("#add_update_product").modal();
        $.LoadingOverlay("hide");
    }

    $(document).ready(function () {
        var opt = build_datatable_init();
        <?php if(isset($type)): ?>
        opt["ajax"] = "<?php echo base_url('ui/orders/orders_list?type=' . $type); ?>";
        <?php else: ?>
        opt["ajax"] = "<?php echo base_url('ui/orders/orders_list?'); ?>";
        <?php endif; ?>
        opt["columnDefs"] = [
            {
                "targets": 0,
                "data": "firstname",
                "render": function (data, type, row, meta) {
                    return row['firstname'] + " " + row["lastname"];
                }
            },
            {
                "targets": 1,
                "data": "mobile",
                "render": function (data, type, row, meta) {
                    return data;
                }
            },
            {
                "targets": 2,
                "data": "user_request_date",
                "render": function (data, type, row, meta) {
                    return data;
                }
            },
            {
                "targets": 3,
                "data": "user_address",
                "render": function (data, type, row, meta) {
                    return data;
                }
            },
            {
                "targets": 4,
                "data": "id",
                "render": function (data, type, row, meta) {
                    var ret = '';
                    if (row['order_status'] == 'ORDER_CREATED') {
                        ret += "<button class='btn btn-sm btn-circle btn-default' onClick='confirmOrder({0})'>تایید سفارش</button>".format(data);
                    } else if(row['order_status'] == 'ORDER_PREPAYMENT_DONE') {
                        ret += "<button class='btn btn-sm btn-circle btn-default' onClick='confirmOrderPayment({0})'>تایید پرداخت</button>".format(data);
                    } else if(row['order_status'] == 'ORDER_PAID'){
                        ret += "<button class='btn btn-sm btn-circle btn-default' onClick='confirmOrderShipped({0})'>تایید ارسال</button>".format(data);
                    }
                    return ret;
                }
            }
            //{
            //    "targets": 4,
            //    "data": "reseller_id",
            //    "render": function (data, type, row, meta) {
            //        var name = row["reseller_firstname"] + " " + row["reseller_lastname"];
            //        name     = name.replace(/null/g, "--");
            //        // console.log( row['reseller_id']);
            //        return "<a href='javascript:;' onClick='changeReseller({0})'>{1}</a>".format(row['id'], name);
            //    }
            //},
            //{
            //    "targets": 5,
            //    "data": "id",
            //    "render": function (data, type, row, meta) {
            //        var btn = '<button class="btn btn-default btn-circle"  onclick="delete_product(\'' + data + '\')">';
            //        btn += "حذف";
            //        btn += "</button>";
            //        var url = "<?php //echo base_url('ui/products/manage_images?id='); ?>//";
            //        url += data;
            //        btn += "<a class='btn btn-default btn-circle' href='{0}'>تصاویر</a>".format(url);
            //        return btn;
            //        return data;
            //    }
            //},

            // {
            //     "targets": 6,
            //     "data": "email",
            //     "render": function (data, type, row, meta) {
            //       return data;
            //     }
            // },
            // {
            //     "targets": 7,
            //     "data": "province_name",
            //     "render": function (data, type, row, meta) {
            //         return data;
            //     }
            // },

        ];

        $("#table-reservations").DataTable(opt);

    });

    // $('body').on('click', '.person_type_btn', function () {
    //     var self = $(this);
    //     var view = {
    //         'person_semat': self.attr("data-person-semat") || "--",
    //         'company_name': self.attr("data-company-name") || "--"
    //     };
    //
    //     var content = compile_handlebar("person-type-template", view);
    //     build_bootstrap_modal({"placementId": "modal-holder", "content": content});
    // });
    //
    // $('body').on('click', '.karfarma_details', function () {
    //     var self = $(this);
    //     var view = {
    //         'certification_no': self.attr('data-certification-no'),
    //         'certification_image': self.attr('data-certification-image')
    //     };
    //     // console.log(view);
    //     var content = compile_handlebar("karfarma-template", view);
    //     // console.log(content);
    //     build_bootstrap_modal({"placementId": "modal-holder", "content": content});
    // });

    //function confirmOrder(order_id) {
    //    // alert(order_id);
    //    var dlg = {
    //        "url": "<?php //echo base_url('ui/orders/confirm_order'); ?>//",
    //        "reload_on_success": true,
    //        "title": "تایید سفارش",
    //        "html": "مطمئن هستید؟",
    //        "to_send": {
    //            'id': order_id
    //        }
    //    };
    //    ask_user_confirm(dlg);
    //}

    function confirmOrder(order_id) {


        swal({
            title: 'درصد پیش پرداخت',
            input: 'number',
            inputValue: 40,
            // inputPlaceholder: 'Type your message here',
            showCancelButton: true,
            confirmButtonText: "تایید",
            cancelButtonText: "انصراف",
            inputValidator: function (value) {
                return new Promise(function (resolve) {
                    if (value === '') {
                        resolve('مقدار نامعتبر');
                    } else {
                        // resolve(value);
                        var dlg = {
                            "url": "<?php echo base_url('ui/orders/confirm_order'); ?>",
                            "reload_on_success": true,
                            "title": "تایید سفارش",
                            "html": "مطمئن هستید؟",
                            "to_send": {
                                'prepayment_percent': value,
                                'id': order_id
                            }
                        };
                        ask_user_confirm(dlg);
                    }
                })
            }
        });


    }


    function confirmOrderPayment(order_id){
            // alert(order_id);
            var dlg = {
                "url": "<?php echo base_url('ui/orders/confirm_order_payment'); ?>",
                "reload_on_success": true,
                "title": "تایید پرداخت سفارش",
                "html": "مطمئن هستید؟",
                "to_send": {
                    'id': order_id
                }
            };
            ask_user_confirm(dlg);
    }


    function changeUnit(product_id) {

        swal({
            title: 'انتخاب واحد',
            input: 'select',
            inputOptions: {
                <?php
                // foreach ($units as $r) {
                //     echo "'{$r['id']}':'{$r['unit_name']}',";
                // }
                ?>
            },
            inputPlaceholder: 'انتخاب کنید',
            showCancelButton: true,
            inputValidator: function (value) {
                return new Promise(function (resolve) {
                    if (value === '') {
                        resolve('یک واحد انتخاب کنید.');
                    } else {
                        // resolve(value);
                        var dlg = {
                            "url": "<?php echo base_url('ui/products/change_unit'); ?>",
                            "reload_on_success": true,
                            "title": "تغییر واحد",
                            "html": "مطمئن هستید؟",
                            "to_send": {
                                'unit_id': value,
                                'product_id': product_id
                            }
                        };
                        ask_user_confirm(dlg);
                    }
                })
            }
        });

    }

    //function delete_product(product_id){
    //    var dlg = {
    //        "url": "<?php //echo base_url('ui/products/delete_product'); ?>//",
    //        "reload_on_success" : true,
    //        "title" : "حذف کالا",
    //        "html": "مطمئن هستید؟",
    //        "to_send":{
    //            'id':product_id
    //        }
    //    };
    //    ask_user_confirm(dlg);
    //}

</script>
