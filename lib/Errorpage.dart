import 'package:flutter/material.dart';

class Errorpage extends StatefulWidget{
  _Errorpage createState() => _Errorpage();
}

class  _Errorpage extends State<Errorpage> {
  
  @override
  Widget build(BuildContext contetx)
  {
      return MaterialApp(
        title: 'ERROR PAGE',
        debugShowCheckedModeBanner: false,
        home:  Scaffold(
          appBar: AppBar(
            title: Text('error found'),
            backgroundColor: Colors.amber,
          ),
        ),
      );
  }
}