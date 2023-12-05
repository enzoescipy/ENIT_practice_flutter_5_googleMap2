import 'package:enitproject/package/debug_console.dart';
import 'package:enitproject/service/location_service.dart';
import 'package:enitproject/model/storylist_model.dart';
import 'package:enitproject/repository/storylist_network_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PreviewController extends GetxController {
  //싱글톤처럼 쓰기위함
  static PreviewController get to => Get.find();

  //데이터베이스에 있는 정보 가져와서 담을 리스트 선언
  RxList<StoryListModel> previewStoryList = RxList<StoryListModel>();

  @override
  void onInit() async {
    await storyListNetworkRepository.getStoryListModel().then((value) => {
          previewStoryList(value),
        });
    super.onInit();
  }

  Future<void> fireBaseDelete(int index) async {
    EasyLoading.show();
    // grab the current storylistmodel.
    final targetPkey = LocationService.to.storyList[index].pkey;
    debugConsole(index);
    debugConsole(LocationService.to.storyList.map((e) => e.pkey).toList());
    debugConsole(targetPkey);
    if (targetPkey == null) {
      return;
    }

    debugConsole(targetPkey);

    await storyListNetworkRepository.deleteStoryModel(targetPkey);
    LocationService.to.storyList.removeWhere((element) => element.pkey == targetPkey);

    EasyLoading.dismiss();
  }
}
