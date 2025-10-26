class StockModel {
  String? salesId;
  String? productId;
  String? storeId;
  String? isStockAvailable;
  int? stock;
  String? createdBy;

  StockModel({
    this.salesId,
    this.productId,
    this.storeId,
    this.isStockAvailable,
    this.stock,
    this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'sales_id': salesId,
      'product_id': productId,
      'store_id': storeId,
      'is_stock_available': isStockAvailable,
      'stock': stock,
      'created_by': createdBy,
    };
  }
}
