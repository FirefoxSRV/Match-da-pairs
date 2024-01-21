import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ParentMaterialAlertDialog extends StatelessWidget {
  const ParentMaterialAlertDialog({
    super.key,
    required this.title,
    required this.containerHeight,
    required this.onPressed
  });
  final String title;
  final double containerHeight;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomRight: Radius.circular(20))
      ),
      color: Theme.of(context).colorScheme.primary,
      onPressed:onPressed,
      child: Text(title,style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
    );
  }
}


class OpenMaterialAlertDialog extends StatelessWidget {
  const OpenMaterialAlertDialog({
    super.key,
    required this.containerHeight,
    required this.title,
    required this.content,
    this.actions
  });

  final double containerHeight;
  final String title;
  final String content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        double width = constraints.maxWidth;
        return AlertDialog(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)
            ),
            title: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(fontSize: 25,fontWeight: FontWeight.w600),
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: width*0.7,
                  height: containerHeight * 0.1,
                  child: Center(child: Text(content,style: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.normal,color: Theme.of(context).disabledColor),))
              ),
            ),
          actions: actions,
        );
      }
    );
  }
}

