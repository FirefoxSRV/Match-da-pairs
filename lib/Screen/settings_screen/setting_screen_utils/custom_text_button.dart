
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
  });

  final double containerWidth;
  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(left: containerWidth/6.1),
            child: Text("Sign In with Google",
                style: GoogleFonts.quicksand(
                    fontSize: 20.0, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.tertiary)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Padding(
              padding: EdgeInsets.only(bottom: containerHeight/42.264,left: containerWidth/20.57),
              child: FaIcon(FontAwesomeIcons.google,color: Theme.of(context).colorScheme.tertiary,),
            ),
              SizedBox(width: containerWidth/16.45,),
              Expanded(
                child: Text(
                    "You are not yet signed in . Sign in to save your data and sync it across devices .",

                    style: GoogleFonts.quicksand(fontSize: 16.0,color: Theme.of(context).colorScheme.tertiary)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
