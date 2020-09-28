import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Login.dart';
import 'package:my_project/authentication/MUser.dart';
import 'package:my_project/mainpage.dart';
import 'package:provider/provider.dart';

class Buildpage extends StatefulWidget {
  @override
  _BuildpageState createState() => _BuildpageState();
}

class _BuildpageState extends State<Buildpage> {
  @override
  Widget build(BuildContext context) {
    final  user = Provider.of<MUser>(context);

    if(user == null)
    {
      return Login();
    }
    else
    {
      return Mainpage();
    }
  }
}