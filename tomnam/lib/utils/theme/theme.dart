import 'package:flutter/material.dart';
import 'package:tomnam/utils/theme/text_theme.dart';
import 'appbar_theme.dart';
import 'bottom_sheet_theme.dart';
import 'checkbox_theme.dart';
import 'chip_theme.dart';
import 'elevated_button_theme.dart';
import 'outlined_button_theme.dart';
import 'text_field_theme.dart';

class TApptheme {
  TApptheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Manrope',
      brightness: Brightness.light,
      primaryColor: Colors.teal.shade900, // put colors on constants
      scaffoldBackgroundColor: Colors.white, //scaffold is different screes
      textTheme: TTextTheme.lightTextTheme,
      chipTheme: TChipTheme.lightChipTheme,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      checkboxTheme: TCheckBoxTheme.lightCheckBoxTheme,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutLinedButtonTheme,
      inputDecorationTheme:
          TTextFormFieldTheme.lightInputDecorationTheme); // text field theme

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Manrope',
    brightness: Brightness.light,
    primaryColor: Colors.teal.shade900, // put colors on constants
    scaffoldBackgroundColor: Colors.black, //scaffold is different screes
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutLinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darklightInputDecorationTheme,
  );
}
