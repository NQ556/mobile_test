import 'package:fpdart/src/either.dart';
import 'package:mobile_test/core/common/usecase/usecase.dart';
import 'package:mobile_test/core/error/failure.dart';
import 'package:mobile_test/features/auth/domain/repositories/auth_repository.dart';

class UserCheckLogin implements Usecase<bool, NoParams> {
  final AuthRepository authRepository;

  UserCheckLogin(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return authRepository.isLoggedIn();
  }
}
