import 'package:appnote/app/auth/signup.dart';
import 'package:appnote/app/auth/success.dart';
import 'package:appnote/app/home.dart';
import 'package:appnote/app/notes/add.dart';
import 'package:appnote/app/notes/edit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/auth/login.dart';


 late SharedPreferences sharedPref;

void main() async{
  //first step in shared prefrences
WidgetsFlutterBinding.ensureInitialized();
sharedPref = await SharedPreferences.getInstance();
runApp(MyApp());

}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Course PHP Rest API",
     // initialRoute: "login",
       initialRoute:sharedPref.getString("id") == null ? "login" : "home",
      routes: {
        "login":(context) => const Login(),
        "signup":(context) => const SignUp(), 
        "home":(context) => const Home(),
        "success":(context) => const success(),
        "addnotes":(context) => const AddNotes(),
        "editnotes":(context) => const EditNotes(),
      },
    );
  }
}


//--stacktrace option
//--info
// --debug
//--scan