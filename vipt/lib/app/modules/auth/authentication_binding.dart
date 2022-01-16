import 'package:get/get.dart';
import 'package:vipt/app/modules/auth/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
  }
}
