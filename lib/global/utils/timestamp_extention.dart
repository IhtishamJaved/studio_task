import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension DateTimeToTimestamp on Timestamp {
  DateTime get timeStampToDateTime =>
      DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  String get toFormattedDocID => DateFormat('dd-MMM-yy').format(toDate());
}

extension TimeStampToDateTime on DateTime {
  Timestamp get dateTimeToTimestamp =>
      Timestamp.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

  String get formattedMonthYear {
    final dateFormat = DateFormat('MMMM, yyyy');
    return dateFormat.format(this);
  }

  String get toFormattedDocID => DateFormat('dd-MMM-yy').format(this);
}
