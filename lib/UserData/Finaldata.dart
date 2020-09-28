import 'package:flutter/material.dart';
import 'package:my_project/UserData/Curplaysongdata.dart';

class Finaldata {
  Curplaysongdata cpsd = new Curplaysongdata();
  void setplay(String i,String s){
    cpsd.setsong(s,i);
  }
  String returnimg()
  {
    return cpsd.image;
  }
  String returnsong()
  {
    return cpsd.song;
  }
  
}