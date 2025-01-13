import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mem_game/Logic/google_user_info.dart';


class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    super.key,
    required this.title,
    required this.content,
    required this.containerWidth,
    required this.containerHeight,
    required this.fontAwesomeIcon,
    required this.onPressed
  });

  final double containerWidth;
  final double containerHeight;
  final String title;
  final String content;
  final IconData fontAwesomeIcon;
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
                    fontSize: 20.0, fontWeight: FontWeight.bold,color: selfUser.email !=""?Theme.of(context).colorScheme.tertiary:Colors.grey)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Padding(
              padding: EdgeInsets.only(bottom: containerHeight/42.264,left: containerWidth/20.57),
              child: FaIcon(fontAwesomeIcon,color: selfUser.email!=""?Theme.of(context).colorScheme.tertiary:Colors.grey,),
            ),
              SizedBox(width: containerWidth/16.45,),
              Expanded(
                child: Text(
                    content,
                    style: GoogleFonts.quicksand(fontSize: 16.0,color: selfUser.email!=""?Theme.of(context).colorScheme.tertiary:Colors.grey)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
