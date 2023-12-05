import 'package:enitproject/app/screen/Tab/children/map/controller/map_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MapHomeController>(MapHomeController());
  }
}
