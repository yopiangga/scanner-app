class ArticleModel {
  String id;
  String title;
  String tag;
  List<String> description = [];
  String image;
  String time;

  ArticleModel({
    this.id,
    this.title,
    this.tag,
    this.image,
    this.time,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json, String id) {
    ArticleModel data = ArticleModel(
      id: id,
      title: json['title'],
      tag: json['tag'],
      image: json['image'],
      time: json['time'],
    );

    data.description.addAll(json['description'].split('\n'));

    return data;
  }
}
