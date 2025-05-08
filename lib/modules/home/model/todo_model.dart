import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docID;
  String? title;
  String? description;
  Timestamp? dateTime;

  TodoModel({this.title, this.description, this.docID, this.dateTime});

  // factory TodoModel.empty(
  //     DateTime createdAt, DateTime streakEndTime) {
  //   return TodoModel(
  //     habitTrackerPercent: 0,
  //     caloriesTrackerPercent: 0,
  //     sleepTrackerPercent: 0,
  //     heartRateTrackerPercent: 0,
  //     waterTrackerPercent: 0,
  //     stepsCompletedPercent: 0,
  //     workoutCompletedPercent: 0,
  //     createdAt: createdAt.dateTimeToTimestamp,
  //     updatedAt: Timestamp.now(),
  //     streakStartTime: Timestamp.now(),
  //     streakEndTime: streakEndTime.dateTimeToTimestamp,
  //   );
  // }

  TodoModel.fromJson(Map<String, dynamic> json) {
    docID = json["docID"];
    title = json['title'];
    description = json['description'];
    dateTime = json["dateTime"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['docID'] = docID;
    data['title'] = title;
    data['description'] = description;
    data['dateTime'] = dateTime;

    return data;
  }
}
