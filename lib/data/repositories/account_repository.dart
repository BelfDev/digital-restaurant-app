import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/services/api/account_api_client.dart';
import 'package:dr_app/services/session_manager.dart';

/// This class represents the only source of truth for
/// operations involving the Account entity.
/// Methods for creating a new account and authenticating
/// the user are provided.
class AccountRepository {
  final _accountApiClient = AccountApiClient();
  final _sessionManager = SessionManager();

  /// Creates a new account with the given email and password
  Future<User> signup(String email, String password) async {
    final body = await _accountApiClient.signUp(email, password);
    final user = body.results.length > 0 ? body.results[0] : null;
    await _registerAuthenticatedUser(user);
    return user;
  }

  /// Authenticates the user with the given email and password
  Future<User> login(String email, String password) async {
    final body = await _accountApiClient.login(email, password);
    final user = body.results.length > 0 ? body.results[0] : null;
    await _registerAuthenticatedUser(user);
    return user;
  }

  /// Log the current user out
  Future<bool> logout() async {
    final isSuccessful = await _accountApiClient.logout();
    if (isSuccessful) {
      return await _sessionManager.clearAuthenticatedUser();
    }
    return false;
  }

  Future<bool> _registerAuthenticatedUser(User user) async {
    if (user != null) {
      return await _sessionManager.setAuthenticatedUser(user);
    }
    return false;
  }
}
