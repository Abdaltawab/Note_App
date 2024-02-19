<?php
include "../connect.php";
// fun انا انشاتها اختصارا للكود وعلشان اضمن انه جميع الحقول عندي محمية
$username = filterRequest("username");
$email =  filterRequest("email");
$password =  filterRequest("password"); 
//هتحول ال string لكود  html
//اضافة tags عند كل كود ممكن يسبب مشاكل
//htmlspecialchars(strip_tags())

$stmt = $con->prepare("
INSERT INTO `users`(`username`, `email`, `password`)
 VALUES (?,?,?)
 ");
$stmt->execute(array($username, $email, $password));
 
 //بدي اعرف النتيجة هل انضاف ولالا وهعر ف من خلال count 
 $count = $stmt->rowCount();
 if($count >0){
    echo json_encode(array("status"=>"success"));
 }else{
    echo json_encode(array("status"=>"fail")); 
 }