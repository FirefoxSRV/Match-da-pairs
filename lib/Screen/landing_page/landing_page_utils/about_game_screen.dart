import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutGameScreen extends StatelessWidget {
  const AboutGameScreen({super.key, this.actions});

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double height = constraints.maxHeight;
      double width = constraints.maxWidth;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "About Game",
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(color:Theme.of(context).colorScheme.tertiary
                ,fontSize: 32,fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "How to play ?",
                    style: GoogleFonts.quicksand(
                        fontSize: 28  ,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),

                Text(
                  "Your mission: find and match 8 pairs of cards. There are 3 difficulty modes : Easy, Medium and Hard. ",
                  style: GoogleFonts.quicksand(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).disabledColor),
                ),
                Center(
                  child: Text(
                    "Easy mode",
                    style: GoogleFonts.quicksand(
                        fontSize: 28  ,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                Text(
                  "You get a whopping 500 points when you find all 8 pairs! And don't worry about making mistakes - there's no penalty for wrong guesses , neither there is time limit.",
                  style: GoogleFonts.quicksand(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).disabledColor),
                ),
                Center(
                  child: Text(
                    "Medium mode",
                    style: GoogleFonts.quicksand(
                        fontSize: 28  ,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                Text(
                  "While the mission goal stays the same, there is a time limit of 120 seconds for your boat to sail towards your goal. There is a 50 point penalty for wrong guesses, but let that not stop you. Additionally, for every remaining second on the clock, you earn 5 bonus points. So calculate your moves and time to maximize your points. ",
                  style: GoogleFonts.quicksand(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).disabledColor),
                ),
                Center(
                  child: Text(
                    "Hard mode",
                    style: GoogleFonts.quicksand(
                        fontSize: 28  ,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                Text(
                  "This mode is very similar to the medium mode, but you will notice the difference once you step in. Black and white patterns are hard to memorize and that is the challenge. Again a 50 point penalty for wrong guesses and for every remaining second on the clock, you earn 5 bonus points. ",
                  style: GoogleFonts.quicksand(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).disabledColor),
                ),
              ],
            ),
          ),
        )
      );
    });
  }
}
