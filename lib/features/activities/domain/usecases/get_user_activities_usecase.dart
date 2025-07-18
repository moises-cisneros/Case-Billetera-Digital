import '../entities/activity_entity.dart';
import '../repositories/activity_repository.dart';

class GetUserActivitiesUseCase {
  final ActivityRepository repository;

  GetUserActivitiesUseCase(this.repository);

  Future<List<ActivityEntity>> call() async {
    return await repository.getUserActivities();
  }
} 