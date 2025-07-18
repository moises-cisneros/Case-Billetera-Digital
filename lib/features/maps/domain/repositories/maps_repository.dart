import 'package:case_digital_wallet/features/maps/domain/entities/map_entity.dart';

abstract class MapsRepository {
  Future<List<MapLocationEntity>> getNearbyLocations(double latitude, double longitude, double radius);
  Future<List<P2PAtmEntity>> getNearbyP2PAtms(double latitude, double longitude, double radius);
  Future<List<CryptoPaymentLocationEntity>> getNearbyCryptoPaymentLocations(double latitude, double longitude, double radius);
  Future<MapLocationEntity> getLocationDetails(String locationId);
  Future<bool> addNewLocation(MapLocationEntity location);
  Future<bool> reportLocation(String locationId, String reason);
  Future<List<MapLocationEntity>> searchLocations(String query, double latitude, double longitude);
  Future<List<MapLocationEntity>> filterLocationsByType(String type, double latitude, double longitude);
  Future<List<MapLocationEntity>> filterLocationsByCrypto(String crypto, double latitude, double longitude);
} 