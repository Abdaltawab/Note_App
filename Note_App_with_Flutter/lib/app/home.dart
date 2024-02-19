import 'package:appnote/app/model/notemodel.dart';
import 'package:appnote/app/notes/edit.dart';
import 'package:appnote/components/card.dart';
import 'package:appnote/components/crud.dart';
import 'package:appnote/constant/linkapi.dart';
import 'package:appnote/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}):super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  {

  Crud crud = Crud();
  // ربط تطبيق فلاتر بال api الذي تم انشائه
  getNotes() async{
    var response  = await crud.postReqest(linkViewNotes, {
      "id" : sharedPref.getString("id")
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
        actions: [
          IconButton(onPressed: () {
           sharedPref.clear();//لما اعمل م logout هيبق عند ال صفحة تسجيل الدخول بعد عمل hot restert
            Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
          }, icon: Icon(Icons.exit_to_app))
        ],
        ),
      
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed("addnotes");
      },
      child: Icon(Icons.add),
      ),
     body: Container(
      padding: EdgeInsets.all(10),
       child: ListView(
        children: [
          // نستدعي الملاحظات المكتوبة عندي في جدول النوتس من ال futture nuilder
          //FutureBuilder(builder:(BuildContext context, AsyncSnapshot snapshot) {}), 
         FutureBuilder(
           future: getNotes(),
           //initialData: InitialData,
           builder: (BuildContext context, AsyncSnapshot snapshot) {
            
             if(snapshot.hasData){
                if(snapshot.data['status'] == 'fail') 
                  return Center(child: Text("There is not found notes add notes",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)));
              return ListView.builder(
                itemCount: snapshot.data['data'].length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder:(context,i) {
                  return CardNotes(
                    onDelete: ()async{
                      var response = await crud.postReqest(linkDeleteNotes, {
                        "id" : snapshot.data['data'][i]['notes_id'].toString(),
                        "imagename" : snapshot.data['data'][i]['notes_image'].toString()
                      });
                      if(response['status'] == "success"){
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacementNamed("home");
                      }
                    },
                    ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditNotes(
                      notes:snapshot.data['data'][i] ,
                    ),));
                  }, 
                  notemodel: NoteModel.fromJson(snapshot.data['data'][i]));
                },
              );
             }
             if(snapshot.connectionState== ConnectionState.waiting){
              return Center(child: Text("loading ..."));
             }
              return Center(child: Text("loading ..."));               
           },
         ),
          //CardNotes(ontap: () {}, title: "title", content: "test"),
        ],
       ),
     ),
    );
  }
  

}