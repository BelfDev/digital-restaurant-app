import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class encapsulates Session data and operations
class SessionManager {
  static const String sessionKey = 'session-id';

  // Singleton pattern
  static final SessionManager _singleton = SessionManager._internal();

  SessionManager._internal();

  factory SessionManager() => _singleton;

  // Shared preferences
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // Session id

  String _sessionId;

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
}
