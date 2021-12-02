import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';
import 'package:wecos_forum/features/authorization/domain/repositories/user_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.userRepository) : super(AuthInitialState());

  final UserRepository userRepository;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLoginEvent) {
      yield* _loginHandler(event);
    } else if (event is AuthRegisterEvent) {
      yield* _registerHandler(event);
    }
  }

  Stream<AuthState> _loginHandler(AuthLoginEvent event) async* {
    yield AuthLoadingState();
    try {
      userRepository.login(event.email, event.password);
      yield AuthSuccessState();
    } on DioError catch (e) {
      yield AuthErrorState(e.message);
    } catch (e) {
      yield AuthErrorState(e.toString());
    }
  }

  Stream<AuthState> _registerHandler(AuthRegisterEvent event) async* {
    yield AuthLoadingState();
    try {
      userRepository.register(
          event.email, event.email.split('@').first, event.password);
      yield AuthSuccessState();
    } on DioError catch (e) {
      yield AuthErrorState(e.message);
    } catch (e) {
      yield AuthErrorState(e.toString());
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    GetIt.I
        .get<Logger>()
        .debug(change.currentState.runtimeType.toString(), change.nextState);
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    super.close();
  }
}
