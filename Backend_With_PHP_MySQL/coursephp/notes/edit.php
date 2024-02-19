<?php
include "../connect.php";
// fun انا انشاتها اختصارا للكود وعلشان اضمن انه جميع الحقول عندي محمية

$noteid       = filterRequest("id");//ده اسم الريكوست اللي بيوصلي
$title        = filterRequest("title");//ده اسم الريكوست اللي بيوصلي
$content      =  filterRequest("content");
$imagename    =  filterRequest("imagename");

//هتحول ال string لكود  html 
//اضافة tags عند كل كود ممكن يسبب مشاكل
//htmlspecialchars(strip_tags())

if(isset($_FILES['file'])){
   deleteFile("../upload", $imagename);
   $imagename =imageUpload('file');

}else{
   
}

$stmt = $con->prepare("
UPDATE `notes` SET 
`notes_title`= ?,`notes_content`= ? , notes_image = ? WHERE notes_id = ? ");
$stmt->execute(array($title, $content,$imagename ,$noteid));
 
 //بدي اعرف النتيجة هل انضاف ولالا وهعر ف من خلال count 
 $count = $stmt->rowCount();
 if($count >0){
    echo json_encode(array("status"=>"success"));
 }else{
    echo json_encode(array("status"=>"fail")); 
 }