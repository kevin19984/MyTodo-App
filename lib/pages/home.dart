import 'package:flutter/material.dart';
import 'package:mytodo_app/models/todoModel.dart';
import 'package:mytodo_app/services/dbHelper.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Todo> data = [];
  final _formKey = GlobalKey<FormState>();
  
  String _temDate = '';
  String _temTime = '';
  String error = '';
  
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    data.sort((a,b) => a.deadline.compareTo(b.deadline));
    Todo addTodo = Todo(work: '', deadline: '');
    // addTodo = addTodo.work != '' && addTodo.deadline != '' ? addTodo : Todo(work: '', deadline: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('My ToDo List'),
        centerTitle: true,
        backgroundColor: Colors.purple[100],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return Stack(
                      // overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.purple[300],
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Todo',
                                ),
                                validator: (val) => val.isEmpty ? 'Enter Todo' : null,
                                onChanged: (val) {
                                  setState(() => addTodo.work = val);
                                },
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.date_range),
                                    onPressed: () async {
                                      showDatePicker(
                                        context: context, 
                                        initialDate: DateTime.now(), 
                                        firstDate: DateTime(2020), 
                                        lastDate: DateTime(2022)
                                      ).then((date) {
                                        setState(() {
                                          _temDate = date.toString().substring(0, 10);
                                        });
                                      });
                                    },
                                  ),
                                  Text(_temDate == '' ? 'Pick Date' : _temDate),
                                ],
                              ),
                              // SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.access_time),
                                    onPressed: () async {
                                      showTimePicker(
                                        context: context, 
                                        // initialDate: DateTime.now(), 
                                        // firstDate: DateTime(2020), 
                                        // lastDate: DateTime(2022)
                                        initialTime: TimeOfDay.now(),
                                      ).then((date) {
                                        setState(() {
                                          _temTime = date.toString().substring(10, 15);
                                        });
                                      });
                                    },
                                  ),
                                  Text(_temTime == '' ? 'Pick Time' : _temTime),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              RaisedButton(
                                child: Text("Add Todo"),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    addTodo.deadline = _temDate + ' ' + _temTime;
                                    DBHelper().insertTodo(addTodo);
                                    setState(() {
                                      data.add(addTodo);
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            },
          );  
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