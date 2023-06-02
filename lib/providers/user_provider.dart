import 'package:purala/models/user_model.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  UserModel? _user;

  UserModel? get user => _user;

  void set(UserModel? user) {
    _user = user;
    notifyListeners();
  }
  
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('user', user));
  }
}
