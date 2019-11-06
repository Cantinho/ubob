import 'package:ubob/src/mvi_result.dart';

class HomeResult extends MviResult {

  HomeResult._();
}

class InProgressResult extends HomeResult {

  InProgressResult(): super._();
}

class ErrorResult extends HomeResult {
  final String error;

  ErrorResult(this.error): super._();
}

class LoadTasksResult extends HomeResult {
  final List<String> tasks;

  LoadTasksResult(this.tasks): super._();
}

class AddTaskResult extends HomeResult {
  final String addedTask;

  AddTaskResult(this.addedTask): super._();
}

class UpdateTaskResult extends HomeResult {
  final String updatedTask;

  UpdateTaskResult(this.updatedTask): super._();
}

class DeleteCompletedTaskResults extends HomeResult {
  final List<String> deletedTasks;

  DeleteCompletedTaskResults(this.deletedTasks): super._();
}