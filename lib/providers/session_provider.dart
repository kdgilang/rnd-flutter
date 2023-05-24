import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Session? _session;

  Session? get session => _session;

  void set(Session? session) {
    _session = session;
    notifyListeners();
  }

  bool isValidToken() {
    final expToken = _session!.expiresAt ?? 0;
    
    if (expToken == 0) {
      return false;
    }

    final dateNow = DateTime.now();
    var tokenExp = DateTime.fromMillisecondsSinceEpoch(expToken * 1000);
    var diffDate = tokenExp.difference(dateNow);
    
    return !diffDate.isNegative;
  }
  
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('merchant', session));
  }
}