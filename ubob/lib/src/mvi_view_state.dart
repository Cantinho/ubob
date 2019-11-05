import 'package:ubob/src/mvi_result.dart';

abstract class MviViewState<R extends MviResult> {

  MviViewState<R> reduce(R result);
  bool isSavable();

}