import 'package:cloud_firestore/cloud_firestore.dart';

class Getdata {

   List<QueryDocumentSnapshot> rdata(){
      List<QueryDocumentSnapshot> mdata;
      ()async{
        CollectionReference qn = await FirebaseFirestore.instance.collection('mname');
      
        qn.snapshots().listen((snapshot) { 
         mdata= snapshot.docs;
        });
        return mdata;
      };
   }
  
}