part of 'providers.dart';

class UserProvider with ChangeNotifier {
  UserModel get user => _user;

  UserModel _user;
}
