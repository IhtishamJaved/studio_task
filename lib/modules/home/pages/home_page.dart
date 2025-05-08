import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:studio_task/generated/app_assets.dart';
import 'package:studio_task/global/constants/app_colors.dart';
import 'package:studio_task/global/utils/app_text_style.dart';
import 'package:studio_task/modules/home/controller/home_controller.dart';
import 'package:studio_task/modules/home/widget/todo_tile.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blackBGColor,
          title: Text(
            "Todo",
            style: AppTextStyles.semiBold.copyWith(
              fontSize: 20,
              color: AppColors.whiteBGColor,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: 16,
          ),
          child: Obx(
            () =>
                controller.todoLoading.value
                    ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blackBGColor,
                      ),
                    )
                    : controller.todoModelList.isEmpty
                    ? Center(
                      child: Text(
                        "No todo Find",
                        style: AppTextStyles.medium.copyWith(fontSize: 13),
                      ),
                    )
                    : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.todoModelList.length,

                      itemBuilder: (context, index) {
                        return TodoTile(
                          todoModel: controller.todoModelList[index],
                        );
                      },
                    ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            controller.micON.value
                ? controller.stopListening()
                : controller.startListening();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              color: AppColors.blackBGColor,
              shape: BoxShape.circle,
            ),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () =>
                    controller.loading.value
                        ? Padding(
                          padding: const EdgeInsets.all(3),
                          child: CircularProgressIndicator(
                            color: AppColors.whiteBGColor,
                            strokeWidth: 2,
                          ),
                        )
                        : controller.micON.value
                        ? Lottie.asset(AppAssets.micONIcon)
                        : Icon(Icons.mic_off, color: AppColors.whiteBGColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
