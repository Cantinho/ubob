import 'dart:async';

class DuplicateTransformer<S, T> implements StreamTransformer<S, T> {
  StreamController _controller;

  StreamSubscription _subscription;

  bool cancelOnError;

  // Original Stream
  Stream<S> _stream;

  DuplicateTransformer({bool sync: false, this.cancelOnError}) {
    _controller = new StreamController<T>(onListen: _onListen, onCancel: _onCancel, onPause: () {
      _subscription.pause();
    }, onResume: () {
      _subscription.resume();
    }, sync: sync);
  }

  DuplicateTransformer.broadcast({bool sync: false, bool this.cancelOnError}) {
    _controller = new StreamController<T>.broadcast(onListen: _onListen, onCancel: _onCancel, sync: sync);
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

  /**
   * Transformation
   */

  void onData(S data) {
    _controller.add(data);
    _controller.add(data); /* DUPLICATE EXAMPLE!! REMOVE FOR YOUR OWN IMPLEMENTATION!! */
  }

  /**
   * Bind
   */

  Stream<T> bind(Stream<S> stream) {
    this._stream = stream;
    return _controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() {
    return StreamTransformer.castFrom(this);
  }
}

void main() {
  // Create StreamController
  StreamController controller = new StreamController.broadcast();
  // Transform
  Stream s = controller.stream.transform(new DuplicateTransformer.broadcast());

  s.listen((data) {
    print('data: $data');
  }).cancel();

  s.listen((data) {
    print('data2: $data');
  }).cancel();

  s.listen((data) {
    print('data3: $data');
  });

  // Simulate data

  controller.add(1);
  controller.add(2);
  controller.add(3);

  controller.close();
}