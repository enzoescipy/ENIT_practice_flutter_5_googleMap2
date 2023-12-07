import 'package:enitproject/app/screen/Tab/components/Preview/components/CreateStory/controller/create_story_controller.dart';
import 'package:get/get.dart';

class CreateStroyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateStoryController>(CreateStoryController());
  }
}
