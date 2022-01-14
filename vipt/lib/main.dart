import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vipt/app/core/theme/app_theme.dart';
import 'package:vipt/app/modules/auth/screens/authentication_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'ViPT',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    // );

    return GetMaterialApp(
      // title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: HomePage(),
      // themeMode: ThemeService.theme,
      // initialRoute: Routes.splash,
      // locale: LocalizationService.locale,
      // fallbackLocale: LocalizationService.fallbackLocale,
      // translations: LocalizationService(),
      // debugShowCheckedModeBanner: false,
      // getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthenticationScreen();
  }
}
