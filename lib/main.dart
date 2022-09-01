import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kabtv/pages/home.dart';
import 'package:kabtv/pages/splashScreen.dart';

import 'configs/size_config.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
main() {
  runApp( LayoutBuilder(   // Add LayoutBuilder
      builder: (context, constraints,) {
        return OrientationBuilder(   // Add OrientationBuilder
            builder: (context, orientation) {
              SizeConfi().init(constraints, orientation); // SizeConfig initialization

              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: '',
                  theme: ThemeData(
                    primaryColor: Colors.white,
                    accentColor: Colors.white,
                    fontFamily: 'Poppins Light',
                    pageTransitionsTheme: const PageTransitionsTheme(builders: {
                      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                    }),
                  ),
                  home:  ProviderScope(child: SplashScreen(),)
              );
            }
        );
      }
  ));
}




