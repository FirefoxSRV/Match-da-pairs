import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Logic/functions_objects.dart';
import '../../Material_components/material_alert_dialog.dart';
import '../final_screen/game_complete_screen.dart';
import 'game_screen_utils/tile.dart';
import 'game_screen_utils/timer_floating_action_button.dart';

void playCorrectSound() async {
  final player = AudioPlayer();
  const soundPath = "audio/success.mp3";
  await player.play(AssetSource(soundPath), volume: 0.5);
}

void playWrongSound() async {
  final player = AudioPlayer();
  const soundPath = "audio/wrong.mp3";
  await player.play(AssetSource(soundPath));
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  Timer? timeLeft;
  bool _isMounted = false;
  bool _showPoints = false;
  Selected _selected = Selected.easy;
  Timer? _switchModeTimer;
  bool _isSwitchingModes = false;
  int remainingSeconds = 5;
  bool _isCountToStart = false;
  Timer? _isCountToStartTimer;

  void startTimer() {
    _isCountToStartTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _resetGameState() {
    if (_isSwitchingModes) {
      _isCountToStartTimer?.cancel();
      _switchModeTimer?.cancel();
    }
    timeLeft?.cancel();
    tries = 0;
    _isSwitchingModes = true;
    loadSelect = true;
    itemDuos = getPairs();
    itemDuos.shuffle();
    hiddenDuos = itemDuos;
    selectedTileIndex = -1;
    selectedImagePath = "";
    points = 0;
    remainingSeconds = 5;
    _showPoints = false; // If already mounted , return without any operation
    startTimer();
    _switchModeTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _showPoints = true;
        hiddenDuos = getQuestions();
        loadSelect = false;
        _isSwitchingModes = false;
      });

      _isSwitchingModes = false;
    });
  }

  @override
  void initState() {
    _selected = Selected.easy;
    setMode('easy');
    _isCountToStartTimer?.cancel();
    _switchModeTimer?.cancel();
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
    resetRemainingTime();
    loadSelect = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    timeLeft?.cancel();
    _switchModeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double alertDialogHeightCalculator = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        await buildExitDialog(context, alertDialogHeightCalculator);
        return true;
      },
      child: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;
        Widget currentWidget;
        if (points != 8) {
          currentWidget = buildGameInProgress(height, context);
        } else {
          currentWidget = buildGameCompleteScreen();
        }

        return Scaffold(
          appBar: points != 8
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    onPressed: () {
                      buildExitDialog(context, height);
                    },
                  ),
                )
              : null,
          body: AnimatedSwitcher(
              reverseDuration: Duration(milliseconds: 300),
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: currentWidget),
        );
      }),
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
          floatingActionButton: StatefulBuilder(builder: (context, setState) {
            return TimerFloatingActionButton(
              selected: _selected,
              showPoints: _showPoints,
              remainingTime: remainingTime,
              onTick: (UpdatedRemainingTime) {
                setState(() {
                  remainingTime = UpdatedRemainingTime;
                });
              },
            );
          }),
        ),
        Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              height: height * 0.05,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: _selected == Selected.easy
                        ? 0
                        : _selected == Selected.medium
                            ? MediaQuery.of(context).size.width / 3
                            : 2 * MediaQuery.of(context).size.width / 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton(Selected.easy, "Easy"),
                      _buildButton(Selected.medium, "Medium"),
                      _buildButton(Selected.hard, "Hard"),
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
                    children: List.generate(hiddenDuos.length, (index) {
                      return Tile(
                        state: this,
                        pathToImage: hiddenDuos[index].getImagePath(),
                        tileIndex: index,
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

  Future<dynamic> buildExitDialog(BuildContext context, double height) {
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
                },
                child: Text("Cancel"),
              )
            ],
          );
        });
  }

  Widget _buildButton(Selected level, String text) {
    double height = MediaQuery.of(context).size.height;
    bool isSelected = _selected == level;
    Color textColor = isSelected
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.tertiary;

    return Expanded(
      child: InkWell(
        splashColor: null,
        onTap: () {
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
                        if (_selected != level) {
                          setState(() {
                            _selected = level;
                            setMode(level.toString().split(".").last);
                            _resetGameState();
                            if (_selected != Selected.easy) {
                              resetRemainingTime();
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
                      },
                      child: Text("Cancel"),
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
