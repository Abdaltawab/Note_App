//create read update delete
import 'dart:io';

import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:path/path.dart';



String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'abdo:abdo12345'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};

class Crud{
  getReqest(String url) async{
    try{
      var response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        var responsebody = jsonDecode(response.body);
        return responsebody;
      }else{
        print("Error ${response.statusCode}");
      }
    }catch(e){
      print("Error Catch $e");
    }

  }
  postReqest(String url, Map data) async{
    
    try{
      var response = await http.post(Uri.parse(url),body: data,headers: myheaders);
      if(response.statusCode==200){
        var responsebody = jsonDecode(response.body);
        return responsebody;
      }else{
        print("Error ${response.statusCode}");
      }
    }catch(e){
      print("Error Catch $e");
    }

  }

postReqestWithFile(String url, Map data,File file,) async{
      var request = http.MultipartRequest("POST",Uri.parse(url));
      var length = await file.length();
      var stream = http.ByteStream(file.openRead());
      // لارسال ال files بستخدم MultipartFile ال 
      var multipartFile = http.MultipartFile("file", stream, length, filename:basename(file.path) );
      //اضافة ال files علي ال request
      request.files.add(multipartFile);
      request.headers.addAll(myheaders);
      //ارسال البيانات بطريقة dynamic
      data.forEach((key, value) {
        request.fields[key]= value;
      });
      // ارسال ال request 
      var myrequest = await request.send();
      
            // الحصول علي response 
      var response = await http.Response.fromStream(myrequest);
      if(myrequest.statusCode ==200){
        return jsonDecode(response.body);
      }else{
        print("Error${myrequest.statusCode}");
      }        
}







}