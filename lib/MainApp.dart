import 'package:flutter/material.dart';
import 'package:proyectoapp/NavInferior.dart';
import 'package:proyectoapp/NavPestanas.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainState();
  }
}

class MainState extends State<MainApp> {
  ThemeData themeData = ThemeData.light();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => NavInferior(),
        "/pestanas": (context) => NavPestanas(),
        "/resultado": (context) => RespuestaForm()
      },
      theme: themeData,
    );
  }

  void updateTheme(ThemeData data) {
    setState(() {
      themeData = data;
    });
  }
}
