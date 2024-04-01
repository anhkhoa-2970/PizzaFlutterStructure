import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:testxxxx/core/network_services/error_handler.dart';
import 'package:testxxxx/core/network_services/api_response.dart';
import 'package:testxxxx/core/network_services/network_info.dart';
import 'package:testxxxx/main.dart';

@Singleton()
class ApiExecution {

  final NetworkInfo _networkInfo;

  ApiExecution(this._networkInfo);

  Future<Either<Failure, T>> execute<T>(Future<APIResponse<T>> api) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await api;
        return Right(result.data);
      } catch (e) {
        logger.d("error: $e");
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}