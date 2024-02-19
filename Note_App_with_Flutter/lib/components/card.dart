import 'package:appnote/app/model/notemodel.dart';
import 'package:appnote/constant/linkapi.dart';
import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function() ontap;
  final NoteModel notemodel;

  final void Function()? onDelete;

  const CardNotes({super.key, required this.ontap,required this.onDelete, required this.notemodel});
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        "$linkImageRoot/${notemodel.notesImage}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                        )),
                    Expanded(
                      flex: 2,
                      child: ListTile(
                      title: Text("${notemodel.notesTitle}"),
                      subtitle: Text("${notemodel.notesContent}"),
                      trailing: IconButton(onPressed: onDelete,
                       icon: Icon(Icons.delete))
                        
                      ))
                  ],
                ),
              ),
    );
  }
}