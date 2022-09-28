import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppThemes {
  static ThemeData lightTheme() => ThemeData(
        brightness: Brightness.light,
        fontFamily: GoogleFonts.quicksand().fontFamily,
        // TO BE DONE LIGHT THEME
      );

  static ThemeData darkTheme() => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: navyblueshade2,
        fontFamily: GoogleFonts.quicksand().fontFamily,
        iconTheme: const IconThemeData(color: Colors.white),
        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   secondary: navyblueshade3,
        // ),
        appBarTheme: AppBarTheme(
          backgroundColor: navyblueshade2,
          iconTheme: const IconThemeData(color: Colors.white),
          actionsIconTheme: const IconThemeData(color: Colors.white),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: navyblueshade4,
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: kIsWeb
              ? {
                  // No animations for web app
                  for (final platform in TargetPlatform.values)
                    platform: const NoTransitionsBuilder(),
                }
              : const {
                  // No animations for android and ios app
                  TargetPlatform.android: NoTransitionsBuilder(),
                  TargetPlatform.iOS: NoTransitionsBuilder(),
                },
        ),
      );

  //  Color Codes for Dark Theme
  static Color navyblueshade1 = HexColor('#1C223A');
  static Color navyblueshade2 = HexColor('#1E233E');
  static Color navyblueshade3 = HexColor('#161A2C');
  static Color navyblueshade4 = HexColor('#20263F');
  static Color whiteShade1 = HexColor('#C7D8EB');
  static Color lightBlueShade = HexColor('#87A5B9');
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}
