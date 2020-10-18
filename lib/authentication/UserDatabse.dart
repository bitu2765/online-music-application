import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabase {
  String uid;
  UserDatabase({this.uid});
 
  final CollectionReference cr = FirebaseFirestore.instance.collection('users');
  Future updateusetdata(String email, String pass) async {
    return  await cr.doc(uid).set({"email":email});
  }
}
