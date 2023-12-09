import 'package:enitproject/model/user_preference_model.dart';
import 'package:enitproject/package/debug_console.dart';
import 'package:enitproject/repository/storylist_network_repository.dart';
import 'package:enitproject/service/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:enitproject/service/auth_service.dart';
import 'package:enitproject/app/routes/app_pages.dart';

class JoinController extends GetxController {
  static JoinController get to => Get.find();

  final Map<String, TextEditingController> textFieldControllers = {
    'email_id': TextEditingController(),
    'pw': TextEditingController(),
    'pw_repeat': TextEditingController(),
    'nickname': TextEditingController(),
  };

  Future<void> userJoin() async {
    int emptyCount = 0;
    final textFieldMap = textFieldControllers.map((key, value) {
      if (value.text.isEmpty) {
        emptyCount++;
      }
      return MapEntry(key, value.text);
    });

    debugConsole(textFieldMap);

    if (emptyCount != 0) {
      return;
    }

    EasyLoading.show();

    final userModel = UserPrefModel(textFieldMap['email_id'], textFieldMap['pw'], textFieldMap['nickname']);
    String snackString = "새 신을 신 고 뛰어보자 퐐쫙";
    String title = "회원가입에 실패하였습니다.";

    final status = await AuthService.to.joinWithEmailAndPassword(userModel, passwordRepeat: textFieldMap['pw_repeat']!);
    switch (status) {
      case JoinStatus.success:
        snackString = "가입을 환영합니다, ${userModel.nickname} 님!";
        title = "환영합니다!";
        break;
      case JoinStatus.weakPassword:
        snackString = "비밀번호가 서버에게 패배하였습니다... 더 강력한 비밀번호가 필요합니다!";
        break;
      case JoinStatus.alreadyExistsEmail:
        snackString = "중복되는 이메일입니다.";
        break;
      case JoinStatus.passwordRepeatWrong:
        snackString = "비밀번호 재입력 란이 잘못되었습니다.";
        break;
      default:
        snackString = "예상치 못한 동작입니다. 겪으신 문제점을 관리자에게 문의 드리면 감사하겠습니다.";
    }

    final getSnackBar = GetSnackBar(
      title: title,
      message: snackString,
      duration: const Duration(seconds: 2),
    );

    if (status == JoinStatus.success) {
      await storyListNetworkRepository.createUser(userModel);
      Get.back();
      storyListNetworkRepository.getUserPreference().then((userModel) => UserService.to.save(userModel?.nickname ?? ""));
      Get.rootDelegate.offAndToNamed(Routes.HOME);
      Get.showSnackbar(getSnackBar);
    } else {
      Get.showSnackbar(getSnackBar);
    }
    EasyLoading.dismiss();
  }
}
