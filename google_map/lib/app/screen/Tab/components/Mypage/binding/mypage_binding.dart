import 'package:enitproject/app/screen/Tab/components/Mypage/controller/mypage_controller.dart';
import 'package:get/get.dart';

class MypageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MypageController>(MypageController());
  }
}
