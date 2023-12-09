import 'package:enitproject/app/screen/Detail/view/detail_view.dart';
import 'package:enitproject/app/screen/Tab/components/Map/controller/map_controller.dart';
import 'package:enitproject/app/screen/Tab/components/Map/view/map_home_component/map_home_googlemap.dart';
import 'package:enitproject/service/location_service.dart';
import 'package:enitproject/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:enitproject/const/color.dart';

class HomeView extends GetView<MapHomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${UserService.to.nickname} 님의 지도',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,

      /// 위치 권한 받기
      body: Obx(() => controller.allowPermissionStr.value == '위치 권한이 허가 되었습니다.'
          ? StreamBuilder<Position>(
              stream: Geolocator.getPositionStream(),
              builder: (context, snapshot) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ///구글맵
                    CustomGoogleMap(onMapCreated: controller.onMapCreated),
                    BottomItemView(),
                  ],
                );
              })
          : const Center(
              child: CircularProgressIndicator(), // 대기중 서클 띄워라
            )),
    );
  }

  Widget BottomItemView() {
    return Obx(() => SizedBox(
      height: 100,
      child: ListView.builder(
          itemCount: LocationService.to.storyList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Row(
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
                  ],
                ),
              ),
              onTap: () {
                Get.to(() => DetailStoryView(
                      storyIndex: index,
                    ));
              },
            );
          }),
    ));
  }
}
