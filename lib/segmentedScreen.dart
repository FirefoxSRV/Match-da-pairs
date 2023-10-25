import 'package:flutter/material.dart';




class SegmentedScreen extends StatefulWidget {
  const SegmentedScreen({super.key});

  @override
  State<SegmentedScreen> createState() => _SegmentedScreenState();
}

class _SegmentedScreenState extends State<SegmentedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Row(
          children: [
            Container(child: Text("Hi"),),
            Container(child: Text("Hello"),),
            Container(child: Text("Bye"),),
          ],
        )
      ),
    );
  }
}
