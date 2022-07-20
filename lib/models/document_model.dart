part of 'models.dart';

class DocumentModel {
  String id;
  String title;
  String time;
  String uid;
  String job_id;
  List<String> text = [];
  List<File> image = [];

  DocumentModel({this.id, this.title, this.time, this.uid, this.job_id});

  factory DocumentModel.fromJson(Map<String, dynamic> json, String id) {
    DocumentModel data = DocumentModel(
        id: id,
        title: json['title'],
        time: json['time'].toString(),
        uid: json['uid'],
        job_id: json['job_id']);

    data.text.addAll(json['text'].split("\\"));

    return data;
  }
}
