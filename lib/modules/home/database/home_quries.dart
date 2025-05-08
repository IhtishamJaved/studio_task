import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studio_task/modules/home/model/prompt_model.dart';
import 'package:studio_task/modules/home/model/todo_model.dart';

class HomeQuries {
  static Future<List<TodoModel>> getTodo() {
    final reference =
        FirebaseFirestore.instance
            .collection("todo")
            .orderBy("dateTime", descending: false)
            .get();

    return reference.then((value) {
      if (value.docs.isNotEmpty) {
        final progressModel =
            value.docs.map((doc) => TodoModel.fromJson(doc.data())).toList();

        return progressModel;
      } else {
        return [];
      }
    });
  }

  static Future<String> createTodoInDB(PromptModel promptModel) async {
    final reference = FirebaseFirestore.instance.collection('todo').doc();
    promptModel.docID = reference.id;
    await FirebaseFirestore.instance
        .collection("todo")
        .doc(reference.id)
        .set(promptModel.toJson());
    return reference.id;
  }

  static Future<void> updateTodoInDB(TodoModel todoModel) async {
    await FirebaseFirestore.instance
        .collection("todo")
        .doc(todoModel.docID)
        .update(todoModel.toJson());
  }

  static Future<void> deleteTodoInDB(TodoModel todoModel) async {
    await FirebaseFirestore.instance
        .collection("todo")
        .doc(todoModel.docID)
        .delete();
  }
}
