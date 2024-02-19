import 'dart:io';

import 'package:appnote/components/crud.dart';
import 'package:appnote/components/customtextform.dart';
import 'package:appnote/components/valid.dart';
import 'package:appnote/constant/linkapi.dart';
import 'package:appnote/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditNotes extends StatefulWidget {
  
  final notes;
  const EditNotes({Key? key , this.notes }):super(key:key);


  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
 
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  File? myfile ;

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  
  bool isloading = false;

  Crud crud = Crud();

  editNotes()async{
    if(formstate.currentState!.validate()){
      isloading = true;
      setState(() {
        
      });
      var response;

     if (myfile == null){
       response = await crud.postReqest(linkEditNotes, {
         "title" : title.text,
         "content":content.text,
         // ال id اللي خاص بالملاحظة اللي بعدل عليها
         "id" : widget.notes['notes_id'].toString(),
          "imagename" : widget.notes['notes_image'].toString(),
       });
     }else{
       response = await crud.postReqestWithFile(linkEditNotes, {
         "title" : title.text,
         "content":content.text,
         // ال id اللي خاص بالملاحظة اللي بعدل عليها
         "id" : widget.notes['notes_id'].toString(),
         "imagename" : widget.notes['notes_image'].toString(),
       },myfile!);
     }
    isloading = false;
      setState(() {
        
      });
    if(response['status'] == "success"){
      Navigator.of(context).pushReplacementNamed("home");
    }
    else{
      //
    }
  }
  }

// نعطي قيم افتراضية للcontroller لكي تظهر المعلومات الافتراضية المراد التعديل عليها
  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Notes"),),
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
            MaterialButton(onPressed: () async{
              await editNotes();
            },
            child: Text("Save"),
            textColor:Colors.white,
            color: Colors.black,

            )
          ]),
        ),
      ),
    );
    
  }
   
  }
  
