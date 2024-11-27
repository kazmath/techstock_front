import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:techstock_front/theme.dart';
import 'package:techstock_front/tools/utils.dart';

import 'pages/login.dart';
import 'tools/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Rubik", "Rubik");

    CustomMaterialTheme theme = CustomMaterialTheme(textTheme);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', ''),
      ],

      // theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      theme: theme.light(),
      // darkTheme: ThemeData(
      //   colorScheme: const ColorScheme(
      //     brightness: Brightness.dark,
      //     primary: Color(0xffb0c6ff),
      //     surfaceTint: Color(0xffb0c6ff),
      //     onPrimary: Color(0xff152e60),
      //     primaryContainer: Color(0xff2e4578),
      //     onPrimaryContainer: Color(0xffd9e2ff),
      //     secondary: Color(0xffa4c9fe),
      //     onSecondary: Color(0xff00315c),
      //     secondaryContainer: Color(0xff1f4876),
      //     onSecondaryContainer: Color(0xffd3e3ff),
      //     tertiary: Color(0xff82d3e0),
      //     onTertiary: Color(0xff00363d),
      //     tertiaryContainer: Color(0xff004f58),
      //     onTertiaryContainer: Color(0xff9eeffd),
      //     error: Color(0xffffb3b5),
      //     onError: Color(0xff561d22),
      //     errorContainer: Color(0xff733337),
      //     onErrorContainer: Color(0xffffdada),
      //     surface: Color(0xFFD6D6D6),
      //     onSurface: Color(0xffdee3e5),
      //     onSurfaceVariant: Color(0xffffffff),
      //     outline: Color(0xff899294),
      //     outlineVariant: Color(0xff3f484a),
      //     shadow: Color(0xff000000),
      //     scrim: Color(0xff000000),
      //     inverseSurface: Color(0xffdee3e5),
      //     inversePrimary: Color(0xff475d92),
      //     primaryFixed: Color(0xffd9e2ff),
      //     onPrimaryFixed: Color(0xff001945),
      //     primaryFixedDim: Color(0xffb0c6ff),
      //     onPrimaryFixedVariant: Color(0xff2e4578),
      //     secondaryFixed: Color(0xffd3e3ff),
      //     onSecondaryFixed: Color(0xff001c39),
      //     secondaryFixedDim: Color(0xffa4c9fe),
      //     onSecondaryFixedVariant: Color(0xff1f4876),
      //     tertiaryFixed: Color(0xff9eeffd),
      //     onTertiaryFixed: Color(0xff001f24),
      //     tertiaryFixedDim: Color(0xff82d3e0),
      //     onTertiaryFixedVariant: Color(0xff004f58),
      //     surfaceDim: Color(0xff0e1415),
      //     surfaceBright: Color(0xff343a3b),
      //     surfaceContainerLowest: Color(0xff090f10),
      //     surfaceContainerLow: Color(0xff171d1e),
      //     surfaceContainer: Color(0xff1b2122),
      //     surfaceContainerHigh: Color(0xff252b2c),
      //     surfaceContainerHighest: Color(0xff303637),
      //   ),
      //   useMaterial3: true,
      // ),
      themeMode: ThemeMode.light, // TODO: dark theme

      initialRoute: Constants.baseHref,
      onGenerateRoute: (settings) {
        final args = settings.arguments as Arguments<Map<String, dynamic>>?;

        for (var element in Constants.telas) {
          if (settings.name == element['route']) {
            return MaterialPageRoute(
              settings: settings,
              builder: (context) =>
                  element['builder'](args?.value) ?? const Placeholder(),
            );
          }
        }

        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      },
    );
  }
}
