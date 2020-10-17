import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project/screens/Myplaylist1.dart';
import 'package:my_project/screens/Suggestion.dart';
import 'screens/Myplaylist.dart';
import 'screens/Downloadfile.dart';
import 'screens/Uploadfile.dart';

class Mainpage extends StatefulWidget {
  String uid;
  Mainpage({this.uid});
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int currentpage = 0;


  List tabs = [
    Myplaylist1(uid: FirebaseAuth.instance.currentUser.uid),
    Suggestion(),
    Downloadfile(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'My Music',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: new Text("My Music"),
          //backgroundColor: Colors.black26,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                child: Icon(Icons.search),
                onTap: null,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  child: Center(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                ))
          ],
        ),
        body: tabs[currentpage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentpage,
          selectedItemColor: Colors.white30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("upload"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_download),
              title: Text("download"),
            )
          ],
          onTap: (index) {
            setState(() {
              currentpage = index;
            });
          },
        ),
      ),
    );
  }

}
