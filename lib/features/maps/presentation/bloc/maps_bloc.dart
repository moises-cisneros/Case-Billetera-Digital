import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:case_digital_wallet/features/maps/domain/entities/map_entity.dart';
import 'package:case_digital_wallet/features/maps/domain/repositories/maps_repository.dart';

// Events
abstract class MapsEvent extends Equatable {
  const MapsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNearbyLocations extends MapsEvent {
  final double latitude;
  final double longitude;
  final double radius;

  const LoadNearbyLocations({
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  @override
  List<Object?> get props => [latitude, longitude, radius];
}

class FilterLocationsByType extends MapsEvent {
  final String type;
  final double latitude;
  final double longitude;

  const FilterLocationsByType({
    required this.type,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [type, latitude, longitude];
}

class SearchLocations extends MapsEvent {
  final String query;
  final double latitude;
  final double longitude;

  const SearchLocations({
    required this.query,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [query, latitude, longitude];
}

// States
abstract class MapsState extends Equatable {
  const MapsState();

  @override
  List<Object?> get props => [];
}

class MapsInitial extends MapsState {}

class MapsLoading extends MapsState {}

class MapsLoaded extends MapsState {
  final List<MapLocationEntity> locations;

  const MapsLoaded(this.locations);

  @override
  List<Object?> get props => [locations];
}

class MapsError extends MapsState {
  final String message;

  const MapsError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final MapsRepository repository;

  MapsBloc({required this.repository}) : super(MapsInitial()) {
    on<LoadNearbyLocations>(_onLoadNearbyLocations);
    on<FilterLocationsByType>(_onFilterLocationsByType);
    on<SearchLocations>(_onSearchLocations);
  }

  Future<void> _onLoadNearbyLocations(
    LoadNearbyLocations event,
    Emitter<MapsState> emit,
  ) async {
    emit(MapsLoading());
    try {
      final locations = await repository.getNearbyLocations(
        event.latitude,
        event.longitude,
        event.radius,
      );
      emit(MapsLoaded(locations));
    } catch (e) {
      emit(MapsError(e.toString()));
    }
  }

  Future<void> _onFilterLocationsByType(
    FilterLocationsByType event,
    Emitter<MapsState> emit,
  ) async {
    emit(MapsLoading());
    try {
      final locations = await repository.filterLocationsByType(
        event.type,
        event.latitude,
        event.longitude,
      );
      emit(MapsLoaded(locations));
    } catch (e) {
      emit(MapsError(e.toString()));
    }
  }

  Future<void> _onSearchLocations(
    SearchLocations event,
    Emitter<MapsState> emit,
  ) async {
    emit(MapsLoading());
    try {
      final locations = await repository.searchLocations(
        event.query,
        event.latitude,
        event.longitude,
      );
      emit(MapsLoaded(locations));
    } catch (e) {
      emit(MapsError(e.toString()));
    }
  }
} 