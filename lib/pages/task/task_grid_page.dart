import 'package:flutter/material.dart';
import 'package:project/model/task.dart';
import 'package:project/pages/task/tasks_grid.dart';

class TasksGridPage extends StatelessWidget {
  const TasksGridPage({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade600,
      body: TasksGridContents(tasks: tasks),
    );
  }
}

class TasksGridContents extends StatelessWidget {
  const TasksGridContents({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: TaskGrid(taskPresets: tasks),
    );
  }
}
