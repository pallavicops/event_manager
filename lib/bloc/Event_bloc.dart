import 'dart:async';

import '../models/Event_model.dart';
import '../services/FirebaseDB_services.dart';

class EventBloc {
  final _eventController = StreamController<List<Event>>();
  Stream<List<Event>> get events => _eventController.stream;

  final _eventDetailController = StreamController<Event>();
  Stream<Event> get eventDetail => _eventDetailController.stream;

  final _eventServices = EventServices();

  void fetchEvents() async {
    await _eventServices
        .fetchAllEvents()
        .then((events) => _eventController.sink.add(events));
  }

  void fetchEvent(String eventId) {
    _eventServices
        .fetchEvent(eventId)
        .then((event) => _eventDetailController.sink.add(event!));
  }

  void addEvent(Event event) {
    _eventServices.addEvent(event);
  }

  void deleteEvent(String eventId) {
    _eventServices.deleteEvent(eventId);
  }

  void updateEventName(String eventId, String newName) {
    _eventServices.updateEventName(eventId, newName);
  }

  void updateEventDescription(String eventId, String newDescription) {
    _eventServices.updateEventDescription(eventId, newDescription);
  }

  void updateEventLocation(String eventId, String newLocation) {
    _eventServices.updateEventLocation(eventId, newLocation);
  }

  void updateEventDate(String eventId, DateTime newDate) {
    _eventServices.updateEventDate(eventId, newDate);
  }

  void dispose() {
    _eventController.close();
  }
}

final eventBloc = EventBloc();
