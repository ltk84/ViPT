import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:vipt/app/modules/auth/authentication_binding.dart';
import 'package:vipt/app/modules/auth/screens/authentication_screen.dart';
import 'package:vipt/app/modules/error/screens/error_screen.dart';
import 'package:vipt/app/modules/home/home_binding.dart';
import 'package:vipt/app/modules/home/screens/home_screen.dart';
import 'package:vipt/app/modules/setup_info/screens/setup_info_intro_screen.dart';
import 'package:vipt/app/modules/setup_info/screens/setup_info_question_screen.dart';
import 'package:vipt/app/modules/setup_info/setup_info_binding.dart';
import 'package:vipt/app/modules/splash/screens/splash_screen.dart';
import 'package:vipt/app/modules/splash/splash_binding.dart';

part 'routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: Routes.splash,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.auth,
      page: () => AuthenticationScreen(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
        name: Routes.home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: Routes.error, page: () => const ErrorScreen()),
    GetPage(
      name: Routes.setupInfoIntro,
      page: () => SetupInfoIntroScreen(),
      binding: SetupInfoBinding(),
    ),
    GetPage(
      name: Routes.setupInfoQuestion,
      page: () => SetupInfoQuestionScreen(),
      binding: SetupInfoBinding(),
    )
  ];
}
