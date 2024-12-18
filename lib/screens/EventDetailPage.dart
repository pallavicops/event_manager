import 'package:event_manager/bloc/Event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Event_model.dart';
import 'EventDetailUpdate.dart';

class EventDetailPage extends StatefulWidget {
  final event;
  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  final EventBloc eventBlocInner = EventBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventBlocInner.fetchEvent(widget.event.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Event Detail"),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: StreamBuilder(
            stream: eventBlocInner.eventDetail,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final event = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Event Name or Title",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {
                            final textEditingController =
                                TextEditingController(text: event.name);
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                              ),
                              isScrollControlled: true,
                              builder: (_) => EventDetailUpdate(
                                title: 'Event Name or Title',
                                editingController: textEditingController,
                                keyboardType: TextInputType.text,
                              ),
                            ).then((value) {
                              final newName = textEditingController.text;
                              if (newName.isNotEmpty) {
                                eventBlocInner.updateEventName(
                                    event.id!, newName);
                                eventBlocInner.fetchEvent(event.id!);
                                eventBloc.fetchEvents();
                              }
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    Text(
                      event.name,
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Event Description",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {
                            final textEditingController =
                                TextEditingController(text: event.description);
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                              ),
                              isScrollControlled: true,
                              builder: (_) => EventDetailUpdate(
                                title: 'Event Description',
                                editingController: textEditingController,
                                keyboardType: TextInputType.text,
                              ),
                            ).then((value) {
                              final newDescription = textEditingController.text;
                              if (newDescription.isNotEmpty) {
                                eventBlocInner.updateEventDescription(
                                    event.id!, newDescription);
                                eventBlocInner.fetchEvent(event.id!);
                              }
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    Text(
                      event.description,
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Event Date",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(event.date),
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Event Location",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {
                            final textEditingController =
                                TextEditingController(text: event.location);
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                              ),
                              isScrollControlled: true,
                              builder: (_) => EventDetailUpdate(
                                title: 'Event Location',
                                editingController: textEditingController,
                                keyboardType: TextInputType.text,
                              ),
                            ).then((value) {
                              final newLocation = textEditingController.text;
                              if (newLocation.isNotEmpty) {
                                eventBlocInner.updateEventLocation(
                                    event.id!, newLocation);
                                eventBlocInner.fetchEvent(event.id!);
                              }
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    Text(
                      event.location,
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              );
            }));
  }
}
