import 'package:exemplo_widgets_interacao/widget_interacao.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WidgetsInteracao()
    );
  }
}