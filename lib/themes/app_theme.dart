import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:my_campus/values/constants.dart';

class AppThemes {
  static ThemeData lightTheme() => ThemeData(
        brightness: Brightness.light,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: GoogleFonts.montserrat(
              fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2: GoogleFonts.montserrat(
              fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3:
              GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
          headline4: GoogleFonts.montserrat(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headline5:
              GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
          headline6: GoogleFonts.montserrat(
              fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle1: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          subtitle2: GoogleFonts.montserrat(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText1: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyText2: GoogleFonts.montserrat(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          button: GoogleFonts.montserrat(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          caption: GoogleFonts.montserrat(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          overline: GoogleFonts.montserrat(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ).apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(300, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kPrimaryLightColor,
          iconColor: kPrimaryColor,
          prefixIconColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultSpacing, vertical: defaultSpacing),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: kPrimaryColor),
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

  static ThemeData darkTheme() => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: navyblueshade2,
        primaryColor: kPrimaryColor,
        textTheme: TextTheme(
          headline1: GoogleFonts.montserrat(
              fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2: GoogleFonts.montserrat(
              fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3:
              GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
          headline4: GoogleFonts.montserrat(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headline5:
              GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
          headline6: GoogleFonts.montserrat(
              fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle1: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          subtitle2: GoogleFonts.montserrat(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText1: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyText2: GoogleFonts.montserrat(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          button: GoogleFonts.montserrat(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          caption: GoogleFonts.montserrat(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          overline: GoogleFonts.montserrat(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kPrimaryLightColor,
          iconColor: kPrimaryColor,
          prefixIconColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultSpacing, vertical: defaultSpacing),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1)),
            borderSide: BorderSide.none,
          ),
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
