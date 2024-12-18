import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/Event_model.dart';
import 'Auth_services.dart';

class EventServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  /// Adds a new event to the authenticated user's event list.
  Future<void> addEvent(Event event) async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("User not authenticated.");
      }

      final DatabaseReference userEventsRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(currentUser.uid)
          .child('events');

      await userEventsRef.child(event.id!).set(event.toMap());
      print("Event added successfully: ${event.id}");
    } catch (e) {
      print("Failed to add event: $e");
      rethrow;
    }
  }

  /// Fetches all events for the currently authenticated user.
  Future<List<Event>> fetchAllEvents() async {
    try {
      // Ensure the user is authenticated
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception("User not authenticated.");
      }

      // Define the user's events path
      final String userEventsPath = 'users/${currentUser.uid}/events';

      // Retrieve the events snapshot
      final DataSnapshot snapshot = await _database.child(userEventsPath).get();

      if (!snapshot.exists || snapshot.value == null) {
        return []; // Return an empty list if no events are found
      }

      // Safely handle the dynamic map structure
      final Map<dynamic, dynamic> rawData =
          snapshot.value as Map<dynamic, dynamic>;

      final List<Event> events = rawData.entries.map((entry) {
        final eventMap = Map<String, dynamic>.from(entry.value);
        return Event.fromMap(eventMap);
      }).toList();

      print("Fetched ${events.length} events for user: ${currentUser.uid}");
      return events;
    } catch (e) {
      print("Failed to fetch events: $e");
      rethrow; // Re-throw for additional error handling
    }
  }

  //fetch a single event
  Future<Event?> fetchEvent(String eventId) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not authenticated.");
    }

    final DatabaseReference userEventsRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(currentUser.uid)
        .child('events');

    final DataSnapshot snapshot = await userEventsRef.child(eventId).get();
    if (!snapshot.exists || snapshot.value == null) {
      return null;
    }

    try {
      final eventMap = Map<String, dynamic>.from(
        snapshot.value
            as Map<dynamic, dynamic>, // Safely cast to `Map<dynamic, dynamic>`
      );
      return Event.fromMap(eventMap);
    } catch (e) {
      print("Error parsing event data: $e");
      return null; // Return null if parsing fails
    }
  }

  //method for deleting an event
  Future<void> deleteEvent(String eventId) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception("User not authenticated.");
      }

      final DatabaseReference userEventsRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(currentUser.uid)
          .child('events');

      await userEventsRef.child(eventId).remove();
      print("Event deleted successfully: $eventId");
    } catch (e) {
      print("Failed to delete event: $e");
      rethrow;
    }
  }

  //method for updating event name
  Future<void> updateEventName(String eventId, String newName) async {
    final User? currentUser = _auth.currentUser;

    final DatabaseReference userEventsRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(currentUser!.uid)
        .child('events');

    await userEventsRef.child(eventId).update({'name': newName});
    print("Event name updated successfully: $eventId");
  }

  //method for updating event description
  Future<void> updateEventDescription(
      String eventId, String newDescription) async {
    final User? currentUser = _auth.currentUser;

    final DatabaseReference userEventsRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(currentUser!.uid)
        .child('events');

    await userEventsRef.child(eventId).update({'description': newDescription});
    print("Event description updated successfully: $eventId");
  }

//method for updating event location
  Future<void> updateEventLocation(String eventId, String newLocation) async {
    final User? currentUser = _auth.currentUser;

    final DatabaseReference userEventsRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(currentUser!.uid)
        .child('events');

    await userEventsRef.child(eventId).update({'location': newLocation});
    print("Event location updated successfully: $eventId");
  }

  //method for updating event date
  Future<void> updateEventDate(String eventId, DateTime newDate) async {
    final User? currentUser = _auth.currentUser;

    final DatabaseReference userEventsRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(currentUser!.uid)
        .child('events');

    await userEventsRef.child(eventId).update({'date': newDate.toString()});
    print("Event date updated successfully: $eventId");
  }
}
