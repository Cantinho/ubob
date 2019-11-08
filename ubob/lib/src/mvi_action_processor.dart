import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:ubob/src/mvi_action.dart';
import 'package:ubob/src/mvi_result.dart';

abstract class MviActionsProcessor<A extends MviAction, R extends MviResult> {


  List<Observable<R>> getActionProcessors(Observable<A> shared);

  Observable<R> connect(final Observable<A> shared, final SwitchMapStreamTransformer<A, R> streamTransformer) {
    return shared.transform(streamTransformer);
  }

}

