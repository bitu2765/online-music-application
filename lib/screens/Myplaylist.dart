
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:my_project/Songplayer/SongPlay1.dart';

class Myplaylist extends StatefulWidget{
  String collection,imgurl;
  Myplaylist({this.collection,this.imgurl});
  @override
  _PlaylistMy createState() => _PlaylistMy();
}
class _PlaylistMy extends State<Myplaylist> {
 // _PlaylistMy(){getdata();}
 

  /* bool _intializ=false;
  bool _error=false;

   @override
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
*/
  List<QueryDocumentSnapshot> mdata;

   Future getdata() async {
      CollectionReference qn = await FirebaseFirestore.instance.collection(widget.collection);
      
      qn.snapshots().listen((snapshot) { 
        setState(() {
          mdata = snapshot.docs;
        });
      });
      return qn.doc();
    }

  @override
  void initState() {
    super.initState();
    getdata();
  }
  
    @override
    Widget build(BuildContext context) {
      if(mdata == null)
      {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      else     
      {
        return Scaffold(
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection(widget.collection).snapshots(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return CircularProgressIndicator();
              }
              else{
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot temp = snapshot.data.docs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(temp.get('image_url')),
                        backgroundColor: Colors.brown,
                      ),
                    );
                  },
                );
              }
            }
            ),
        );
      }
     /* return FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } 
          else {
            return new ListView.builder(
              itemCount: snapshot.size(),
            itemBuilder: (BuildContext  context, index) {
                  return InkWell(
                    onTap: ()=>{},
                    child: Card(
                      child:Padding(
                        padding: EdgeInsets.all(15.0),
                          child: Text(
                            mdata[index].get(),
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
      );*/
    }
  }
  
class _Myplay2 extends State<Myplaylist>{

  _Myplay2(){getdata();}


  List<QueryDocumentSnapshot> mdata;

   Future getdata() async {
      CollectionReference qn = await FirebaseFirestore.instance.collection(widget.collection);
      
      qn.snapshots().listen((snapshot) { 
        setState(() {
          mdata = snapshot.docs;
        });
      });
      return qn.doc();
    } 


  @override
  Widget build(BuildContext context)
  {
    getdata();
    return Scaffold(
      body: Container(
        height: 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0)
          )
        ),
        child: Image.network(widget.imgurl),
          ),
      );
  }
}
