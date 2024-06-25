import 'package:blog_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<T, Parameters> {
  Future<Either<Failure, T>> call(Parameters parameters);
}

