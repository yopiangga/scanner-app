part of 'providers.dart';

class DocumentProvider with ChangeNotifier {
  List<DocumentModel> get documents => _documents;

  List<DocumentModel> _documents = [];

  List<DocumentModel> setDocuments(data) => _documents = data;
}
