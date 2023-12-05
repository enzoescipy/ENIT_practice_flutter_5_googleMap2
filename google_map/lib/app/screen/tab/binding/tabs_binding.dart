
import 'package:enitproject/app/screen/Tab/children/Map/controller/map_controller.dart';
import 'package:enitproject/app/screen/Tab/controller/tabs_controller.dart';
import 'package:get/get.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TabsController>(TabsController());
    Get.put<MapHomeController>(MapHomeController());
  }
}
