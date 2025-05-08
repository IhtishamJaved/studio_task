import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studio_task/generated/app_assets.dart';
import 'package:studio_task/global/constants/app_colors.dart';
import 'package:studio_task/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackBGColor,
      body: Center(child: Image.asset(AppAssets.appLogo)),
    );
  }

  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  void _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(Routes.homePage);
  }
}
