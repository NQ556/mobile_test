import 'package:fpdart/src/either.dart';
import 'package:mobile_test/core/common/entities/user.dart';
import 'package:mobile_test/core/common/usecase/usecase.dart';
import 'package:mobile_test/core/error/failure.dart';
import 'package:mobile_test/features/auth/domain/repositories/auth_repository.dart';

class UserLogin implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
