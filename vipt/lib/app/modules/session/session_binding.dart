import 'package:get/get.dart';
import 'package:vipt/app/modules/session/session_controller.dart';

class SessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SessionController());
  }
}
