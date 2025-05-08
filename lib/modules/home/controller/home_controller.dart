import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:studio_task/global/utils/timestamp_extention.dart';
import 'package:studio_task/modules/home/database/home_quries.dart';
import 'package:studio_task/modules/home/model/prompt_model.dart';
import 'package:studio_task/modules/home/model/todo_model.dart';
import 'package:studio_task/services/openai_service.dart';

enum TodoStatus { create, update, delete }

class HomeController extends GetxController {
  SpeechToText speechToText = SpeechToText();
  RxBool speechEnabled = false.obs;
  String words = '';
  TextEditingController controller = TextEditingController();
  RxBool micON = false.obs;

  RxBool loading = false.obs;
  RxBool todoLoading = false.obs;
  final OpenAIService openAIService = OpenAIService();
  RxList<TodoModel> todoModelList = <TodoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
    _getTodo();
  }

  _getTodo() async {
    todoLoading.value = true;
    todoModelList.value = await HomeQuries.getTodo();
    todoLoading.value = false;
  }

  void _initSpeech() async {
    speechEnabled.value = await speechToText.initialize();
  }

  void startListening() async {
    micON.value = true;
    await speechToText.listen(onResult: _onSpeechResult);
  }

  void stopListening() async {
    micON.value = false;
    loading.value = true;

    final promptData = await openAIService.isArtPromptAPI(controller.text);

    await speechToText.stop();

    final promptModel = parseMeetingData(promptData);
    if (promptModel.action!.isNotEmpty) {
      if (promptModel.action == "create") {
        final promptID = await HomeQuries.createTodoInDB(promptModel);
        todoModelList.add(
          TodoModel(
            docID: promptID,
            title: promptModel.title,
            description: promptModel.description,
            dateTime: promptModel.dateTime!.dateTimeToTimestamp,
          ),
        );
      } else if (promptModel.action == "update") {
        final index = todoModelList.indexWhere(
          (todo) => todo.title!.toLowerCase().contains(
            promptModel.title!.toLowerCase(),
          ),
        );

        if (index != -1) {
          todoModelList[index].dateTime =
              promptModel.dateTime!.dateTimeToTimestamp;

          await HomeQuries.updateTodoInDB(todoModelList[index]);
        } else {
          Get.snackbar("Update", "title not found");
        }
      } else if (promptModel.action == "delete") {
        final index = todoModelList.indexWhere(
          (todo) => todo.title!.toLowerCase().contains(
            promptModel.title!.toLowerCase(),
          ),
        );

        if (index != -1) {
          await HomeQuries.deleteTodoInDB(todoModelList[index]);
          todoModelList.removeAt(index);
        } else {
          Get.snackbar("Delete", "title not found");
        }
      }
    }

    todoModelList.sort(
      (a, b) => a.dateTime!.timeStampToDateTime.compareTo(
        b.dateTime!.timeStampToDateTime,
      ),
    );
    todoModelList.refresh();

    loading.value = false;
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    controller.clear();
    controller.text = result.recognizedWords;
    // print(controller.text);
  }

  DateTime parseDateTime(String datetime) {
    String fixedDate = datetime[0].toUpperCase() + datetime.substring(1);
    DateFormat format = DateFormat('MMMM-yyyy-d HH:mm');

    try {
      DateTime dateTime = format.parse(fixedDate);
      return dateTime;
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing date: $e');
      }
      return DateTime.now();
    }
  }

  String exractTime(DateTime datetime) {
    DateFormat format = DateFormat('hh:mm');

    try {
      String formattedTime = DateFormat.jm().format(datetime);
      return formattedTime;
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing date: $e');
      }
      final formattedDate = format.format(DateTime.now());

      return formattedDate;
    }
  }

  String exractDay(DateTime datetime) {
    DateFormat format = DateFormat('dd-MMM');

    try {
      final formattedDate = format.format(datetime);

      return formattedDate;
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing date: $e');
      }
      final formattedDate = format.format(DateTime.now());

      return formattedDate;
    }
  }

  PromptModel parseMeetingData(String content) {
    final lines = content.split('\n');

    String action = '';
    String title = '';
    String description = '';
    DateTime? datetime = DateTime.now();

    for (final line in lines) {
      final trimmedLine = line.trim();
      if (action.isEmpty) {
        if (trimmedLine.toLowerCase().startsWith('task:')) {
          action = trimmedLine.toLowerCase().substring('task:'.length).trim();
        } else if (trimmedLine.toLowerCase() == 'create' ||
            trimmedLine.toLowerCase() == 'update' ||
            trimmedLine.toLowerCase() == 'delete') {
          action = trimmedLine.toLowerCase();
        }
      } else if (line.toLowerCase().startsWith('title:')) {
        title = line.toLowerCase().substring('title:'.length).trim();
      } else if (line.toLowerCase().startsWith('description:')) {
        description =
            line.toLowerCase().substring('description:'.length).trim();
      } else if (line.toLowerCase().startsWith('datetime:')) {
        final dateStr = line.toLowerCase().substring('datetime:'.length).trim();
        datetime = action == "delete" ? datetime : parseDateTime(dateStr);
      }
    }

    if (action.isEmpty ||
        title.isEmpty ||
        description.isEmpty ||
        datetime == null) {
      Get.snackbar("Error", "Something went wrong. Please try again");
      return PromptModel(
        action: action,
        title: "",
        description: "",
        dateTime: DateTime.now(),
      );
    }

    return PromptModel(
      action: action,
      title: title,
      description: description,
      dateTime: datetime,
    );
  }
}
