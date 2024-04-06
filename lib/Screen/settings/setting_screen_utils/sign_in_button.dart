import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SignInButton extends StatelessWidget {
  SignInButton({super.key,required this.title,
    required this.content,
    required this.containerWidth,
    required this.containerHeight,
    required this.fontAwesomeIcon,
    required this.onPressed,
    required this.isLoading});

  double containerWidth;
  double containerHeight;
  String title;
  String content;
  IconData fontAwesomeIcon;
  bool isLoading;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(left: containerWidth/6.1),
            child: Text(title,
                style: GoogleFonts.quicksand(
                    fontSize: 20.0, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.tertiary),),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Padding(
              padding: EdgeInsets.only(bottom: containerHeight/42.264,left: containerWidth/20.57),
              child: FaIcon(fontAwesomeIcon,color: Theme.of(context).colorScheme.tertiary,),
            ),
              SizedBox(width: containerWidth/16.45,),
              Expanded(
                child: Text(
                    content,
                    style: GoogleFonts.quicksand(fontSize: 16.0,color: Theme.of(context).colorScheme.tertiary),),
              ),
            ],
          ),
        ],
      ),
    );
  }

}



