<?php
include "../connect.php";
// fun انا انشاتها اختصارا للكود وعلشان اضمن انه جميع الحقول عندي محمية
$title     = filterRequest("title");//ده اسم الريكوست اللي بيوصلي
$content   =  filterRequest("content");
$userid    =  filterRequest("id"); 
//هتحول ال string لكود  html
//اضافة tags عند كل كود ممكن يسبب مشاكل
//htmlspecialchars(strip_tags())

// اللي هيرجع فيه اسم الصور اللي عاوز ارفعها في ال db
$imagename =imageUpload('file');

if($imagename != 'fail'){

   $stmt = $con->prepare("
   INSERT INTO `notes`(`notes_title`, `notes_content`, `notes_users`,`notes_image`)
    VALUES (?,?,?,?)
    ");
   $stmt->execute(array($title, $content, $userid,$imagename));
    
    //بدي اعرف النتيجة هل انضاف ولالا وهعر ف من خلال count 
    $count = $stmt->rowCount();
    if($count >0){
       echo json_encode(array("status"=>"success"));
    }else{
       echo json_encode(array("status"=>"fail")); 
    }
}else{
   echo json_encode(array("status"=>"fail"));
}
