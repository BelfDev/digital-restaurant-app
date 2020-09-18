import 'package:dr_app/services/session_manager.dart';
import 'package:http_interceptor/http_interceptor.dart';

class SessionInterceptor implements InterceptorContract {
  final _sessionManager = SessionManager();

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    try {
      final sessionId = await _sessionManager.sessionId;
      final authToken = await _sessionManager.authToken;

      if (sessionId != null) {
        data.headers[SessionManager.sessionKey] = sessionId;
      }

      if (authToken != null) {
        data.headers['authorization'] = 'Bearer $authToken';
      }
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    try {
      if (data.headers.containsKey(SessionManager.sessionKey)) {
        final sessionId = data.headers[SessionManager.sessionKey];
        _sessionManager.setSessionId(sessionId);
      }
    } catch (e) {
      print(e);
    }
    return data;
  }
}
