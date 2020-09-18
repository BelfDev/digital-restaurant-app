import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/repositories/account_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  static const id = 'auth_bloc';

  final AccountRepository _accountRepository;

  AuthBloc({
    @required AccountRepository accountRepository,
  })  : assert(accountRepository != null),
        _accountRepository = accountRepository,
        super(const AuthenticationState.unknown());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is SignUpRequested) {
      yield* _mapSigUpRequestedToState(event);
    } else if (event is LogInRequested) {
      yield* _mapLogInRequestedToState(event);
    } else if (event is LogOutRequested) {
      yield* _mapLogOutRequestedToState();
    }
  }

  Stream<AuthenticationState> _mapSigUpRequestedToState(
    SignUpRequested event,
  ) async* {
    yield AuthenticationState.loading();
    try {
      final user = await _accountRepository.signup(event.email, event.password);
      yield AuthenticationState.authenticated(user);
    } catch (e) {
      yield AuthenticationState.error();
    }
  }

  Stream<AuthenticationState> _mapLogInRequestedToState(
    LogInRequested event,
  ) async* {
    yield AuthenticationState.loading();
    try {
      final user = await _accountRepository.login(event.email, event.password);
      yield AuthenticationState.authenticated(user);
    } catch (e) {
      yield AuthenticationState.error();
    }
  }

  Stream<AuthenticationState> _mapLogOutRequestedToState() async* {
    yield AuthenticationState.loading();
    try {
      final result = await _accountRepository.logout();
      if (result) {
        yield AuthenticationState.unauthenticated();
      } else {
        yield AuthenticationState.error();
      }
    } catch (e) {
      yield AuthenticationState.error();
    }
  }
}
