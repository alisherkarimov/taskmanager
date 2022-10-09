import 'package:flutter/cupertino.dart';
import 'package:taskmanager/database_helper.dart';
import 'package:taskmanager/models/task_model.dart';

class HomeProvider extends ChangeNotifier {
  List<Task> taskList = [];

  getTasks() async {
    List<Task> taskList = await DatabaseHelper.instance.getTaskList();
    this.taskList.clear();
    this.taskList.addAll(taskList);
    notifyListeners();
  }

  deleteTask(Task task) {
    DatabaseHelper.instance.delete(task);
    notifyListeners();
  }
}
