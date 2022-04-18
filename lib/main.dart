import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/providers/providers.dart';
import 'package:scanner_app/ui/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DocumentProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maca Santara',
        home: StartPage(),
      ),
    );
  }
}
