part of 'auth_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

/// States related to Authentication
class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final ContentStateStatus operationStatus;
  final User user;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
    this.operationStatus = ContentStateStatus.initial,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.loading({@required AuthenticationStatus status})
      : this._(
          status: status,
          operationStatus: ContentStateStatus.loadInProgress,
        );

  const AuthenticationState.authenticated(User user)
      : this._(
          status: AuthenticationStatus.authenticated,
          operationStatus: ContentStateStatus.loadSuccess,
          user: user,
        );

  const AuthenticationState.unauthenticated()
      : this._(
          status: AuthenticationStatus.unauthenticated,
          operationStatus: ContentStateStatus.loadSuccess,
        );

  const AuthenticationState.error()
      : this._(
          status: AuthenticationStatus.unauthenticated,
          operationStatus: ContentStateStatus.loadFailure,
        );

  @override
  List<Object> get props => [status, user, operationStatus];
}
