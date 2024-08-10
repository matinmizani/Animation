import 'package:flutter/material.dart';
import 'package:project/model/task.dart';
import 'package:project/pages/task/animated_task.dart';

class TaskGrid extends StatefulWidget {
  const TaskGrid({super.key, required this.taskPresets});

  final List<Task> taskPresets;

  @override
  State<TaskGrid> createState() => _TaskGridState();
}

class _TaskGridState extends State<TaskGrid> {
  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return AnimatedTask(iconName: widget.taskPresets[index].iconName);
      },
      itemCount: widget.taskPresets.length,
    );
  }
}
