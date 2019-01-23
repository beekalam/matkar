<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require __DIR__ . "/BASE_REST_Controller.php";

class User extends BASE_REST_Controller
{
    public function ad_history()
    {
        $user_id = $this->input->get("user_id");
        if (!isset($_GET['user_id']) && empty($_GET['user_id'])) {
            return $this->resp(false, "User id is not set or not provided.");
        }

        $data["job_ads"] = $this->db->select("karjoo.firstname,karjoo.lastname,job_ads.user_id,education_majors.major,education_degrees.degree,careers.career,
        job_ads.ad_type,job_ads.employee_resume,job_ads.employer_desc,job_ads.employer_num_people,job_ads.employer_job_hours,employee_gender,employer_gender_pref,
        job_ads.title,job_ads.address,job_ads.job_contact_number,job_ads.admin_approved,
                job_ads.created_at")
                                    ->select("group_concat(province.name) as location_names")
                                    ->from('job_ads')
                                    ->join("education_degrees", "job_ads.id=education_degrees.id", "left")
                                    ->join("education_majors", "job_ads.id=education_majors.id", "left")
                                    ->join("karjoo", "job_ads.user_id=karjoo.id", "left")
                                    ->join("careers", "job_ads.career_id=careers.id", "left")
                                    ->join("job_ad_location", "job_ads.id=job_ad_location.job_ad_id", "left")
                                    ->join("province", "job_ad_location.location_id=province.id")
                                    ->where("job_ads.user_id", $user_id)
                                    ->group_by("job_ads.id")
                                    ->get()
                                    ->result_array();

        $data["product_ads"] = $this->db->select("products.id,products.name,products.description,products.image,products.contact_number,products.price")
                                        ->from('products')
                                        ->join('karjoo', "products.user_id = karjoo.id", "left")
                                        ->where("karjoo.id", $user_id)
                                        ->get()
                                        ->result_array();

        foreach($data["product_ads"] as &$pad){
            $pad["image_absolute_path"] = base_url(AD_IMAGE_PATH."/".$pad['image']);
        }

        $this->resp(true, $data);
    }


}