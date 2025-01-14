import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'material_alert_dialog.dart';

Future<dynamic> buildExitDialog(BuildContext context, double height, Function onCancel) {
  return showDialog(
      context: context,
      builder: (context) {
        return OpenMaterialAlertDialog(
          title: "Exit",
          content: "This will reset your progress.",
          containerHeight: height * 0.5,
          actions: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: GoogleFonts.quicksand(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary)),
              onPressed: () {
                Navigator.pop(context);
                onCancel();
              },
              child: const Text("Cancel"),
            )
          ],
        );
      });
}