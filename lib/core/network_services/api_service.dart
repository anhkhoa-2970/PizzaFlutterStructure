import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:testxxxx/core/network_services/api_logger.dart';
import 'package:testxxxx/core/network_services/api_response.dart';
import 'package:testxxxx/core/network_services/token_interceptor.dart';
import 'package:testxxxx/data/models/user_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api.mockfly.dev/mocks/868039bb-5857-47bd-9812-152645da1551/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/users')
  Future<APIResponse<ResponseGetUsers>> getUsers();

  @POST('/users')
  Future<APIResponse<ResponseUser>> addNewUser(@Body() UserModel userModel);

  @PUT('/users')
  Future<APIResponse<ResponseUser>> updateUser(@Body() UserModel userModel);

  @DELETE("/users/{id}")
  Future<APIResponse<dynamic>> deleteUser(@Path() String id);
}

final Dio _dio = Dio(
  BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json),
);

void configureDio() {
  _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));
  _dio.interceptors.add(TokenInterceptor());
}

final client = RestClient(_dio);
