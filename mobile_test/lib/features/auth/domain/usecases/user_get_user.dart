import 'package:fpdart/src/either.dart';
import 'package:mobile_test/core/common/entities/user.dart';
import 'package:mobile_test/core/common/usecase/usecase.dart';
import 'package:mobile_test/core/error/failure.dart';
import 'package:mobile_test/features/auth/domain/repositories/auth_repository.dart';

class UserGetUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;

  UserGetUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return authRepository.getUser();
  }
}
