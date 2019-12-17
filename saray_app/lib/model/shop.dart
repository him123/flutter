import 'dart:ui';

class Shop {
  final String id;
  final String name;
  final String address;
  final String description;
  final String price;
  final String email;
  final String phone;
  final String imageUrl;

  Shop(
      {this.id,
      this.name,
      this.address,
      this.description,
      this.imageUrl,
      this.price,
      this.email,
      this.phone});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return new Shop(
      id: json['supplier_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      imageUrl: json['image'],
    );
  }
}
