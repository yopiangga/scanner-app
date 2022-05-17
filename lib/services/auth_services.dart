part of 'services.dart';

class AuthServices {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
      String email, String password) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // print(result.user);
      // return SignInSignUpResult(user: user);
    } catch (e) {
      // print(e.toString().split("]")[1].trim());
      print(e.toString());
      return SignInSignUpResult(message: e.toString(), uid: null);
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // print(result.user.uid);
      // shareUID = result.user.uid;
      return SignInSignUpResult(uid: result.user.uid, message: "Login Succes");
    } catch (e) {
      print(e.toString());
      // print(e.toString().split("]")[1].trim());
      return SignInSignUpResult(message: e.toString().split("]")[1].trim());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<auth.User> get userStream => _auth.authStateChanges();
}

class SignInSignUpResult {
  // final User user;
  final String uid;
  final String message;

  SignInSignUpResult({this.message = "", this.uid = ""});
}
