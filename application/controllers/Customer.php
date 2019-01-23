<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require __DIR__ . "/BASE_REST_Controller.php";

class Customer extends BASE_REST_Controller
{

    function checkuser()
    {
        $data = new stdClass();

        if ($_REQUEST) {
            if (isset($_REQUEST['mobile']) && $_REQUEST['mobile'])// $data->mobile = $_REQUEST['mobile'];
                $data->mobile = $_REQUEST['mobile'];
            if (isset($_REQUEST['code']) && $_REQUEST['code'])// $data->mobile = $_REQUEST['mobile'];
                $data->code = $_REQUEST['code'];

        }

        if (isset($data->code) && isset($data->mobile) && $data->code && $data->mobile) {
            $datac = $this->base_model->get_data('customers', 'status', array('mobile' => $data->mobile, 'code' => $data->code));
            if (!$datac || $datac[0]->status == 0)
                $this->resp(true, array("user_active" => false));
        } else
            $this->resp(true, array("user_active" => false));
    }

    public function register()
    {
        $user_id = 0;
        $data    = null;
        $data    = new stdClass();

        if ($_REQUEST) {
            if (isset($_REQUEST['mobile']) && $_REQUEST['mobile'])
                $data->mobile = $_REQUEST['mobile'];
        }

        if ($data) {
            $data2['err'] = null;

            if ((!isset($data->mobile)) || ($data->mobile == NULL))
                $data2['err'] .= 'موبایل الزامی است.';


            if (!$data2['err']) {
                unset($data2['format']);

                if (!$this->base_model->get_data('customers', '*', array('mobile' => $data->mobile))) {
                    $user_id            = $this->base_model->insert('customers', $data);
                    $data2['registerd'] = true;
                } else {
                    $data2['logined'] = true;
                }

                if (isset($data->mobile))
                    $data2['code'] = $this->send_notify($user_id, $data->mobile);

                $this->base_model->update('customers', array('mobile' => $data->mobile), array('code' => $data2['code']));

                $data2["customer_info"] = $this->db->get_where("customers", array("mobile" => $data->mobile,
                                                                                  "code"   => $data2["code"]))
                                                   ->row(0, "array");
            }

            if ($data2)
                $this->resp(true, $data2);
        } else
            $this->resp(true, array("err" => "null"));
    }

    function send_notify($user_id, $mobile_number)
    {
        $this->load->helper("sms_helper");
        $code    = rand(1000, 9999);
        $message = ' براي تاييد ايميل 
<a href="http://shadleen.com/api/index.php/main/check_code?code=' . $code . '&user_id=' . $user_id . '">
اينجا
</a>
 کليد کنيد.
';

        if ($mobile_number) {
            send_sms_verify_code($mobile_number, $code);
        }

        return $code;

    }

    public function check_code()
    {
        $data = new stdClass();
        if ($_REQUEST) {
            if (isset($_REQUEST['mobile']) && isset($_REQUEST['code']))// $data->mobile = $_REQUEST['mobile'];
            {
                $data->mobile = $_REQUEST['mobile'];
                $data->code   = $_REQUEST['code'];
            }
        }

        log_message("debug", "in check code");
        log_message("debug", print_r($_REQUEST, true));
        if ($data && isset($data->code) && isset($data->mobile)) {
            if ($this->base_model->get_data('customers', '*', array('mobile' => $data->mobile, 'code' => $data->code))) {

                $data3['status'] = 1;
                $this->base_model->update('customers', array('mobile' => $data->mobile), $data3);
                //unset($_SESSION['register_code']);
                $res = array("user_active" => true);

                $user = $this->db->get_where("customers", array(
                    "mobile" => $data->mobile,
                    "code"   => $data->code
                ))->result_array();

                if (count($user) > 0) {
                    $res["user_id"] = $user[0]["id"];
                }
                $this->resp(true, $res);
            } else {
                //unset($_SESSION['register_code']);
                $data = array("user_active" => false);
                $this->resp(true, $data);
            }
        }
    }

    public function profile()
    {
        $this->checkuser();
        $data = new stdClass();
        if ($_REQUEST) {
            if (isset($_REQUEST['mobile']))// $data->mobile = $_REQUEST['mobile'];
                $data->mobile = $_REQUEST['mobile'];
        }
        if ($data) {
            $data = $this->base_model->get_data('customers', 'mobile,firstname,lastname,mobile,address,status,email,national_code', array('mobile' => $data->mobile));
            if ($data) {
                $this->resp(true, $data);
            }

        }
    }

    public function update_profile()
    {

        if (isset($_POST['customer_id'])) {
            $customer_id = $this->input->post('customer_id');
            $this->db->where('id', $customer_id);
            $inputs    = array('firstname', 'lastname', 'mobile', 'national_code', 'address', 'email');
            $any_input = false;
            foreach ($inputs as $input) {
                if (isset($_POST[$input])) {
                    $this->db->set($input, $this->input->post($input));
                    $any_input = true;
                }
            }

            //any of the fields where provided.
            if ($any_input)
                $this->db->update("customers");
            return $this->resp(true, array());
        }

        return $this->resp(false, "customer_id is empty or not provided.");

    }

}