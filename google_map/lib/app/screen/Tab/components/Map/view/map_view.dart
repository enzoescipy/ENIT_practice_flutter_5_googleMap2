import 'package:enitproject/app/screen/Tab/components/Map/controller/map_controller.dart';
import 'package:enitproject/app/screen/Tab/components/Map/view/map_home_component/map_home_googlemap.dart';
import 'package:enitproject/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

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
                  children: [
                    ///구글맵
                    CustomGoogleMap(onMapCreated: controller.onMapCreated),
                  ],
                );
              })
          : const Center(
              child: CircularProgressIndicator(), // 대기중 서클 띄워라
            )),
    );
  }
}
