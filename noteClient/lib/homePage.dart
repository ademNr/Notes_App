import 'package:flutter/material.dart';
import './addnotes.dart';
import './getnotes.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
  AddNotes(), 
  GetNotes()
  ] ;
  int currentIndex = 0 ;

  void onTap(int index){
    setState((){
      currentIndex = index ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,

        unselectedFontSize: 1,
        selectedItemColor: Colors.blue,

        onTap: onTap,
        currentIndex: currentIndex,
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.note_add),label: "add a note" ),
          BottomNavigationBarItem(icon: Icon(Icons.note),label: "my notes" ),
      
        ],
      ),
    );
  }
}
