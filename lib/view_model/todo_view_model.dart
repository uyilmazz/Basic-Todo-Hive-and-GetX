import 'package:app1/manager/todo_cache_manager.dart';
import 'package:app1/model/todo.dart';
import 'package:get/get.dart';

enum ToDoState { initialState, loadingState, loadedState, errorstate }

class Controller extends GetxController {
  final TodoCacheManager _todoCacheManager = TodoCacheManager('todos');

  var state = ToDoState.initialState.obs;
  RxList<dynamic> toDoList = [].obs;

  Future<void> getToDos() async {
    try {
      state.value = ToDoState.loadingState;
      await _todoCacheManager.init();
      List<Todo>? _cacheTodos = _todoCacheManager.getItems();
      if (_cacheTodos != null) {
        toDoList.value = _cacheTodos;
      }
      state.value = ToDoState.loadedState;
    } catch (error) {
      state.value = ToDoState.errorstate;
    }
  }

  Future<bool> addToDo(String todoTitle, {bool isCompleted = false}) async {
    try {
      Todo newItem = Todo(todoTitle, isCompleted);
      toDoList.add(newItem);
      int? itemIndex = await _todoCacheManager.addItem(newItem);
      return itemIndex != null ? true : false;
    } catch (error) {
      state.value = ToDoState.errorstate;
      return false;
    }
  }

  Future<void> deleteToDo(int index, Todo item) async {
    try {
      await _todoCacheManager.deleteItem(index);
      toDoList.remove(item);
    } catch (error) {
      state.value = ToDoState.errorstate;
    }
  }

  Future<void> updateToDo(int index) async {
    try {
      toDoList[index].isCompleted = !toDoList[index].isCompleted;
      await _todoCacheManager.updateItem(index, toDoList[index]);
    } catch (error) {
      state.value = ToDoState.errorstate;
    }
  }
}
