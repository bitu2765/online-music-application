import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:firebase/firestore.dart';

class Practice extends StatefulWidget {
  _pra createState() => new _pra();
}

class _pra extends State<Practice> {
  bool _intializ=false,_error=false;
  void initState(){
    initializeFlutterFire();
    super.initState();
  }


  void initializeFlutterFire() async{
    try{
        await Firebase.initializeApp();
      setState(() {
        _intializ=true;
      });
    }catch(e)
    {
      setState(() {
        _error=true;
      });
    }
  }

  Stream<QuerySnapshot> pd;

  Stream<QuerySnapshot> gd() {
    asn();
    return pd;
  }

  Future asn() async{
    Stream<QuerySnapshot> td = await FirebaseFirestore.instance.collection('mname').snapshots();
    setState(() {
      pd = td;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('moviesong').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          } 
          else
          {
            return new ListView.builder(
              itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext  context, index) {
              QueryDocumentSnapshot ds = snapshot.data.docs[index];
                  return InkWell(
                    onTap: ()=>{},
                    child: Card(
                      child:Padding(
                        padding: EdgeInsets.all(15.0),
                          child: Text(
                            ds.get('movie_name').toString(),
                            style: TextStyle(fontSize: 20.0),
                      ),
                      ),
                      elevation: 10.0,
                    ),
                  );
                }
                );
          }
        }
      );
  }
}