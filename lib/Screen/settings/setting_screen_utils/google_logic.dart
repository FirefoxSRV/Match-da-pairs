import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Logic/google_user_info.dart';
import '../../../Logic/shared_preferences.dart';

Future<User?> signInWithGoogle(GoogleSignIn googleSignIn, FirebaseAuth auth) async {
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

      // Store user data in shared preferences
      await setDataToStore(user?.email, user?.displayName, user?.photoURL);

      return user;
    } else {
      if (kDebugMode) {
        print("Google sign-in failed: googleUser is null");
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print("Error during Google sign-in: $error");
    }
  }
  return null;
}

Future<void> signOut(GoogleSignIn googleSignIn, FirebaseAuth auth) async {
  try {
    await auth.signOut();
    await googleSignIn.signOut();

    user = null;
    userAvailable = false;

    // Clear user data from shared preferences
    await resetStoredData();
  } catch (e) {
    if (kDebugMode) {
      print("Error signing out: $e");
    }
  }
}