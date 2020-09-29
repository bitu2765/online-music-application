import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_project/authentication/Authservice.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService _auth = AuthService();

  String _email, _pass, message="successfully";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.amber[800],
          Colors.amber[700],
          Colors.amber[600],
          Colors.amber,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 40.0, color: Colors.white54),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Welcome',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
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
                        height: 10.0,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              boxShadow: [BoxShadow(color: Colors.grey[400])]),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black87,
                                  fontStyle: FontStyle.italic),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _pass = val;
                              });
                            },
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black87),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          //  print(_email);
                          // FirebaseAuth.instance.createUserWithEmailAndPassword(
                          //    email: _email, password: _pass);
                          //    print(_pass);
                          dynamic result =
                              await _auth.registerwithemailandpassword(
                                  _email.trim(), _pass.trim());
                          if (result == null) {
                            setState(() {
                              message =
                                  "Registration failed please enter valid Email Or Password";
                            });
                          }
                        },
                        child: Container(
                          height: 40.0,
                          width: 130.0,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.amberAccent),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                          onTap: () async {
                            dynamic result =
                               await _auth.signinWithemailandpassword(_email.trim(), _pass.trim());
                            if (result == null) {
                              setState(() {
                                message =
                                    "Login failed please enter valid Email Or Password";
                              });
                            }
                            
                          },
                          child: Container(
                              height: 40.0,
                              width: 130.0,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Center(
                                child: Text(
                                  "Login ",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.amberAccent),
                                ),
                              ))),
                     
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ), //),
    );
  }
}
