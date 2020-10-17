import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:my_project/screens/Finalplaylist.dart';
import 'package:my_project/screens/Myplaylist.dart';

class Myplaylist1 extends StatefulWidget {
  String uid;
  Myplaylist1({this.uid});
  @override
  _MyPlay1 createState() => new _MyPlay1();
}

class _MyPlay1 extends State<Myplaylist1> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    'Albums',
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ],
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('song').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < snapshot.data.docs.length; i++)
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Finalplaylist(
                                              uid: widget.uid,
                                                  collection: snapshot
                                                      .data.docs[i]
                                                      .get('album'),
                                                  image: snapshot.data.docs[i]
                                                      .get('image_url'),
                                                )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 20.0,
                                      left: 10.0,
                                    ),
                                    height: 150.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data.docs[i]
                                              .get('image_url')),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  snapshot.data.docs[i].get('album'),
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  }
                }),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    'Movies',
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('moviesong')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < snapshot.data.docs.length; i++)
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Finalplaylist(
                                              uid: widget.uid,
                                                  collection: snapshot
                                                      .data.docs[i]
                                                      .get('movie_name'),
                                                  image: snapshot.data.docs[i]
                                                      .get('movie_image'),
                                                )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 30.0,
                                        bottom: 1.0,
                                        left: 10.0,
                                        right: 10.0),
                                    height: 130.0,
                                    width: 130.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color: Colors.grey[400],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data.docs[i]
                                              .get('movie_image')),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  snapshot.data.docs[i].get('movie_name'),
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  }
                }),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    'Artist',
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ],
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('artist').orderBy("name").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return SingleChildScrollView(
                        child: Column(
                      children: [
                        for (int i = 0, j = 0;
                            i <
                                snapshot.data.docs.length / 2 -
                                    (snapshot.data.docs.length % 2);
                            i++, j += 2)
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Finalplaylist(
                                                    uid: widget.uid,
                                                    collection: snapshot
                                                        .data.docs[j]
                                                        .get('name'),
                                                    image: snapshot.data.docs[j]
                                                        .get('image_url'),
                                                  )));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 30.0,
                                          bottom: 1.0,
                                          left: 10.0,
                                          right: 10.0),
                                      height: 150.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: Colors.grey[400],
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data.docs[j]
                                                .get('image_url')),
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    snapshot.data.docs[j].get('name'),
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              )),
                              if (1 + i < snapshot.data.docs.length)
                                Expanded(
                                    child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Finalplaylist(
                                                      uid: widget.uid,
                                                      collection: snapshot
                                                          .data.docs[j + 1]
                                                          .get('name'),
                                                      image: snapshot
                                                          .data.docs[j + 1]
                                                          .get('image_url'),
                                                    )));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 30.0,
                                            bottom: 1.0,
                                            left: 10.0,
                                            right: 10.0),
                                        height: 150.0,
                                        width: 150.0,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                              color: Colors.grey[400],
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data.docs[j + 1]
                                                  .get('image_url')),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      snapshot.data.docs[j + 1].get('name'),
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ))
                            ],
                          ),
                        if (snapshot.data.docs.length % 2 == 1)
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Finalplaylist(
                                            uid: widget.uid,
                                                collection: snapshot
                                                    .data
                                                    .docs[snapshot
                                                            .data.docs.length -
                                                        1]
                                                    .get('name'),
                                                image: snapshot
                                                    .data
                                                    .docs[snapshot
                                                            .data.docs.length -
                                                        1]
                                                    .get('image_url'),
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 30.0,
                                      bottom: 1.0,
                                      left: 10.0,
                                      right: 10.0),
                                  height: 150.0,
                                  width: 150.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                        color: Colors.grey[400],
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot.data
                                            .docs[snapshot.data.docs.length - 1]
                                            .get('image_url')),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                snapshot
                                    .data.docs[snapshot.data.docs.length - 1]
                                    .get('name'),
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          )
                      ],
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
