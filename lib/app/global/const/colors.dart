import 'package:flutter/material.dart';

class ColorsApp {
  ColorsApp._();
  static const primary3 = Color(0xFFE4575E);
  static const Color primary2 = Color(0xFFF9795F);
  static const Color primary = Color(0xFF03486F);
  static const Color red = Color(0xFFFF0000);
  static const Color red2 = Color(0xFFFF6868);
  static const Color blue = Color(0xFF5D5DF6);
  static const Color blue2 = Color(0xFF3F3FBD);
  static const Color purple = Color(0xFFDBBEFF);
  static const Color purple2 = Color(0xFFAC9DBF);
  static const Color grey = Color(0xFF8A92A6);
  static const Color green1 = Color(0xFF5EE75D);
  static const Color green2 = Color(0xFF159400);
  static const Color maroon = Color(0xFFAB1919);
  static const Color maroon2 = Color(0xFFAC1C58);
  static const Color maroon3 = Color(0xFFB12536);
  static const Color maroon4 = Color(0xFFC23470);
  static const Color maroon5 = Color(0xFFDC4863);
  static const Color maroon6 = Color(0xFFFF637F);
  static const Color maroon7 = Color(0xFFED5583);
  static const Color maroon8 = Color(0xFFE04B6F);
  static const Color maroon9 = Color(0xFFDC486C);
  static const Color black = Color(0xFF200909);
  static const Color brown = Color(0xFF431212);
  static const Color brown2 = Color(0xFF5C1919);
  static const Color brown3 = Color(0xFF6C1E1E);
  static const Color brown4 = Color(0xFF711F1F);
  static const Color yellow = Color(0xFFE4D657);
  static const Color yellow2 = Color(0xFFF9D75F);
  static const Color blue3 = Color(0xFF0286F7);
  static const Color blue4 = Color(0xFF3A57E8);
  static const Color backgroundColors = Color(0xFFF6F8FD);
  static const Color darkBlue = Color(0xFF223263);
  static const Color subtitle = Color(0xFF9098B1);
  static const LinearGradient merahGrad = LinearGradient(
      colors: [red, red2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static const LinearGradient gr = LinearGradient(
      colors: [blue, blue2],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static const LinearGradient grad = LinearGradient(
      colors: [primary3, primary2],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight);

  static const LinearGradient belumAdaResi = LinearGradient(
      colors: [green1, green2],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight);

  static const LinearGradient gg = LinearGradient(colors: [
    maroon,
    maroon2,
    maroon3,
    maroon4,
    maroon5,
    maroon6,
    maroon7,
    maroon8,
    maroon9
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static const RadialGradient rA = RadialGradient(
    colors: [
      black,
      brown,
      brown2,
      brown3,
      brown4,
    ],
  );
  static const LinearGradient belumLunas = LinearGradient(
      colors: [yellow, yellow2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static const LinearGradient pengirimProses = LinearGradient(
      colors: [blue3, blue4],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
