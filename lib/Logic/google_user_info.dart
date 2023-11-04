import 'package:firebase_auth/firebase_auth.dart';

bool userAvailable = false;
User? user;
SelfUser selfUser = SelfUser();

class SelfUser{
  String displayName="";
  String email="";
  String displayUrl="";



  void classMapper(User? user){
    if(user!=null){
      displayName = user.displayName!;
      email = user.email!;
      displayUrl = user.photoURL!;
    }
  }

}