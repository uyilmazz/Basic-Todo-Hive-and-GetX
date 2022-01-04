import 'package:app1/model/todo.dart';
import 'package:app1/view_model/todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoCard extends StatefulWidget {
  final int index;
  final Todo currentTodo;
  const TodoCard({Key? key, required this.index, required this.currentTodo})
      : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  final Controller _getController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) async {
        await _getController.deleteToDo(widget.index, widget.currentTodo);
      },
      key: ObjectKey(widget.currentTodo),
      child: builCard(),
    );
  }

  Card builCard() {
    return Card(
      elevation: widget.currentTodo.isCompleted ? 1 : 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: Theme.of(context).primaryColor,
      child: buildListTile(),
    );
  }

  ListTile buildListTile() {
    return ListTile(
      title: Text(
        widget.currentTodo.title,
        style: TextStyle(
            color: Colors.black,
            decoration: widget.currentTodo.isCompleted
                ? TextDecoration.lineThrough
                : null),
      ),
      trailing: buildCheckbox(),
    );
  }

  Checkbox buildCheckbox() {
    return Checkbox(
      value: widget.currentTodo.isCompleted,
      onChanged: (value) {
        setState(() {});
        _getController.updateToDo(widget.index);
      },
      activeColor: Colors.green,
    );
  }
}
