import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/login.dart';
import 'tools/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.getTextTheme('Rubik'),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff475d92),
          surfaceTint: Color(0xff475d92),
          onPrimary: Color(0xffffffff),
          primaryContainer: Color(0xffd9e2ff),
          onPrimaryContainer: Color(0xff001945),
          secondary: Color(0xff3a608f),
          onSecondary: Color(0xffffffff),
          secondaryContainer: Color(0xffd3e3ff),
          onSecondaryContainer: Color(0xff001c39),
          tertiary: Color(0xff006874),
          onTertiary: Color(0xffffffff),
          tertiaryContainer: Color(0xff9eeffd),
          onTertiaryContainer: Color(0xff001f24),
          error: Color(0xff8f4a4e),
          onError: Color(0xffffffff),
          errorContainer: Color(0xffffdada),
          onErrorContainer: Color(0xff3b080f),
          surface: Color(0xfff5fafb),
          onSurface: Color(0xff171d1e),
          onSurfaceVariant: Color(0xff3f484a),
          outline: Color(0xff6f797a),
          outlineVariant: Color(0xffbfc8ca),
          shadow: Color(0xff000000),
          scrim: Color(0xff000000),
          inverseSurface: Color(0xff2b3133),
          inversePrimary: Color(0xffb0c6ff),
          primaryFixed: Color(0xffd9e2ff),
          onPrimaryFixed: Color(0xff001945),
          primaryFixedDim: Color(0xffb0c6ff),
          onPrimaryFixedVariant: Color(0xff2e4578),
          secondaryFixed: Color(0xffd3e3ff),
          onSecondaryFixed: Color(0xff001c39),
          secondaryFixedDim: Color(0xffa4c9fe),
          onSecondaryFixedVariant: Color(0xff1f4876),
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
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xffb0c6ff),
          surfaceTint: Color(0xffb0c6ff),
          onPrimary: Color(0xff152e60),
          primaryContainer: Color(0xff2e4578),
          onPrimaryContainer: Color(0xffd9e2ff),
          secondary: Color(0xffa4c9fe),
          onSecondary: Color(0xff00315c),
          secondaryContainer: Color(0xff1f4876),
          onSecondaryContainer: Color(0xffd3e3ff),
          tertiary: Color(0xff82d3e0),
          onTertiary: Color(0xff00363d),
          tertiaryContainer: Color(0xff004f58),
          onTertiaryContainer: Color(0xff9eeffd),
          error: Color(0xffffb3b5),
          onError: Color(0xff561d22),
          errorContainer: Color(0xff733337),
          onErrorContainer: Color(0xffffdada),
          surface: Color(0xFFD6D6D6),
          onSurface: Color(0xffdee3e5),
          onSurfaceVariant: Color(0xffffffff),
          outline: Color(0xff899294),
          outlineVariant: Color(0xff3f484a),
          shadow: Color(0xff000000),
          scrim: Color(0xff000000),
          inverseSurface: Color(0xffdee3e5),
          inversePrimary: Color(0xff475d92),
          primaryFixed: Color(0xffd9e2ff),
          onPrimaryFixed: Color(0xff001945),
          primaryFixedDim: Color(0xffb0c6ff),
          onPrimaryFixedVariant: Color(0xff2e4578),
          secondaryFixed: Color(0xffd3e3ff),
          onSecondaryFixed: Color(0xff001c39),
          secondaryFixedDim: Color(0xffa4c9fe),
          onSecondaryFixedVariant: Color(0xff1f4876),
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
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light, // TODO: dark theme

      initialRoute: Constants.baseHref,
      onGenerateRoute: (settings) {
        for (var element in Constants.telas) {
          if (settings.name == element['route']) {
            return MaterialPageRoute(
              builder: (context) => element['widget'] ?? const Placeholder(),
            );
          }
        }

        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      },
    ),
  );
}
