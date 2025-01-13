import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../game_end/final_screen.dart';

class TimerFloatingActionButton extends StatefulWidget {
  final bool isVisible;
  final Function(int remTime) onTick;
  final String mode;
  final bool isPaused;
  const TimerFloatingActionButton({
    Key? key,
    required this.mode,
    required this.isPaused,
    required this.isVisible,
    required this.onTick,
  }) : super(key: key);

  @override
  _TimerFloatingActionButtonState createState() => _TimerFloatingActionButtonState();
}

class _TimerFloatingActionButtonState extends State<TimerFloatingActionButton> {

  Timer? timer;
  int remainingTime = 120;
  @override
  void initState() {
    super.initState();
    if (widget.isVisible) {
      startTimer();
    }
  }

  void resetTimer() {
    setState(() {
      remainingTime = 120;
    });
    if (widget.isVisible) {
      startTimer();
    }
  }


  @override
  void didUpdateWidget(TimerFloatingActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.mode != widget.mode || oldWidget.isVisible != widget.isVisible) {
      resetTimer();
    }
    if (widget.isVisible) {
      startTimer();
    } else {
      stopTimer();
    }
  }

  void startTimer() {
    stopTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        if (widget.isPaused) {
          return;
        }
        setState(() {
          remainingTime--;
        });
      } else {
        stopTimer();
      }
      widget.onTick(remainingTime);
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: widget.isVisible,
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        width: width * 0.5,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {
              // Add your functionality here
            },
            child: Row(
              children: [
                const Expanded(child: Icon(Icons.alarm)),
                Expanded(
                  child: Text(
                    "${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}",
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
