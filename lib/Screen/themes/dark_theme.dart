import 'package:flutter/material.dart';
import 'package:mem_game/constants.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  dialogBackgroundColor: const Color(0xff21232a),
  disabledColor: Colors.white70,
  indicatorColor: kDarkSwitchBackgroundDisableColor,
  hoverColor: kDarkSwitchBackgroundEnableColor,
  dividerColor: kDarkSwitchForegroundDisableColor,
  canvasColor: kDarkSwitchForegroundEnableColor,
  colorScheme: ColorScheme.dark(
    background: kScaffoldBackgroundColor,
    primary: kDarkModeButtonBackgroundGreen,
    secondary: kDarkModeButtonIconTextColorGreen,
    tertiary: kDarkBodyTextColor,
    outline: kButtonOutlineColor
  ),
);