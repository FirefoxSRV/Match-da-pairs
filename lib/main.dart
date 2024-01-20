import 'package:flutter/material.dart';
import 'package:mem_game/Logic/shared_preferences.dart';
import 'package:mem_game/Screen/themes/dark_theme.dart';
import 'package:mem_game/Screen/themes/light_theme.dart';
import 'package:mem_game/constants.dart';
import 'Screen/first_screen/my_app.dart';
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
      home: const MyApp(),
      theme: lightTheme,
      darkTheme: darkTheme,
    ),
  );
}


