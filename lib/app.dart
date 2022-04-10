import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'blocs/theme.dart';
import 'pages/login.dart';
import 'pages/movies.dart';
import 'pages/signup.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBLOC, ThemeMode>(builder: (context, mode) {
      // ThemeMode'a göre status bardaki ikon renkleride değiştirilecek
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: mode == ThemeMode.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          theme: mode == ThemeMode.dark ? ThemeData.dark() : ThemeData.light(),
          darkTheme: ThemeData.dark(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            LocalJsonLocalization.delegate,
          ],
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            return supportedLocales.first;
          },
          supportedLocales: const [
            Locale('tr', 'TR'),
            Locale('en', 'US'),
          ],
          routes: {
            '/': (context) => const LoginPage(),
            '/signup': (context) => const SignupPage(),
            '/movies': (context) => const MoviesPage(),
          },
          initialRoute: '/',
        ),
      );
    });
  }
}
