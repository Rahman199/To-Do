import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  @override
  void OnReady() {
    super.onReady();
  }

  final RxList<Task> taskListe = <Task>[].obs;

  Future<int> addTask({Task? task}) {
    print("addTask({Task? task}) ");
    return DBHelper.insert(task);
  }

  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskListe.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void deleteTask(Task task) async {
    final tasks = await DBHelper.query();
    await DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }

  deleteAllTasks() async {
    final tasks = await DBHelper.query();
    await DBHelper.deleteAllTasks();
    getTasks();
  }
}
