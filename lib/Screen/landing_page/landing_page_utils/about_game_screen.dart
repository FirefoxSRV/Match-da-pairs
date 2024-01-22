import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutGameScreen extends StatelessWidget {
  const AboutGameScreen({super.key, this.actions});

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
            icon: const Icon(Icons.arrow_back),
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
                  "Your mission: find and match 8 pairs of hidden cards. Visibility of the cards are set for 5 seconds for you to memorize the cards. There are 3 difficulty modes : Easy, Medium and Hard. ",
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
                  "While the mission goal stays the same, there is a time limit of 120 seconds for your boat to sail towards your goal. There is a 50 point penalty for wrong guesses, but let that not stop you. Additionally, for every remaining second on the clock, you earn 5 bonus points. You get scores even if you do not complete finding all the 8 pairs - 90 points for each pair found. The math is different if you find all 8 pairs. So calculate your moves and time to maximize your points. ",
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
                  "This mode is similar to the medium mode, but you will notice the difference once you step in. Black and white patterns are hard to memorize and that is the challenge. Again a 50 point penalty for wrong guesses and for every remaining second on the clock, you earn 5 bonus points. If you are not able to complete the game within the given time limit, you get 120 points for each pair found. ",
                  style: GoogleFonts.quicksand(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).disabledColor),
                ),
                Center(
                  child: Text(
                    "The Formula",
                    style: GoogleFonts.quicksand(
                        fontSize: 28  ,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).disabledColor,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "D − Penalty × ( Tries − 8  ) + 5 ×  (120 − Time)",
                        style: GoogleFonts.quicksand(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).dialogBackgroundColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "where, D takes value of 1000 for medium and 1500 for hard level.",
                  style: GoogleFonts.quicksand(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).disabledColor),
                ),
                Center(
                  child: Text(
                    "Google sync",
                    style: GoogleFonts.quicksand(
                        fontSize: 28  ,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                Text(
                  "This app uses firebase to store the scores of users. Hence, you need to sign in via google for syncing your scores. To sign in, go to in-app Settings in the home screen -> Click on sign in with Google.",
                  style: GoogleFonts.quicksand(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).disabledColor),
                ),
                Center(
                  child: Text(
                    "Tips",
                    style: GoogleFonts.quicksand(
                        fontSize: 28  ,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                Text(
                  "Shhsh.....No one bothers to scroll till the last. Here me out. To climb the leaderboard, you need to grind yourself in the 'Hard' section as that can fetch you a lot of points. Try to get all the pairs in 8/8. And yup, be the flash.",
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
