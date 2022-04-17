part of 'models.dart';

class DocumentModel {
  String id;
  String title;
  String time;
  String uid;
  List<Object> pages;

  DocumentModel({
    this.id,
    this.title,
    this.time,
    this.uid,
    this.pages,
  });
}
