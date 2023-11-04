
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

      return user;
    }
  } catch (error) {
    print(error);
    return null;
  }
}
