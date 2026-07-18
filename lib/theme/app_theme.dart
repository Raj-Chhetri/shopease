import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF6D28FF);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primary.withValues(alpha: 0.14),
      onPrimaryContainer: primary,
      secondary: primary,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: const Color(0xFF17131F),
      surfaceContainerHighest: const Color(0xFFF3EFF8),
      onSurfaceVariant: const Color(0xFF625B6D),
      outlineVariant: const Color(0xFFD9D2E2),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFFCFBFF),
      canvasColor: const Color(0xFFFCFBFF),
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFCFBFF),
        foregroundColor: Color(0xFF17131F),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFFD9D2E2)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFE0DAE8),
          disabledForegroundColor: const Color(0xFF8A8393),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme(
        fillColor: const Color(0xFFF7F3FF),
        textColor: const Color(0xFF17131F),
        hintColor: const Color(0xFF716A7C),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return Colors.transparent;
        }),
        checkColor: const WidgetStatePropertyAll(Colors.white),
        side: const BorderSide(color: Color(0xFF716A7C), width: 1.5),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: primary.withValues(alpha: 0.14),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? primary
                : const Color(0xFF716A7C),
          );
        }),
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    ).copyWith(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primary.withValues(alpha: 0.24),
      onPrimaryContainer: Colors.white,
      secondary: primary,
      onSecondary: Colors.white,
      surface: const Color(0xFF211D29),
      onSurface: const Color(0xFFF7F2FF),
      surfaceContainerHighest: const Color(0xFF332E3B),
      onSurfaceVariant: const Color(0xFFD6CEDF),
      outlineVariant: const Color(0xFF4B4456),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFF15121B),
      canvasColor: const Color(0xFF15121B),
      cardColor: const Color(0xFF211D29),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF15121B),
        foregroundColor: Color(0xFFF7F2FF),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF211D29),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFF4B4456)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFF45404D),
          disabledForegroundColor: const Color(0xFF9D96A6),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme(
        fillColor: const Color(0xFF211D29),
        textColor: const Color(0xFFF7F2FF),
        hintColor: const Color(0xFFB8B0C2),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return Colors.transparent;
        }),
        checkColor: const WidgetStatePropertyAll(Colors.white),
        side: const BorderSide(color: Color(0xFFD6CEDF), width: 1.5),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF211D29),
        indicatorColor: primary.withValues(alpha: 0.24),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? Colors.white
                : const Color(0xFFD6CEDF),
          );
        }),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme({
    required Color fillColor,
    required Color textColor,
    required Color hintColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hintStyle: TextStyle(color: hintColor),
      labelStyle: TextStyle(color: hintColor),
      prefixIconColor: primary,
      suffixIconColor: hintColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: primary.withValues(alpha: 0.75)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: primary.withValues(alpha: 0.65)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: primary, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.red, width: 1.8),
      ),
    );
  }
}
