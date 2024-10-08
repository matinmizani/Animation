import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String iconName;

  factory Task.create({required String iconName}) {
    final id = const Uuid().v1();
    return Task(id: id, iconName: iconName);
  }

  Task({
    required this.id,
    required this.iconName,
  });
}
