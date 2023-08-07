part of 'event_add_bloc.dart';

class EventAddState extends Equatable {
  const EventAddState(
      {this.name,
      this.description,
      this.location,
      this.firstDate,
      this.secondDate,
      this.color,
      this.dateForScreen,
      this.day,
      this.eventId,
      this.status = AddingStatus.initial});

  final String? firstDate;
  final String? secondDate;
  final String? day;
  final String? name;
  final String? description;
  final String? location;
  final int? color;
  final AddingStatus status;
  final String? dateForScreen;
  final int? eventId;

  EventAddState copyWith({
    String? firstDate,
    String? secondDate,
    String? name,
    String? description,
    String? location,
    int? color,
    AddingStatus? status,
    String? dateForScreen,
    String? day,
  }) =>
      EventAddState(
          firstDate: firstDate ?? this.firstDate,
          secondDate: secondDate ?? this.secondDate,
          color: color ?? this.color,
          description: description ?? this.description,
          location: location ?? this.location,
          name: name ?? this.name,
          status: status ?? this.status,
          dateForScreen: dateForScreen ?? this.dateForScreen,
          eventId: eventId,
          day: day ?? this.day);
  bool get isComplete =>
      (name != null && name!.isNotEmpty) &&
      (description != null && description!.isNotEmpty) &&
      color != null &&
      (firstDate != null && firstDate!.isNotEmpty) &&
      (secondDate != null && secondDate!.isNotEmpty) &&
      (dateForScreen != null && dateForScreen!.isNotEmpty) &&
      day != null;

  @override
  List<Object?> get props => [
        name,
        description,
        location,
        firstDate,
        secondDate,
        color,
        dateForScreen,
        isComplete,
        status,
        eventId,
        day,
      ];
}

enum AddingStatus { initial, added, edited, failure }
