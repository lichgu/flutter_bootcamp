import 'package:flutter/material.dart';
import '../constants.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.title,
    required this.isChecked,
    required this.isPrioritized,
    required this.checkboxCallback,
    required this.priorityCallback,
    required this.longPressCallback,
  });

  final String title;
  final bool isChecked;
  final bool isPrioritized;
  final void Function(bool?)? checkboxCallback;
  final void Function()? priorityCallback;
  final void Function()? longPressCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
          color: isPrioritized
              ? kWarningColor
              : Theme.of(context).primaryColorDark,
        ),
      ),
      trailing: Wrap(
        spacing: -10,
        children: [
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            value: isChecked,
            onChanged: checkboxCallback,
          ),
          TextButton(
            onPressed: priorityCallback,
            child: Icon(
              Icons.warning_amber_outlined,
              color: isPrioritized
                  ? kWarningColor
                  : Theme.of(context).primaryColorLight,
            ),
          )
        ],
      ),
      onLongPress: longPressCallback,
    );
  }
}

/*

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;
  bool isPrioritized = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'this is a task',
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
          color: isPrioritized
              ? kWarningColor
              : Theme.of(context).primaryColorDark,
        ),
      ),
      trailing: Wrap(
        spacing: -10,
        children: [
          TaskCheckbox(
            checkboxState: isChecked,
            toggleCheckboxState: (bool? checkboxState) {
              setState(() {
                isChecked = checkboxState!;
              });
            },
          ),
          TaskPriorityButton(
              isPrioritized: isPrioritized,
              togglePriority: () {
                setState(() {
                  isPrioritized = !isPrioritized;
                });
              }),
        ],
      ),
    );
  }
}

class TaskCheckbox extends StatelessWidget {
  const TaskCheckbox(
      {super.key,
      required this.checkboxState,
      required this.toggleCheckboxState});
  final bool checkboxState;
  final void Function(bool?)? toggleCheckboxState;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Theme.of(context).primaryColor,
      value: checkboxState,
      onChanged: toggleCheckboxState,
    );
  }
}

class TaskPriorityButton extends StatelessWidget {
  const TaskPriorityButton(
      {super.key, required this.isPrioritized, required this.togglePriority});

  final bool isPrioritized;
  final void Function()? togglePriority;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: togglePriority,
      child: Icon(
        Icons.warning_amber_outlined,
        color: isPrioritized
            ? kWarningColor
            : Theme.of(context).unselectedWidgetColor,
      ),
    );
  }
}

*/
