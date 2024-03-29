import 'package:flutter/material.dart';


class AppColors {


  static const Color green1 = const Color(0xFFC5F6C1);
  static const Color green2 = const Color(0xFF80FF81);
  static const Color secondary = const Color(0xFFFFFFFF);
  static const Color third = const Color(0xFF000000);
  static const Color background = const Color(0xFFEEEEEE);

  Color color = Colors.pink;

}

const lightColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: const Color(0xFF006689),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFC3E8FF),
  onPrimaryContainer: Color(0xFF001E2C),
  secondary: Color(0xFF4E616D),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD1E5F3),
  onSecondaryContainer: Color(0xFF091E28),
  tertiary: Color(0xFF605A7D),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFE6DEFF),
  onTertiaryContainer: Color(0xFF1C1736),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFBFCFE),
  onBackground: Color(0xFF191C1E),
  surface: Color(0xFFFBFCFE),
  onSurface: Color(0xFF191C1E),
  surfaceVariant: Color(0xFFDCE3E9),
  onSurfaceVariant: Color(0xFF41484D),
  outline: Color(0xFF71787D),
  onInverseSurface: Color(0xFFF0F1F3),
  inverseSurface: Color(0xFF2E3133),
  inversePrimary: Color(0xFF78D1FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006689),
  outlineVariant: Color(0xFFC0C7CD),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF78D1FF),
  onPrimary: Color(0xFF003549),
  primaryContainer: Color(0xFF004C68),
  onPrimaryContainer: Color(0xFFC3E8FF),
  secondary: Color(0xFFB5C9D7),
  onSecondary: Color(0xFF20333D),
  secondaryContainer: Color(0xFF364955),
  onSecondaryContainer: Color(0xFFD1E5F3),
  tertiary: Color(0xFFC9C1EA),
  onTertiary: Color(0xFF312C4C),
  tertiaryContainer: Color(0xFF484264),
  onTertiaryContainer: Color(0xFFE6DEFF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF191C1E),
  onBackground: Color(0xFFE1E2E5),
  surface: Color(0xFF191C1E),
  onSurface: Color(0xFFE1E2E5),
  surfaceVariant: Color(0xFF41484D),
  onSurfaceVariant: Color(0xFFC0C7CD),
  outline: Color(0xFF8A9297),
  onInverseSurface: Color(0xFF191C1E),
  inverseSurface: Color(0xFFE1E2E5),
  inversePrimary: Color(0xFF006689),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF78D1FF),
  outlineVariant: Color(0xFF41484D),
  scrim: Color(0xFF000000),
);