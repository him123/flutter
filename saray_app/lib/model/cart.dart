class Cart {
  final String material_id;
  final String qty;
  final String price;
  final String unit;
  final String item_name;
  final String description;
  final String image;
  final String del_date;

  Cart(
      {this.material_id,
      this.qty,
      this.price,
      this.unit,
      this.item_name,
      this.description,
      this.image,
      this.del_date});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return new Cart(
      material_id: json['material_id'],
      qty: json['qty'],
      unit: json['unit'],
      item_name: json['item_name'],
      description: json['description'],
      image: json['image'],
      del_date: json['del_date'],
      price: json['price'],
    );
  }
}
