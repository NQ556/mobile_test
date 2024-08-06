import 'package:fpdart/fpdart.dart';
import 'package:mobile_test/core/common/entities/user.dart';
import 'package:mobile_test/core/error/exception.dart';
import 'package:mobile_test/core/error/failure.dart';
import 'package:mobile_test/features/auth/data/datasources/auth_datasource.dart';
import 'package:mobile_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authDatasource.login(
        email: email,
        password: password,
      );

      return right(user);
    } on MyException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      return right(await authDatasource.getUser());
    } on MyException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      return right(await authDatasource.isLoggedIn());
    } on MyException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authDatasource.logout();
      return right(unit);
    } on MyException catch (e) {
      return left(Failure(e.message));
    }
  }
}
