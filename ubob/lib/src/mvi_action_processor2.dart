import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/transformers.dart';
import 'package:ubob/src/mvi_action.dart';
import 'package:ubob/src/mvi_result.dart';

abstract class MviActionProcessor<A extends MviAction, R extends MviResult> implements StreamTransformer<A, R> {

  StreamController _controller;

  StreamSubscription _subscription;

  bool cancelOnError;

  // Original Stream
  Stream<A> _stream;

  MviActionProcessor({bool sync: false, this.cancelOnError}) {
    _controller = new StreamController<R>(onListen: _onListen,
        onCancel: _onCancel,
        onPause: () {
          _subscription.pause();
        },
        onResume: () {
          _subscription.resume();
        },
        sync: sync);
  }

  MviActionProcessor.broadcast({bool sync: false, bool this.cancelOnError}) {
    _controller = new StreamController<R>.broadcast(
        onListen: _onListen, onCancel: _onCancel, sync: sync);
  }

  void _onListen() {
    _subscription = _stream.listen(onData,
        onError: _controller.addError,
        onDone: _controller.close,
        cancelOnError: cancelOnError);
  }

  void _onCancel() {
    _subscription.cancel();
    _subscription = null;
  }

  ///Transformation
  void onData(A data) {
    _controller.add(data);
  }

  /// Bind
  Stream<R> bind(Stream<A> stream) {
    this._stream = stream;
    return _controller.stream;
  }

  Stream<R> _apply(Stream<A> actions) {
    return Observable.merge(getActionProcessors(actions));
  }

  List<Stream<R>> getActionProcessors(Stream<A> shared);


  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);

  Stream<R> connect(final Stream<A> shared, final SwitchMapStreamTransformer<A, R> streamTransformer) {
    return shared.transform(streamTransformer);
  }

}