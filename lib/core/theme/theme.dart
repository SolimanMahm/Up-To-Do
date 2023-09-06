import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

ThemeData getAppTheme() {
  return ThemeData(
      // backgroundColor
      scaffoldBackgroundColor: AppColors.primary,
      // text
      textTheme: TextTheme(
        displayLarge: GoogleFonts.lato(
          fontSize: 32,
          color: AppColors.text.withOpacity(.87),
          fontWeight: FontWeight.w700,
        ),
        displayMedium: GoogleFonts.lato(
          fontSize: 16,
          color: AppColors.text.withOpacity(.87),
          fontWeight: FontWeight.w400,
        ),
        displaySmall: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.text,
        ),
      ),
      // button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.rectangleButton,
          fixedSize: Size(10, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      // textFormField
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        hintStyle: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.text,
        ),
        fillColor: AppColors.textField,
        filled: true,
      ));
}
