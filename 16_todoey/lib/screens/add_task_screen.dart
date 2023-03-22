import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_data.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  // when using a callback to add a new tasks:
  //const AddTaskScreen({super.key, required this.addTaskCallback});
  //final Function addTaskCallback;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final addTaskController = TextEditingController();

  @override
  void dispose() {
    addTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              controller: addTaskController,
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                //widget.addTaskCallback(addTaskController.text);
                Provider.of<TaskData>(context, listen: false)
                    .addTask(addTaskController.text);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context)
                    .primaryColor, // if you want to change button colour
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
