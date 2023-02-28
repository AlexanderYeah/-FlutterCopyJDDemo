import 'package:flutter/material.dart';
import 'pages/tabs/tab.dart';
import 'routers/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tabs(),
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
          colorScheme: ColorScheme(
              primary: Colors.white, //上方标题栏颜色
              secondary: Colors.green,
              background: Colors.white,
              error: Colors.red,
              brightness: Brightness.light,
              onBackground: Colors.pink,
              onError: Colors.yellow,
              onPrimary: Colors.white, //字体颜色
              onSecondary: Colors.redAccent,
              onSurface: Colors.redAccent,
              surface: Colors.redAccent)),
    );
  }
}
