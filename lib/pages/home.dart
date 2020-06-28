import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My ToDo List'),
        centerTitle: true,
        backgroundColor: Colors.purple[100],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('111');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[50],
      ),
      body: Column(
        children: <Widget>[
          
        ],
      ),
    );
  }
}