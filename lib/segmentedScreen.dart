import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Selected { easy, medium, hard }

class SegmentedScreen extends StatefulWidget {
  const SegmentedScreen({super.key});

  @override
  State<SegmentedScreen> createState() => _SegmentedScreenState();
}

class _SegmentedScreenState extends State<SegmentedScreen> {
  Selected _selected = Selected.easy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 300.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).colorScheme.tertiary),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: _selected == Selected.easy
                    ? 0
                    : _selected == Selected.medium
                        ? MediaQuery.of(context).size.width / 3
                        : 2 * MediaQuery.of(context).size.width / 3,
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(Selected.easy, "Easy"),
                  _buildButton(Selected.medium, "Medium"),
                  _buildButton(Selected.hard, "Hard"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(Selected level, String text) {
    bool isSelected = _selected == level;
    Color textColor = isSelected
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.tertiary;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selected = level;
          });
        },
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,color: textColor),
          ),
        ),
      ),
    );
  }
}
