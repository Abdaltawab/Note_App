import 'package:appnote/components/crud.dart';
import 'package:appnote/components/customtextform.dart';
import 'package:appnote/components/valid.dart';
import 'package:appnote/constant/linkapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();
  bool isloading = false;
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> signUp() async {
    if (formstate.currentState!.validate()) {
      setState(() {
        isloading = true;
      });

      var response = await _crud.postReqest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });

      setState(() {
        isloading = false;
      });

      if (response['status'] == "success") {
        Navigator.of(context).pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("SignUp Fail");
        // يمكنك إضافة رسالة خطأ إلى المستخدم هنا إذا لزم الأمر
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  Image.asset("images/logo.png", width: 200, height: 200),
                  CustomTextFormSign(
                    valid: (val) {
                      return validInput(val!, 5, 40);
                    },
                    mycontroller: username,
                    hint: "Username",
                  ),
                  CustomTextFormSign(
                    valid: (val) {
                      return validInput(val!, 3, 20);
                    },
                    mycontroller: email,
                    hint: "Email",
                  ),
                  CustomTextFormSign(
                    valid: (val) {
                      return validInput(val!, 3, 10);
                    },
                    mycontroller: password,
                    hint: "Password",

                    //bscureText: true, // لإخفاء النص الذي تكتبه (لكلمة المرور)
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding:
                    EdgeInsets.symmetric(horizontal: 70.0, vertical: 10),
                    onPressed: () async {
                      await signUp();
                    },
                    child: Text("SignUp"),
                  ),
                  SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed("login");
                    },
                    child: Text("Already have an account? Login"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
