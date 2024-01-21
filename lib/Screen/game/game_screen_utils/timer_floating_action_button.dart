import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Logic/functions_objects.dart';
import '../../game_end/final_screen.dart';

class TimerFloatingActionButton extends StatefulWidget {
  Selected selected;
  final bool showPoints;
  final int remainingTime;
  final Function(int remainingTime) onTick;
  TimerFloatingActionButton({
    Key? key,
    required this.selected,
    required this.showPoints,
    required this.remainingTime,
    required this.onTick,
  }) : super(key: key);

  @override
  _TimerFloatingActionButtonState createState() => _TimerFloatingActionButtonState();
}

class _TimerFloatingActionButtonState extends State<TimerFloatingActionButton> {

  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (widget.selected != Selected.easy && widget.showPoints) {
      startTimer();
    }
  }

  @override
  void didUpdateWidget(TimerFloatingActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != Selected.easy && widget.showPoints) {
      startTimer();
    } else {
      stopTimer1();
    }
  }

  void startTimer() {
    stopTimer1();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
        widget.onTick(remainingTime);
      } else {
        stopTimer2();
      }
    });
  }

  void stopTimer1() {
    timer?.cancel();
  }

  void stopTimer2() {
    timer?.cancel();
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return GameCompleteScreen(selected: widget.selected,remainingTime: remainingTime,tries: tries,points: points);
    }));
  }

  @override
  void dispose() {
    stopTimer1();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: widget.selected != Selected.easy && widget.showPoints,
      child: AnimatedContainer(
        duration: Duration(seconds: 3),
        width: width * 0.5,
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {
              // Add your functionality here
            },
            child: Row(
              children: [
                Expanded(child: Icon(Icons.alarm)),
                Expanded(
                  child: Text(
                    "${widget.remainingTime ~/ 60}:${(widget.remainingTime % 60).toString().padLeft(2, '0')}",
                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: width * 0.05),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
