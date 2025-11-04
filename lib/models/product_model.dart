class ProductModel {
  int? id;
  String? productId;
  String? productName;
  String? categoryId;
  String? categoryName;
  String? variantId;
  String? variantName;
  dynamic description;
  String? active;
  String? createdDate;
  String? createdBy;
  String? updatedDate;

  ProductModel({
    this.id,
    this.productId,
    this.productName,
    this.categoryId,
    this.categoryName,
    this.variantId,
    this.variantName,
    this.description,
    this.active,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      variantId: json['variant_id'],
      variantName: json['variant_name'],
      description: json['description'],
      active: json['active'],
      createdDate: json['created_date'],
      createdBy: json['created_by'],
      updatedDate: json['updated_by'],
    );
  }

  ProductModel copyWith({
    int? id,
    String? productId,
    String? productName,
    String? categoryId,
    String? categoryName,
    String? variantId,
    String? variantName,
    dynamic description,
    String? active,
    String? createdDate,
    String? createdBy,
    String? updatedDate,
  }) => ProductModel(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    categoryId: categoryId ?? this.categoryId,
    categoryName: categoryName ?? this.categoryName,
    variantId: variantId ?? this.variantId,
    variantName: variantName ?? this.variantName,
    description: description ?? this.description,
    active: active ?? this.active,
    createdDate: createdDate ?? this.createdDate,
    createdBy: createdBy ?? this.createdBy,
    updatedDate: updatedDate ?? this.updatedDate,
  );
}
