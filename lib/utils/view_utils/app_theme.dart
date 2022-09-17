import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'dimens.dart';


class AppThemes {
  // final lightTheme = ThemeData(
  //   primaryColor: white,
  //   primaryColorDark: textColor,
  //   accentColor: kAccentColorOrange,
  //   textTheme: lightTextTheme,
  //   hintColor: black_5,
  //   disabledColor: grey,
  // );
  //
  // final darkTheme = ThemeData(
  //   primaryColor: black,
  //   primaryColorDark: white,
  //   accentColor: red,
  //   cardColor: black,
  //   canvasColor: black,
  //   hintColor: light_grey_white,
  //   textTheme: darkTextTheme,
  //   disabledColor: light_grey,
  //   shadowColor: light_grey_white,
  // );

  ThemeData getLightTheme() {
    ThemeData theme = ThemeData();
    theme = ThemeData().copyWith(
        primaryColor: primary,
        primaryColorDark: primaryDark,
        colorScheme: theme.colorScheme.copyWith(secondary: accent),
        textTheme: lightTextTheme
    );
    return theme;
  }

  ThemeData getDarkTheme() {
    ThemeData theme = ThemeData();
    theme = ThemeData().copyWith(
        primaryColor: primary,
        primaryColorDark: primaryDark,
        primaryColorLight: primaryLight,
        //backgroundColor: textFieldColor,
        colorScheme: theme.colorScheme.copyWith(secondary: accent),
        textTheme: darkTextTheme
    );
    return theme;
  }


  static final lightTextTheme = TextTheme(
    headline1: GoogleFonts.roboto(
        color: primary,
        fontSize: dp22,
        fontWeight: FontWeight.normal), //login register large heading
    headline2: GoogleFonts.roboto(
        color: primary,
        fontSize: dp20,
        fontWeight: FontWeight.normal), // large text
    headline3: GoogleFonts.roboto(
        color: primary,
        fontSize: dp16,
        fontWeight: FontWeight.normal), //mid text bold
    headline4: GoogleFonts.roboto(
        color: primary,
        fontSize: dp18,
        fontWeight: FontWeight.normal), //text field
    headline5: GoogleFonts.roboto(
        color: primary,
        fontSize: dp18,
        fontWeight: FontWeight.normal), //drawer text
    headline6: GoogleFonts.roboto(
        color: primary,
        fontSize: dp18,
        fontWeight: FontWeight.w600), //appBar title
    subtitle1: GoogleFonts.roboto(
        color: primary.withOpacity(0.60), fontSize: dp16, fontWeight: FontWeight.normal),
    subtitle2: GoogleFonts.roboto(
        color: primary.withOpacity(0.60), fontSize: dp14, fontWeight: FontWeight.bold),
    bodyText1: GoogleFonts.roboto(
        color: primary, fontSize: dp14, fontWeight: FontWeight.normal),
    bodyText2: GoogleFonts.roboto(
        color: primary, fontSize: dp14, fontWeight: FontWeight.bold),
    button: GoogleFonts.roboto(
        color: primary, fontSize: dp20, fontWeight: FontWeight.bold),
  );

  static final darkTextTheme = TextTheme(
    headline1: GoogleFonts.roboto(
        color: black, fontSize: dp30, fontWeight: FontWeight.bold),
    headline2: GoogleFonts.roboto(
        color: white, fontSize: dp20, fontWeight: FontWeight.bold),
    headline3: GoogleFonts.roboto(
        color: white, fontSize: dp24, fontWeight: FontWeight.bold),
    headline4: GoogleFonts.roboto(
        color: black, fontSize: dp16, fontWeight: FontWeight.bold),
    headline5: GoogleFonts.roboto(
        color: black, fontSize: dp16, fontWeight: FontWeight.normal),
    headline6: GoogleFonts.roboto(color: black, fontSize: dp20),
    subtitle1: GoogleFonts.roboto(
      color: black,
      fontSize: dp14,
    ),
    subtitle2: GoogleFonts.roboto(color: grey, fontSize: dp14),
    bodyText1: GoogleFonts.roboto(
      color: black_5,
      fontSize: dp16,
    ),
    bodyText2: GoogleFonts.roboto(
        color: kAccentColorOrange, fontSize: dp16, fontWeight: FontWeight.bold),
    button: GoogleFonts.roboto(
        color: white, fontSize: dp20, fontWeight: FontWeight.bold),
  );

}

class TextThemes {

}
