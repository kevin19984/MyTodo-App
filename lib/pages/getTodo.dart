import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GetTodo extends StatefulWidget {
  @override
  _GetTodoState createState() => _GetTodoState();
}

class _GetTodoState extends State<GetTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Center(
        child: SpinKitFadingGrid(
          color: Colors.purple[200],
          size: 80.0,
        ),
      ),
    );
  }
}
