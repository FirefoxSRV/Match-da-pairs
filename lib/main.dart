import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mem_game/Logic/shared_preferences.dart';
import 'package:mem_game/Screen/themes/dark_theme.dart';
import 'package:mem_game/Screen/themes/light_theme.dart';
import 'package:mem_game/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Logic/google_user_info.dart';
import 'Material_components/material_alert_dialog.dart';
import 'Screen/first_screen/my_app.dart';
import 'Screen/game_screen/game_screen.dart';
import 'package:animations/animations.dart';
import 'Screen/settings_screen/SettingScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getStoredData();
  runApp(
    MaterialApp(
      themeMode: theme,
      home: MyApp(),
      theme: lightTheme,
      darkTheme: darkTheme,
    ),
  );
}


