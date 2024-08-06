import 'package:get_it/get_it.dart';
import 'package:mobile_test/features/auth/data/datasources/auth_datasource.dart';
import 'package:mobile_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_test/features/auth/domain/usecases/user_get_user.dart';
import 'package:mobile_test/features/auth/domain/usecases/user_login.dart';
import 'package:mobile_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => sharedPreferences);

  _initAuth();
}

void _initAuth() {
  getIt.registerFactory<AuthDatasource>(
    () => AuthDatasourceImpl(
      getIt(),
    ),
  );

  getIt.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => UserLogin(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => UserGetUser(
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => AuthBloc(
      userLogin: getIt(),
      userGetUser: getIt(),
    ),
  );
}
