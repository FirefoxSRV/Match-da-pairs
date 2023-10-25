import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mem_game/Screen/themes/dark_theme.dart';
import 'package:mem_game/Screen/themes/light_theme.dart';
import 'package:mem_game/segmentedScreen.dart';
import 'Material_components/material_alert_dialog.dart';
import 'Screen/game_screen/game_screen.dart';
import 'package:animations/animations.dart';
import 'Screen/settings_screen/SettingScreen.dart';


void main() {
  runApp(
    MaterialApp(
      // home: const SegmentedScreen(),
      home: MyApp(),
      theme: lightTheme,
      darkTheme: darkTheme,
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
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            // backgroundColor: kScaffoldBackgroundColor,
            title: Padding(
              padding: EdgeInsets.only(top:containerHeight*0.01),
              child: Text(greet,style: GoogleFonts.quicksand(color:Theme.of(context).colorScheme.tertiary
                  ,fontSize: 32,fontWeight: FontWeight.w300),),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButton: AnimatedScale(
            duration: const Duration(milliseconds: 950),
            scale: 1,
            child: OpenContainer(
              closedColor: Theme.of(context).colorScheme.primary,
              middleColor: Theme.of(context).colorScheme.primary,
              transitionType: ContainerTransitionType.fadeThrough,
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              openBuilder: (BuildContext context, VoidCallback closeContainer) {
                return const SettingScreen();
              },
              closedBuilder: (BuildContext context, VoidCallback openContainer) {
                return FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () {
                    openContainer();
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 10.0,
                  splashColor: Theme.of(context).colorScheme.outline,
                  child: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 25,
                  ),
                );
              },
              useRootNavigator: true,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Center(child: Image.asset("assets/images/bgGameScreen.png",color: Theme.of(context).colorScheme.tertiary,alignment: Alignment.centerLeft)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ParentMaterialAlertDialog(containerHeight: containerHeight,title: "About game",onPressed: (){
                      showDialog(context: context, builder: (context){
                        return OpenMaterialAlertDialog(containerHeight: containerHeight);
                      });
                    },),
                    ParentMaterialAlertDialog(containerHeight: containerHeight,title: "Play",onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const GameScreen();
                      }));
                    },)
                  ],
                ),

              ],
            ),
          ),
        );
      }
    );
  }
}
