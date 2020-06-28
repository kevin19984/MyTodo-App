import 'package:flutter/material.dart';
import 'package:mytodo_app/pages/getTodo.dart';
import 'package:mytodo_app/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => GetTodo(),
      '/home': (context) => Home(),
    },
  ));
}