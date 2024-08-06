import 'package:get_it/get_it.dart';
import 'package:mobile_test/features/auth/data/datasources/auth_datasource.dart';
import 'package:mobile_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_test/features/auth/domain/usecases/user_get_user.dart';
import 'package:mobile_test/features/auth/domain/usecases/user_login.dart';
import 'package:mobile_test/features/auth/domain/usecases/user_logout.dart';
import 'package:mobile_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_test/features/home/data/datasources/item_datasource.dart';
import 'package:mobile_test/features/home/data/repositories/item_repository_impl.dart';
import 'package:mobile_test/features/home/domain/repositories/item_repository.dart';
import 'package:mobile_test/features/home/domain/usecases/item_load_items.dart';
import 'package:mobile_test/features/home/domain/usecases/item_load_more_items.dart';
import 'package:mobile_test/features/home/presentation/bloc/item_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => sharedPreferences);

  _initAuth();
  _initItems();
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

  getIt.registerFactory(
    () => UserLogout(
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => AuthBloc(
      userLogin: getIt(),
      userGetUser: getIt(),
      userLogout: getIt(),
    ),
  );
}

void _initItems() {
  getIt.registerFactory<ItemDatasource>(
    () => ItemDatasourceImpl(),
  );

  getIt.registerFactory<ItemRepository>(
    () => ItemRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => ItemLoadItems(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => ItemLoadMoreItems(
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => ItemBloc(
      itemLoadItems: getIt(),
      itemLoadMoreItems: getIt(),
    ),
  );
}
