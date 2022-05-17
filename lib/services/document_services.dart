part of 'services.dart';

class DocumentServices {
  static Future<List<DocumentModel>> getDocuments(
      {http.Client client, String uid = ""}) async {
    String url = baseUrl + "/api/document/get-documents/" + uid;

    client ??= http.Client();

    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data;

    return result
        .map((e) => DocumentModel.fromJson(e['data'], e['id']))
        .toList();
  }

  static Future<http.Response> addDocument(DocumentModel item) async {
    String url = baseUrl + "/api/document/add";

    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': item.title ?? "",
        'time': item.time ?? "",
        'text': item.text.first ?? "",
        'uid': item.uid ?? "",
      }),
    );
  }

  static Future<bool> editDocument(DocumentModel item) async {
    String url = baseUrl + "/api/document/edit";

    String dataText = item.text.join('\\');

    http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': item.id,
        'text': dataText ?? "",
      }),
    );

    return true;
  }
}
