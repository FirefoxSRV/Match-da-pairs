
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Logic/google_user_info.dart';


Future<User?> signInWithGoogle(GoogleSignIn googleSignIn,FirebaseAuth auth) async {
  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential authResult = await auth.signInWithCredential(credential);
      final User? user = authResult.user;
      selfUser.classMapper(user);

      return user;
    }
  } catch (error) {
    if (kDebugMode) {
      print(error);
    }
  }
  return null;
}


Future<void> signOut(googleSignIn,auth) async {
  try {
    await auth.signOut();
    await googleSignIn.signOut();

    user = null;
    userAvailable = false;
  } catch (e) {
    if (kDebugMode) {
      print("Error signing out: $e");
    }
  }
}