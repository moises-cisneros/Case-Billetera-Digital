import 'package:equatable/equatable.dart';

class MapLocationEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String type; // 'crypto_payment', 'p2p_atm', 'exchange_office'
  final List<String> acceptedCryptos;
  final double rating;
  final int reviewCount;
  final String address;
  final String phone;
  final String website;
  final bool isOpen;
  final Map<String, dynamic> additionalInfo;

  const MapLocationEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.acceptedCryptos,
    required this.rating,
    required this.reviewCount,
    required this.address,
    required this.phone,
    required this.website,
    required this.isOpen,
    required this.additionalInfo,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        latitude,
        longitude,
        type,
        acceptedCryptos,
        rating,
        reviewCount,
        address,
        phone,
        website,
        isOpen,
        additionalInfo,
      ];
}

class P2PAtmEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> acceptedCryptos;
  final List<String> acceptedFiatCurrencies;
  final double exchangeRate;
  final double fee;
  final String contactInfo;
  final String verificationStatus; // 'verified', 'pending', 'unverified'
  final double rating;
  final int transactionCount;
  final bool isOnline;
  final String lastActive;

  const P2PAtmEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.acceptedCryptos,
    required this.acceptedFiatCurrencies,
    required this.exchangeRate,
    required this.fee,
    required this.contactInfo,
    required this.verificationStatus,
    required this.rating,
    required this.transactionCount,
    required this.isOnline,
    required this.lastActive,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        latitude,
        longitude,
        acceptedCryptos,
        acceptedFiatCurrencies,
        exchangeRate,
        fee,
        contactInfo,
        verificationStatus,
        rating,
        transactionCount,
        isOnline,
        lastActive,
      ];
}

class CryptoPaymentLocationEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> acceptedCryptos;
  final String businessType; // 'restaurant', 'retail', 'service', etc.
  final double minAmount;
  final double maxAmount;
  final String address;
  final String phone;
  final String website;
  final bool isOpen;
  final List<String> operatingHours;
  final double rating;
  final int reviewCount;

  const CryptoPaymentLocationEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.acceptedCryptos,
    required this.businessType,
    required this.minAmount,
    required this.maxAmount,
    required this.address,
    required this.phone,
    required this.website,
    required this.isOpen,
    required this.operatingHours,
    required this.rating,
    required this.reviewCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        latitude,
        longitude,
        acceptedCryptos,
        businessType,
        minAmount,
        maxAmount,
        address,
        phone,
        website,
        isOpen,
        operatingHours,
        rating,
        reviewCount,
      ];
} 