import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {

  _Homepage createState() => _Homepage();
}

class _Homepage extends State<Homepage>{

  String phonenum;


  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: "Authentication",
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("phone login"),)
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'phone number',
                ),
                onChanged: (value){
                  this.phonenum=value;
             },
              ),
            ),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }
}