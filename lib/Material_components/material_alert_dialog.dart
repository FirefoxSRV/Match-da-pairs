
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ParentMaterialAlertDialog extends StatelessWidget {
  ParentMaterialAlertDialog({
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
      shape: RoundedRectangleBorder(
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
  });

  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
        ),
        title: Center(
          child: Text(
            "Alert",
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(fontSize: 25,fontWeight: FontWeight.w600),
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: 300,
              height: containerHeight * 0.1,
              child: Text("This is just a normal alert dialog box",style: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.normal,color: Theme.of(context).disabledColor),)
          ),
        ));
  }
}

