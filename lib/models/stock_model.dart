import 'package:purala/models/base_model.dart';

class StockModel extends BaseModel {
  final String? note;
  final num price;
  final num salePrice;
  final int quantity;
  final String? productName;
  final String? supplierName;

  const StockModel({
    super.id,
    this.note,
    this.productName,
    this.supplierName,
    required this.price,
    required this.salePrice,
    required this.quantity,
  });

  StockModel copyWith({
    int? id,
    String? note,
    num? price,
    num? salePrice,
    int? quantity,
    String? productName,
    String? supplierName,
  }) {
    return StockModel(
      id: id ?? this.id,
      note: note ?? this.note,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      quantity: quantity ?? this.quantity,
      productName: productName ?? this.productName,
      supplierName: supplierName ?? this.supplierName,
    );
  }

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id'],
      note: json['note'],
      price: json['price'],
      salePrice: json['sale_price'],
      quantity: json['quantity'],
      productName: json['stocks_product_links'][0]?['products']?['name'],
      supplierName: json['stocks_supplier_links'][0]?['suppliers']?['name'],
    );
  }
}