import 'package:flutter/material.dart';
import 'package:mytodo_app/models/todoModel.dart';
import 'package:mytodo_app/services/dbHelper.dart';
// import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map tem = {};

  @override
  Widget build(BuildContext context) {
    
    tem = tem.isNotEmpty ? tem : ModalRoute.of(context).settings.arguments;
    List<Todo> data = tem['allTodo'];
    data.sort((a,b) => a.deadline.compareTo(b.deadline));
    print(data);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('My ToDo List'),
        centerTitle: true,
        backgroundColor: Colors.purple[100],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Todo addTodo = Todo(work: 'BOB 센터 방문', deadline: '2020-07-02 12:00');
          DBHelper().insertTodo(addTodo);
          setState(() {
            data.add(addTodo);
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[50],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
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
                  SizedBox(height: 6.0,),
                  Text(
                    '기한 : ${data[index].deadline}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 6.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          data[index].work = '취약점 분석 과제 2';
                          data[index].deadline = '2020-07-20 14:00';
                          DBHelper().updateTodo(data[index]);
                          setState(() {});
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          DBHelper().deleteTodo(data[index].id);
                          setState(() {
                            data.remove(data[index]);
                          });
                        }, 
                        icon: Icon(Icons.delete), 
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