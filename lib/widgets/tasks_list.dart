import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:todoey_flutter/widgets/task_tile.dart';
import 'package:provider/provider.dart';

enum SlidableAction { completed, deleted }

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemCount: taskData.taskCount,
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: TaskTile(
                  taskTitle: task.name,
                  isChecked: task.isDone,
                  longPressCallback: () => taskData.deleteTask(task),
                  checkboxCallback: (bool? checkboxState) {
                    taskData.updateTask(task);
                  }),
              actions: [
                IconSlideAction(
                    caption: 'Complete',
                    color: Colors.green,
                    icon: Icons.check,
                    onTap: () {
                      taskData.deleteTask(task);
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Task Completed')));
                    })
              ],
              secondaryActions: [
                IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete_forever,
                    onTap: () {
                      taskData.deleteTask(task);
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Task Deleted')));
                    })
              ],
            );
          },
        );
      },
    );
  }
}
