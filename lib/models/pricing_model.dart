class PricingModel {
  String? salesId;
  String? productId;
  String? storeId;
  String? isPromo;
  int? promoPrice;
  String? startDate;
  String? endDate;
  String? posm;
  String? mechanisme;
  String? createdBy;

  PricingModel({
    this.salesId,
    this.productId,
    this.storeId,
    this.isPromo,
    this.promoPrice,
    this.startDate,
    this.endDate,
    this.posm,
    this.mechanisme,
    this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'sales_id': salesId,
      'product_id': productId,
      'store_id': storeId,
      'is_promo': isPromo,
      'promo_price': promoPrice,
      'start_date': startDate,
      'end_date': endDate,
      'posm': posm,
      'mechanisme': mechanisme,
      'created_by': createdBy,
    };
  }
}
