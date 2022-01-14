import 'package:get/get.dart';
import 'package:vipt/app/data/services/app_start_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    await AppStartService.instance.initFirebase();
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {}
}
