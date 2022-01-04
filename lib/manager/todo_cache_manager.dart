import 'package:app1/manager/cache_manager.dart';
import 'package:app1/model/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoCacheManager extends CacheManager<Todo> {
  TodoCacheManager(String key) : super(key);

  @override
  Future<int?> addItem(Todo item) async {
    return await box?.add(item);
  }

  @override
  Future<void> deleteItem(int index) async {
    await box?.deleteAt(index);
  }

  @override
  List<Todo>? getItems() {
    return box?.values.toList();
  }

  @override
  Future<void> updateItem(int index, Todo item) async {
    await box?.putAt(index, item);
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TodoAdapter());
    }
  }
}
