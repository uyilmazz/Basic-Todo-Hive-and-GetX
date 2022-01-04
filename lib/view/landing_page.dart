import 'package:app1/view/homepage.dart';
import 'package:app1/view_model/todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Controller _getController = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    getItems();
  }

  Future<void> getItems() async {
    await _getController.getToDos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Obx(() => _getController.state.value == ToDoState.loadingState
                ? buildLoadingState()
                : _getController.state.value == ToDoState.loadedState
                    ? TodoView()
                    : buildErrorstate())));
  }

  // get _screenControl => _

  Center buildLoadingState() =>
      const Center(child: CircularProgressIndicator());

  getTodoViewPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TodoView()));
  }

  Center buildErrorstate() {
    return const Center(
      child: Text('Error occured'),
    );
  }
}
