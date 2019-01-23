<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require __DIR__ . "/BASE_REST_Controller.php";

class Order extends BASE_REST_Controller
{

    public function orders()
    {
        $page        = $this->input->get("page");
        $offset      = $this->input->get("offset");
        $customer_id = $this->input->get("customer_id");
        $this->load->model("Orders_model");
        $this->load->helper("persiandate_helper");

        if (!$customer_id) {
            return $this->resp(false, "customer_id not provided or empty.");
        }
        // $province_id = $this->input->get('province_id');

        $this->db->select("*")
                 ->from('orders');
        // ->join('category', "products.main_cat_id = category.id", "left")
        // ->join('product_images',"product_images.product_id=product.id","left");
        // ->join("province", "products.province_id = province.id", "left");

        // if (isset($_GET['sub_cat_id'])) {
        //     $this->db->where("(products.admin_approved = 1 and products.sub_cat_id=$sub_cat_id)");
        // } else {
        //     $this->db->where("products.admin_approved = 1");
        // }

        // $where = "( products.admin_approved = 1";
        // if (isset($_GET['sub_cat_id'])) {
        //     $where .= " and products.sub_cat_id=$sub_cat_id ";
        // }
        // $where .= " )";
        $where = array("customer_id" => $customer_id);
        $this->db->where($where);
        if (isset($_GET['page']) && isset($_GET['offset'])) {
            $this->db->limit($page, $offset * $page);
        }

        // if (isset($_GET['province_id']))
        //     $this->db
        //         ->order_by("field(karjoo.province_id,{$province_id}) DESC, karjoo.province_id");
        // else
        //     $this->db->order_by("created_at", "DESC");

        // var_dump($this->db->get_compiled_select());
        // exit;
        $this->db->order_by("created_at", "desc");
        $res = $this->db->get()->result_array();
        // add image absolute paths
        // foreach ($res as &$r) {
        //     $images = explode(',', $r['images']);
        //     $tmp    = array();
        //     foreach ($images as $i) {
        //         $tmp[] = base_url(PRODUCT_IMAGE_PATH . "/" . $i);
        //     }
        //     $r['images'] = $tmp;
        //
        //     // $r["image_absolute_path"] = base_url(AD_IMAGE_PATH . "/" . $r["image"]);
        // }

        foreach ($res as &$order) {
            $order                          = array_merge($order, $this->Orders_model->get_order_detail($order));
            $order["created_at_fa"]         = convert_gregorian_iso_to_jalali_iso($order["created_at"]);
            $order["prepayment_factor_pdf"] = base_url("ui/userreport/invoice?order_id=" . $order['id'] . "&format=pdf");
            // $order["prepayment_factor_"] = base_url("ui/userreport/invoice?order_id=" . $order['id'] . "&format=pdf");
            if ($order['order_status'] == 'ORDER_CONFIRMED') {
                $order['payment_url'] = base_url('ui/payment/index?order_id=' . $order['id']);
            }
        }


        $this->resp(true, $res);
    }

    public function order_detail()
    {
        $order_id = $this->input->get("order_id");

        $this->db->select('*')
                 ->from('view_order_lines_detail');

        $res = $this->db->get()->result_array();

        $this->resp(true, $res);
    }


}