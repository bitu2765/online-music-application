import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPass extends StatefulWidget {
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100.0,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  boxShadow: [BoxShadow(color: Colors.grey[400])]),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic),
                ),
                onChanged: (val) {
                  setState(() {
                    _email = val;
                  });
                },
              )),
          SizedBox(
            height: 100.0,
          ),
          GestureDetector(
              onTap: (){
                FirebaseAuth.instance.sendPasswordResetEmail(email: _email.trim());
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 140.0,
                child: Center(
                  child: Text("Send Email",style: TextStyle(color: Colors.brown),),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.amberAccent,
                ),
              ),
          ),
        ],
      ),
    );
  }
}
