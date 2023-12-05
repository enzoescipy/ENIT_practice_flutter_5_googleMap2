
import 'package:enitproject/app/screen/Tab/children/Preview/controller/preview_controller.dart';
import 'package:get/get.dart';

class PreviewBinding extends Bindings {

  @override
  void dependencies() {
    Get.put<PreviewController>(PreviewController());

  }
}