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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF0D6EFD), // Cor dos botões
          onPrimary: Color(0xFFFFFFFF), // texto na cor dos botões
          secondary: Color(0xFF182B43), // Azul escuro
          onSecondary: Color(0xFFFFFFFF), // texto no Azul escuro
          tertiary: Color(0xFFEDEDED), // Botão de voltar
          onTertiary: Color(0xFF898989), // texto no Botão de voltar
          error: Color(0xFFFD3F3F), // Botão de erro
          onError: Color(0xFFFFFFFF), // texto no Botão de erro
          surface: Color(0xFFE4E7EC), // Cor do fundo
          onSurface: Color(0xFF000000), // texto na cor do fundo
          surfaceContainer: Color(0xFFF8F8FA),
          surfaceContainerHighest:
              Color(0xFFFFFFFF), // Cor do fundo alternativo
          onSurfaceVariant:
              Color(0xFF182B43), // texto na cor do fundo alternativo
        ),
      ),
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
