class PromptModel {
  final String? action;
  final String? title;
  final String? description;
  final DateTime? dateTime;
  String? docID;

  PromptModel({
    required this.action,
    required this.title,
    required this.description,
    required this.dateTime,
    this.docID,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['docID'] = docID;
    data['title'] = title;
    data['description'] = description;
    data['dateTime'] = dateTime;

    return data;
  }
}
