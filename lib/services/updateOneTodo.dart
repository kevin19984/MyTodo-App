import 'package:flutter/material.dart';
import 'package:mytodo_app/models/todoModel.dart';
import 'package:mytodo_app/services/dbHelper.dart';

class UpdateOneTodo extends StatefulWidget {
  final Todo targetTodo;

  const UpdateOneTodo({Key key, this.targetTodo}) : super(key: key);

  @override
  _UpdateOneTodoState createState() => _UpdateOneTodoState();
}

class _UpdateOneTodoState extends State<UpdateOneTodo> {
  final _formKey = GlobalKey<FormState>();

  String _temDate = '';
  String _temTime = '';

  @override
  Widget build(BuildContext context) {
    _temDate =
        _temDate == '' ? widget.targetTodo.deadline.substring(0, 10) : _temDate;
    _temTime =
        _temTime == '' ? widget.targetTodo.deadline.substring(11) : _temTime;
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
                  initialValue: widget.targetTodo.work,
                  decoration: InputDecoration(
                    hintText: 'Todo',
                  ),
                  validator: (val) => val.isEmpty ? 'Enter Todo' : null,
                  onChanged: (val) {
                    setState(() => widget.targetTodo.work = val);
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
                    child: Text("Update Todo"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        widget.targetTodo.deadline = _temDate + ' ' + _temTime;
                        DBHelper().updateTodo(widget.targetTodo);
                        Navigator.pop(context, widget.targetTodo);
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
