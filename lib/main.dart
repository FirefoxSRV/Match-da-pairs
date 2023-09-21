import 'package:flutter/material.dart';
import 'package:mem_game/Logic/functions_objects.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screen/game_screen/game_screen.dart';
import 'package:animations/animations.dart';
import 'Screen/settings_screen/SettingScreen.dart';
import 'constants.dart';
void main() {
  runApp(
    MaterialApp(
      // home: const GameScreen(),
      home: MyApp(),
      theme: ThemeData(
        useMaterial3: true
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {

    late String greet;
    int dayHour = DateTime.now().hour;
    if (dayHour >= 0 && dayHour < 12) {
      greet = "Good Morning,";
    } else if (dayHour >= 12 && dayHour < 18) {
      greet = "Good Afternoon,";
    } else if (dayHour >= 18 && dayHour < 24) {
      greet = "Good Evening,";
    }

    return LayoutBuilder(
      builder: (context,constraints) {
        var containerWidth = constraints.maxWidth;
        var containerHeight = constraints.maxHeight;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: containerHeight*0.2,
            backgroundColor: scaffoldBackgroundColor,
            title: Padding(
              padding: EdgeInsets.only(top:containerHeight*0.01),
              child: Text(greet,style: GoogleFonts.quicksand(color: bodyTextColor
                  ,fontSize: 32,fontWeight: FontWeight.w300),),
            ),
          ),
          backgroundColor: scaffoldBackgroundColor,
          floatingActionButton: AnimatedScale(
            duration: const Duration(milliseconds: 950),
            scale: 1,
            child: OpenContainer(
              closedColor: darkModeButtonBackgroundGreen,
              middleColor: darkModeButtonBackgroundGreen,
              transitionType: ContainerTransitionType.fadeThrough,
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              openBuilder: (BuildContext context, VoidCallback closeContainer) {
                return SettingScreen();
              },
              closedBuilder: (BuildContext context, VoidCallback openContainer) {
                return FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () {
                    openContainer();
                  },
                  backgroundColor: darkModeButtonBackgroundGreen,
                  elevation: 10.0,
                  splashColor: Colors.grey,
                  child: Icon(
                    Icons.settings,
                    color: darkModeButtonIconTextColorGreen,
                    size: 25,
                  ),
                );
              },
              useRootNavigator: true,
            ),
          ),
          body: Center(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomRight: Radius.circular(20))
              ),
              color: darkModeButtonBackgroundGreen,
              onPressed: (){
                showDialog(context: context, builder: (context){
                    return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: buttonOutlineColor),
                        ),
                        title: Center(
                          child: Text(
                            "Alert",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(fontSize: 25),
                          ),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 300,
                            height: containerHeight * 0.1,
                            child: Text("Hii")
                          ),
                        ));
                });
              },
              child: Text("Alert",style: TextStyle(color: darkModeButtonIconTextColorGreen),),
            ),
          ),
        );
      }
    );
  }
}


