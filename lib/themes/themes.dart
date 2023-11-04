// Themes

import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings/settings.dart';

class Themes {
  Color primaryColor = const Color(0xFFFC7A69);
  Color linkText = const Color(0xFF4B39EF);
  Color primaryBackground = const Color(0xFFF1F4F8);
  Color secondaryBackground = const Color(0xFFFFFFFF);
  Color primaryText = const Color(0xFF14181B);
  Color secondaryText = const Color(0xFF57636C);
  Color tabColor = const Color(0xFFfbcbc5);
  Color alternate = const Color(0xFFE0E3E7);
  Color darkPrimaryBackground = const Color(0xFF1D2428);
  Color darkSecondaryBackground = const Color(0xFF14181B);
  Color darkPrimaryText = const Color(0xFFFFFFFF);
  Color darkSecondaryText = const Color(0xFF95A1AC);
  Color darkTabColor = const Color(0xFF7a4a44);
  Color darkAlternate = const Color(0xFF262D34);
}

primary() {
  return Themes().primaryColor;
}

link() {
  return Themes().linkText;
}

alternate() {
  return (darkMode == false) ? Themes().alternate : Themes().darkAlternate;
}

pBackground() {
  return (darkMode == false) ? Themes().primaryBackground : Themes().darkPrimaryBackground;
}

sBackground() {
  return (darkMode == false) ? Themes().secondaryBackground : Themes().darkSecondaryBackground;
}

pText() {
  return (darkMode == false) ? Themes().primaryText : Themes().darkPrimaryText;
}

sText() {
  return (darkMode == false) ? Themes().secondaryText : Themes().darkSecondaryText;
}

tab() {
  return (darkMode == false) ? Themes().tabColor : Themes().darkTabColor;
}

pwText(double fontSize, var color) {
  return GoogleFonts.nunito(
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
    color: color,
  );
}

swText(double fontSize, var color) {
  return GoogleFonts.nunito(
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: color,
  );
}

saveThemeMode(bool mode) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("themeMode", mode);
  Restart.restartApp();
}
