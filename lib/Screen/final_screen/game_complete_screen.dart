import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  late int score;

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
    score = scoreCalculation(tries, widget.remainingTime, widget.selected);
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
      if (event.snapshot.exists && points == 8) {
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
        if(points == 8){
          databaseReference.push().set({
            "email": newEmail,
            "points": newPoints.toString(),
            "displayName":displayName,
            "displayUrl":displayUrl
          });
        }

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
      child: LayoutBuilder(
        builder: (context,constraints) {
          double containerHeight = constraints.maxHeight;
          double containerWidth = constraints.maxWidth;
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/final_screen_image.png"), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  height: containerHeight*0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.background
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).disabledColor,
                          ),
                          width: containerWidth*0.4,
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Column(
                              children: [
                                Text("Your score is ",style: GoogleFonts.quicksand(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w700,fontSize: 20),),
                                Text("$score",style: GoogleFonts.quicksand(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w700,fontSize: 30),),
                              ],
                            )),
                          ),
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              minWidth: containerWidth*0.5,
                              color: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const LeaderBoardScreen()));
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Leaderboard",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                            ),
                            MaterialButton(
                              minWidth: containerWidth*0.5,
                              color: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              onPressed: () {
                                if (remainingTime != 0){
                                  Navigator.pop(context);
                                }
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyApp()));
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Go Home",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}



