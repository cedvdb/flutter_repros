import 'package:flutter/material.dart';

abstract class Themes {
  static const seedColor = Colors.orange;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: seedColor,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: seedColor,
  );

  static final lightThemeM3 = ThemeData(
    brightness: Brightness.light,
    primarySwatch: seedColor,
    useMaterial3: true,
  );

  static final darkThemeM3 = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: seedColor,
    useMaterial3: true,
  );
  static final lightThemeFromSwatch = ThemeData.from(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: seedColor,
      brightness: Brightness.light,
    ),
  );

  static final darkThemeFromSwatch = ThemeData.from(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: seedColor,
      brightness: Brightness.dark,
    ),
  );

  static final lightThemeFromSwatchM3 = ThemeData.from(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: seedColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  static final darkThemeFromSwatchM3 = ThemeData.from(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );

  static final lightThemeSeeded = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
  );

  static final darkThemeSeeded = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
  );

  static final lightThemeSeededM3 = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  static final darkThemeSeededM3 = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
