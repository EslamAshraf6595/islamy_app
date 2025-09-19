import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/model/audio_provider.dart';
import 'package:islamy_app/model/most_recent_provider.dart';
import 'package:islamy_app/model/tasbeeh_provider.dart';
import 'package:islamy_app/ui/home/home_screen.dart';
import 'package:islamy_app/ui/quran/sura_content.dart';
import 'package:islamy_app/ui/welcome_screen/onboarding_Screens.dart';

import 'package:islamy_app/utils/app_routes.dart';
import 'package:islamy_app/utils/appthems.dart';
import 'package:provider/provider.dart';

void main() {
   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
   FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MostRecentProvider()),
        ChangeNotifierProvider(create: (context) => TasbeehProvider()),
         ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThems.apptheme,
            initialRoute: AppRoutes.onboardingScreens,
            onGenerateRoute: (settings) {
              if (settings.name == AppRoutes.homeRoute) {
                return MaterialPageRoute(builder: (_) => HomeScreen());
              }

              if (settings.name == AppRoutes.sura_content) {
                final index = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => SuraContent(index: index),
                );
              }
              if (settings.name == AppRoutes.onboardingScreens) {
                final index = settings.arguments as int? ??0;
                return MaterialPageRoute(
                  builder: (_) => OnboardingScreens(index: index),
                );
              }

              return null;
            },
          );
        },
      ),
    );
  }
}
