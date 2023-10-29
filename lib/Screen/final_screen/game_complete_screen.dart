
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mem_game/main.dart';

import '../../Logic/functions_objects.dart';

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
    return WillPopScope(
      onWillPop: (){
        if (remainingTime != 0){
          Navigator.pop(context);
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
        return Future.value(false);
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Go Home",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
              ),
              Container(
                child: Text("points :$points"),
              ),
              selected != Selected.easy?Container(
                child: Text("Remaining Time :$remainingTime"),
              ):Container(child: Text(""),),
              Container(

                child: Text("Tries:$tries"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
