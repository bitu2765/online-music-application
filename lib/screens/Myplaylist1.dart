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
  @override
  _MyPlay1 createState() => new _MyPlay1();
}

class _MyPlay2 extends State<Myplaylist1> {
  List<QueryDocumentSnapshot> mdata, sdata, adata;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future getdata() async {
    CollectionReference qn = FirebaseFirestore.instance.collection('moviesong');
    qn.snapshots().listen((snapshot) {
      setState(() {
        sdata = snapshot.docs;
      });
    });

    qn = FirebaseFirestore.instance.collection('song');
    qn.snapshots().listen((snapshot) {
      mdata = snapshot.docs;
    });

    qn = FirebaseFirestore.instance.collection('artist');
    qn.snapshots().listen((snapshot) {
      adata = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Albums',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  for (int i = 0; i < mdata.length; i++)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Myplaylist(
                                          collection: mdata[i].get('album'),
                                          imgurl: mdata[i].get('image_url'),
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 25.0,
                                bottom: 10.0,
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
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0)),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(mdata[i].get('image_url')),
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                        Text(
                          mdata[i].get('album'),
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  'Movie Hits',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  for (int i = 0; i < sdata.length; i++)
                    Column(
                      children: [
                        GestureDetector(
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
                                borderRadius: BorderRadius.circular(100.0),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(sdata[i].get('movie_image')),
                                  fit: BoxFit.fill,
                                )),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Finalplaylist(
                                          collection:
                                              sdata[i].get('movie_name'),
                                          image: sdata[i].get('movie_image'),
                                        )));
                          },
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Text(
                          sdata[i].get('movie_name'),
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Artist',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 20.0,
              ),
            ),
            Column(
              children: <Widget>[
                for (int i = 0, j = 0;
                    i < adata.length / 2 - (adata.length % 2);
                    i++, j += 2)
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        children: [
                          GestureDetector(
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
                                      BorderRadius.all(Radius.circular(20.0)),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(adata[j].get('image_url')),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Finalplaylist(
                                            collection: adata[j].get('name'),
                                            image: adata[j].get('image_url'),
                                          )));
                            },
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            adata[j].get('name'),
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      )),
                      if (1 + j < adata.length)
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            adata[j + 1].get('image_url')),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Finalplaylist(
                                                collection:
                                                    adata[j + 1].get('name'),
                                                image: adata[j + 1]
                                                    .get('image_url'),
                                              )));
                                },
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                adata[j + 1].get('name'),
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                if ((adata.length) % 2 == 1)
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 30.0, bottom: 1.0, left: 10.0, right: 10.0),
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Colors.grey[400],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    adata[adata.length - 1].get('image_url')),
                                fit: BoxFit.fill,
                              )),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Finalplaylist(
                                        collection:
                                            adata[adata.length - 1].get('name'),
                                        image: adata[adata.length - 1]
                                            .get('image_url'),
                                      )));
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        adata[adata.length - 1].get('name'),
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/* for (int i = 0; i < mdata.length; i++)
                  GestureDetector(
                    onTap: null,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 1.0, bottom: 1.0, left: 10.0, right: 10.0),
                      height: 130.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.grey[400],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)
                          ),
                          image: DecorationImage(
                            image: NetworkImage(mdata[i].get('image_url')),
                            fit: BoxFit.cover,
                          )),
                    ),
                  )*/

/* Column(
              children: <Widget>[
                for (int i = 0, j = 0; i < adata.length / 2; i++, j++)
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 30.0, bottom: 1.0, left: 10.0, right: 10.0),
                          height: 130.0,
                          width: 130.0,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Colors.grey[400],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              image: DecorationImage(
                                image: NetworkImage(adata[j].get('image_url')),
                                fit: BoxFit.fill,
                              )),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Finalplaylist(
                                        collection: adata[j].get('name'),
                                        image: adata[j].get('image_url'),
                                      )));
                        },
                      )),
                      if (++j < adata.length)
                        Expanded(
                            child: GestureDetector(
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
                                    BorderRadius.all(Radius.circular(20.0)),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(adata[j].get('image_url')),
                                  fit: BoxFit.fill,
                                )),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Finalplaylist(
                                          collection: adata[j].get('name'),
                                          image: adata[j].get('image_url'),
                                        )));
                          },
                        )),
                    ],
                  )
              ],
            )*/

/*StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('artist').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return GridView.builder(
                      itemCount: snapshot.data.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context,index){
                          DocumentSnapshot temp=snapshot.data.docs[index];
                          return Column(
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage(temp.get('image_url')))
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                        );
                  }
                }),*/

class _MyPlay1 extends State<Myplaylist1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('artist').snapshots(),
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
                                                      collection: snapshot
                                                          .data.docs[j+1]
                                                          .get('name'),
                                                      image: snapshot
                                                          .data.docs[j+1]
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
                                                  .data.docs[j+1]
                                                  .get('image_url')),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      snapshot.data.docs[j+1].get('name'),
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ))
                            ],
                          ),
                          if(snapshot.data.docs.length%2==1)
                          Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Finalplaylist(
                                                      collection: snapshot
                                                          .data.docs[snapshot.data.docs.length-1]
                                                          .get('name'),
                                                      image: snapshot
                                                          .data.docs[snapshot.data.docs.length-1]
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
                                                  .data.docs[snapshot.data.docs.length-1]
                                                  .get('image_url')),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      snapshot.data.docs[snapshot.data.docs.length-1].get('name'),
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
