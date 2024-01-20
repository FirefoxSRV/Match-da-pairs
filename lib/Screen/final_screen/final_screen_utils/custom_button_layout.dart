import 'package:flutter/material.dart';



class CustomButtonLayout extends StatelessWidget {
  const CustomButtonLayout(
      {super.key,
        required this.containerWidth,
        required this.title,
        required this.onPressed});
  final String title;
  final double containerWidth;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: containerWidth * 0.5,
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
