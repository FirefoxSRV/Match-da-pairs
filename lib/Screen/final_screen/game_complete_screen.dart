import 'package:flutter/material.dart';
import '../../Logic/functions_objects.dart';
import '../first_screen/my_app.dart';

class GameCompleteScreen extends StatelessWidget {
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
              selected != Selected.easy?Text("Remaining Time :$remainingTime"):const Text(""),
              Text("Tries:$tries")
            ],
          ),
        ),
      ),
    );
  }
}
