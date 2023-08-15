import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// base light theme
final baseLight = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueAccent.shade200,
    outline: Colors.grey.shade100,
    outlineVariant: Colors.grey.shade200,
  ),
  textTheme: GoogleFonts.quicksandTextTheme(ThemeData.light().textTheme),
  useMaterial3: true,
);

/// Light theme customization
final lightTheme = baseLight.copyWith(
  dividerColor: baseLight.colorScheme.outlineVariant,
  dividerTheme: DividerThemeData(
    space: 16,
    color: baseLight.colorScheme.outlineVariant,
    thickness: 1,
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: baseLight.textTheme.headlineMedium,
    subtitleTextStyle: baseLight.textTheme.bodySmall,
  ),
  cardTheme: CardTheme(
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: baseLight.colorScheme.outlineVariant,
      ),
    ),
  ),
);

/// Base dark theme
final baseDark = ThemeData.from(
  colorScheme: ColorScheme.dark(
    outline: Colors.grey.shade800,
    outlineVariant: Colors.grey.shade900,
  ),
  textTheme: GoogleFonts.quicksandTextTheme(ThemeData.dark().textTheme),
  useMaterial3: true,
);

/// Dark theme customization
final darkTheme = baseDark.copyWith(
  dividerColor: baseDark.colorScheme.outlineVariant,
  dividerTheme: baseDark.dividerTheme.copyWith(
    space: 16,
    color: baseDark.colorScheme.outlineVariant,
    thickness: 1,
  ),
  listTileTheme: baseDark.listTileTheme.copyWith(
    titleTextStyle: baseDark.textTheme.headlineMedium,
    subtitleTextStyle: baseDark.textTheme.bodySmall,
  ),
  cardTheme: CardTheme(
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: baseDark.colorScheme.outlineVariant,
      ),
    ),
  ),
);
