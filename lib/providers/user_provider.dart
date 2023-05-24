import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  User? _user;

  User? get user => _user;

  void set(User? user) {
    _user = user;
    notifyListeners();
  }
  
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('merchant', user));
  }
}
