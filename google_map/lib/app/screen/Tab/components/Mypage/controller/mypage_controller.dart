import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:enitproject/service/auth_service.dart';
import 'package:enitproject/app/routes/app_pages.dart';

class MypageController extends GetxController {
  static MypageController get to => Get.find();

  final idTextControl = TextEditingController();
  final pwTextControl = TextEditingController();

  @override
  void onInit() {

  }

  Future<void> fireAuthLogin() async {
    EasyLoading.show();

    if (idTextControl.text.isEmpty == true || pwTextControl.text.isEmpty == true) {
      EasyLoading.dismiss();
      return;
    }

    AuthService.to.logInWithEmailAndPassword(email: idTextControl.text, password: pwTextControl.text).then((loginStatus) {
      if (loginStatus == LoginStatus.success) {
        EasyLoading.dismiss();
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
    });
  }
}
