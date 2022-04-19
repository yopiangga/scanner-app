part of 'providers.dart';

class ArticleProvider with ChangeNotifier {
  List<ArticleModel> get articles => _articles;

  List<ArticleModel> _articles = [];
}
