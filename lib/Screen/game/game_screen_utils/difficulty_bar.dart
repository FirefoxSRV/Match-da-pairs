
import 'package:flutter/material.dart';

import '../../../Logic/structure.dart';

class DifficultyBar extends StatelessWidget {
  const DifficultyBar({
    super.key,
    required Selected selected,
    required double height
  }) : _selected = selected, height= height;

  final Selected _selected;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: _selected == Selected.easy
          ? 0
          : _selected == Selected.medium
          ? MediaQuery.of(context).size.width / 3
          : 2 * MediaQuery.of(context).size.width / 3,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: height * 0.05,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
