import 'package:fpdart/fpdart.dart';
import 'package:mobile_test/core/common/entities/user.dart';
import 'package:mobile_test/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, bool>> isLoggedIn();
  Future<Either<Failure, void>> logout();
}
