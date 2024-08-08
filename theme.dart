import 'package:application/utils/constants/choicechip_theme.dart';
import 'package:application/utils/theme/custom_themes/textTheme.dart';
import 'package:flutter/material.dart';

import 'custom_themes/appbarTheme.dart';
import 'custom_themes/botton_sheet.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/inputdecoration.dart';
import 'custom_themes/outile_button_theme.dart';
import 'elevatedButtontheme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
      brightness: Brightness.light,
    primaryColor: Colors.pinkAccent,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButton,
      appBarTheme: TAppBarTheme.LightAppBarTheme,
      checkboxTheme:  TCheckboxTheme.lightCheckboxThemeData,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: TInputDecorationTheme.lightInputDecorationTheme,
    chipTheme: TChipTheme.lightChipTheme,

  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.pinkAccent,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButton,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme:  TCheckboxTheme.darkCheckboxThemeData,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TInputDecorationTheme.darkInputDecorationTheme,
    chipTheme: TChipTheme.DarkChipTheme,


  );

}