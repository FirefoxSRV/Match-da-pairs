import 'package:flutter/material.dart';

import '../../constants.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  dialogBackgroundColor: const Color(0xfff4e7e6),
  disabledColor: Colors.black54,
  indicatorColor: kLightSwitchBackgroundDisableColor,
  hoverColor: kLightSwitchBackgroundEnableColor,
  dividerColor: kLightSwitchForegroundDisableColor,
  canvasColor: kLightSwitchForegroundEnableColor,
  colorScheme: ColorScheme.light(
      surface: kLightScaffoldBackgroundColor,
      primary: kLightModeButtonBackgroundGreen,
      secondary: kLightModeButtonIconTextColorGreen,
      tertiary: kLightBodyTextColor,
      outline: kButtonOutlineColor
  ),
);