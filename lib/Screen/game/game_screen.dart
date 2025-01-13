import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Logic/structure.dart';
import 'game_screen_utils/difficulty_bar.dart';
import 'game_screen_utils/exit_dialog.dart';
import 'game_screen_utils/material_alert_dialog.dart';
import '../game_end/final_screen.dart';
import 'game_screen_utils/tile.dart';
import 'game_screen_utils/timer_floating_action_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  Selected _selected = Selected.easy;

  int points = 0;
  int tries = 0;

  bool _showPoints = false;
  int remainingSeconds = 5;
  Timer? _isCountToStartTimer;
  String mode = "easy";

  int remainingTime = 0; //Will be updated by the timer
  bool gameOver = false;
  late TileManager tileManager;

  bool gameIsPaused = false;


  void startTimer() {
    _isCountToStartTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        if (gameIsPaused) {
          return;
        }
        setState(() {
          remainingSeconds--;
        });
      } else {
        setState(() {
          _showPoints = true;
          tileManager.viewModeAll(false);
        });
        timer.cancel();
      }
    });
  }

  void _resetGameState() {
    _isCountToStartTimer?.cancel();
    tries = 0;
    points = 0;
    remainingSeconds = 5;
    remainingTime = 120;
    gameOver = false;
    _showPoints = false;
    gameIsPaused = false;
    tileManager = TileManager(updateGameState: (int newPoints, int newTries) {
      setState(() {
        points = points + newPoints;
        tries = tries + newTries;
        gameOver |= (points == 8);
      });
    });
    tileManager.setMode(mode);
    tileManager.generatePairs(mode);
    tileManager.viewModeAll(true);
    startTimer();
  }

  @override
  void initState() {
    _selected = Selected.easy;
    mode = "easy";
    _isCountToStartTimer?.cancel();
    _resetGameState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }


  @override
  void dispose() {
    _isCountToStartTimer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void pauseGame(){
    setState(() {
      gameIsPaused = true;
    });
    tileManager.pauseGame();
  }
  void unPauseGame(){
    setState(() {
      gameIsPaused = false;
    });
    tileManager.unPauseGame();
  }

  @override
  Widget build(BuildContext context) {
    double alertDialogHeightCalculator = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        pauseGame();
        await buildExitDialog(context, alertDialogHeightCalculator, unPauseGame);
        return true;
      },
      child: LayoutBuilder(builder: (context, constraints) {
        var height = constraints.maxHeight;
        Widget currentWidget;
        if (!gameOver) {
          currentWidget = buildGameInProgress(height, context);
        } else {
          currentWidget = buildGameCompleteScreen();
        }

        return Scaffold(
          appBar: !gameOver
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    onPressed: () {
                      pauseGame();
                      buildExitDialog(context, height, unPauseGame);
                    },
                  ),
                )
              : null,
          body: AnimatedSwitcher(
              reverseDuration: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: currentWidget),
        );
      }),
    );
  }

  Widget buildRemTime(int remTime) {
    return Text(
      "You have $remTime seconds",
      style: GoogleFonts.quicksand(fontSize: 24, fontWeight: FontWeight.w700),
    );
  }


  GameCompleteScreen buildGameCompleteScreen() {
    return GameCompleteScreen(
      selected: _selected,
      tries: tries,
      remainingTime: remainingTime,
      points: points,
    );
  }

  Stack buildGameInProgress(double height, BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
             TimerFloatingActionButton(
              mode: mode,
              isPaused: gameIsPaused,
              isVisible: _selected!=Selected.easy && _showPoints,
              onTick : (finalTime) {
                remainingTime = finalTime;
                if(finalTime == 0) {
                  setState(() {
                    gameOver = true;
                  });
                }
              },
            )
        ),
        Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              height: height * 0.05,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  DifficultyBar(selected: _selected,height: height,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildChangeModeButton(Selected.easy, "Easy"),
                      _buildChangeModeButton(Selected.medium, "Medium"),
                      _buildChangeModeButton(Selected.hard, "Hard"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _showPoints ? "$points/8 " : "Memorize",
                            style: GoogleFonts.quicksand(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                          if (_showPoints) ...[
                            Text(
                              "Points",
                              style: GoogleFonts.quicksand(),
                            ),
                          ] else ...[
                            const Text(" "),
                          ],
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 0.0, maxCrossAxisExtent: 100),
                    children: List.generate(16, (index) {
                      return Tile(
                        tileManager: tileManager,
                        tileIndex : index,
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _showPoints
                            ? "$tries "
                            : "You have $remainingSeconds seconds",
                        style: GoogleFonts.quicksand(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      if (_showPoints) ...[
                        Text("Tries", style: GoogleFonts.quicksand()),
                      ] else ...[
                        const Text(" "),
                      ],
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }



  Widget _buildChangeModeButton(Selected level, String text) {
    double height = MediaQuery.of(context).size.height;
    bool isSelected = _selected == level;
    Color textColor = isSelected
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.tertiary;

    return Expanded(
      child: InkWell(
        splashColor: null,
        onTap: () {
          pauseGame();
          showDialog(
              context: context,
              builder: (context) {
                return OpenMaterialAlertDialog(
                  containerHeight: height,
                  title: "Change mode",
                  content: "You will lose track of the current mode.",
                  actions: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.pop(context);
                        unPauseGame();
                        if (_selected != level) {
                          setState(() {
                            _selected = level;
                            mode = level.toString().split(".").last;
                            tileManager.setMode(mode);
                            _resetGameState();
                            if (_selected != Selected.easy) {
                              setState(() {
                                remainingTime = 120;
                              });
                            }
                          });
                        }
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
                        unPauseGame();
                      },
                      child: const Text("Cancel"),
                    )
                  ],
                );
              });
        },
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}
