import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/activity_entity.dart';
import '../../domain/usecases/get_user_activities_usecase.dart';

// Events
abstract class ActivityEvent {}

class LoadUserActivities extends ActivityEvent {}

class FilterActivitiesByType extends ActivityEvent {
  final String type;
  FilterActivitiesByType(this.type);
}

class FilterActivitiesByDateRange extends ActivityEvent {
  final DateTime start;
  final DateTime end;
  FilterActivitiesByDateRange({required this.start, required this.end});
}

// States
abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final List<ActivityEntity> activities;
  ActivityLoaded(this.activities);
}

class ActivityError extends ActivityState {
  final String message;
  ActivityError(this.message);
}

// Bloc
class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final GetUserActivitiesUseCase getUserActivitiesUseCase;

  ActivityBloc({
    required this.getUserActivitiesUseCase,
  }) : super(ActivityInitial()) {
    on<LoadUserActivities>(_onLoadUserActivities);
    on<FilterActivitiesByType>(_onFilterActivitiesByType);
    on<FilterActivitiesByDateRange>(_onFilterActivitiesByDateRange);
  }

  Future<void> _onLoadUserActivities(
    LoadUserActivities event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());
    try {
      final activities = await getUserActivitiesUseCase();
      emit(ActivityLoaded(activities));
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }

  Future<void> _onFilterActivitiesByType(
    FilterActivitiesByType event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());
    try {
      final allActivities = await getUserActivitiesUseCase();
      final filteredActivities = allActivities
          .where((activity) => activity.type == event.type)
          .toList();
      emit(ActivityLoaded(filteredActivities));
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }

  Future<void> _onFilterActivitiesByDateRange(
    FilterActivitiesByDateRange event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());
    try {
      final allActivities = await getUserActivitiesUseCase();
      final filteredActivities = allActivities
          .where((activity) => 
              activity.timestamp.isAfter(event.start) && 
              activity.timestamp.isBefore(event.end))
          .toList();
      emit(ActivityLoaded(filteredActivities));
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }
} 