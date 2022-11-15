
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetNotes extends StatefulWidget {
  GetNotes({Key? key}) : super(key: key);

  @override
  State<GetNotes> createState() => _GetNotesState();
}

class _GetNotesState extends State<GetNotes> {
  final url  ="https://myn0tes-app.herokuapp.com/api/notes";
  var _jsonNotes = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  void updateNote(String id, String title, String desc)async{
             try{
               final response = await http.put(Uri.parse("https://myn0tes-app.herokuapp.com/api/notes/$id"),
                 body: {
                 'title':title,
                   'desc': desc
                 }
               );


             }catch(err){

             }

           }
  void deleteNote(String id) async{
    try{
    final response = await http.delete(Uri.parse("https://myn0tes-app.herokuapp.com/api/notes/$id"));
  }catch(err){

  }
}
  void fetchNotes() async{

    try {
      final response = await http.get(Uri.parse((url)));
      final jsonData = jsonDecode(response.body) as List;

      setState((){
         _jsonNotes = jsonData ;
      });
    }catch(err){

    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Center(child: Text("To Do List App ")),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _jsonNotes.length,
            itemBuilder: (context, index ) {
              final post = _jsonNotes[index];
              if (_jsonNotes.length == 0) {
                return Center(child: Text("there are no Tasks"),);
              } else {
                return SafeArea(
                  child: Container(
                    height: 300,
                    child: Card(
                      elevation: 4,
                      color: Colors.white,
                      margin: EdgeInsets.all(20),
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: SafeArea(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text("TASK : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),)),
                                  Expanded(child: Text(
                                    "${post["title"]}",

                                    style: TextStyle(),)),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "TASK DESCRIPTION : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),)
                                  ),
                                  Expanded(child: Text(
                                    "${post["desc"]}",
                                    style: TextStyle(),)),
                                ],
                              ),
                              SizedBox(height: 90,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  RaisedButton(
                                     color: Colors.redAccent,
                                      child: Row(
                                        children: [
                                          Text("Delete", style: TextStyle(color: Colors.white),),
                                          Icon(Icons.delete, color: Colors.white,)
                                        ],
                                      ),
                                      onPressed: (){
                                        deleteNote(post["_id"]);
                                        fetchNotes();
                                      }
                                  ),
                                  //------------------------
                                  SizedBox(width: 20,),
                                  //---------------
                                  RaisedButton(
                                      color: Colors.lightGreen,
                                      child: Row(
                                        children: [
                                          Text("update", style: TextStyle(color: Colors.white),),
                                          Icon(Icons.delete, color: Colors.white,)
                                        ],
                                      ),
                                      onPressed: ()=> showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text('Update Task'),

                                          actions: <Widget>[
                                            TextField(

                                              controller: titleController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Task',
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            TextField(

                                              controller: descController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'description ',
                                              ),
                                            ),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.end,
                                             children: [
                                               TextButton(
                                                 onPressed: () => Navigator.pop(context, 'Cancel'),
                                                 child: const Text('Cancel'),
                                               ),
                                               TextButton(
                                                 onPressed: () { updateNote(post['_id'], titleController.text, descController.text);

                                                 Navigator.pop(context);
                                                 fetchNotes();
                                                 }

                                                 ,
                                                 child: const Text('Update'),
                                               ),
                                             ],
                                           )
                                          ],
                                        ),
                                        ),

                                  ),

                                  //------------------------

                                ],
                              )


                            ],
                          ),
                        ),
                      ),

                    ),
                  ),
                );
              }
            }
        ),
      ),

    ); 
  }
}