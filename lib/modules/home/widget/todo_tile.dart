import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studio_task/global/utils/app_text_style.dart';
import 'package:studio_task/global/utils/timestamp_extention.dart';
import 'package:studio_task/modules/home/controller/home_controller.dart';
import 'package:studio_task/modules/home/model/todo_model.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.todoModel});

  final TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .2),
            offset: Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todoModel.title!.toUpperCase(),
                  maxLines: 1,
                  style: AppTextStyles.semiBold.copyWith(fontSize: 13),
                ),
                Text(
                  todoModel.description!,
                  maxLines: 2,
                  style: AppTextStyles.normal.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              Text(
                Get.find<HomeController>().exractTime(
                  todoModel.dateTime!.timeStampToDateTime,
                ),
                style: AppTextStyles.semiBold.copyWith(fontSize: 13),
              ),
              Text(
                Get.find<HomeController>().exractDay(
                  todoModel.dateTime!.timeStampToDateTime,
                ),
                style: AppTextStyles.semiBold.copyWith(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
