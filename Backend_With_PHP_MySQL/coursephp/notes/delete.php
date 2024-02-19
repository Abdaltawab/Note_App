<?php
include "../connect.php";
// fun انا انشاتها اختصارا للكود وعلشان اضمن انه جميع الحقول عندي محمية
$noteid     = filterRequest("id");//ده اسم الريكوست اللي بيوصلي

$imagename = filterRequest("imagename");


//هتحول ال string لكود  html
//اضافة tags عند كل كود ممكن يسبب مشاكل
//htmlspecialchars(strip_tags())

$stmt = $con->prepare("DELETE FROM notes WHERE notes_id = ?");
$stmt->execute(array($noteid));
 
 //بدي اعرف النتيجة هل انضاف ولالا وهعر ف من خلال count 
 $count = $stmt->rowCount();
 if($count >0){
   deleteFile("../upload", $imagename);
    echo json_encode(array("status"=>"success"));
 }else{
    echo json_encode(array("status"=>"fail")); 
 }