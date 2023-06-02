import 'package:purala/models/product_model.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ProductModel? _product;

  ProductModel? get product => _product;

  void set(ProductModel? product) {
    _product = product;
    notifyListeners();
  }
  
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('product', product));
  }
}
