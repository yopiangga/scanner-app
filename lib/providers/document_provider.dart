part of 'providers.dart';

class DocumentProvider with ChangeNotifier {
  List<DocumentModel> get documents => _documents;

  List<DocumentModel> _documents = [];
}
