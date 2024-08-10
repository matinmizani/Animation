import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:project/model/task.dart';
import 'package:project/pages/task/task_grid_page.dart';
import 'package:project/persistence/hive_data_store.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder(
        valueListenable: dataStore.tasksListenable(),
        builder: (_, Box<Task> box, __) {
          return TasksGridPage(tasks: box.values.toList());
        });
  }
}
