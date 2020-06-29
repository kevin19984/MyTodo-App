import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mytodo_app/models/todoModel.dart';
import 'package:mytodo_app/services/dbHelper.dart';

class GetTodo extends StatefulWidget {
  @override
  _GetTodoState createState() => _GetTodoState();
}

class _GetTodoState extends State<GetTodo> {

  void getAllTodo() async {

    List<Todo> allTodo = await DBHelper().getAllTodo();
    print(allTodo); 
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'allTodo': allTodo,
    });
  }

  @override
  void initState() {
    super.initState();
    getAllTodo();
  }

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
