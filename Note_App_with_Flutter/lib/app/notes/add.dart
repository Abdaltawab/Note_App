import 'dart:io';

import 'package:appnote/components/crud.dart';
import 'package:appnote/components/customtextform.dart';
import 'package:appnote/components/valid.dart';
import 'package:appnote/constant/linkapi.dart';
import 'package:appnote/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  
  bool isloading = false;

  Crud crud = Crud();

  // addNotes()async{
  //   if(myfile == null) return AwesomeDialog(context: context,title: "important", body: Text("Please add the picture in the note"))..show();
  //   if(formstate.currentState!.validate()){
  //     isloading = true;
  //     setState(() {
  //
  //     });
  //     var response = await crud.postReqestWithFile(linkAddNotes, {
  //     "title" : title.text,
  //     "content":content.text,
  //     "id" : sharedPref.getString("id")
  //   }, myfile!);
  //   isloading = false;
  //     setState(() {
  //
  //     });
  //   if(response['status'] == "success"){
  //     Navigator.of(context).pushReplacementNamed("home");
  //   }
  //   else{
  //     //
  //   }
  // }
  // }
  addNotes() async {
    if (myfile == null) {
      return AwesomeDialog(
        context: context,
        title: "important",
        body: Text("Please add the picture in the note"),
      )..show();
    }

    if (formstate.currentState!.validate()) {
      setState(() {
        isloading = true;
      });

      var response = await crud.postReqestWithFile(linkAddNotes, {
        "title": title.text,
        "content": content.text,
        "id": sharedPref.getString("id")
      }, myfile!);

      setState(() {
        isloading = false;
      });

      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        // Handle error case
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Notes"),),
      body: 
      isloading== true?
      Center(child: CircularProgressIndicator(),): Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: formstate,
          child: ListView(children: [
            CustomTextFormSign(hint: "title", mycontroller: title, valid: (val){
              return validInput(val!, 1, 40);
            }),
            CustomTextFormSign(hint: "content", mycontroller: content, valid: (val){
               return validInput(val!, 10, 200);
            }),
            Container(height: 20,),
            MaterialButton(onPressed: (){
              showModalBottomSheet(context: context, builder: (context)=>Container(
                height: 140,
                width: double.infinity,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Please Choose Image",style: TextStyle(fontSize: 22.0),),
                  ),
                  InkWell(
                    onTap: () async{
                      XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                      myfile = File(xfile!.path);
                      setState(() {

                      });
                    },
                    child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text("From Gallary",style: TextStyle(fontSize: 18.0),),
                  ),
                  ),
                  SizedBox(height: 5.0,),
                  InkWell(
                    onTap: () async{
                      XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                      myfile = File(xfile!.path);
                      setState(() {

                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text("From Camera",style: TextStyle(fontSize: 17.0),),
                  ),
                  ),
              ]),
              )
              );
            },
            child: Text("Choose Image"),
            textColor:Colors.white,
            color: myfile == null? Colors.blue: Colors.green,

            ),
            Container(height: 20,),
            MaterialButton(onPressed: () async{
              await addNotes();
            },
            child: Text("add"),
            textColor:Colors.white,
            color: Colors.blue,

            ),
          ]),
        ),
      ),
    );
    
  }
  
}


