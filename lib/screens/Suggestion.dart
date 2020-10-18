import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/SongObj/SObject.dart';
import 'package:my_project/screens/Finalplaylist.dart';

class Suggestion extends StatefulWidget {
  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  final ffi = FirebaseFirestore.instance;
  Map fi = new Map<String, int>();
  List k = new List<SObject>();

  void initState() {
    super.initState();
    filter();
  }

  void makesug() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('history')
        .orderBy("date", descending: true)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        makesug1(element.get("date"));
      });
    });
  }

  void makesug1(String da) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection(da)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        setState(() {
          fi[element.id] = element.get(element.id);
        });
      });
    });
  }

  void filter() async {
    await makesug();
    await ffi.collection("suggestions").snapshots().listen((event) {
      event.docs.forEach((element) {
        filter1(element.get("name"));
      });
    });
  }

  void filter1(String s) async {
    await FirebaseFirestore.instance.collection(s).snapshots().listen((event1) {
      event1.docs.forEach((element1) {
        int cntt = 0;
        FirebaseFirestore.instance
            .collection(s)
            .doc(element1.id)
            .collection("tags")
            .snapshots()
            .listen((event2) {
          event2.docs.forEach((element2) {
            try {
              if (fi.containsKey(element2.get("tag"))) {
                cntt += fi[element2.get("tag")];
              }
            } catch (e) {}
          });
          if (cntt > 0) {
            SObject tek = SObject(
                album: s,
                song: element1.get("song_name"),
                song_url: element1.get("song_url"),
                img_url: element1.get("image_url"),
                cnt: cntt);
            k.add(tek);
          }
        });
      });
      //sorting();
    });

    print("object");
    await print(k.length);
  }

  int sorting() {
    () async {
      filter();
    };

    k.sort((a, b) {
      return b.cnt.compareTo(a.cnt);
    });
    return k.length;
  }

  @override
  Widget build(BuildContext context) {
    // sorting();
    return Scaffold(
      body: ListView.builder(
          itemCount: sorting(),
          itemBuilder: (context, ind) {
            try {
              return ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(k[ind].img_url),
                  ),
                  title: Text(k[ind].song),
                  subtitle: Text(k[ind].cnt.toString()),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Finalplaylist(
                              ke: true,
                              sk: k[ind],
                            )));
                  });
            } catch (e) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        onPressed: () async {
          await k.clear();
          await filter();
        },
        child: Icon(
          Icons.refresh,
          size: 30.0,
        ),
      ),
    );
  }

  Future setdata() async {
    QuerySnapshot qn = await ffi.collection("suggestion").get();

    Stream<QuerySnapshot> pn = await ffi.collection("suggestions").snapshots();

    try {
      await pn.listen((event) {
        event.docs.forEach((element) {
          print(element.get("name"));
        });
      });
      // print("object1");
    } catch (e) {
      // print("object");
    }
  }
}
