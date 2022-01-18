import 'package:get/get.dart';
import 'package:vipt/app/modules/setup_info/setup_info_controller.dart';

class SetupInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetupInfoController());
  }
}
