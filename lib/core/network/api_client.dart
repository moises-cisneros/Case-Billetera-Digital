import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:case_digital_wallet/features/auth/data/models/auth_models.dart';
import 'package:case_digital_wallet/features/wallet/data/models/wallet_models.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Auth endpoints
  @POST('/auth/register/request-sms')
  Future<ApiResponse<dynamic>> requestSms(@Body() RequestSmsRequest request);

  @POST('/auth/register/verify-sms')
  Future<ApiResponse<dynamic>> verifySms(@Body() VerifySmsRequest request);

  @POST('/auth/register/complete')
  Future<ApiResponse<AuthResponse>> completeRegistration(
      @Body() CompleteRegistrationRequest request);

  @POST('/auth/login')
  Future<ApiResponse<AuthResponse>> login(@Body() LoginRequest request);

  // Wallet endpoints
  @GET('/wallet/balance')
  Future<ApiResponse<WalletBalance>> getBalance();

  @POST('/wallet/deposit/request')
  Future<ApiResponse<DepositResponse>> requestDeposit(
      @Body() DepositRequest request);

  @POST('/wallet/transfer')
  Future<ApiResponse<TransferResponse>> transfer(
      @Body() TransferRequest request);

  @GET('/wallet/transactions')
  Future<ApiResponse<List<Transaction>>> getTransactions(
    @Query('page') int page,
    @Query('limit') int limit,
  );
}

class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final String? error;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      message: json['message'],
      error: json['error'],
    );
  }
}

// Interceptors
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;

  AuthInterceptor(this._storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.read(key: 'auth_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expirado, intentar refresh
      final refreshToken = await _storage.read(key: 'refresh_token');
      if (refreshToken != null) {
        try {
          final response = await Dio().post(
            '${err.requestOptions.baseUrl}/auth/refresh',
            data: {'refresh_token': refreshToken},
          );
          
          final newToken = response.data['access_token'];
          await _storage.write(key: 'auth_token', value: newToken);
          
          // Reintentar la petición original
          final originalRequest = err.requestOptions;
          originalRequest.headers['Authorization'] = 'Bearer $newToken';
          
          final retryResponse = await Dio().fetch(originalRequest);
          handler.resolve(retryResponse);
          return;
        } catch (e) {
          // Refresh falló, hacer logout
          await _storage.deleteAll();
          // Aquí podrías navegar a la pantalla de login
        }
      }
    }
    handler.next(err);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message = 'Error de conexión';
    
    switch (err.response?.statusCode) {
      case 400:
        message = 'Datos inválidos';
        break;
      case 401:
        message = 'No autorizado';
        break;
      case 403:
        message = 'Acceso denegado';
        break;
      case 404:
        message = 'Recurso no encontrado';
        break;
      case 500:
        message = 'Error del servidor';
        break;
      case 502:
        message = 'Servicio no disponible';
        break;
      case 503:
        message = 'Servicio temporalmente no disponible';
        break;
    }

    if (err.response?.data != null && err.response?.data['message'] != null) {
      message = err.response?.data['message'];
    }

    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: message,
    );

    handler.next(customError);
  }
}
