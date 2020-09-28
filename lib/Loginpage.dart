
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_project/authentication/Authservice.dart';
import 'package:my_project/mainpage.dart';
import 'package:my_project/screens/Practice.dart';

class Loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<Loginpage> {
  final _firestore = FirebaseFirestore.instance;

  String _email, _pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 280.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                image: DecorationImage(
                  image: AssetImage('assets/images/loginpic.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Enter email ", border: InputBorder.none),
              onChanged: (value) {
                setState(() {
                  this._email = value;
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter Password", border: InputBorder.none),
              onChanged: (value) {
                setState(() {
                  this._pass = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _pass);
                    print(_email);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _pass);
                    //FirebaseFirestore.instance.collection('users').add();
                  },
                  child: Text(
                    'Registration',
                    style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
