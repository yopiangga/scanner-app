class DocumentModelDB {
  int id;
  String title;
  String time;
  String uid;

  DocumentModelDB({
    this.id,
    this.title,
    this.time,
    this.uid,
  });

  DocumentModelDB.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.time = map['time'];
    this.uid = map['uid'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['title'] = this.title;
    map['time'] = this.time;
    map['uid'] = this.uid;
    return map;
  }
}
