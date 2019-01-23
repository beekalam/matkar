<?php
require(APPPATH . '/libraries/REST_Controller.php');

// die("in base rest controller.");

/**
 * @SWG\Swagger(
 *        produces={"application/json"},
 *        consumes={"application/json"},
 * 		@SWG\Info(
 *            title="API",
 *            description="REST API",
 *            version="1.0",
 *            termsOfService="terms",
 * 			@SWG\Contact(name="call@me.com"),
 * 			@SWG\License(name="proprietary")
 *        ),
 *
 * 		@SWG\Definition(
 *            definition="UserUpdateProfile",
 * 			@SWG\Property(property="id", type="string" , example="31"),
 * 			@SWG\Property(property="fullname", type="string", example="mohammad mansouri"),
 * 			@SWG\Property(property="national_code", type="string", example="5139998877"),
 * 			@SWG\Property(property="email", type="string", example="beekm@gmail.com"),
 * 			@SWG\Property(property="person_type", type="string", example="hoghoghi"),
 * 			@SWG\Property(property="person_semat", type="string", example="برنامه نویس"),
 * 			@SWG\Property(property="company_name", type="string", example="فانا"),
 * 			@SWG\Property(property="address", type="string", example="address"),
 * 			@SWG\Property(property="province_id", type="string", example="17"),
 *        ),
 *
 *      @SWG\Definition(
 *            definition="CategoryCatalogRequest",
 * 			@SWG\Property(property="id", type="string" , example="9"),
 *      ),
 *
 *      @SWG\Definition(
 *            definition="GetUserInfoRequest",
 * 			@SWG\Property(property="user_id", type="string" , example="31"),
 *      ),
 *
 * 		@SWG\Definition(
 *            definition="CreateAdRequest",
 * 			@SWG\Property(property="user_id", type="string" , example="31"),
 * 			@SWG\Property(property="main_cat_id", type="string", example="9"),
 * 			@SWG\Property(property="sub_cat_id", type="string" ,example="15"),
 * 			@SWG\Property(property="contact_number", type="string", example="09359012419"),
 * 			@SWG\Property(property="description", type="string", example="description"),
 * 			@SWG\Property(property="image", type="string", example="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAA4klEQVQoz5XPTQsBQRzH8d9rcFKu3sAmckCSh5cmF+UgDg6SQmRjk2elYT0lEVGODi4OXoL/P4V2p3bV5zAz/2/TDFrXmyNTQ6pkiTKK4co1oQmInTVNcIx0BbO9XRSD3qMf7KIY2QYWRyPFy8znFCOvYnUyisSY+ZxiFNrYnA2S9wfh9fyA0QbaDPUxSl2OUexge/minw3X8Pih+LigqQHKPS74jgmv33wB9tn+QnUoEYwy6YgvNgvFmXQEdSoRTjDpCG1hlrzeiHQEdPT/OCdbdJc2cTx4PN1ij/7KEmUUvwD7HXJhrSgL7QAAAABJRU5ErkJggg==")
 *      ),
 *
 *      @SWG\Definition(
 *            definition="LikeUnlikeProductRequest",
 * 			@SWG\Property(property="user_id", type="string" , example="31"),
 * 			@SWG\Property(property="product_id", type="string", example="6"),
 * 			@SWG\Property(property="operation", type="string", example="like")
 *      ),
 *     @SWG\Definition(
 *            definition="PopularProductsRequest",
 * 			@SWG\Property(property="main_cat_id", type="string" , example="9")
 *      ),
 *     @SWG\Definition(
 *          definition="EmployeeJobRequest",
 * 			@SWG\Property(property="user_id", type="string" , example="31"),
 * 			@SWG\Property(property="career_id", type="string" , example="5"),
 * 			@SWG\Property(property="major_id", type="string" , example="13"),
 * 			@SWG\Property(property="degree_id", type="string" , example="6"),
 * 			@SWG\Property(property="job_contact_number", type="string" , example="09359012568"),
 * 			@SWG\Property(property="employee_resume", type="string" , example="بسی کار نکردم در این سال سی."),
 * 			@SWG\Property(property="employee_desc", type="string" , example="من خیلی خوبم.")
 *      ),
 *     @SWG\Definition(
 *          definition="RegisterAsEmployerRequest",
 * 			@SWG\Property(property="certification_no", type="string" , example="1596895"),
 * 			@SWG\Property(property="user_id", type="string" , example="31")
 *      ),
 *      @SWG\Definition(
 *          definition="EmployerJobRequest",
 * 			@SWG\Property(property="user_id", type="string" , example="31"),
 * 			@SWG\Property(property="career_id", type="string" , example="5"),
 * 			@SWG\Property(property="job_contact_number", type="string" , example="09359012568"),
 * 			@SWG\Property(property="employer_num_people", type="string" , example="5"),
 * 			@SWG\Property(property="employer_job_hours", type="string" , example="7-3"),
 * 			@SWG\Property(property="employer_desc", type="string" , example="ما خیلی خوبیم.")
 *      ),
 *     @SWG\Definition(
 *          definition="UserParticipateInBetRequest",
 * 			@SWG\Property(property="user_id", type="string" , example="31"),
 * 			@SWG\Property(property="bet_id", type="string" , example="1"),
 * 			@SWG\Property(property="bet_option_id", type="string" , example="1")
 *      )
 *    )
 */

class BASE_REST_Controller extends REST_Controller
{

    public function __construct()
    {
        parent::__construct();
        log_message("debug",$_SERVER['REQUEST_URI']);
        log_message("debug","POST parameters are:" . print_r($_POST,true));
        log_message("debug","GET parameters are:" . print_r($_GET,true));
    }

    protected function resp($success, $data)
    {
        $to_send = array("success" => false, "data" => array());
        if ($success == false) {
            $to_send["success"] = false;
            $to_send["error"]   = $data;
        } else {
            $to_send["success"] = true;
            $to_send["data"]    = $data;
        }

        return $this->response($to_send);
    }

    protected function make_response($success, $data)
    {
        return array("success" => $success, "data" => $data);
    }

    protected function read_params()
    {
        $this->load->helper("utils");
        $params = json_decode(file_get_contents('php://input'));
        $params = object_to_array($params);
        return $params;
    }

    // protected function extract_first_last_name(){
    //     if(!isset($_POST['fullname'])){
    //         return;
    //     }
    //
    //     $name = explode(' ', $_POST['fullname']);
    //     unset($_POST['fullname']);
    //     $_POST['firstname'] = "";
    //     $_POST['lastname'] = "";
    //     if (count($name) == 2) {
    //         $_POST['firstname'] = $name[0];
    //         $_POST['lastname']  = $name[1];
    //     } else if (count($name) > 2) {
    //         $_POST['firstname'] = $name[0];
    //         unset($name[0]);
    //         $_POST['lastname'] = join(' ', $name);
    //     }
    //
    // }

}