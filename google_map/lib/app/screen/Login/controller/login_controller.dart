import 'package:enitproject/package/debug_console.dart';
import 'package:get/get.dart';
import 'package:enitproject/service/auth_service.dart';
import 'package:enitproject/repository/storylist_network_repository.dart';

class LoginController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    // final userCredential = await AuthService.to.logInWithGoogle();
    // await AuthService.to.logOut();
    // await storyListNetworkRepository.getStoryListFromTestUser_debug();
    // debugConsole(AuthService.to.getCurrentUser());
  }
}
