import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class CustomMaterialTheme {
  final TextTheme textTheme;

  const CustomMaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3a608f),
      surfaceTint: Color(0xff3a608f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd3e3ff),
      onPrimaryContainer: Color(0xff001c39),
      secondary: Color(0xff485d92),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdae2ff),
      onSecondaryContainer: Color(0xff001946),
      tertiary: Color(0xff006874),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9eeffd),
      onTertiaryContainer: Color(0xff001f24),
      error: Color(0xff904a49),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad8),
      onErrorContainer: Color(0xff3b080b),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff43474e),
      outline: Color(0xff73777f),
      outlineVariant: Color(0xffc3c6cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xffa4c9fe),
      primaryFixed: Color(0xffd3e3ff),
      onPrimaryFixed: Color(0xff001c39),
      primaryFixedDim: Color(0xffa4c9fe),
      onPrimaryFixedVariant: Color(0xff1f4876),
      secondaryFixed: Color(0xffdae2ff),
      onSecondaryFixed: Color(0xff001946),
      secondaryFixedDim: Color(0xffb1c5ff),
      onSecondaryFixedVariant: Color(0xff2f4578),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001f24),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff004f58),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1a4472),
      surfaceTint: Color(0xff3a608f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5276a7),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2b4174),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5e73a9),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff004a53),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff25808c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff6e2f2f),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffaa5f5e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3f434a),
      outline: Color(0xff5b5f67),
      outlineVariant: Color(0xff777b83),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xffa4c9fe),
      primaryFixed: Color(0xff5276a7),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff385d8d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5e73a9),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff455b8f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff25808c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff006671),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002344),
      surfaceTint: Color(0xff3a608f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1a4472),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff031f51),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2b4174),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00272c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff004a53),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff440f11),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff6e2f2f),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff20242b),
      outline: Color(0xff3f434a),
      outlineVariant: Color(0xff3f434a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xffe3ecff),
      primaryFixed: Color(0xff1a4472),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff002d56),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2b4174),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff112a5c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff004a53),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003238),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa4c9fe),
      surfaceTint: Color(0xffa4c9fe),
      onPrimary: Color(0xff00315c),
      primaryContainer: Color(0xff1f4876),
      onPrimaryContainer: Color(0xffd3e3ff),
      secondary: Color(0xffb1c5ff),
      onSecondary: Color(0xff162e60),
      secondaryContainer: Color(0xff2f4578),
      onSecondaryContainer: Color(0xffdae2ff),
      tertiary: Color(0xff82d3e0),
      onTertiary: Color(0xff00363d),
      tertiaryContainer: Color(0xff004f58),
      onTertiaryContainer: Color(0xff9eeffd),
      error: Color(0xffffb3b1),
      onError: Color(0xff571d1e),
      errorContainer: Color(0xff733333),
      onErrorContainer: Color(0xffffdad8),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffc3c6cf),
      outline: Color(0xff8d9199),
      outlineVariant: Color(0xff43474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff3a608f),
      primaryFixed: Color(0xffd3e3ff),
      onPrimaryFixed: Color(0xff001c39),
      primaryFixedDim: Color(0xffa4c9fe),
      onPrimaryFixedVariant: Color(0xff1f4876),
      secondaryFixed: Color(0xffdae2ff),
      onSecondaryFixed: Color(0xff001946),
      secondaryFixedDim: Color(0xffb1c5ff),
      onSecondaryFixedVariant: Color(0xff2f4578),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001f24),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff004f58),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffabcdff),
      surfaceTint: Color(0xffa4c9fe),
      onPrimary: Color(0xff001730),
      primaryContainer: Color(0xff6e93c5),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb7caff),
      onSecondary: Color(0xff00143b),
      secondaryContainer: Color(0xff7a90c8),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff86d7e5),
      onTertiary: Color(0xff001a1d),
      tertiaryContainer: Color(0xff499ca9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffb9b7),
      onError: Color(0xff340407),
      errorContainer: Color(0xffcb7a79),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xfff6fcfd),
      onSurfaceVariant: Color(0xffc7cbd4),
      outline: Color(0xff9fa3ab),
      outlineVariant: Color(0xff7f838b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff214977),
      primaryFixed: Color(0xffd3e3ff),
      onPrimaryFixed: Color(0xff001127),
      primaryFixedDim: Color(0xffa4c9fe),
      onPrimaryFixedVariant: Color(0xff063764),
      secondaryFixed: Color(0xffdae2ff),
      onSecondaryFixed: Color(0xff000f31),
      secondaryFixedDim: Color(0xffb1c5ff),
      onSecondaryFixedVariant: Color(0xff1d3466),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001417),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff003c44),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbfaff),
      surfaceTint: Color(0xffa4c9fe),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffabcdff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffcfaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb7caff),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff1fdff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff86d7e5),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffb9b7),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffbfaff),
      outline: Color(0xffc7cbd4),
      outlineVariant: Color(0xffc7cbd4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff002b52),
      primaryFixed: Color(0xffdbe8ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffabcdff),
      onPrimaryFixedVariant: Color(0xff001730),
      secondaryFixed: Color(0xffe0e6ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb7caff),
      onSecondaryFixedVariant: Color(0xff00143b),
      tertiaryFixed: Color(0xffaaf3ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff86d7e5),
      onTertiaryFixedVariant: Color(0xff001a1d),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  /// Salvar&#x2F;aprovado
  static const salvarAprovado = ExtendedColor(
    seed: Color(0xff6fb555),
    value: Color(0xff6fb555),
    light: ColorFamily(
      color: Color(0xff426834),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc3efad),
      onColorContainer: Color(0xff042100),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff426834),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc3efad),
      onColorContainer: Color(0xff042100),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff426834),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc3efad),
      onColorContainer: Color(0xff042100),
    ),
    dark: ColorFamily(
      color: Color(0xffa8d293),
      onColor: Color(0xff153809),
      colorContainer: Color(0xff2b4f1e),
      onColorContainer: Color(0xffc3efad),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffa8d293),
      onColor: Color(0xff153809),
      colorContainer: Color(0xff2b4f1e),
      onColorContainer: Color(0xffc3efad),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffa8d293),
      onColor: Color(0xff153809),
      colorContainer: Color(0xff2b4f1e),
      onColorContainer: Color(0xffc3efad),
    ),
  );

  /// botao add
  static const botaoAdd = ExtendedColor(
    seed: Color(0xff0299da),
    value: Color(0xff0299da),
    light: ColorFamily(
      color: Color(0xff256489),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc9e6ff),
      onColorContainer: Color(0xff001e2f),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff256489),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc9e6ff),
      onColorContainer: Color(0xff001e2f),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff256489),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc9e6ff),
      onColorContainer: Color(0xff001e2f),
    ),
    dark: ColorFamily(
      color: Color(0xff95cdf7),
      onColor: Color(0xff00344d),
      colorContainer: Color(0xff004c6e),
      onColorContainer: Color(0xffc9e6ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff95cdf7),
      onColor: Color(0xff00344d),
      colorContainer: Color(0xff004c6e),
      onColorContainer: Color(0xffc9e6ff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff95cdf7),
      onColor: Color(0xff00344d),
      colorContainer: Color(0xff004c6e),
      onColorContainer: Color(0xffc9e6ff),
    ),
  );

  /// Botao de voltar
  static const botaoDeVoltar = ExtendedColor(
    seed: Color(0xffededed),
    value: Color(0xffededed),
    light: ColorFamily(
      color: Color(0xff006874),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff9eeffd),
      onColorContainer: Color(0xff001f24),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff006874),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff9eeffd),
      onColorContainer: Color(0xff001f24),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff006874),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff9eeffd),
      onColorContainer: Color(0xff001f24),
    ),
    dark: ColorFamily(
      color: Color(0xff82d3e0),
      onColor: Color(0xff00363d),
      colorContainer: Color(0xff004f58),
      onColorContainer: Color(0xff9eeffd),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff82d3e0),
      onColor: Color(0xff00363d),
      colorContainer: Color(0xff004f58),
      onColorContainer: Color(0xff9eeffd),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff82d3e0),
      onColor: Color(0xff00363d),
      colorContainer: Color(0xff004f58),
      onColorContainer: Color(0xff9eeffd),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        salvarAprovado,
        botaoAdd,
        botaoDeVoltar,
      ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
