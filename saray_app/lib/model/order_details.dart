class OrderDetials {
  final String item_id;
  final String qty;
  final String price;
  final String unit;
  final String delivery_date;
  final String item_name;
  final String description;
  final String image;

  OrderDetials(
      {this.item_id,
      this.qty,
      this.price,
      this.unit,
      this.delivery_date,
      this.item_name,
      this.image,
      this.description});

  factory OrderDetials.fromJson(Map<String, dynamic> json) {
    return new OrderDetials(
      item_id: json['item_id'],
      qty: json['qty'],
      price: json['price'],
      unit: json['unit'],
      delivery_date: json['delivery_date'],
      item_name: json['item_name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
