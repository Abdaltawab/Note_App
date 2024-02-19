<?php

define('MP',10488576 );
function filterRequest($requestname){
     return htmlspecialchars(strip_tags($_POST[$requestname]));
}

function imageUpload($imageRequest){
     //rand(1000,10000) دي علشان لو صورة اتكررت بنفس الاسم بديلها رقم عشوائي قبلها علشان تترفع ومتستبدلش الاولي 
     $imagename  =rand(1000,10000) .$_FILES[$imageRequest]['name'];
     $imagetmp   = $_FILES[$imageRequest]['tmp_name'];
     $imagesize  = $_FILES[$imageRequest]['size'];
     $allowExt   = array("jpg","png", "gif","mp3","pdf","jpeg");
     $strToArray = explode(".",$imagename);
     $ext        = end($strToArray);
     $ext        = strtolower($ext);
     // لقيت ملف بدون extention
     if(!empty($imagename) && !in_array($ext,$allowExt)){
          $msgError[] = "Ext"; 
     }
     if($imagesize >2* MP ){
          $msgError[] = "size";
     }
     if(empty($msgError)){
          
     //move_uploaded_file() دي بتاخد الصورة من المسار المؤقت وبيرفعه علي السيرفر بالمسار اللي انت هتحدده
     move_uploaded_file($imagetmp , "../upload/" . $imagename );
     // هترجع اسم الصورة علشان تخزنها في ال data base
     return $imagename;
     }else{
          // echo "<pre>";
          // print_r($msgError);
          // echo "</pre>";
          return "fail";

     }
}
function deleteFile($dir, $imagename){
     if(file_exists($dir . "/" . $imagename)){
          unlink($dir . "/" . $imagename);    
     }
     
 }
 function checkAuthenticate(){
     if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {

          if ($_SERVER['PHP_AUTH_USER'] != "abdo" ||  $_SERVER['PHP_AUTH_PW'] != "abdo12345"){
              header('WWW-Authenticate: Basic realm="My Realm"');
              header('HTTP/1.0 401 Unauthorized');
              echo 'Page Not Found';
              exit;
          }
      } else {
          exit;
      }
}     
