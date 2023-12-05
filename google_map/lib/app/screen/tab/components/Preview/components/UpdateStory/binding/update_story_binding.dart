import 'package:enitproject/app/screen/Tab/components/Preview/components/UpdateStory/controller/update_story_controller.dart';
import 'package:get/get.dart';

class UpdateStroyBinding extends Bindings {
  final int storyIndex;
  UpdateStroyBinding({required this.storyIndex}) : super();
  @override
  void dependencies() {
    Get.put<UpdateStoryController>(UpdateStoryController(storyIndex: storyIndex));
  }
}
