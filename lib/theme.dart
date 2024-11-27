import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class CustomMaterialTheme {
  final TextTheme textTheme;

  const CustomMaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282015887),
      surfaceTint: Color(4282015887),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292076543),
      onPrimaryContainer: Color(4278197305),
      secondary: Color(4282932626),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292535039),
      onSecondaryContainer: Color(4278196550),
      tertiary: Color(4278216820),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4288606205),
      onTertiaryContainer: Color(4278198052),
      error: Color(4287646281),
      onError: Color(4294967295),
      errorContainer: Color(4294957784),
      onErrorContainer: Color(4282058763),
      surface: Color(4294310651),
      onSurface: Color(4279704862),
      onSurfaceVariant: Color(4282599246),
      outline: Color(4285757311),
      outlineVariant: Color(4291020495),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020723),
      inversePrimary: Color(4288989694),
      primaryFixed: Color(4292076543),
      onPrimaryFixed: Color(4278197305),
      primaryFixedDim: Color(4288989694),
      onPrimaryFixedVariant: Color(4280240246),
      secondaryFixed: Color(4292535039),
      onSecondaryFixed: Color(4278196550),
      secondaryFixedDim: Color(4289840639),
      onSecondaryFixedVariant: Color(4281288056),
      tertiaryFixed: Color(4288606205),
      onTertiaryFixed: Color(4278198052),
      tertiaryFixedDim: Color(4286764000),
      onTertiaryFixedVariant: Color(4278210392),
      surfaceDim: Color(4292205532),
      surfaceBright: Color(4294310651),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916150),
      surfaceContainer: Color(4293521392),
      surfaceContainerHigh: Color(4293126634),
      surfaceContainerHighest: Color(4292797413),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4279911538),
      surfaceTint: Color(4282015887),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283594407),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281024884),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284380073),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278209107),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4280647820),
      onTertiaryContainer: Color(4294967295),
      error: Color(4285411119),
      onError: Color(4294967295),
      errorContainer: Color(4289355614),
      onErrorContainer: Color(4294967295),
      surface: Color(4294310651),
      onSurface: Color(4279704862),
      onSurfaceVariant: Color(4282336074),
      outline: Color(4284178279),
      outlineVariant: Color(4286020483),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020723),
      inversePrimary: Color(4288989694),
      primaryFixed: Color(4283594407),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281884045),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284380073),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282735503),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4280647820),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278216305),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205532),
      surfaceBright: Color(4294310651),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916150),
      surfaceContainer: Color(4293521392),
      surfaceContainerHigh: Color(4293126634),
      surfaceContainerHighest: Color(4292797413),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278199108),
      surfaceTint: Color(4282015887),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4279911538),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278394705),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281024884),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200108),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278209107),
      onTertiaryContainer: Color(4294967295),
      error: Color(4282650385),
      onError: Color(4294967295),
      errorContainer: Color(4285411119),
      onErrorContainer: Color(4294967295),
      surface: Color(4294310651),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280296491),
      outline: Color(4282336074),
      outlineVariant: Color(4282336074),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020723),
      inversePrimary: Color(4293127423),
      primaryFixed: Color(4279911538),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278201686),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281024884),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4279315036),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278209107),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278202936),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205532),
      surfaceBright: Color(4294310651),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916150),
      surfaceContainer: Color(4293521392),
      surfaceContainerHigh: Color(4293126634),
      surfaceContainerHighest: Color(4292797413),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288989694),
      surfaceTint: Color(4288989694),
      onPrimary: Color(4278202716),
      primaryContainer: Color(4280240246),
      onPrimaryContainer: Color(4292076543),
      secondary: Color(4289840639),
      onSecondary: Color(4279643744),
      secondaryContainer: Color(4281288056),
      onSecondaryContainer: Color(4292535039),
      tertiary: Color(4286764000),
      onTertiary: Color(4278203965),
      tertiaryContainer: Color(4278210392),
      onTertiaryContainer: Color(4288606205),
      error: Color(4294947761),
      onError: Color(4283899166),
      errorContainer: Color(4285739827),
      onErrorContainer: Color(4294957784),
      surface: Color(4279112725),
      onSurface: Color(4292797413),
      onSurfaceVariant: Color(4291020495),
      outline: Color(4287467929),
      outlineVariant: Color(4282599246),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inversePrimary: Color(4282015887),
      primaryFixed: Color(4292076543),
      onPrimaryFixed: Color(4278197305),
      primaryFixedDim: Color(4288989694),
      onPrimaryFixedVariant: Color(4280240246),
      secondaryFixed: Color(4292535039),
      onSecondaryFixed: Color(4278196550),
      secondaryFixedDim: Color(4289840639),
      onSecondaryFixedVariant: Color(4281288056),
      tertiaryFixed: Color(4288606205),
      onTertiaryFixed: Color(4278198052),
      tertiaryFixedDim: Color(4286764000),
      onTertiaryFixedVariant: Color(4278210392),
      surfaceDim: Color(4279112725),
      surfaceBright: Color(4281612859),
      surfaceContainerLowest: Color(4278783760),
      surfaceContainerLow: Color(4279704862),
      surfaceContainer: Color(4279968034),
      surfaceContainerHigh: Color(4280625964),
      surfaceContainerHighest: Color(4281349687),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289449471),
      surfaceTint: Color(4288989694),
      onPrimary: Color(4278196016),
      primaryContainer: Color(4285436869),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290235135),
      onSecondary: Color(4278195259),
      secondaryContainer: Color(4286222536),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4287027173),
      onTertiary: Color(4278196765),
      tertiaryContainer: Color(4283014313),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949303),
      onError: Color(4281598983),
      errorContainer: Color(4291525241),
      onErrorContainer: Color(4278190080),
      surface: Color(4279112725),
      onSurface: Color(4294376701),
      onSurfaceVariant: Color(4291283924),
      outline: Color(4288652203),
      outlineVariant: Color(4286546827),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inversePrimary: Color(4280371575),
      primaryFixed: Color(4292076543),
      onPrimaryFixed: Color(4278194471),
      primaryFixedDim: Color(4288989694),
      onPrimaryFixedVariant: Color(4278597476),
      secondaryFixed: Color(4292535039),
      onSecondaryFixed: Color(4278193969),
      secondaryFixedDim: Color(4289840639),
      onSecondaryFixedVariant: Color(4280104038),
      tertiaryFixed: Color(4288606205),
      onTertiaryFixed: Color(4278195223),
      tertiaryFixedDim: Color(4286764000),
      onTertiaryFixedVariant: Color(4278205508),
      surfaceDim: Color(4279112725),
      surfaceBright: Color(4281612859),
      surfaceContainerLowest: Color(4278783760),
      surfaceContainerLow: Color(4279704862),
      surfaceContainer: Color(4279968034),
      surfaceContainerHigh: Color(4280625964),
      surfaceContainerHighest: Color(4281349687),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294703871),
      surfaceTint: Color(4288989694),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289449471),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294769407),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290235135),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294049279),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4287027173),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949303),
      onErrorContainer: Color(4278190080),
      surface: Color(4279112725),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294703871),
      outline: Color(4291283924),
      outlineVariant: Color(4291283924),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inversePrimary: Color(4278201170),
      primaryFixed: Color(4292602111),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289449471),
      onPrimaryFixedVariant: Color(4278196016),
      secondaryFixed: Color(4292929279),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290235135),
      onSecondaryFixedVariant: Color(4278195259),
      tertiaryFixed: Color(4289393663),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4287027173),
      onTertiaryFixedVariant: Color(4278196765),
      surfaceDim: Color(4279112725),
      surfaceBright: Color(4281612859),
      surfaceContainerLowest: Color(4278783760),
      surfaceContainerLow: Color(4279704862),
      surfaceContainer: Color(4279968034),
      surfaceContainerHigh: Color(4280625964),
      surfaceContainerHighest: Color(4281349687),
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
    seed: Color(4285510997),
    value: Color(4285510997),
    light: ColorFamily(
      color: Color(4282542132),
      onColor: Color(4294967295),
      colorContainer: Color(4291030957),
      onColorContainer: Color(4278460672),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4282542132),
      onColor: Color(4294967295),
      colorContainer: Color(4291030957),
      onColorContainer: Color(4278460672),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4282542132),
      onColor: Color(4294967295),
      colorContainer: Color(4291030957),
      onColorContainer: Color(4278460672),
    ),
    dark: ColorFamily(
      color: Color(4289254035),
      onColor: Color(4279580681),
      colorContainer: Color(4281028382),
      onColorContainer: Color(4291030957),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4289254035),
      onColor: Color(4279580681),
      colorContainer: Color(4281028382),
      onColorContainer: Color(4291030957),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4289254035),
      onColor: Color(4279580681),
      colorContainer: Color(4281028382),
      onColorContainer: Color(4291030957),
    ),
  );

  /// botao add
  static const botaoAdd = ExtendedColor(
    seed: Color(4278360538),
    value: Color(4278360538),
    light: ColorFamily(
      color: Color(4280640649),
      onColor: Color(4294967295),
      colorContainer: Color(4291421951),
      onColorContainer: Color(4278197807),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4280640649),
      onColor: Color(4294967295),
      colorContainer: Color(4291421951),
      onColorContainer: Color(4278197807),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4280640649),
      onColor: Color(4294967295),
      colorContainer: Color(4291421951),
      onColorContainer: Color(4278197807),
    ),
    dark: ColorFamily(
      color: Color(4288007671),
      onColor: Color(4278203469),
      colorContainer: Color(4278209646),
      onColorContainer: Color(4291421951),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4288007671),
      onColor: Color(4278203469),
      colorContainer: Color(4278209646),
      onColorContainer: Color(4291421951),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4288007671),
      onColor: Color(4278203469),
      colorContainer: Color(4278209646),
      onColorContainer: Color(4291421951),
    ),
  );

  /// Botao de voltar
  static const botaoDeVoltar = ExtendedColor(
    seed: Color(4293783021),
    value: Color(4293783021),
    light: ColorFamily(
      color: Color(4278216820),
      onColor: Color(4294967295),
      colorContainer: Color(4288606205),
      onColorContainer: Color(4278198052),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4278216820),
      onColor: Color(4294967295),
      colorContainer: Color(4288606205),
      onColorContainer: Color(4278198052),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4278216820),
      onColor: Color(4294967295),
      colorContainer: Color(4288606205),
      onColorContainer: Color(4278198052),
    ),
    dark: ColorFamily(
      color: Color(4286764000),
      onColor: Color(4278203965),
      colorContainer: Color(4278210392),
      onColorContainer: Color(4288606205),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4286764000),
      onColor: Color(4278203965),
      colorContainer: Color(4278210392),
      onColorContainer: Color(4288606205),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4286764000),
      onColor: Color(4278203965),
      colorContainer: Color(4278210392),
      onColorContainer: Color(4288606205),
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
