import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mem_game/Screen/leaderboard/LeaderBoardScreen.dart';
import '../../Logic/functions_objects.dart';
import '../landing_page/landing_page.dart';
import '../../Logic/google_user_info.dart';
import 'final_screen_utils/custom_button_layout.dart';
import 'final_screen_utils/final_screen_functions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class GameCompleteScreen extends StatefulWidget {
  final Selected selected;
  final int tries;
  final int remainingTime;
  final int points;

  const GameCompleteScreen({
    required this.selected,
    required this.tries,
    required this.points,
    required this.remainingTime,
    super.key,
  });

  @override
  State<GameCompleteScreen> createState() => _GameCompleteScreenState();
}

class _GameCompleteScreenState extends State<GameCompleteScreen> {
  late int score;
  late Future<void> _wait;
  Future<ConnectivityResult> getConnectivity() async {
    return await Connectivity().checkConnectivity();
  }
  Future<ConnectivityResult> checkConnectivityAndProceed() async {
    var connectivityResult = await getConnectivity();
    return connectivityResult;
  }
  Future<void> checkAndProceed() async {
    var connectivityResult = await checkConnectivityAndProceed();
    SelfUser user = selfUser;
    if (user.email != "") {
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        print("Success");
        leaderboardPush(user, score);
        // leaderboardPush(user, 8);

      }


    } else {
      print("Not signed in");
    }
  }
  @override
  void initState() {
    super.initState();
    score = scoreCalculation(widget.tries, widget.remainingTime, widget.selected, widget.points);
    checkAndProceed();

    _wait = Future.delayed(Duration(seconds: 1));
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _wait,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return buildGameCompleteScreen(context);
        }
      },
    );
  }



  @override
  Widget buildGameCompleteScreen(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (remainingTime != 0) {
          Navigator.pop(context);
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
      },
      child: LayoutBuilder(builder: (context, constraints) {
        double containerHeight = constraints.maxHeight;
        double containerWidth = constraints.maxWidth;
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/final_screen_image.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                height: containerHeight * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.background),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).disabledColor,
                        ),
                        width: containerWidth * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Column(
                            children: [
                              Text(
                                "Your score is ",
                                style: GoogleFonts.quicksand(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              Text(
                                "$score",
                                style: GoogleFonts.quicksand(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30),
                              ),
                            ],
                          )),
                        ),
                      ),
                      Column(
                        children: [
                          CustomButtonLayout(
                              containerWidth: containerWidth,
                              title: "Leaderboard",
                              onPressed: () async{
                                var connectivityResult = await (Connectivity().checkConnectivity());
                                if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                  print("INTERNET THERE");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const LeaderBoardScreen()));
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("No internet connection"),
                                    ),
                                  );
                                }


                              }),
                          CustomButtonLayout(
                            containerWidth: containerWidth,
                            title: "Go Home",
                            onPressed: () {
                              Navigator.popUntil(context, (route) => route.isFirst);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const MyApp()),
                              );
                            },

                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
