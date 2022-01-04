import 'package:app1/extension.dart';
import 'package:app1/model/todo.dart';
import 'package:app1/view_model/todo_view_model.dart';
import 'package:app1/widgets/dissmissble_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoView extends StatelessWidget {
  TodoView({Key? key}) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();
  final Controller _getController = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: buildAppBar,
          floatingActionButton: buildFloatingActionButton(context),
          body: Column(
            children: [
              SizedBox(height: context.dynamicHeight(0.03)),
              Expanded(flex: 13, child: buildListView()),
              const Expanded(flex: 2, child: SizedBox())
            ],
          )),
    );
  }

  Widget buildListView() {
    return Obx(
      () => ListView.builder(
          itemCount: _getController.toDoList.length,
          itemBuilder: (context, index) {
            Todo currentToDo = _getController.toDoList[index];
            return TodoCard(index: index, currentTodo: currentToDo);
          }),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        buildShowdialog(context);
      },
      child: const Text('ADD'),
    );
  }

  Future<dynamic> buildShowdialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New Task'),
            content: buildTextField(context),
            actions: [
              buildElevatedButton('OK', () async {
                if (_textEditingController.text.trim() == '') {
                  buildSnackbar(
                      'Task cannot be empty!', Colors.redAccent, context);
                } else {
                  bool result =
                      await _getController.addToDo(_textEditingController.text);
                  result
                      ? buildSnackbar('Task added successfully',
                          Colors.greenAccent, context)
                      : buildSnackbar(
                          'Task could not be added', Colors.redAccent, context);
                }
                _textEditingController.text = "";
                Navigator.pop(context);
              }),
              buildElevatedButton('CANCEL', () {
                Navigator.pop(context);
              })
            ],
          );
        });
  }

  buildSnackbar(String title, Color color, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title, style: TextStyle(color: color)),
      duration: const Duration(milliseconds: 1500),
    ));
  }

  ElevatedButton buildElevatedButton(String text, VoidCallback onPress) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: text != 'OK' ? Colors.red : Colors.teal),
        onPressed: onPress,
        child: Text(text));
  }

  TextField buildTextField(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      style: Theme.of(context).textTheme.headline6,
      minLines: 1,
      maxLines: 3,
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: 'new Task',
      ),
    );
  }

  AppBar get buildAppBar => AppBar(
        title: const Text('ToDo App'),
        centerTitle: true,
      );
}
