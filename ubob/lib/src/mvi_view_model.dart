import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:ubob/src/mvi_action.dart';
import 'package:ubob/src/mvi_result.dart';
import 'package:ubob/src/mvi_view_state.dart';

abstract class MviViewModel<A extends MviAction, R extends MviResult, VS extends MviViewState<R>>  {
  final StreamTransformer<A, R> _actionProcessor;
  final VS _defaultViewState;
  CompositeSubscription _disposables;
  PublishSubject _actionSource = PublishSubject<A>();
  Observable<VS> _viewStateObservable;

  MviViewModel(this._actionProcessor, this._defaultViewState);

  initViewStatesObservable(VS savedViewState) {
    // TODO implement this
  }

  getViewStatesObservable() {
    // TODO implement this
    if(_viewStateObservable == null) {
      //_viewStateObservable = _actionSource
    }
  }

  processActions(final Observable<A> actionsObservable) {
    // TODO implement this
  }

  clear() {
    _disposables.clear();
    _actionSource.close();
  }

}