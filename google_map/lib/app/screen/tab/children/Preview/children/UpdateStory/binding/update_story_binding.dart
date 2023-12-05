import 'package:enitproject/app/screen/Tab/children/preview/children/UpdateStory/controller/update_story_controller.dart';
import 'package:get/get.dart';
import 'dart:developer';

class UpdateStroyBinding extends Bindings {
  final int storyIndex;
  UpdateStroyBinding({required this.storyIndex}) : super();
  @override
  void dependencies() {
    Get.put<UpdateStoryController>(UpdateStoryController(storyIndex: storyIndex));
  }
}
