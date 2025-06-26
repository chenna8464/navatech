import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_test/albums/data/models/api_failure_model.dart';

class BaseException {
  Future<Either<ApiFailureModel, T>> baseApiMethodExceptions<T>(
    Future<Either<ApiFailureModel, T>> Function() baseMethod,
  ) async {
    try {
      return await baseMethod();
    } on DioException catch (e) {
      return Left(
        ApiFailureModel(
          status: e.error.toString(),
          message: e.message.toString(),
          code: e.response!.statusCode!,
        ),
      );
    } catch (e) {
      return Left(
        ApiFailureModel(
          status: 'Failure',
          code: 400,
          message: 'Something went wrong',
        ),
      );
    }
  }
}
