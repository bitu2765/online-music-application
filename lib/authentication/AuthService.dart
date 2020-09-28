import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Loginpage.dart';
import 'package:my_project/screens/Practice.dart';

import 'MUser.dart';


class AuthService {
  
  FirebaseAuth _auth=FirebaseAuth.instance;

  //create user object based on firebase
  MUser _userFromFirebaseUser(User user){
    return user != null ? MUser(uid: user.uid):null;
  }

  Stream<MUser> get user{
    return _auth.authStateChanges().map( _userFromFirebaseUser);
  }
  //create account with email&password in firebase
  Future registerwithemailandpassword(String email,String pass)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);

    User user = result.user;
    return  _userFromFirebaseUser(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
    
  }

  // sign in with email&password in firebase

  //sign out
  Future signOut() async{
    try{
      await _auth.signOut();
    }catch(e)
    {
      print(e);
    }
  }

}