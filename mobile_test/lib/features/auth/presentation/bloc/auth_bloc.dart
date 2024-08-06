import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_test/core/common/entities/user.dart';
import 'package:mobile_test/core/common/usecase/usecase.dart';
import 'package:mobile_test/core/error/error_list.dart';
import 'package:mobile_test/features/auth/domain/usecases/user_get_user.dart';
import 'package:mobile_test/features/auth/domain/usecases/user_login.dart';
import 'package:mobile_test/features/auth/domain/usecases/user_logout.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserGetUser _userGetUser;
  final UserLogout _userLogout;

  AuthBloc({
    required UserLogin userLogin,
    required UserGetUser userGetUser,
    required UserLogout userLogout,
  })  : _userLogin = userLogin,
        _userGetUser = userGetUser,
        _userLogout = userLogout,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) {
      emit(AuthLoadingState());
    });

    on<LogInEvent>(_onAuthLogIn);
    on<GetUserEvent>(_onGetUser);
    on<LogOutEvent>(_onLogout);
  }

  void _onAuthLogIn(
    LogInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userLogin.call(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailureState(ErrorList.wrongEmailPassword)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onGetUser(
    GetUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userGetUser.call(NoParams());

    response.fold(
      (_) => emit(AuthIsNotLoggedInState()),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onLogout(
    LogOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userLogout.call(NoParams());

    response.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (_) => emit(AuthLogOutSuccessState()),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    emit(AuthSuccessState(user));
  }
}
