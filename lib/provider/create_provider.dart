import 'package:flutter/cupertino.dart';
import 'package:taskmanager/database_helper.dart';

import '../models/task_model.dart';

class CreateProvider extends ChangeNotifier {
  insertTask(Task task) {
    DatabaseHelper.instance.insert(task);
    notifyListeners();
  }

  updateTask(Task task) {
    DatabaseHelper.instance.update(task);
    notifyListeners();
  }
}
