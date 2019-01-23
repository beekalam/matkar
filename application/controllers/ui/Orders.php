<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH . "controllers/Base.php");

class Orders extends Base
{

    function __construct()
    {
        parent::__construct();
        $this->load->library('Jalali_date');
    }

    public function index()
    {
        $data         = array("active_menu" => "m-manage-orders", "title" => "سفارشات");
        $data['type'] = $this->input->get('type') ? $this->input->get('type') : 'ORDER_CREATED';

        $this->view('orders/index', $data);
    }

    public function orders_list()
    {
        require APPPATH . "third_party/datatable-ssp/ssp.class.php";

        $table = 'view_orders_list';

        // Table's primary key
        $primaryKey = 'id';

        $columns = array(
            array('db' => 'id', 'dt' => 'id'),
            array('db' => 'firstname', 'dt' => 'firstname'),
            array('db' => 'lastname', 'dt' => 'lastname'),
            array('db' => 'mobile', 'dt' => 'mobile'),
            array('db' => 'customer_id', 'dt' => 'customer_id'),
            array('db' => 'created_at', 'dt' => 'created_at'),
            array('db' => 'user_request_date', 'dt' => 'user_request_date'),
            array('db' => 'order_type', 'dt' => 'order_type'),
            array('db' => 'order_status', 'dt' => 'order_status'),
            // array('db' => 'company_name', 'dt' => 'company_name'),
            // array('db' => 'province_id', 'dt' => 'province_id'),
            // array('db' => 'province_name', 'dt' => 'province_name'),
            // array('db' => 'is_employer', 'dt' => 'is_employer'),
            // array('db' => 'employer_details_id', 'dt' => 'employer_details_id'),
            // array('db' => 'certification_image', 'dt' => 'certification_image'),
            // array('db' => 'certification_no', 'dt' => 'certification_no'),
            // array('db' => 'created_at', 'dt' => 'created_at'),
            array('db' => 'user_address', 'dt' => 'user_address'),
        );


        if (isset($_GET['type'])) {
            $type = $this->input->get("type");
            echo json_encode(SSP::complex($_GET, $this->build_sql_details(), $table, $primaryKey, $columns, " order_status='{$type}'"));
        } else {
            echo json_encode(SSP::simple($_GET, $this->build_sql_details(), $table, $primaryKey, $columns));
        }
    }

    public function confirm_order()
    {
        $id                 = $this->input->post("id");
        $prepayment_percent = intVal($this->input->post("prepayment_percent"));

        $ok_to_continue = $prepayment_percent > 0 && $prepayment_percent <= 100;
        if (!$ok_to_continue) exit;

        $this->db->trans_start();
        $res = $this->db->set("order_status", "ORDER_CONFIRMED")
                        ->set("prepayment_percent", $prepayment_percent)
                        ->where("id", $id)
                        ->update("orders");
        // add current price to order_lines table.
        $order_lines = $this->db->get_where("order_lines", array("order_id" => $id))->result_array();
        foreach ($order_lines as $order_line) {
            $product = $this->db->get_where("products", array("id" => $order_line["product_id"]))->row(0, "array");
            if ($product) {
                $this->db->set("admin_confirmed_price", $product["price_per_unit"])
                         ->where(array("id" => $order_line["id"]))
                         ->update("order_lines");
            }
        }

        $this->db->trans_complete();

        if ($this->db->trans_status()) {
            return ejson(true);
        }

        ejson(false, "Error updating order status.");
    }

    public function confirm_order_payment()
    {
        $id = $this->input->post("id");
        if (!$id) exit;

        $this->db->trans_start();
        $res = $this->db->set("order_status", "ORDER_PAID")
                        ->where("id", $id)
                        ->update("orders");
        $this->db->trans_complete();

        if ($this->db->trans_status()) {
            return ejson(true);
        }

        ejson(false, "Error setting order paid status.");
    }

}
