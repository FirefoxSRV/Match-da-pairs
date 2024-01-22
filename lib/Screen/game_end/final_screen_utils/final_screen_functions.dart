import 'package:firebase_database/firebase_database.dart';
import '../../../Logic/functions_objects.dart';
import '../../../Logic/google_user_info.dart';

void leaderboardPush(SelfUser user, int newPoints) async {
  final newEmail = user.email;
  final displayUrl = user.displayUrl;
  final displayName = user.displayName;
  final databaseReference = FirebaseDatabase.instance.ref("Players");
  Query dbRef = FirebaseDatabase.instance.ref().child('Players').orderByChild("points");
  dbRef.once().then((DatabaseEvent event) {
    if (event.snapshot.exists && points == 8) {
      Map<dynamic, dynamic> values =
      event.snapshot.value as Map<dynamic, dynamic>;
      bool emailExists = false;
      String keyToUpdate = '';
      values.forEach((key, value) {
        if (value['email'] == newEmail) {
          emailExists = true;
          int existingPoints = int.parse(value['points'].toString());
          if (newPoints > existingPoints) {
            keyToUpdate = key;
          }
        }
      });
      if (emailExists && keyToUpdate.isNotEmpty) {
        databaseReference.child(keyToUpdate).update({
          "points": newPoints.toString(),
          "displayName": displayName,
          "displayUrl": displayUrl
        });
      } else if (!emailExists) {
        databaseReference.push().set({
          "email": newEmail,
          "points": newPoints.toString(),
          "displayName": displayName,
          "displayUrl": displayUrl
        });
      }
    } else {
      if (points == 8) {
        databaseReference.push().set({
          "email": newEmail,
          "points": newPoints.toString(),
          "displayName": displayName,
          "displayUrl": displayUrl
        });
      }
    }
  });
}






int scoreCalculation(int tries, int timeLeft, Selected selected,int points) {

  if (selected == Selected.easy) {
    return 500;
  } else if (selected == Selected.medium) {
    if (points < 8){
      return points*90;
    }
    int score = 1000 - (50 * (tries - 8)) + 5 * (timeLeft);
    return score;
  } else if (selected == Selected.hard) {
    if (points < 8){
      return points*120;
    }
    int score = 1500 - (50 * (tries - 8)) + 5 * (timeLeft);
    return score;
  }
  return 0;
}