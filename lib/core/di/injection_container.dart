import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:case_digital_wallet/core/config/app_config.dart';
import 'package:case_digital_wallet/core/network/api_client.dart';
import 'package:case_digital_wallet/features/auth/data/datasources/auth_remote_datasource.dart';
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
import 'package:case_digital_wallet/features/wallet/data/services/privy_service_impl.dart';
import 'package:case_digital_wallet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:case_digital_wallet/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:case_digital_wallet/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:case_digital_wallet/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:case_digital_wallet/features/profile/domain/repositories/profile_repository.dart';

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
  sl.registerLazySingleton(() => ApiClient(sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
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
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetBalanceUseCase(sl()));
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserProfileUseCase(sl()));

  // Services
  sl.registerLazySingleton(() => PrivyServiceImpl());

  // Blocs
  sl.registerFactory(() => AuthBloc(
        loginUseCase: sl(),
        registerUseCase: sl(),
      ));
  sl.registerFactory(() => WalletBloc(
        getBalanceUseCase: sl(),
      ));
  sl.registerFactory(() => ProfileBloc(
        getUserProfileUseCase: sl(),
        updateUserProfileUseCase: sl(),
      ));
}
