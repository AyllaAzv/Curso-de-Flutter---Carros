import 'dart:async';
import 'package:provider/provider.dart';

class Event {
  
}

class EventBus {
  final _streamController = StreamController<Event>.broadcast();

  Stream<Event> get stream => _streamController.stream;

  static EventBus get(context) => Provider.of<EventBus>(context, listen: false);

  sendEvent(Event event) {
    _streamController.add(event);
  }

  dispose() {
    _streamController.close();
  }
}
