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
}
