import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282867090),
      surfaceTint: Color(4282867090),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292469503),
      onPrimaryContainer: Color(4278196549),
      secondary: Color(4282015887),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292076543),
      onSecondaryContainer: Color(4278197305),
      tertiary: Color(4278216820),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4288606205),
      onTertiaryContainer: Color(4278198052),
      error: Color(4287580750),
      onError: Color(4294967295),
      errorContainer: Color(4294957786),
      onErrorContainer: Color(4282058767),
      surface: Color(4294310651),
      onSurface: Color(4279704862),
      onSurfaceVariant: Color(4282337354),
      outline: Color(4285495674),
      outlineVariant: Color(4290758858),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020723),
      inversePrimary: Color(4289775359),
      primaryFixed: Color(4292469503),
      onPrimaryFixed: Color(4278196549),
      primaryFixedDim: Color(4289775359),
      onPrimaryFixedVariant: Color(4281222520),
      secondaryFixed: Color(4292076543),
      onSecondaryFixed: Color(4278197305),
      secondaryFixedDim: Color(4288989694),
      onSecondaryFixedVariant: Color(4280240246),
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
      primary: Color(4280959348),
      surfaceTint: Color(4282867090),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4284314537),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279911538),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283594407),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278209107),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4280647820),
      onTertiaryContainer: Color(4294967295),
      error: Color(4285411123),
      onError: Color(4294967295),
      errorContainer: Color(4289355619),
      onErrorContainer: Color(4294967295),
      surface: Color(4294310651),
      onSurface: Color(4279704862),
      onSurfaceVariant: Color(4282074182),
      outline: Color(4283916642),
      outlineVariant: Color(4285758590),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020723),
      inversePrimary: Color(4289775359),
      primaryFixed: Color(4284314537),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282669967),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283594407),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281884045),
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
      primary: Color(4278263633),
      surfaceTint: Color(4282867090),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280959348),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278199108),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4279911538),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200108),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278209107),
      onTertiaryContainer: Color(4294967295),
      error: Color(4282650389),
      onError: Color(4294967295),
      errorContainer: Color(4285411123),
      onErrorContainer: Color(4294967295),
      surface: Color(4294310651),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280034599),
      outline: Color(4282074182),
      outlineVariant: Color(4282074182),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020723),
      inversePrimary: Color(4293389311),
      primaryFixed: Color(4280959348),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4279249756),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4279911538),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278201686),
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
      primary: Color(4289775359),
      surfaceTint: Color(4289775359),
      onPrimary: Color(4279578208),
      primaryContainer: Color(4281222520),
      onPrimaryContainer: Color(4292469503),
      secondary: Color(4288989694),
      onSecondary: Color(4278202716),
      secondaryContainer: Color(4280240246),
      onSecondaryContainer: Color(4292076543),
      tertiary: Color(4286764000),
      onTertiary: Color(4278203965),
      tertiaryContainer: Color(4278210392),
      onTertiaryContainer: Color(4288606205),
      error: Color(4294947765),
      onError: Color(4283833634),
      errorContainer: Color(4285739831),
      onErrorContainer: Color(4294957786),
      surface: Color(4279112725),
      onSurface: Color(4292797413),
      onSurfaceVariant: Color(4290758858),
      outline: Color(4287206036),
      outlineVariant: Color(4282337354),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inversePrimary: Color(4282867090),
      primaryFixed: Color(4292469503),
      onPrimaryFixed: Color(4278196549),
      primaryFixedDim: Color(4289775359),
      onPrimaryFixedVariant: Color(4281222520),
      secondaryFixed: Color(4292076543),
      onSecondaryFixed: Color(4278197305),
      secondaryFixedDim: Color(4288989694),
      onSecondaryFixedVariant: Color(4280240246),
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
      primary: Color(4290169599),
      surfaceTint: Color(4289775359),
      onPrimary: Color(4278195258),
      primaryContainer: Color(4286222536),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4289449471),
      onSecondary: Color(4278196016),
      secondaryContainer: Color(4285436869),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4287027173),
      onTertiary: Color(4278196765),
      tertiaryContainer: Color(4283014313),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949307),
      onError: Color(4281598730),
      errorContainer: Color(4291525246),
      onErrorContainer: Color(4278190080),
      surface: Color(4279112725),
      onSurface: Color(4294376701),
      onSurfaceVariant: Color(4291022030),
      outline: Color(4288390566),
      outlineVariant: Color(4286285191),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inversePrimary: Color(4281353849),
      primaryFixed: Color(4292469503),
      onPrimaryFixed: Color(4278193968),
      primaryFixedDim: Color(4289775359),
      onPrimaryFixedVariant: Color(4280038502),
      secondaryFixed: Color(4292076543),
      onSecondaryFixed: Color(4278194471),
      secondaryFixedDim: Color(4288989694),
      onSecondaryFixedVariant: Color(4278597476),
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
      primary: Color(4294769407),
      surfaceTint: Color(4289775359),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4290169599),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294703871),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4289449471),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294049279),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4287027173),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949307),
      onErrorContainer: Color(4278190080),
      surface: Color(4279112725),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294180094),
      outline: Color(4291022030),
      outlineVariant: Color(4291022030),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inversePrimary: Color(4278986841),
      primaryFixed: Color(4292863743),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4290169599),
      onPrimaryFixedVariant: Color(4278195258),
      secondaryFixed: Color(4292602111),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4289449471),
      onSecondaryFixedVariant: Color(4278196016),
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


  List<ExtendedColor> get extendedColors => [
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
