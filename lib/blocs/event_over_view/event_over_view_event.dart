part of 'event_over_view_bloc.dart';

abstract class EventOverViewEvent {
  const EventOverViewEvent();
}

class EventAdded extends EventOverViewEvent {
  EventAdded({required this.event});
  final Event event;
}

class EventEdited extends EventOverViewEvent {
  EventEdited({required this.event, required this.id});
  final int id;
  final Event event;
}

class EventDeleted extends EventOverViewEvent {
  EventDeleted({required this.event});
  final Event event;
}

class EventsLoaded extends EventOverViewEvent {
  EventsLoaded({required this.date});
  final DateTime date;
}
