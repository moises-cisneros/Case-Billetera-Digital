
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:case_digital_wallet/core/config/app_config.dart';
import 'package:case_digital_wallet/core/network/api_client.dart';
import 'package:case_digital_wallet/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:case_digital_wallet/features/auth/data/datasources/auth_remote_datasource_dev.dart';
import 'package:case_digital_wallet/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:case_digital_wallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:case_digital_wallet/features/auth/domain/usecases/login_usecase.dart';
import 'package:case_digital_wallet/features/auth/domain/usecases/register_usecase.dart';
import 'package:case_digital_wallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:case_digital_wallet/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:case_digital_wallet/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:case_digital_wallet/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:case_digital_wallet/features/wallet/domain/usecases/get_balance_usecase.dart';
import 'package:case_digital_wallet/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:case_digital_wallet/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/get_crypto_prices_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/get_user_crypto_balances_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/get_crypto_transactions_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/buy_crypto_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/sell_crypto_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/send_crypto_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/convert_to_crypto_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/convert_from_crypto_usecase.dart';
import 'package:case_digital_wallet/features/crypto/presentation/bloc/crypto_bloc.dart';
import 'package:case_digital_wallet/features/crypto/data/repositories/crypto_repository_impl.dart';
import 'package:case_digital_wallet/features/maps/domain/repositories/maps_repository.dart';
import 'package:case_digital_wallet/features/maps/data/repositories/maps_repository_impl.dart';
import 'package:case_digital_wallet/features/maps/presentation/bloc/maps_bloc.dart';
import 'package:case_digital_wallet/features/profile/domain/repositories/profile_repository.dart';
import 'package:case_digital_wallet/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:case_digital_wallet/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:case_digital_wallet/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:case_digital_wallet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:case_digital_wallet/features/qr/domain/repositories/qr_repository.dart';
import 'package:case_digital_wallet/features/qr/data/repositories/qr_repository_impl.dart';
import 'package:case_digital_wallet/features/qr/domain/usecases/generate_qr_usecase.dart';
import 'package:case_digital_wallet/features/qr/domain/usecases/scan_qr_usecase.dart';
import 'package:case_digital_wallet/features/qr/presentation/bloc/qr_bloc.dart';
import 'package:case_digital_wallet/features/activities/domain/repositories/activity_repository.dart';
import 'package:case_digital_wallet/features/activities/data/repositories/activity_repository_impl.dart';
import 'package:case_digital_wallet/features/activities/domain/usecases/get_user_activities_usecase.dart';
import 'package:case_digital_wallet/features/activities/presentation/bloc/activity_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // Dio
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = AppConfig.apiBaseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    return dio;
  });

  // API Client
  sl.registerLazySingleton(() {
    final dio = sl<Dio>();
    dio.interceptors.add(AuthInterceptor(sl()));
    dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print(obj),
    ));
    return ApiClient(dio);
  });

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () =>
        // AuthRemoteDataSourceImpl(sl(), sl()),
        DevelopmentAuthRemoteDataSource(), // Usar implementación de desarrollo
  );
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CryptoRepository>(
    () => CryptoRepositoryImpl(),
  );
  sl.registerLazySingleton<MapsRepository>(
    () => MapsRepositoryImpl(),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(),
  );
  sl.registerLazySingleton<QRRepository>(
    () => QRRepositoryImpl(),
  );
  sl.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetBalanceUseCase(sl()));

  // Crypto Use cases (mock implementations for now)
  sl.registerLazySingleton(() => GetCryptoPricesUseCase(sl()));
  sl.registerLazySingleton(() => GetUserCryptoBalancesUseCase(sl()));
  sl.registerLazySingleton(() => GetCryptoTransactionsUseCase(sl()));
  sl.registerLazySingleton(() => BuyCryptoUseCase(sl()));
  sl.registerLazySingleton(() => SellCryptoUseCase(sl()));
  sl.registerLazySingleton(() => SendCryptoUseCase(sl()));
  sl.registerLazySingleton(() => ConvertToCryptoUseCase(sl()));
  sl.registerLazySingleton(() => ConvertFromCryptoUseCase(sl()));

  // Profile Use cases
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserProfileUseCase(sl()));

  // QR Use cases
  sl.registerLazySingleton(() => GenerateQRUseCase(sl()));
  sl.registerLazySingleton(() => ScanQRUseCase(sl()));

  // Activity Use cases
  sl.registerLazySingleton(() => GetUserActivitiesUseCase(sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(
        loginUseCase: sl(),
        registerUseCase: sl(),
      ));
  sl.registerFactory(() => WalletBloc(
        getBalanceUseCase: sl(),
      ));
  sl.registerFactory(() => CryptoBloc(
        getCryptoPrices: sl(),
        getUserCryptoBalances: sl(),
        getCryptoTransactions: sl(),
        buyCrypto: sl(),
        sellCrypto: sl(),
        sendCrypto: sl(),
        convertToCrypto: sl(),
        convertFromCrypto: sl(),
      ));
  sl.registerFactory(() => MapsBloc(
        repository: sl(),
      ));
  sl.registerFactory(() => ProfileBloc(
        getUserProfileUseCase: sl(),
        updateUserProfileUseCase: sl(),
      ));
  sl.registerFactory(() => QRBloc(
        generateQRUseCase: sl(),
        scanQRUseCase: sl(),
      ));
  sl.registerFactory(() => ActivityBloc(
        getUserActivitiesUseCase: sl(),
      ));
}
