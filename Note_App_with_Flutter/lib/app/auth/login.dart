import 'package:appnote/components/crud.dart';
import 'package:appnote/components/customtextform.dart';
import 'package:appnote/components/valid.dart';
import 'package:appnote/constant/linkapi.dart';
import 'package:appnote/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  GlobalKey<FormState> formstate = GlobalKey();                                       

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Crud crud = Crud();

  bool isloading = false;

  login() async{
    if(formstate.currentState!.validate()){
      isloading= true;
      setState(() {});
      var response = await crud.postReqest(linkLogin, {
        "email" : email.text,
        "password" : password.text
        });
      isloading= false;
      setState(() {});
      if(response['status'] == "success"){
      //second step in sharedpref
      // استقيال البيانات
       sharedPref.setString("id", response['data']['id'].toString());//استقبال الداتا وبدي الداتا id 
       sharedPref.setString("username", response['data']['username']);//استقبال الداتا وبدي الداتا id 
       sharedPref.setString("email", response['data']['email']);//استقبال الداتا وبدي الداتا id 
       Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
    }else{
      AwesomeDialog(context: context,
      title: "ِAlert", body: Text("password or email is wrong or not signup "))..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child:isloading==true?
        Center(
          child: CircularProgressIndicator(),
        )
        : ListView(
          children: [
            Form(
              key: formstate,
          child: Column(children: [
            Image.asset("images/logo.png",width: 200,height: 200 ,),
            CustomTextFormSign(
              valid: (val){
                return validInput(val!, 3, 20);
              } ,
              mycontroller: email,
              hint: "email"
              ),
            CustomTextFormSign(
              valid: (val){
                return validInput(val!, 3, 10);
              } ,
              mycontroller: password,
              hint: "password"
              ),
            MaterialButton(

              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 70.0,vertical: 10),
              onPressed: () async{
                await login(); 
            },
            child: Text("login"),
            ),
            SizedBox(height: 0.0,),
            MaterialButton(
              textColor: Colors.black,
              
              onPressed: () {
              Navigator.of(context).pushNamed("signup");
            },
            child: Text("sign up"),
            ),
          ]),
        ),
          ],
        ),
      )
    );
  }
}