class Event {
  String? id; // Unique identifier for the event
  String name; // Name of the event
  String description; // Description of the event
  DateTime date; // Date of the event
  String location; // Location of the event
  String createdBy; // User ID of the event creator

  Event({
    this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.createdBy,
  });

  // Convert Firebase snapshot (Map) to Event object
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      date: DateTime.parse(map['date']),
      location: map['location'] ?? '',
      createdBy: map['createdBy'] ?? '',
    );
  }

  // Convert Event object to a Map (for Firebase storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'createdBy': createdBy,
    };
  }
}
