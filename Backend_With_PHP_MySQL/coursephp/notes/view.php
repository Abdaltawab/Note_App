<?php
include "../connect.php" ;
// fun انا انشاتها اختصارا للكود وعلشان اضمن انه جميع الحقول عندي محمية

$userid =  filterRequest("id"); 
//هتحول ال string لكود  html
//اضافة tags عند كل كود ممكن يسبب مشاكل
//htmlspecialchars(strip_tags())

$stmt = $con->prepare("SELECT * FROM notes WHERE `notes_users` = ? ");

$stmt->execute(array($userid));
// للحصول علي معلومات اليوزر اللي وصلولي من الركوست هنعرف متغير data
 $data = $stmt->fetchAll(PDO::FETCH_ASSOC);//علشان ما تجبلي indexed array ولكن ass array
  //كل الملاحظات وليس الملاحظة المطلوبة 

 //بدي اعرف النتيجة هل انضاف ولالا وهعر ف من خلال count 
 $count = $stmt->rowCount();
 if($count >0){
 echo json_encode(array("status" => "success" ,"data"=> $data));
 }else{
    echo json_encode(array("status" => "fail"));
 }

 //step 3 in shared pref ببعت البيانات عن طريق المتغير data 