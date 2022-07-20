part of 'providers.dart';

class LanguageProvider with ChangeNotifier {
  String _selectedValue = "Indonesia";
  String _selectedKey = "id-ID";

  List<LanguageModel> _items = [
    LanguageModel(title: "English", key: "en-US"),
    LanguageModel(title: "Indonesia", key: "id-ID"),
  ];

  List<LanguageModel> get items => _items;
  String get selectedValue => _selectedValue;
  String get selectedKey => _selectedKey;

  setSelected(value, key) {
    _selectedValue = value;
    _selectedKey = key;
  }
}
