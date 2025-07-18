import '../entities/activity_entity.dart';

abstract class ActivityRepository {
  Future<List<ActivityEntity>> getUserActivities();
  Future<List<ActivityEntity>> getActivitiesByType(String type);
  Future<List<ActivityEntity>> getActivitiesByDateRange(DateTime start, DateTime end);
  Future<ActivityEntity> getActivityById(String id);
  Future<void> markActivityAsRead(String id);
} 