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
}
