import 'package:flutter/material.dart';
import 'package:mytodo_app/models/todoModel.dart';
import 'package:mytodo_app/services/dbHelper.dart';

class AddOneTodo extends StatefulWidget {
  @override
  _AddOneTodoState createState() => _AddOneTodoState();
}

class _AddOneTodoState extends State<AddOneTodo> {
  final _formKey = GlobalKey<FormState>();

  String _temDate = '';
  String _temTime = '';

  Todo addTodo = Todo(work: '', deadline: '');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                FlatButton.icon(
                  icon: Icon(Icons.date_range),
                  label: Text(_temDate == '' ? 'Pick Date' : _temDate),
                  onPressed: () async {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2022))
                        .then((date) {
                      setState(() {
                        _temDate = date.toString().substring(0, 10);
                      });
                    });
                  },
                ),
                // SizedBox(height: 10.0),
                FlatButton.icon(
                  icon: Icon(Icons.access_time),
                  label: Text(_temTime == '' ? 'Pick Time' : _temTime),
                  onPressed: () async {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((date) {
                      setState(() {
                        _temTime = date.toString().substring(10, 15);
                      });
                    });
                  },
                ),
                SizedBox(height: 5.0),
                Center(
                  child: RaisedButton(
                    child: Text("Add Todo"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        addTodo.deadline = _temDate + ' ' + _temTime;
                        DBHelper().insertTodo(addTodo);
                        // setState(() {
                        //   data.add(addTodo);
                        // });
                        Navigator.pop(context, addTodo);
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
