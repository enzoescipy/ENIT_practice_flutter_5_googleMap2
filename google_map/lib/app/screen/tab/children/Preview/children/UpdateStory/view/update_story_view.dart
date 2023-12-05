import 'package:enitproject/app/screen/Tab/children/Preview/children/UpdateStory/controller/update_story_controller.dart';
import 'package:enitproject/service/location_service.dart';
import 'package:enitproject/model/storylist_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:enitproject/const/const.dart';
import 'dart:developer';

class UpdateStoryView extends GetView<UpdateStoryController> {
  const UpdateStoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: const Text(
              '마커 수정',
              style: TextStyle(color: Colors.black),
            ),
            leading: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black,
                iconSize: 35.0,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
          body: Center(
            child: Container(
              child: SizedBox(
                width: 300,
                child: ListView(
                  children: [
                    ListViewNameField(),
                    ListViewLatitudeField(),
                    ListViewLongitudeField(),
                    ListViewImageField(),
                    ListViewAddressField(),
                    ListViewScriptField(),
                    Submit()
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget ListViewNameField() {
    log("11");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "이름",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers[KEY_TITLE]))
      ],
    );
  }

  Widget ListViewLatitudeField() {
    log("12");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "위도",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers[KEY_LATITUDE]))
      ],
    );
  }

  Widget ListViewLongitudeField() {
    log("13");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "경도",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers[KEY_LONGITUDE]))
      ],
    );
  }

  Widget ListViewImageField() {
    log("14");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "이미지 URL",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers[KEY_IMAGE]))
      ],
    );
  }

  Widget ListViewAddressField() {
    log("15");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "주소",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers[KEY_ADDRESS_SEARCH]))
      ],
    );
  }

  Widget ListViewScriptField() {
    log("16");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "장소 설명",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers[KEY_SCRIPT]))
      ],
    );
  }

  Widget Submit() {
    return Center(
      child: IconButton(
        icon: Icon(Icons.send),
        onPressed: (() async {
          controller.isUpdated = true;
          await controller.fireBaseUpdate();
          Get.back();
        }),
      ),
    );
  }
}
