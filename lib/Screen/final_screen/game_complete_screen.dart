
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Logic/functions_objects.dart';

class GameCompleteScreen extends StatelessWidget {
  const GameCompleteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    points = 0;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(25)),
        child: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Go Home",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
