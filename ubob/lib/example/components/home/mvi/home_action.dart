import 'package:ubob/src/mvi_action.dart';

class HomeAction extends MviAction {

  HomeAction._();

}

class LoadTaskAction extends HomeAction {
  LoadTaskAction():super._();
}

class AddTaskAction extends HomeAction {
  final String taskContent;

  AddTaskAction(final this.taskContent):super._();
}

class UpdateTaskAction extends HomeAction {
  final int taskId;
  final bool isDone;

  UpdateTaskAction(this.taskId, this.isDone): super._();
}

class DeleteCompletedTaskAction extends HomeAction {

  DeleteCompletedTaskAction():super._();
}
