import 'package:rxdart/rxdart.dart';
import 'package:ubob/example/components/home/mvi/home_action.dart';
import 'package:ubob/example/components/home/mvi/home_result.dart';
import 'package:ubob/src/mvi_action_processor.dart';

class HomeActionProcessor extends MviActionsProcessor<HomeAction, HomeResult> {

  @override
  List<Observable<HomeResult>> getActionProcessors(Observable<HomeAction> shared) {
    final list = [
      connect(shared, loadTasksActionProcessor),
      connect(shared, addTaskActionProcessor),
      connect(shared, updateTasksActionProcessor)
    ];
    return list;
  }


  // Each processor responds with a proper Result for a particular Action.
  // Operator switchMap(...) is used to cancel processing and start a new one,
  // if the new Action will be emitted during processing the previous one.
  // ActionProcessor is the place where business logic should be implemented
  // and it is the place where interactions with the data layer should take place.
  // If an application is using UseCases as a business logic implementation
  // then those UseCases should be executed here.

  SwitchMapStreamTransformer<HomeAction,
      HomeResult> loadTasksActionProcessor = SwitchMapStreamTransformer(
          (action) {
        final tasksResult = [];
        return Observable.just(LoadTasksResult(tasksResult));
      }
  );

  SwitchMapStreamTransformer<HomeAction,
      HomeResult> addTaskActionProcessor = SwitchMapStreamTransformer(
          (action) {
        final String taskContent = "this is a content";
        return Observable.just(AddTaskResult(taskContent));
      }
  );

  SwitchMapStreamTransformer<HomeAction,
      HomeResult> updateTasksActionProcessor = SwitchMapStreamTransformer(
          (action) {
        final updatedTask = "task has a new content";
        return Observable.just(UpdateTaskResult(updatedTask));
      }
  );

}