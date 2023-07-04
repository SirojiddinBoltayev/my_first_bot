import 'dart:async';

class StreamButton {
  final streamController = StreamController<bool>();

  Sink<bool> get dataSink => streamController.sink;

  Stream<bool> get dataStream => streamController.stream;
}
