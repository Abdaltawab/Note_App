<?php
include "../connect.php" ;
// fun انا انشاتها اختصارا للكود وعلشان اضمن انه جميع الحقول عندي محمية
$email =  filterRequest("email");
$password =  filterRequest("password"); 
//هتحول ال string لكود  html
//اضافة tags عند كل كود ممكن يسبب مشاكل
//htmlspecialchars(strip_tags())

$stmt = $con->prepare("SELECT * FROM users WHERE `password` = ? AND email = ?");

$stmt->execute(array($password, $email));
// للحصول علي معلومات اليوزر اللي وصلولي من الركوست هنعرف متغير data
 $data = $stmt->fetch(PDO::FETCH_ASSOC);//علشان ما تجبلي indexed array ولكن ass array
  
 //بدي اعرف النتيجة هل انضاف ولالا وهعر ف من خلال count 
 $count = $stmt->rowCount();
 if($count >0){
 echo json_encode(array("status" => "success" ,"data"=> $data));
 }else{
    echo json_encode(array("status" => "fail"));
 }

 //step 3 in shared pref ببعت البيانات عن طريق المتغير data