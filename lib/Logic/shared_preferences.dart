import 'package:flutter/material.dart';
import 'package:mem_game/Logic/google_user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> setDataToStore(String? userEmail,String? userName,String? photoUrl) async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.setString('username', userName!);
  pref.setString('email', userEmail!);
  pref.setString('photoUrl', photoUrl!);
}

Future<void> getStoredData() async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  if(pref.getString('username')==null){
    pref.setString('username', '');
    pref.setString('email', '');
    pref.setString('photoUrl', '');
    return;
  }
  selfUser.email = pref.getString('email')! ?? '';
  selfUser.displayName = pref.getString('username')! ?? '';
  selfUser.displayUrl = pref.getString('photoUrl')! ?? '';
  userAvailable = true;
  print(selfUser.email);
}

Future<void> resetStoredData() async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.clear();
}