import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mem_game/Screen/leaderboard_screen/LeaderBoardScreen.dart';
import '../../Logic/functions_objects.dart';
import '../first_screen/my_app.dart';
import '../../Logic/google_user_info.dart';


class GameCompleteScreen extends StatefulWidget {
  final Selected selected;
  final int tries;
  final int remainingTime;
  final int points;

  const GameCompleteScreen({
    required this.selected,
    required this.tries,
    required this.points,
    required this.remainingTime,
    super.key,
  });

  @override
  State<GameCompleteScreen> createState() => _GameCompleteScreenState();
}

class _GameCompleteScreenState extends State<GameCompleteScreen> {
  int scoreCalculation(int tries,int timeLeft,Selected selected){
    if(selected == Selected.easy){
      return 500;
    }else if(selected == Selected.medium){
      int score = 1000 - (50* (tries-8)) + 5*(timeLeft);
      return score;
    }else if(selected == Selected.hard){
      int score = 1500 - (50* (tries-8)) + 5*(timeLeft);
      return score;
    }
    return 0;
  }

  @override
  void initState() {
    int score = scoreCalculation(tries, widget.remainingTime, widget.selected);
    print(score);
    SelfUser user = selfUser;
    if (user.email !=""){
      leaderboardPush(user,score);
    }else{
      print("Not signed in");
    }

    super.initState();
  }

  void leaderboardPush(SelfUser user, int newPoints) async{
    final newEmail = user.email;
    final displayUrl = user.displayUrl;
    final displayName = user.displayName;
    final databaseReference = FirebaseDatabase.instance.ref("Players");
    Query dbRef  = FirebaseDatabase.instance.ref().child('Players').orderByChild("points");
    dbRef.once().then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
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
            "displayName":displayName,
            "displayUrl":displayUrl
          });
        } else if (!emailExists) {
          databaseReference.push().set({
            "email": newEmail,
            "points": newPoints.toString(),
            "displayName":displayName,
            "displayUrl":displayUrl
          });
        }
      } else {
        databaseReference.push().set({
          "email": newEmail,
          "points": newPoints.toString(),
          "displayName":displayName,
          "displayUrl":displayUrl
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop){
        if (didPop){
          return;
        }
        if (remainingTime != 0){
          Navigator.pop(context);
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyApp()));
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.amber,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                onPressed: () {
                  if (remainingTime != 0){
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyApp()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Go Home",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
              ),
              Text("points :$points"),
              widget.selected != Selected.easy?Text("Remaining Time :$remainingTime"):const Text(""),
              Text("Tries:$tries"),
              MaterialButton(
                color: Colors.amber,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LeaderBoardScreen()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Go to leaderboard",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



