import 'dart:async';

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class CounterBloc {
  int _value = 0;

  // event stream controller
  final StreamController<CounterEvent> _eventController =
      StreamController<CounterEvent>();

  // sink event untuk jalur masuk
  StreamSink<CounterEvent> get sinkEvent => _eventController.sink;

  // jalur keluar
  Stream<CounterEvent> get streamEvent => _eventController.stream;

  // state stream controller
  final StreamController<int> stateController = StreamController<int>();

  StreamSink<int> get sinkState => stateController.sink;

  Stream<int> get streamState => stateController.stream;

  void mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _value++;
    } else {
      _value--;
    }
    sinkState.add(_value);
  }
  
  // memasukkan data ke mapEventToState
  CounterBloc() {
    streamEvent.listen((event) {
      mapEventToState(event);
    });
  }

  void dispose() {
    _eventController.close();
    stateController.close();
  }
}
