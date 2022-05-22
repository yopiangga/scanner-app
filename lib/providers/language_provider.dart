part of 'providers.dart';

class LanguageProvider with ChangeNotifier {
  String _selectedValue = "Eng";
  String _selectedKey = "en-US";

  List<LanguageModel> _items = [
    LanguageModel(title: "Eng", key: "en-US"),
    LanguageModel(title: "Ind", key: "id-ID"),
  ];

  List<LanguageModel> get items => _items;
  String get selectedValue => _selectedValue;
  String get selectedKey => _selectedKey;

  setSelected(value, key) {
    _selectedValue = value;
    _selectedKey = key;
  }
}
