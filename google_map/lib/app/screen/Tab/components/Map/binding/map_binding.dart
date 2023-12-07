import 'package:enitproject/app/screen/Tab/components/Map/controller/map_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MapHomeController>(MapHomeController());
  }
}
