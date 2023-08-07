import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/data/local_storage/local_storage.dart';
import 'package:todo_task/data/models/event_model.dart';
part 'event_over_view_event.dart';
part 'event_over_view_state.dart';

class EventOverViewBloc extends Bloc<EventOverViewEvent, EventOverViewState> {
  EventOverViewBloc() : super(const EventOverViewState()) {
    on<EventOverViewEvent>(_onEvent, transformer: sequential());
  }
  _onEvent(
    EventOverViewEvent event,
    Emitter<EventOverViewState> emit,
  ) {
    if (event is EventsLoaded) return _onEventsLoaded(event, emit);
    if (event is EventAdded) return _onEventAdded(event, emit);
    if (event is EventEdited) return _onEventEdited(event, emit);
    if (event is EventDeleted) return _onEventDeleted(event, emit);
  }

  _onEventsLoaded(EventsLoaded event, Emitter<EventOverViewState> emit) async {
    try {
      final events =
          await LocalStorage.getAllEvents(date: event.date.toIso8601String());
      final allEvents = await LocalStorage.getAllEvents();
      if (events.isEmpty) {
        emit(state.copyWith(
            events: events,
            allEvents: allEvents,
            selectedDate: event.date,
            status: OverviewStatus.failure,
            message: "Events not found"));
      } else {
        emit(state.copyWith(
          events: events,
          allEvents: allEvents,
          selectedDate: event.date,
          status: OverviewStatus.loaded,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          status: OverviewStatus.failure, message: e.toString()));
    }
  }

  _onEventAdded(EventAdded event, Emitter<EventOverViewState> emit) async {
    try {
      await LocalStorage.insertEvent(event.event);
      emit(state.copyWith(
          status: OverviewStatus.added,
          allEvents: List.of(state.allEvents)..add(event.event),
          message: "Event Added!"));
    } catch (e) {
      emit(state.copyWith(
          status: OverviewStatus.failure, message: e.toString()));
    }
  }

  _onEventEdited(EventEdited event, Emitter<EventOverViewState> emit) async {
    try {
      await LocalStorage.editEvent(event.event, event.id).then((value) async {
        emit(
          state.copyWith(
              status: OverviewStatus.edited,
              message: "Event Edited!",
              allEvents: await LocalStorage.getAllEvents(),
              events: await LocalStorage.getAllEvents(date: event.event.day)),
        );
      });
    } catch (e) {
      emit(state.copyWith(
          status: OverviewStatus.failure, message: e.toString()));
    }
  }

  _onEventDeleted(EventDeleted event, Emitter<EventOverViewState> emit) async {
    try {
      await LocalStorage.deleteEventById(event.event.id!);
      emit(state.copyWith(
          // status: OverviewStatus.deleted,
          allEvents: List.of(state.allEvents)..remove(event.event),
          events: List.of(state.events)..remove(event.event)));
    } catch (e) {
      emit(state.copyWith(
          status: OverviewStatus.failure, message: e.toString()));
    }
  }
}
