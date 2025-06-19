import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

class LoadActivitiesRequested extends ActivityEvent {}

class FilterActivitiesRequested extends ActivityEvent {
  final String filterType;

  const FilterActivitiesRequested(this.filterType);

  @override
  List<Object> get props => [filterType];
}

// States
abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object?> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final List<ActivityItem> activities;

  const ActivityLoaded(this.activities);

  @override
  List<Object> get props => [activities];
}

class ActivityError extends ActivityState {
  final String message;

  const ActivityError(this.message);

  @override
  List<Object> get props => [message];
}

// Models
class ActivityItem extends Equatable {
  final String id;
  final String type;
  final String description;
  final double amount;
  final DateTime date;
  final String status;

  const ActivityItem({
    required this.id,
    required this.type,
    required this.description,
    required this.amount,
    required this.date,
    required this.status,
  });

  @override
  List<Object> get props => [id, type, description, amount, date, status];
}

// Bloc
class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityInitial()) {
    on<LoadActivitiesRequested>(_onLoadActivitiesRequested);
    on<FilterActivitiesRequested>(_onFilterActivitiesRequested);
  }

  Future<void> _onLoadActivitiesRequested(
    LoadActivitiesRequested event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());
    try {
      // Aquí iría la lógica para cargar las actividades desde el repositorio
      final activities = [
        ActivityItem(
          id: '1',
          type: 'deposit',
          description: 'Depósito bancario',
          amount: 500.0,
          date: DateTime.now(),
          status: 'completed',
        ),
        ActivityItem(
          id: '2',
          type: 'transfer',
          description: 'Envío a Juan Pérez',
          amount: -200.0,
          date: DateTime.now().subtract(const Duration(hours: 2)),
          status: 'completed',
        ),
      ];

      emit(ActivityLoaded(activities));
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }

  Future<void> _onFilterActivitiesRequested(
    FilterActivitiesRequested event,
    Emitter<ActivityState> emit,
  ) async {
    if (state is ActivityLoaded) {
      final currentActivities = (state as ActivityLoaded).activities;
      final filteredActivities = currentActivities
          .where((activity) => activity.type == event.filterType)
          .toList();

      emit(ActivityLoaded(filteredActivities));
    }
  }
}
