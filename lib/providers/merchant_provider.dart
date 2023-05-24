import 'package:purala/models/merchant_model.dart';
import 'package:flutter/foundation.dart';

class MerchantProvider with ChangeNotifier, DiagnosticableTreeMixin {
  MerchantModel? _merchant;

  MerchantModel? get merchant => _merchant;

  void set(MerchantModel? merchant) {
    _merchant = merchant;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('merchant', merchant));
  }
}