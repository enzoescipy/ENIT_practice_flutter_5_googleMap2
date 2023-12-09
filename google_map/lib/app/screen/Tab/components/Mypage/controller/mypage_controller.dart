import 'package:enitproject/model/user_preference_model.dart';
import 'package:enitproject/package/debug_console.dart';
import 'package:enitproject/repository/storylist_network_repository.dart';
import 'package:enitproject/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:enitproject/service/auth_service.dart';
import 'package:enitproject/app/routes/app_pages.dart';

class MypageController extends GetxController {
  static MypageController get to => Get.find();

  final idTextControl = TextEditingController();
  final nicknameControl = TextEditingController();
  RxString nickname = "".obs;

  @override
  void onInit() async {
    var userPreference = await storyListNetworkRepository.getUserPreference();
    if (userPreference == null) {
      userPreference = UserPrefModel("유저 정보를 로드할 수 없습니다.", "유저 정보를 로드할 수 없습니다.", "유저 정보를 로드할 수 없습니다.");
    }
    idTextControl.text = userPreference.email ?? "유저 정보를 로드할 수 없습니다.";
    nicknameControl.text = userPreference.nickname ?? "유저 정보를 로드할 수 없습니다.";
    nickname = nicknameControl.text.obs;
    super.onInit();
  }

  Future<void> submit() async {
    EasyLoading.show();

    if (nicknameControl.text.isEmpty == true) {
      EasyLoading.dismiss();
      return;
    }

    UserService.to.save(nicknameControl.text);
    nickname = nicknameControl.text.obs;
    await storyListNetworkRepository.updateUserPreference(nicknameControl.text);

    EasyLoading.dismiss();
  }

  Future<void> logout() async {
    await AuthService.to.logOut();
    Get.rootDelegate.offAndToNamed(Routes.LOGIN);
  }

  Future<void> withDraw() async {
    EasyLoading.show();
    String snackString = "새 신을 신 고 뛰어보자 퐐쫙";
    String title = "회원탈퇴에 실패하였습니다.";


    await storyListNetworkRepository.deleteUser();
    final status = await AuthService.to.withDrawUser();
    debugConsole(status);
    if (status == WithDrawStatus.success) {
      title = "회원탈퇴에 성공하였습니다.";
      snackString = "다음에 뵈요!";
      Get.rootDelegate.offAndToNamed(Routes.LOGIN);
    } else if (status == WithDrawStatus.noLoginRecent) {
      snackString = "로그인 기록이 너무 오래 되었습니다. 재로그인을 해야 할 수 있습니다. (데이터는 삭제되었습니다.)";
    } else {
      snackString = "예상치 못한 동작입니다. 관리자에게 문의해 주시면 감사하겠습니다. (데이터는 삭제되었습니다.)";
    }

    final getSnackBar = GetSnackBar(
      title: title,
      message: snackString,
      duration: const Duration(seconds: 2),
    );
    Get.showSnackbar(getSnackBar);
    EasyLoading.dismiss();
  }
}
