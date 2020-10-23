
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_player/music_player.dart';
import 'package:my_project/SongObj/SObject.dart';

class Finalplaylist extends StatefulWidget {
  String collection, image, uid;
  SObject sk;
  bool ke;
  Finalplaylist({this.collection, this.image, this.uid, this.ke, this.sk});
  @override
  _fplay createState() => new _fplay();
}

class _fplay extends State<Finalplaylist> {
  static MusicPlayer musicplayer;
  bool isplaying = false, datset = true;
  DateTime dt = DateTime.now();
  List<QueryDocumentSnapshot> dr;
  //final db = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    initPlateformState();
  }

  @override
  Future<void> initPlateformState() async {
    musicplayer = MusicPlayer();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ke) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.sk.album),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.all(25.0),
                height: 300.0,
                width: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                      image: NetworkImage(widget.sk.img_url), fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.sk.song,
                style: TextStyle(fontSize: 35.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await FirebaseFirestore.instance.collection(widget.sk.album).doc(widget.sk.did).update({"play":FieldValue.increment(1)});
                  await  musicplayer.play(MusicItem(
                      url: widget.sk.song_url,
                      albumName: widget.sk.album,
                      artistName: widget.sk.album,
                      coverUrl: widget.sk.img_url,
                      trackName: widget.sk.song,
                      duration: Duration(seconds: 255),
                    ));
                  },
                  child: Icon(
                    Icons.play_circle_filled,
                    color: Colors.blue,
                    size: 55.0,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
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
                              for (int i = 0;
                                  i < snapshot.data.docs.length;
                                  i++)
                                ListTile(
                                    title: Text(
                                      snapshot.data.docs[i].get('song_name'),
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    trailing: Text(
                                      snapshot.data.docs[i]
                                              .get("play")
                                              .toString() +
                                          " played",
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                    onTap: () async {
                                      QuerySnapshot qs = await FirebaseFirestore
                                          .instance
                                          .collection(widget.collection)
                                          .where("song_url",
                                              isEqualTo: snapshot.data.docs[i]
                                                  .get("song_url"))
                                          .get();
                                      await qs.docs.forEach((element) {
                                        FirebaseFirestore.instance
                                            .collection(widget.collection)
                                            .doc(element.id)
                                            .update({
                                          "play": FieldValue.increment(1)
                                        });
                                      });
                                      musicplayer.play(MusicItem(
                                        url: snapshot.data.docs[i]
                                            .get('song_url'),
                                        trackName: snapshot.data.docs[i]
                                            .get('song_name'),
                                        artistName: snapshot.data.docs[i]
                                            .get('song_name'),
                                        albumName: snapshot.data.docs[i]
                                            .get('song_name'),
                                        coverUrl: snapshot.data.docs[i]
                                            .get('image_url'),
                                        duration: Duration(seconds: 255),
                                      ));

                                      await rhis(
                                          snapshot.data.docs[i].id.toString());
                                    })
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

  String dtstr(DateTime d) {
    String te = d.toString();
    String ma = te[0];
    for (int i = 1; i < 10; i++) {
      ma = ma + te[i];
    }
    return ma;
  }

  void rhis(String k) async {
    DocumentSnapshot df = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .collection('history')
        .doc(dtstr(dt))
        .get();
    if (!df.exists) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .collection('history')
          .doc(dtstr(dt))
          .set({"date": dtstr(dt)});
    }
    try {
      await FirebaseFirestore.instance
          .collection(widget.collection)
          .doc(k)
          .collection('tags')
          .snapshots()
          .listen((event) {
        //print("1111");
        event.docs.forEach((element) {
          // print("222");
          reg(element.get("tag"));
        });
      });
    } catch (e) {
      print("errors11");
    }
  }

  void reg(String sk) async {
    DocumentSnapshot df = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .collection(dtstr(dt))
        .doc(sk)
        .get();
    if (df.exists) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection(dtstr(dt))
          .doc(sk)
          .update({sk: FieldValue.increment(1)});
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection(dtstr(dt))
          .doc(sk)
          .set({sk: FieldValue.increment(1)});
    }
  }
}
