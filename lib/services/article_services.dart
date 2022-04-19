part of 'services.dart';

class ArticleServices {
  static Future<List<ArticleModel>> getArticles({http.Client client}) async {
    String url = baseUrl + "/api/article/get-articles";

    client ??= http.Client();

    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return [];
    }

    print("ss");
    var data = json.decode(response.body);
    List result = data;

    print(result);

    return result
        .map((e) => ArticleModel.fromJson(e['data'], e['id']))
        .toList();
  }
}
