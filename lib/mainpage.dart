
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project/Login.dart';
import 'package:my_project/Welcomlogin.dart';
import 'package:my_project/Loginpage.dart';
import 'package:my_project/screens/Getdata.dart';
import 'package:my_project/screens/Myplaylist1.dart';
import './screens/Practice.dart';
import 'screens/Myplaylist.dart';
import 'screens/Downloadfile.dart';
import 'screens/Uploadfile.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {

  int currentpage=0;

  List tabs = [
    Myplaylist1(),
    Uploadfile(),
    Downloadfile(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
      ]);
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
                child: Icon(Icons.search),
              ),/*
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child:  Icon(Icons.refresh),
                
                ),*/
                IconButton(
                  icon: Icon(Icons.refresh), 
                  onPressed:(){
                    FirebaseAuth.instance.signOut();
                  }
                  )
            ],
            
            ),
          body: 
          tabs[currentpage],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentpage,
            selectedItemColor: Colors.white30,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title:  Text("home"),
                ),
                BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title:  Text("upload"),
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_download),
                title:  Text("download"),
                )
            ],
            onTap: (index){
              setState(() {
                currentpage=index;
              });
            },
          ),
          ),
      );
  }
}