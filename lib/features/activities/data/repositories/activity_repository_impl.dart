import '../../domain/entities/activity_entity.dart';
import '../../domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  @override
  Future<List<ActivityEntity>> getUserActivities() async {
    // Mock activities - in real app this would come from API
    await Future.delayed(const Duration(milliseconds: 800));
    
    return [
      ActivityEntity(
        id: 'act_1',
        type: 'payment',
        title: 'Pago a María García',
        description: 'Transferencia por servicios',
        amount: 150.00,
        currency: 'BS',
        status: 'completed',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        recipientId: 'user_456',
        recipientName: 'María García',
        senderId: 'user_123',
        senderName: 'Juan Pérez',
      ),
      ActivityEntity(
        id: 'act_2',
        type: 'deposit',
        title: 'Depósito desde Banco Nacional',
        description: 'Transferencia bancaria',
        amount: 500.00,
        currency: 'BS',
        status: 'completed',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        senderId: 'bank_nacional',
        senderName: 'Banco Nacional',
      ),
      ActivityEntity(
        id: 'act_3',
        type: 'crypto',
        title: 'Compra de USDT',
        description: 'Resguardo en crypto',
        amount: 200.00,
        currency: 'BS',
        status: 'completed',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        metadata: {'crypto_amount': 28.57, 'crypto_currency': 'USDT'},
      ),
      ActivityEntity(
        id: 'act_4',
        type: 'withdrawal',
        title: 'Retiro a cuenta bancaria',
        description: 'Transferencia a Banco Mercantil',
        amount: 300.00,
        currency: 'BS',
        status: 'pending',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        recipientId: 'bank_mercantil',
        recipientName: 'Banco Mercantil',
      ),
      ActivityEntity(
        id: 'act_5',
        type: 'transfer',
        title: 'Envío a Carlos López',
        description: 'Pago por comida',
        amount: 75.50,
        currency: 'BS',
        status: 'completed',
        timestamp: DateTime.now().subtract(const Duration(days: 4)),
        recipientId: 'user_789',
        recipientName: 'Carlos López',
        senderId: 'user_123',
        senderName: 'Juan Pérez',
      ),
      ActivityEntity(
        id: 'act_6',
        type: 'crypto',
        title: 'Venta de USDT',
        description: 'Conversión a bolivianos',
        amount: 100.00,
        currency: 'BS',
        status: 'completed',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        metadata: {'crypto_amount': 14.29, 'crypto_currency': 'USDT'},
      ),
    ];
  }

  @override
  Future<List<ActivityEntity>> getActivitiesByType(String type) async {
    final allActivities = await getUserActivities();
    return allActivities.where((activity) => activity.type == type).toList();
  }

  @override
  Future<List<ActivityEntity>> getActivitiesByDateRange(DateTime start, DateTime end) async {
    final allActivities = await getUserActivities();
    return allActivities.where((activity) => 
      activity.timestamp.isAfter(start) && activity.timestamp.isBefore(end)
    ).toList();
  }

  @override
  Future<ActivityEntity> getActivityById(String id) async {
    final allActivities = await getUserActivities();
    return allActivities.firstWhere((activity) => activity.id == id);
  }

  @override
  Future<void> markActivityAsRead(String id) async {
    // Mock implementation - in real app this would update on server
    await Future.delayed(const Duration(milliseconds: 300));
  }
} 