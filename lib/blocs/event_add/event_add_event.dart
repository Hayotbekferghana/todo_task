part of 'event_add_bloc.dart';

abstract class EventAddEvent {}

class EventTimeSelected extends EventAddEvent {
  EventTimeSelected(
      {required this.first,
      required this.second,
      required this.dateForScreen,
      required this.day});

  final String first;
  final String second;
  final String dateForScreen;
  final String day;
}

class EventNameChanged extends EventAddEvent {
  EventNameChanged({required this.name});
  final String name;
}

class EventDescriptionChanged extends EventAddEvent {
  EventDescriptionChanged({required this.description});
  final String description;
}

class ColorSelected extends EventAddEvent {
  ColorSelected({required this.color});
  final int color;
}

class EventLocationSelected extends EventAddEvent {
  EventLocationSelected({required this.location});
  final String location;
}

class EventSubmitted extends EventAddEvent {
  EventSubmitted({required this.isEdited, required this.context});
  final BuildContext context;
  final bool isEdited;
}
