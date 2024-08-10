import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project/model/task.dart';
import 'package:project/model/task_state.dart';

class HiveDataStore {
  static const tasksBoxName = "tasks";
  static const taskStateBoxName = "tasksState";

  static taskStateKey(String key) => "tasksState/$key";

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Task>(TaskAdapter());
    Hive.registerAdapter<TaskState>(TaskStateAdapter());
    await Hive.openBox<Task>(tasksBoxName);
    await Hive.openBox<TaskState>(taskStateBoxName);
  }

  Future<void> createDemoTasks({required List<Task> tasks}) async {
    bool force = false;
    final box = Hive.box<Task>(tasksBoxName);
    if (box.isEmpty || force) {
      await box.clear();
      await box.addAll(tasks);
    }
  }

  ValueListenable<Box<Task>> tasksListenable() {
    return Hive.box<Task>(tasksBoxName).listenable();
  }

  Future<void> setTaskState(
      {required Task task, required bool completed}) async {
    final box = Hive.box<TaskState>(tasksBoxName);
    final taskState = TaskState(taskId: task.id, completed: completed);
    await box.put(taskStateKey(task.id), taskState);
  }

  ValueListenable<Box<TaskState>> taskStateListenable({required Task task}) {
    final box = Hive.box<TaskState>(taskStateBoxName);
    final key = taskStateKey(task.id);
    return box.listenable(keys: <String>[key]);
  }
}

final dataStoreProvider = Provider<HiveDataStore>((ref) {
  throw UnimplementedError();
});
