import 'package:flutter/material.dart';
import 'package:mem_game/Logic/shared_preferences.dart';
import 'package:mem_game/Screen/themes/dark_theme.dart';
import 'package:mem_game/Screen/themes/light_theme.dart';
import 'Screen/game_end/final_screen.dart';
import 'Screen/landing_page/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screen/themes/theme_provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getStoredData();
  imageCache.clear();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(ThemeMode.system),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            home: const MyApp(),
            theme: lightTheme,
            darkTheme: darkTheme,
          );
        },
      ),
    ),
  );
}

