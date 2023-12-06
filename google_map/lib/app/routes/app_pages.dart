import 'package:enitproject/app/screen/Login/view/login_view.dart';
import 'package:enitproject/app/screen/Tab/components/Map/binding/map_binding.dart';
import 'package:enitproject/app/screen/Tab/components/Map/view/map_view.dart';
import 'package:enitproject/app/screen/Tab/components/Preview/binding/preview_binding.dart';
import 'package:enitproject/app/screen/Tab/components/Preview/view/preview_view.dart';
import 'package:enitproject/app/screen/Root/binding/root_binding.dart';
import 'package:enitproject/app/screen/Root/view/root_screen.dart';
import 'package:enitproject/app/screen/Login/binding/login_binding.dart';
import 'package:enitproject/app/screen/Login/controller/login_controller.dart';

import 'package:enitproject/app/screen/Tab/binding/tabs_binding.dart';
import 'package:enitproject/app/screen/Tab/view/tabs_view.dart';
import 'package:get/get.dart';

import 'package:enitproject/app/screen/Tab/components/Preview/components/CreateStory/view/create_story_view.dart';
import 'package:enitproject/app/screen/Tab/components/Preview/components/CreateStory/binding/create_story_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.ROOT,
      page: () => const RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          preventDuplicates: true,
          name: _Paths.LOGIN,
          page: () => const LoginView(),
          binding: LoginBinding()
        ),
        GetPage(
          preventDuplicates: true,
          name: _Paths.TAB,
          page: () => const TabsView(),
          bindings: [
            TabsBinding(),
          ],
          title: null,
          children: [
            ///홈
            GetPage(
              name: _Paths.Home,
              page: () => const HomeView(),
              title: 'Home',
              binding: HomeBinding(),
            ),

            /// 이야기 목록
            GetPage(
              name: _Paths.LOCATIONLIST,
              page: () => const PreviewScreen(),
              title: 'Storylist',
              binding: PreviewBinding(),
              // children: [
              //   GetPage(
              //     name: _Paths.CREATE,
              //     page: () => const CreateStoryView(),
              //     title: "StoryCreate",
              //     binding: CreateStroyBinding()
              //   )
              // ]
            ),
          ],
        ),
      ],
    ),
  ];
}
// middlewares: [
//   //only enter this route when authed
//   EnsureAuthMiddleware(),
// ],
