import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Uploadfile extends StatefulWidget {
  @override
  _Uploaded createState() => _Uploaded();
}

class _Uploaded extends State<Uploadfile> {

  TextEditingController songname = TextEditingController();
  TextEditingController artistname = TextEditingController();

 /* File image;
  String imagepath;
  void selectimage() async{
    image = await FilePicker.getFile();
    setState(() {
      image = image;
      imagepath = basename(image.path);
    });
  }*/
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: ()=>{},
            child: Text("select image"),
          ),
          RaisedButton(
            onPressed: ()=>{},
            child: Text("select song"),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: songname,
            decoration: InputDecoration(
              hintText: "enter song name",
            ),
            )
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: artistname,
            decoration: InputDecoration(
              hintText: "enter artist name",
            ),
            )
          ),
          RaisedButton(
            onPressed: ()=>{},
            child: Text("Upload"),
          )
        ],
      ),
    );
  }
}
