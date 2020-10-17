import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/scheduler.dart';
import 'package:my_project/authentication/userdatabse.dart';

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
  void registerwithemailandpassword(String email,String pass)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      User user = result.user;
        try{
           await user.sendEmailVerification();
           //add user on firebase firestore for user record
           await UserDatabase(uid:  user.uid).updateusetdata(email, pass);
           signOut();
        }
        catch(e)
        {
          user.delete();
          print("verification not complete");
          return;
        }
      
   // return  _userFromFirebaseUser(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
    
  }

  // sign in with email&password in firebase
  Future signinWithemailandpassword(String email,String pass) async
  {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User user  = result.user;
      if(!user.emailVerified)
      {
        signOut();
        return;
      }
      return _userFromFirebaseUser(user);
    }
    catch(e)
    {
      print(e.toString());
    }
  }


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