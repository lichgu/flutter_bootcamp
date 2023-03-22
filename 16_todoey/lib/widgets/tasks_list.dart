import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/widgets/task_tile.dart';
import '../models/task.dart';
import '../models/task_data.dart';

class TasksList extends StatelessWidget {
  TasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, taskData, Widget? child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final Task task = taskData.tasks[index];
            return TaskTile(
              title: task.title,
              isChecked: task.isDone,
              isPrioritized: task.isPrioritized,
              checkboxCallback: (bool? checkboxState) {
                taskData.finishTask(task);
              },
              priorityCallback: () {
                taskData.prioritizeTask(task);
              },
              longPressCallback: () {
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
