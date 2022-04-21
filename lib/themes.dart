import 'package:flutter/material.dart';

abstract class Themes {
  static const seedColor = Colors.orange;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: seedColor,
  ).copyWith(cardColor: Colors.green.shade200);

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: seedColor,
  ).copyWith(cardColor: Colors.green.shade200);

  static final lightThemeM3 = ThemeData(
    brightness: Brightness.light,
    primarySwatch: seedColor,
    useMaterial3: true,
  ).copyWith(cardColor: Colors.green.shade200);

  static final darkThemeM3 = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: seedColor,
    useMaterial3: true,
  ).copyWith(cardColor: Colors.green.shade200);

  static final lightThemeFromSwatch = ThemeData.from(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: seedColor,
      brightness: Brightness.light,
    ),
  ).copyWith(cardColor: Colors.green.shade200);

  static final darkThemeFromSwatch = ThemeData.from(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: seedColor,
      brightness: Brightness.dark,
    ),
  ).copyWith(cardColor: Colors.green.shade200);

  static final lightThemeFromSwatchM3 = ThemeData.from(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: seedColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  ).copyWith(cardColor: Colors.green.shade200);

  static final darkThemeFromSwatchM3 = ThemeData.from(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  ).copyWith(cardColor: Colors.green.shade200);

  static final lightThemeSeeded = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
  ).copyWith(cardColor: Colors.green.shade200);

  static final darkThemeSeeded = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
  ).copyWith(cardColor: Colors.green.shade200);

  static final lightThemeSeededM3 = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  ).copyWith(cardColor: Colors.green.shade200);

  static final darkThemeSeededM3 = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  ).copyWith(cardColor: Colors.green.shade200);
}
