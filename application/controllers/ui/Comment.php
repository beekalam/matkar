<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH . "controllers/Base.php");

class Comment extends Base
{
    function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        $this->load->helper("sms_helper");

        $data = array("active_menu" => "",
                      "title"       => "نظرات کاربران");

        $this->view("comments/index", $data);
    }

    public function comments_list()
    {
        require APPPATH . "third_party/datatable-ssp/ssp.class.php";

        $table = 'view_product_comments';

        // Table's primary key
        $primaryKey = 'id';

        $columns = array(
            array('db' => 'id', 'dt' => 'id'),
            array('db' => 'comment', 'dt' => 'comment'),
            array('db' => 'product_id', 'dt' => 'product_id'),
            array('db' => 'customer_id', 'dt' => 'customer_id'),
            array('db' => 'firstname', 'dt' => 'firstname'),
            array('db' => 'lastname', 'dt' => 'lastname'),
            array('db' => 'title', 'dt' => 'title'),
            array('db' => 'description', 'dt' => 'description'),
            array('db' => 'status', 'dt' => 'status'),
        );

        echo json_encode(SSP::simple($_GET, $this->build_sql_details(), $table, $primaryKey, $columns));
    }

    public function approve_comment()
    {
        $id  = $this->input->post("id");
        $res = $this->db->set('status', '1')
                        ->where('id', $id)
                        ->update('product_comments');
        ejson(true);
    }

    public function delete_comment()
    {
        $id  = $this->input->post("id");
        $res = $this->db->where('id', $id)->delete('product_comments');
        ejson(true);
    }
}
