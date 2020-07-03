import 'package:flutter/material.dart';
import 'package:mytodo_app/models/todoModel.dart';
import 'package:mytodo_app/services/addOneTodo.dart';
import 'package:mytodo_app/services/dbHelper.dart';
import 'package:mytodo_app/services/updateOneTodo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> data;
  bool first = true;

  @override
  Widget build(BuildContext context) {
    data = first ? ModalRoute.of(context).settings.arguments : data;
    first = false;
    data.sort((a, b) => a.deadline.compareTo(b.deadline));

    return Scaffold(
      appBar: AppBar(
        title: Text('My ToDo List'),
        backgroundColor: Colors.purple[100],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.add),
            label: Text('add Todo'),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AddOneTodo(),
              ).then((val) {
                if (val != null) {
                  setState(() {
                    data.add(val);
                  });
                }
              });
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.delete_sweep),
            label: Text('delete all'),
            onPressed: () async {
              DBHelper().deleteAllTodo();
              setState(() {
                data = [];
              });
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.fromLTRB(16.0, 7.0, 16.0, 7.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    data[index].work,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    '기한 : ${data[index].deadline}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                UpdateOneTodo(targetTodo: data[index]),
                          ).then((val) {
                            if (val != null) {
                              setState(() {
                                data[index] = val;
                              });
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          DBHelper().deleteTodo(data[index].id);
                          setState(() {
                            data.remove(data[index]);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
