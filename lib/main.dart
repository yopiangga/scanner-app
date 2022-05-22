import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/providers/providers.dart';
import 'package:scanner_app/services/services.dart';
import 'package:scanner_app/ui/pages/pages.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<auth.User>(
        stream: AuthServices.userStream,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return StreamProvider.value(
              value: AuthServices.userStream,
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (context) => DocumentProvider()),
                  ChangeNotifierProvider(create: (context) => UserProvider()),
                  ChangeNotifierProvider(
                      create: (context) => ArticleProvider()),
                  ChangeNotifierProvider(
                      create: ((context) => LanguageProvider()))
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Maca Santara',
                  home: snapshot.data != null
                      ? MainPage(uid: snapshot?.data?.uid)
                      : StartPage(),
                ),
              ),
            );
          } else {
            return MaterialApp(
              title: 'Maca Santara',
              debugShowCheckedModeBanner: false,
              home: Splash(),
            );
          }
        }));
  }
}

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(20),
          child: Center(child: Image.asset('assets/images/logo.png'))),
    );
  }
}
