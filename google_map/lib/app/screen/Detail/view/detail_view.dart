import 'package:enitproject/app/routes/app_pages.dart';
import 'package:enitproject/app/screen/Tab/children/Map/controller/map_controller.dart';
import 'package:enitproject/model/storylist_model.dart';
import 'package:enitproject/package/debug_console.dart';
import 'package:enitproject/service/location_service.dart';
import 'package:enitproject/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailStoryView extends GetView<LocationService> {
  final int storyIndex;
  StoryListModel? storyModel;

  /// if the storyModel field is null, class will find the storyModel by the given storyIndex key.
  DetailStoryView({required this.storyIndex, this.storyModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugConsole(storyModel?.title);
    storyModel ??= LocationService.to.storyList[storyIndex];
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
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
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          '${storyModel?.title}',
                          style: const TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${storyModel?.addressDetail}',
                              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            TextButton(
                              child: const Text(
                                '지도로 돌아가기',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: GREEN_BRIGHT_COLOR,
                                ),
                              ),
                              onPressed: () {
                                Get.rootDelegate.offAndToNamed(Routes.HOME);
                                MapHomeController.to.mapController!.animateCamera(
                                  CameraUpdate.newLatLng(
                                    // story 클릭 시 그 위치로 이동시키기
                                    LatLng(storyModel!.latitude!.toDouble(), storyModel!.longitude!.toDouble()),
                                  ),
                                );
                                Get.back();
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      '${storyModel?.image}',
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                          color: GREEN_MID_COLOR),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),

                        ///글 내용
                        child: Text(
                          '${storyModel?.script}',
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 110,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
