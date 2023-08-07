import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/blocs/event_over_view/event_over_view_bloc.dart';
import 'package:todo_task/data/models/event_model.dart';
import 'package:todo_task/utils/time_utils.dart';

part 'event_add_event.dart';
part 'event_add_state.dart';

class EventAddBloc extends Bloc<EventAddEvent, EventAddState> {
  EventAddBloc({Event? event})
      : super(EventAddState(
          eventId: event?.id,
          name: event?.name,
          description: event?.description,
          location: event?.location,
          firstDate: event?.firstDate,
          secondDate: event?.secondDate,
          dateForScreen: event?.day != null
              ? DateTime.parse(event!.day).monthStart.toString()
              : null,
          color: event?.color,
          day: event?.day,
        )) {
    on<EventAddEvent>(_onEvent, transformer: sequential());
  }
  _onEvent(EventAddEvent event, Emitter<EventAddState> emit) {
    if (event is EventTimeSelected) return _onTimeSelected(event, emit);

    if (event is EventNameChanged) return _onNameSelected(event, emit);
    if (event is ColorSelected) return _onColorSelected(event, emit);
    if (event is EventSubmitted) return _onEventSubmitted(event, emit);
    if (event is EventLocationSelected) return _onLocationSelected(event, emit);
    if (event is EventDescriptionChanged) {
      return _onDescriptionSelected(event, emit);
    }
  }

  _onTimeSelected(EventTimeSelected event, Emitter<EventAddState> emit) =>
      emit(state.copyWith(
          firstDate: event.first,
          secondDate: event.second,
          dateForScreen: event.dateForScreen,
          day: event.day));

  _onNameSelected(EventNameChanged event, Emitter<EventAddState> emit) =>
      emit(state.copyWith(name: event.name));
  _onDescriptionSelected(
          EventDescriptionChanged event, Emitter<EventAddState> emit) =>
      emit(state.copyWith(description: event.description));
  _onColorSelected(ColorSelected event, Emitter<EventAddState> emit) =>
      emit(state.copyWith(color: event.color));
  _onLocationSelected(
          EventLocationSelected event, Emitter<EventAddState> emit) =>
      emit(state.copyWith(location: event.location));

  _onEventSubmitted(EventSubmitted event, Emitter<EventAddState> emit) async {
    try {
      if (event.isEdited) {
        event.context.read<EventOverViewBloc>().add(EventEdited(
              id: state.eventId!,
              event: Event(
                id: state.eventId,
                name: state.name!,
                description: state.description!,
                secondDate: state.secondDate!,
                firstDate: state.firstDate!,
                location: state.location ?? "",
                day: state.day!,
                color: state.color!,
              ),
            ));
      } else {
        event.context.read<EventOverViewBloc>().add(EventAdded(
              event: Event(
                name: state.name!,
                description: state.description!,
                secondDate: state.secondDate!,
                firstDate: state.firstDate!,
                location: state.location ?? "",
                day: state.day!,
                color: state.color!,
              ),
            ));
      }
      emit(state.copyWith(
          status: event.isEdited ? AddingStatus.edited : AddingStatus.added));
    } catch (e) {
      emit(state.copyWith(status: AddingStatus.failure));
    }
  }
}
