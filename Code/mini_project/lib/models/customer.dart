class CustomerModel {
  String? id;
  String? image;
  String? name;
  String? email;
  String? createAt;
  String? numberPhone;
  String? address;
  String? itemProduct;
  String? totalPrice;
  String? payNow;
  String? itemPayNow;
  String? remindDebt;

  CustomerModel({
    this.id,
    this.image,
    this.name,
    this.email,
    this.createAt,
    this.numberPhone,
    this.address,
    this.itemProduct,
    this.totalPrice,
    this.payNow,
    this.itemPayNow,
    this.remindDebt,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'email': email,
      'createAt': createAt,
      'numberPhone': numberPhone,
      'address': address,
      'itemProduct': itemProduct,
      'totalPrice': totalPrice,
    };
  }

  Map<String, dynamic> toMapPay() {
    return {
      'payNow': payNow,
      'itemPayNow': itemPayNow,
      'remindDebt': remindDebt,
    };
  }
}
