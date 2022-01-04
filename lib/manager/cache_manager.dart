import 'package:hive_flutter/hive_flutter.dart';

abstract class CacheManager<T> {
  final String key;
  CacheManager(this.key);

  Box<T>? box;

  Future<void> init() async {
    registerAdapters();
    if (box == null) {
      box = await Hive.openBox(key);
    }
  }

  void registerAdapters();
  Future<int?> addItem(T item);
  Future<void> updateItem(int index, T item);
  Future<void> deleteItem(int index);
  List<T>? getItems();
  Future<void> clearAll() async {
    await box?.clear();
  }
}
