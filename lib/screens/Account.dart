
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            margin: EdgeInsets.only(
              top: 20.0,
            ),
            child: Image.asset("assets/images/male-user.png"),
          ),
          SizedBox(
            height: 30.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text("Email",style: TextStyle(fontSize: 30.0,color: Colors.black),),
          SizedBox(
            height: 10.0,
          ),
          Text(FirebaseAuth.instance.currentUser.email,style: TextStyle(fontSize: 20.0,color: Colors.black),)
        ],
      ),
    );
  }
}
