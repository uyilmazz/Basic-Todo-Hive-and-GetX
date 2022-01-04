import 'package:hive_flutter/hive_flutter.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  String title;
  @HiveField(1)
  bool isCompleted;

  Todo(this.title, this.isCompleted);

  Map<String, dynamic> toMap() {
    return {'title': title, 'isCompleted': isCompleted};
  }

  Todo.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        isCompleted = map['isCompleted'];
}
