import 'package:get/get.dart';

class UserService extends GetxService {
  ///싱글톤처럼 쓰기위함
  static UserService get to => Get.find();

  ///데이터베이스에 있는 정보 가져와서 담을 리스트 선언
  RxString nickname = "".obs;

  void save(String nickname) {
    this.nickname = nickname.obs;
  }

  String take() {
    return nickname.value;
  }
}
