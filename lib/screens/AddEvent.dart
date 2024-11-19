import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../bloc/Event_bloc.dart';
import '../models/Event_model.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();
  final Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Event'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Event Name or Title",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Description",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Location",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                                initialDate: DateTime.now())
                            .then((value) {
                          setState(() {
                            _dateController.text = value.toString();
                          });
                        });
                      },
                      icon: const Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.black,
                      )),
                  border: const OutlineInputBorder(),
                  hintText: "Date",
                ),
              ),
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    final String name = _nameController.text;
                    final String description = _descriptionController.text;
                    final String location = _locationController.text;
                    final String date = _dateController.text;

                    final Event event = Event(
                      id: uuid.v1(),
                      name: name,
                      description: description,
                      location: location,
                      date: DateTime.parse(date),
                      createdBy: "User",
                    );
                    eventBloc.addEvent(event);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Event added successfully"),
                    ));
                    eventBloc.fetchEvents();
                    Navigator.pop(context);
                    // Replace with the actual user ID
                  },
                  child: const Text("Add Event"))
            ],
          ),
        ));
  }
}
