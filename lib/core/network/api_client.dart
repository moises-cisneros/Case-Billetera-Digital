import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
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
