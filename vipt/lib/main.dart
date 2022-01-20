import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/theme/app_theme.dart';
import 'app/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // themeMode: ThemeService.theme,
      initialRoute: Routes.setupInfoIntro,
      // locale: LocalizationService.locale,
      // fallbackLocale: LocalizationService.fallbackLocale,
      // translations: LocalizationService(),
      // debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
