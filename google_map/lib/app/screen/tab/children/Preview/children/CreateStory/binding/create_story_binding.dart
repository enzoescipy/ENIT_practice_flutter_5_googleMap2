import 'package:enitproject/app/screen/Tab/children/Preview/children/CreateStory/controller/create_story_controller.dart';
import 'package:get/get.dart';

class CreateStroyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateStoryController>(CreateStoryController());
  }
}
