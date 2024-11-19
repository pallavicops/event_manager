import 'dart:async';

import '../models/Event_model.dart';
import '../services/FirebaseDB_services.dart';

class EventBloc {
  final _eventController = StreamController<List<Event>>();
  Stream<List<Event>> get events => _eventController.stream;

  final _eventServices = EventServices();

  void fetchEvents() {
    _eventServices
        .fetchAllEvents()
        .then((events) => _eventController.sink.add(events));
  }

  void addEvent(Event event) {
    _eventServices.addEvent(event);
  }
}

final eventBloc = EventBloc();
