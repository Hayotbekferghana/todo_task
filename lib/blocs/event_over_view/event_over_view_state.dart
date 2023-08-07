part of 'event_over_view_bloc.dart';

class EventOverViewState extends Equatable {
  const EventOverViewState({
    this.status = OverviewStatus.initial,
    this.events = const [],
    this.allEvents = const [],
    this.selectedDate,
    this.message,
  });
  final OverviewStatus status;
  final List<Event> events;
  final DateTime? selectedDate;
  final String? message;
  final List<Event> allEvents;
  copyWith(
          {OverviewStatus? status,
          List<Event>? events,
          DateTime? selectedDate,
          String? message,
          List<Event>? allEvents}) =>
      EventOverViewState(
          status: status ?? this.status,
          selectedDate: selectedDate ?? this.selectedDate,
          events: events ?? this.events,
          message: message ?? this.message,
          allEvents: allEvents ?? this.allEvents);
  @override
  List<Object?> get props => [
        status,
        events,
        selectedDate,
        message,
        allEvents,
      ];
}

enum OverviewStatus {
  initial,
  loading,
  loaded,
  edited,
  deleted,
  added,
  failure
}
