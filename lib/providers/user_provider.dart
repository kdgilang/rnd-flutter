import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider {
  static User? _user;
  static Session? _session;

  static void setAuth(User? user, Session? session) {
    _user = user;
    _session = session;
  }

  static User? getUser() {
    return _user;
  }

  static Session? getSession() {
    return _session;
  }

  static bool isValidUser() {
    final expToken = _session!.expiresAt ?? 0;
    
    if (expToken == 0) {
      return false;
    }

    final dateNow = DateTime.now();
    var tokenExp = DateTime.fromMillisecondsSinceEpoch(expToken * 1000);
    var diffDate = tokenExp.difference(dateNow);
    
    return !diffDate.isNegative;
  }
}
