import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class Myplaylist1 extends StatefulWidget {
  @override
  _myPlay1 createState() => new _myPlay1();
}

class _myPlay1 extends State<Myplaylist1> {
  _myPlay1(){getdata();}

  List<QueryDocumentSnapshot> mdata;

  Future getdata() async {
      CollectionReference qn = await FirebaseFirestore.instance.collection('song');
      
      qn.snapshots().listen((snapshot) { 
        setState(() {
          mdata = snapshot.docs;
        });
      });
    }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body:  Container(
        margin: EdgeInsets.all(25.0),
      ),
    );
  } 
}