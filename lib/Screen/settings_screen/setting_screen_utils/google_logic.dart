
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Logic/google_user_info.dart';


Future<User?> signInWithGoogle(GoogleSignIn _googleSignIn,FirebaseAuth _auth) async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      selfUser.classMapper(user);
      return user;
    }
  } catch (error) {
    print(error);
    return null;
  }
}


Future<void> signOut(_googleSignIn,_auth) async {
  try {
    await _auth.signOut();
    await _googleSignIn.signOut();

    user = null;
    userAvailable = false;
  } catch (e) {
    print("Error signing out: $e");
  }
}