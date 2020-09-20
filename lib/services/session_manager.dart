import 'dart:convert';

import 'package:dr_app/data/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class encapsulates local operations that
/// involve [Session] or [User].
class SessionManager {
  static const String sessionKey = 'session-id';
  static const String userKey = 'user';

  // Singleton pattern
  static final SessionManager _singleton = SessionManager._internal();

  SessionManager._internal();

  factory SessionManager() => _singleton;

  // Shared preferences
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  String _sessionId;
  User _authenticatedUser;

  // Session id

  Future<String> get sessionId async => _getSessionId();

  // Retrieves session id from memory or shared preferences
  Future<String> _getSessionId() async {
    if (_sessionId == null) {
      final prefs = await _prefs;
      if (prefs.containsKey(sessionKey)) {
        _sessionId = prefs.getString(sessionKey);
      }
    }
    debugPrint('Retrieved session id: $_sessionId');
    return _sessionId;
  }

  /// Adds session to shared preferences
  Future<bool> setSessionId(String id) async {
    if (id != _sessionId) {
      final prefs = await _prefs;
      final isSuccessful = await prefs.setString(sessionKey, id);
      if (isSuccessful) {
        _sessionId = id;
      }
      debugPrint('Refreshed session id: $_sessionId');
      return isSuccessful;
    }
    return false;
  }

  // User

  bool get isAuthenticated => _authenticatedUser != null;

  Future<String> get authToken async => (await _getUser())?.token ?? null;

  String get authEmail => _authenticatedUser.email ?? null;

  // Retrieves user from memory cache or shared preferences
  Future<User> _getUser() async {
    if (_authenticatedUser == null) {
      final prefs = await _prefs;
      if (prefs.containsKey(userKey)) {
        final encodedUser = prefs.getString(userKey);
        final decodedUser = json.decode(encodedUser);
        _authenticatedUser = User.fromJson(decodedUser);
      }
    }
    debugPrint('Retrieved authenticated user: $_authenticatedUser');
    return _authenticatedUser;
  }

  /// Adds user to shared preferences
  Future<bool> setAuthenticatedUser(User user) async {
    if (user != _authenticatedUser) {
      final prefs = await _prefs;
      final encodedUser = json.encode(user.toJson());
      final isSuccessful = await prefs.setString(userKey, encodedUser);
      if (isSuccessful) {
        _authenticatedUser = user;
      }
      debugPrint('Refreshed authenticated user: $_authenticatedUser');
      return isSuccessful;
    }
    return false;
  }

  /// Removes current authenticated user from shared preferences
  Future<bool> clearAuthenticatedUser() async {
    final user = await _getUser();
    if (user != null) {
      final prefs = await _prefs;
      final result = await prefs.remove(userKey);
      _authenticatedUser = null;
      if (result) {
        _authenticatedUser = null;
        return true;
      }
    }
    return false;
  }
}
