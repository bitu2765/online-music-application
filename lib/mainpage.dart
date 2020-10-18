import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project/screens/Account.dart';
import 'package:my_project/screens/Myplaylist1.dart';
import 'package:my_project/screens/Suggestion.dart';

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
    Account(),
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
          title: new Text("Music"),
          //backgroundColor: Colors.black26,
          actions: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: GestureDetector(
                  child: Center(
                      child: Image.asset(
                    "assets/images/logout.png",
                    width: 25.0,
                    height: 25.0,
                  )),
                  onTap: () {
                    showalert();
                  },
                ))
          ],
        ),
        body: tabs[currentpage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentpage,
          selectedItemColor: Colors.blueAccent[400],
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/home.png",
                width: 25.0,
                color: Colors.white,
              ),
              title: Text("home"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/more.png",
                width: 25.0,
                color: Colors.white,
              ),
              title: Text("suggestion"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/add-user.png",
                width: 25.0,
                color: Colors.white,
              ),
              title: Text(
                "you",
                style: TextStyle(fontSize: 15.0),
              ),
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

  Future<void> showalert() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Logout"),
            content: Text("Sure you want to logout?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              FlatButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }
}
