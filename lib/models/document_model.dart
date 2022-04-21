part of 'models.dart';

class DocumentModel {
  String id;
  String title;
  String time;
  String uid;
  List<String> text = [];
  List<File> image = [];

  DocumentModel({
    this.id,
    this.title,
    this.time,
    this.uid,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json, String id) {
    DocumentModel data = DocumentModel(
      id: id,
      title: json['title'],
      time: json['time'].toString(),
      uid: json['uid'],
    );

    data.text.addAll(json['text'].split("\\"));

    return data;
  }
}
