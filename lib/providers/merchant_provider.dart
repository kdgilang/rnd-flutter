import 'package:purala/models/merchant_model.dart';

class MerchantProvider {
  static MerchantModel? _merchant;

  static void set(MerchantModel merchant) {
    _merchant = merchant;
  }

  static MerchantModel? get() {
    return _merchant;
  }
}
