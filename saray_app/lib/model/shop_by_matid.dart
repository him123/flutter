import 'dart:ui';

class ShopByMat {
  final String supplier_id;
  final String item_id;
  final String item_name;
  final String description;
  final String company;
  final String price;
  final String unit;
  final String image;
  final String supplier_name;
  final String supplier_email;
  final String supplier_phone;
  final String supplier_address;
  final String profile;

  ShopByMat(
      {this.supplier_id,
      this.item_id,
      this.item_name,
      this.description,
      this.company,
      this.price,
      this.unit,
      this.image,
      this.supplier_name,
      this.supplier_email,
      this.supplier_phone,
      this.supplier_address,
      this.profile});

  factory ShopByMat.fromJson(Map<String, dynamic> json) {
    return new ShopByMat(
      supplier_id: json['supplier_id'],
      item_id: json['item_id'],
      item_name: json['item_name'],
      description: json['description'],
      company: json['company'],
      price: json['price'],
      unit: json['unit'],
      image: json['image'],
      supplier_name: json['supplier_name'],
      supplier_email: json['supplier_email'],
      supplier_phone: json['supplier_phone'],
      supplier_address: json['supplier_address'],
      profile: json['profile'],
    );
  }
}
