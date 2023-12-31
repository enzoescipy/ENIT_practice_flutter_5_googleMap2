import 'package:enitproject/app/routes/app_pages.dart';
import 'package:enitproject/service/location_service.dart';
import 'package:enitproject/service/splash_service.dart';
import 'package:enitproject/service/auth_service.dart';
import 'package:enitproject/service/user_service.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:enitproject/firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:enitproject/package/debug_console.dart';

Future<void> main() async {
  ///파이어베이스 연동
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  enableDebug();
  runApp(
    GetMaterialApp.router(
      initialBinding: BindingsBuilder(
        () async {
          // 초기화 하면서 서비스를 가져온다.
          Get.put(SplashService());
          Get.put(LocationService());
          Get.put(AuthService());
          Get.put(UserService());
        },
      ),
      builder: EasyLoading.init(),
      getPages: AppPages.routes,
    ),
  );
}
