
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_project/authentication/AuthService.dart';
import 'package:my_project/authentication/MUser.dart';
import 'package:provider/provider.dart';

import 'Buildpage.dart';



void main()async{
  String useruid;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  NewApp createState() => NewApp();
}

class NewApp extends State<MyApp>{
 

  @override
  Widget build(BuildContext context)
  {
    return StreamProvider<MUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Buildpage(),
      ),
      );
  }
}