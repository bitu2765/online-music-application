import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/UserData/Finaldata.dart';

class Finalplaylist extends StatefulWidget {
  String collection, image;
  Finalplaylist({this.collection, this.image});
  @override
  _fplay createState() => new _fplay();
}

class _fplay extends State<Finalplaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 320.0,
                height: 250.0,
                margin: EdgeInsets.only(
                    top: 5.0, left: 20.0, right: 20.0, bottom: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.collection,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(widget.collection)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < snapshot.data.docs.length; i++)
                              ListTile(
                                  title: Text(
                                    snapshot.data.docs[i].get('song_name'),
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  onTap: () {})
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ));
  }
}
