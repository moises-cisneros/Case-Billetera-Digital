import 'package:case_digital_wallet/features/maps/domain/entities/map_entity.dart';
import 'package:case_digital_wallet/features/maps/domain/repositories/maps_repository.dart';

class MapsRepositoryImpl implements MapsRepository {
  @override
  Future<List<MapLocationEntity>> getNearbyLocations(
    double latitude,
    double longitude,
    double radius,
  ) async {
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 800));

    // Datos mock de lugares de crypto en Santa Cruz, Bolivia
    return [
      // Cajeros P2P en Santa Cruz
      const MapLocationEntity(
        id: 'p2p_1',
        name: 'Cajero P2P - Ventura Mall',
        description:
            'Cajero automático P2P para compra y venta de criptomonedas',
        latitude: -17.7833,
        longitude: -63.1833,
        type: 'p2p_atm',
        acceptedCryptos: ['BTC', 'ETH', 'USDT', 'BNB'],
        rating: 4.5,
        reviewCount: 23,
        address: 'Av. San Martín, Santa Cruz',
        phone: '+591 3 1234567',
        website: 'https://venturamall.bo',
        isOpen: true,
        additionalInfo: {
          'verificationStatus': 'verified',
          'transactionCount': 89,
          'exchangeRate': 6.95,
          'fee': 2.0,
        },
      ),
      const MapLocationEntity(
        id: 'p2p_2',
        name: 'Cajero P2P - Plaza 24 de Septiembre',
        description: 'Cajero P2P con excelente reputación en el centro',
        latitude: -17.7867,
        longitude: -63.1817,
        type: 'p2p_atm',
        acceptedCryptos: ['BTC', 'ETH', 'USDT'],
        rating: 4.2,
        reviewCount: 45,
        address: 'Plaza 24 de Septiembre, Santa Cruz',
        phone: '+591 3 2345678',
        website: '',
        isOpen: true,
        additionalInfo: {
          'verificationStatus': 'verified',
          'transactionCount': 156,
          'exchangeRate': 6.93,
          'fee': 1.5,
        },
      ),

      // Casas de cambio
      const MapLocationEntity(
        id: 'exchange_1',
        name: 'Crypto Exchange Santa Cruz',
        description: 'Casa de cambio especializada en criptomonedas',
        latitude: -17.7850,
        longitude: -63.1820,
        type: 'exchange_office',
        acceptedCryptos: ['BTC', 'ETH', 'USDT', 'SOL', 'ADA'],
        rating: 4.7,
        reviewCount: 67,
        address: 'Calle Libertad 123, Santa Cruz',
        phone: '+591 3 3456789',
        website: 'https://cryptoexchangesc.bo',
        isOpen: true,
        additionalInfo: {
          'businessType': 'exchange',
          'minAmount': 50.0,
          'maxAmount': 5000.0,
        },
      ),
      const MapLocationEntity(
        id: 'exchange_2',
        name: 'Bitcoin House Santa Cruz',
        description: 'Oficina de intercambio Bitcoin con cajero',
        latitude: -17.7810,
        longitude: -63.1850,
        type: 'exchange_office',
        acceptedCryptos: ['BTC', 'ETH', 'USDT'],
        rating: 4.3,
        reviewCount: 34,
        address: 'Av. Monseñor Rivero, Santa Cruz',
        phone: '+591 3 4567890',
        website: 'https://bitcoinexchangesc.bo',
        isOpen: true,
        additionalInfo: {
          'businessType': 'exchange',
          'minAmount': 100.0,
          'maxAmount': 10000.0,
        },
      ),

      // Establecimientos que aceptan crypto
      const MapLocationEntity(
        id: 'crypto_1',
        name: 'Restaurante Crypto - El Patio',
        description: 'Restaurante gourmet que acepta pagos con criptomonedas',
        latitude: -17.7830,
        longitude: -63.1880,
        type: 'crypto_payment',
        acceptedCryptos: ['BTC', 'ETH', 'USDT'],
        rating: 4.6,
        reviewCount: 78,
        address: 'Calle Sucre 456, Santa Cruz',
        phone: '+591 3 5678901',
        website: 'https://elpatio.bo',
        isOpen: true,
        additionalInfo: {
          'businessType': 'restaurant',
          'minAmount': 20.0,
          'maxAmount': 2000.0,
        },
      ),
      const MapLocationEntity(
        id: 'crypto_2',
        name: 'Café Bitcoin - Coffee & Crypto SC',
        description:
            'Café que acepta pagos con Bitcoin, USDT y otras criptomonedas',
        latitude: -17.7850,
        longitude: -63.1820,
        type: 'crypto_payment',
        acceptedCryptos: ['BTC', 'ETH', 'USDT'],
        rating: 4.4,
        reviewCount: 56,
        address: 'Av. Cañoto 789, Santa Cruz',
        phone: '+591 3 6789012',
        website: 'https://coffeecryptosc.bo',
        isOpen: true,
        additionalInfo: {
          'businessType': 'restaurant',
          'minAmount': 10.0,
          'maxAmount': 1000.0,
        },
      ),
      const MapLocationEntity(
        id: 'crypto_3',
        name: 'Tienda Crypto - Digital Store SC',
        description: 'Tienda de tecnología que acepta pagos en crypto',
        latitude: -17.7800,
        longitude: -63.1860,
        type: 'crypto_payment',
        acceptedCryptos: ['BTC', 'ETH', 'USDT'],
        rating: 4.1,
        reviewCount: 42,
        address: 'Calle Ballivián 321, Santa Cruz',
        phone: '+591 3 7890123',
        website: 'https://digitalstoresc.bo',
        isOpen: true,
        additionalInfo: {
          'businessType': 'retail',
          'minAmount': 25.0,
          'maxAmount': 3000.0,
        },
      ),

      // Más cajeros P2P
      const MapLocationEntity(
        id: 'p2p_3',
        name: 'Cajero P2P - Zona Norte',
        description: 'Cajero P2P en zona residencial',
        latitude: -17.7900,
        longitude: -63.1700,
        type: 'p2p_atm',
        acceptedCryptos: ['BTC', 'ETH', 'USDT'],
        rating: 4.0,
        reviewCount: 28,
        address: 'Av. Roca y Coronado, Santa Cruz',
        phone: '+591 3 8901234',
        website: '',
        isOpen: true,
        additionalInfo: {
          'verificationStatus': 'verified',
          'transactionCount': 67,
          'exchangeRate': 6.90,
          'fee': 2.5,
        },
      ),
      const MapLocationEntity(
        id: 'p2p_4',
        name: 'Cajero P2P - Equipetrol',
        description: 'Cajero P2P en zona comercial',
        latitude: -17.7700,
        longitude: -63.1900,
        type: 'p2p_atm',
        acceptedCryptos: ['BTC', 'USDT'],
        rating: 3.8,
        reviewCount: 19,
        address: 'Av. Irala, Santa Cruz',
        phone: '+591 3 9012345',
        website: '',
        isOpen: true,
        additionalInfo: {
          'verificationStatus': 'verified',
          'transactionCount': 45,
          'exchangeRate': 6.88,
          'fee': 2.0,
        },
      ),

      // Más establecimientos
      const MapLocationEntity(
        id: 'crypto_4',
        name: 'Bar Crypto - Bitcoin Pub SC',
        description: 'Bar que acepta pagos con Bitcoin',
        latitude: -17.7820,
        longitude: -63.1840,
        type: 'crypto_payment',
        acceptedCryptos: ['BTC', 'ETH', 'USDT'],
        rating: 4.3,
        reviewCount: 67,
        address: 'Calle Arenales 987, Santa Cruz',
        phone: '+591 3 1234567',
        website: 'https://bitcoinpubsc.bo',
        isOpen: true,
        additionalInfo: {
          'businessType': 'bar',
          'minAmount': 15.0,
          'maxAmount': 1500.0,
        },
      ),
      const MapLocationEntity(
        id: 'crypto_5',
        name: 'Hotel Crypto - Digital Inn SC',
        description: 'Hotel que acepta reservas con criptomonedas',
        latitude: -17.7880,
        longitude: -63.1890,
        type: 'crypto_payment',
        acceptedCryptos: ['BTC', 'ETH', 'USDT'],
        rating: 4.5,
        reviewCount: 123,
        address: 'Av. Busch 111, Santa Cruz',
        phone: '+591 3 2345678',
        website: 'https://digitalinnsc.bo',
        isOpen: true,
        additionalInfo: {
          'businessType': 'hotel',
          'minAmount': 50.0,
          'maxAmount': 5000.0,
        },
      ),
    ];
  }

  @override
  Future<List<P2PAtmEntity>> getNearbyP2PAtms(
      double latitude, double longitude, double radius) async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      P2PAtmEntity(
        id: 'p2p_1',
        name: 'Juan Pérez - Cajero P2P',
        description: 'Persona verificada que cambia dinero físico por crypto',
        latitude: latitude - 0.002,
        longitude: longitude + 0.003,
        acceptedCryptos: const ['BTC', 'ETH', 'USDT', 'BNB'],
        acceptedFiatCurrencies: const ['BOB', 'USD'],
        exchangeRate: 6.95,
        fee: 2.0,
        contactInfo: '+591 7 12345678',
        verificationStatus: 'verified',
        rating: 4.8,
        transactionCount: 89,
        isOnline: true,
        lastActive: '2024-01-15 14:30:00',
      ),
      P2PAtmEntity(
        id: 'p2p_2',
        name: 'María García - Cajero P2P',
        description: 'Cajero P2P con excelente reputación',
        latitude: latitude + 0.005,
        longitude: longitude - 0.004,
        acceptedCryptos: const ['BTC', 'ETH', 'USDT'],
        acceptedFiatCurrencies: const ['BOB', 'USD'],
        exchangeRate: 6.93,
        fee: 1.5,
        contactInfo: '+591 7 87654321',
        verificationStatus: 'verified',
        rating: 4.9,
        transactionCount: 234,
        isOnline: true,
        lastActive: '2024-01-15 15:45:00',
      ),
    ];
  }

  @override
  Future<List<CryptoPaymentLocationEntity>> getNearbyCryptoPaymentLocations(
      double latitude, double longitude, double radius) async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      CryptoPaymentLocationEntity(
        id: 'crypto_1',
        name: 'Café Bitcoin',
        description: 'Café que acepta pagos con Bitcoin y otras criptomonedas',
        latitude: latitude + 0.001,
        longitude: longitude + 0.001,
        acceptedCryptos: const ['BTC', 'ETH', 'USDT'],
        businessType: 'restaurant',
        minAmount: 10.0,
        maxAmount: 1000.0,
        address: 'Av. Principal 123, La Paz',
        phone: '+591 2 123456',
        website: 'https://cafebitcoin.com',
        isOpen: true,
        operatingHours: const ['Lun-Vie: 8:00-22:00', 'Sáb-Dom: 9:00-23:00'],
        rating: 4.5,
        reviewCount: 23,
      ),
      CryptoPaymentLocationEntity(
        id: 'crypto_2',
        name: 'Restaurante Crypto',
        description: 'Restaurante que acepta pagos con criptomonedas',
        latitude: latitude - 0.003,
        longitude: longitude - 0.002,
        acceptedCryptos: const ['BTC', 'USDT'],
        businessType: 'restaurant',
        minAmount: 5.0,
        maxAmount: 500.0,
        address: 'Zona Norte, La Paz',
        phone: '+591 2 555555',
        website: 'https://restaurantecrypto.com',
        isOpen: true,
        operatingHours: const ['Lun-Dom: 12:00-23:00'],
        rating: 4.6,
        reviewCount: 34,
      ),
    ];
  }

  @override
  Future<MapLocationEntity> getLocationDetails(String locationId) async {
    await Future.delayed(const Duration(seconds: 1));

    // Simula obtener detalles de una ubicación específica
    return MapLocationEntity(
      id: locationId,
      name: 'Ubicación Detallada',
      description: 'Descripción detallada de la ubicación',
      latitude: -16.4897,
      longitude: -68.1193,
      type: 'crypto_payment',
      acceptedCryptos: const ['BTC', 'ETH', 'USDT'],
      rating: 4.5,
      reviewCount: 50,
      address: 'Dirección completa',
      phone: '+591 2 123456',
      website: 'https://ejemplo.com',
      isOpen: true,
      additionalInfo: const {},
    );
  }

  @override
  Future<bool> addNewLocation(MapLocationEntity location) async {
    await Future.delayed(const Duration(seconds: 2));
    // Simula agregar una nueva ubicación
    return true;
  }

  @override
  Future<bool> reportLocation(String locationId, String reason) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simula reportar una ubicación
    return true;
  }

  @override
  Future<List<MapLocationEntity>> searchLocations(
      String query, double latitude, double longitude) async {
    await Future.delayed(const Duration(seconds: 1));

    // Simula búsqueda de ubicaciones
    final allLocations = await getNearbyLocations(latitude, longitude, 5000);
    return allLocations
        .where((location) =>
            location.name.toLowerCase().contains(query.toLowerCase()) ||
            location.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<List<MapLocationEntity>> filterLocationsByType(
    String type,
    double latitude,
    double longitude,
  ) async {
    final allLocations = await getNearbyLocations(latitude, longitude, 5000);

    if (type == 'all') {
      return allLocations;
    }

    return allLocations.where((location) => location.type == type).toList();
  }

  @override
  Future<List<MapLocationEntity>> filterLocationsByCrypto(
      String crypto, double latitude, double longitude) async {
    await Future.delayed(const Duration(seconds: 1));

    final allLocations = await getNearbyLocations(latitude, longitude, 5000);
    return allLocations
        .where((location) =>
            location.acceptedCryptos.contains(crypto.toUpperCase()))
        .toList();
  }
}
