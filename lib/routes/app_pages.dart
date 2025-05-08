import 'package:get/get.dart';
import 'package:studio_task/modules/home/binding/home_binding.dart';
import 'package:studio_task/modules/home/pages/home_page.dart';
import 'package:studio_task/modules/splash/pages/splash_page.dart';
import 'package:studio_task/routes/app_routes.dart';

class AppPages {
  AppPages._();
  static const initial = Routes.splash;

  static final routes = [
    GetPage(name: Routes.splash, page: () => const SplashPage()),
    GetPage(
      name: Routes.homePage,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
