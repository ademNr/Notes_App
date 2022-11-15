import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './getnotes.dart';


class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final url  ="https://myn0tes-app.herokuapp.com/api/notes";

  void postData(String task, String desc)async{

    try {
      final response = await http.post(Uri.parse(url),
          body: {
            "title": task,
            "desc": desc
          }
      );
    }catch(err){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("To do List App")),),

      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Create a task',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),

                Container(
                  padding: const EdgeInsets.all(10),

                  child: TextFormField(


                    controller: taskController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Task',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(

                    controller: descController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'description in details',
                    ),
                  ),
                ),
                SizedBox(height: 50,),

                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      color: Colors.green,


                      child: const Text('Submit Task', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        postData(taskController.text, descController.text);
                        
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GetNotes()));
                      },
                    )
                ),

              ],
            ),
          )
      ),
    );
  }
}