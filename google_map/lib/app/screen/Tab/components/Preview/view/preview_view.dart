import 'package:enitproject/app/screen/Tab/components/Preview/controller/preview_controller.dart';
import 'package:enitproject/service/location_service.dart';
import 'package:enitproject/const/color.dart';
import 'package:enitproject/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:enitproject/app/screen/Detail/view/detail_view.dart';
import 'package:enitproject/app/screen/Tab/components/Preview/components/CreateStory/view/create_story_view.dart';

import 'package:enitproject/app/screen/Tab/components/Preview/components/CreateStory/binding/create_story_binding.dart';
import 'package:enitproject/app/screen/Tab/components/Preview/components/UpdateStory/binding/update_story_binding.dart';
import 'package:enitproject/app/screen/Tab/components/Preview/components/UpdateStory/view/update_story_view.dart';

class PreviewScreen extends GetView<PreviewController> {
  const PreviewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '${UserService.to.nickname} 님의 마커 목록',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          /// 현재위치로 화면 이동
          IconButton(
            onPressed: () async {
              Get.to(
                const CreateStoryView(),
                binding: CreateStroyBinding(),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  '전체',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 5,
                ),
                Obx(
                  () => Text(
                    '${LocationService.to.storyList.length}',
                    style: const TextStyle(color: FONT_MID_BLACK_COLOR, fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                )
              ],
            ),
            const Divider(
              height: 5,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: LocationService.to.storyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    '${LocationService.to.storyList[index].image}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fitHeight,
                                    alignment: FractionalOffset.center,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${LocationService.to.storyList[index].addressSearch}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                        color: GREEN_DARK_COLOR,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${LocationService.to.storyList[index].title}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      '${LocationService.to.storyList[index].addressDetail}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.black,
                                iconSize: 35.0,
                                onPressed: () {
                                  Get.to(
                                    UpdateStoryView(),
                                    binding: UpdateStroyBinding(storyIndex: index),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.black,
                                iconSize: 35.0,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("정말 삭제하시겠습니까?"),
                                          actions: [
                                            MaterialButton(
                                                child: const Text("Yes"),
                                                onPressed: () {
                                                  controller.fireBaseDelete(index);
                                                  Navigator.pop(context);
                                                }),
                                            MaterialButton(
                                                child: const Text("No"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        );
                                      });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(() => DetailStoryView(
                              storyIndex: index,
                            ));
                      },
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
