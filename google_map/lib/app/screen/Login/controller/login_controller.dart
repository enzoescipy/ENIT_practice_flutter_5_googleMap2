import 'package:enitproject/repository/storylist_network_repository.dart';
import 'package:enitproject/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:enitproject/service/auth_service.dart';
import 'package:enitproject/app/routes/app_pages.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  final idTextControl = TextEditingController();
  final pwTextControl = TextEditingController();

  @override
  void onInit() {
    if (AuthService.to.getCurrentUser() != null) {
      storyListNetworkRepository.getUserPreference().then((userModel) {
        UserService.to.save(userModel.$1?.nickname ?? "");
        Get.rootDelegate.offAndToNamed(Routes.HOME);
      });
    }
    // AuthService.to.logOut(); //debug
    // storyListNetworkRepository.getUserPreference(); // debug
    // storyListNetworkRepository.updateUserPreference("아직모른다"); // debug
    // storyListNetworkRepository.createUser(UserPrefModel(null, null, "testNickNAme일지도")); // debug
    super.onInit();
  }

  Future<void> googleAuthLogin() async {
    EasyLoading.show();
    final status = await AuthService.to.logInWithGoogle();
    if (status == null) {
      return;
    } else {
      EasyLoading.dismiss();
      await storyListNetworkRepository.getUserPreference().then((userModel) => UserService.to.save(userModel.$1?.nickname ?? ""));
      Get.rootDelegate.offAndToNamed(Routes.HOME);
    }
  }

  Future<void> fireAuthLogin() async {
    EasyLoading.show();

    if (idTextControl.text.isEmpty == true || pwTextControl.text.isEmpty == true) {
      EasyLoading.dismiss();
      return;
    }

    final loginStatus = await AuthService.to.logInWithEmailAndPassword(email: idTextControl.text, password: pwTextControl.text);
    if (loginStatus == LoginStatus.success) {
      EasyLoading.dismiss();
      await storyListNetworkRepository.getUserPreference().then((userModel) => UserService.to.save(userModel.$1?.nickname ?? ""));
      Get.rootDelegate.offAndToNamed(Routes.HOME);
      return;
    }

    String errString = "새 신을 신 고 뛰어보자 퐐쫙";
    switch (loginStatus) {
      case LoginStatus.invalidEmail:
        errString = "아이디는 이메일 형식이어야 합니다.";
        break;
      case LoginStatus.userDisabled:
        errString = "해당 유저는 차단되었습니다. 관리자에게 문의하세요.";
        break;
      case LoginStatus.userNotFound:
        errString = "비밀번호가 잘못되었거나, 해당 유저가 존재하지 않습니다.";
        break;
      default:
        errString = "예상치 못한 동작입니다. 겪으신 문제점을 관리자에게 문의 드리면 감사하겠습니다.";
    }

    Get.showSnackbar(GetSnackBar(
      title: "로그인에 실패하였습니다.",
      message: errString,
    ));

    EasyLoading.dismiss();
  }
}
