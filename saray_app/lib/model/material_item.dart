class MaterialItem {
  final String title;
  final String id;
  final String description;
  final String imgUrl;
  final String price;
  final String company;
  final String unit;


  const MaterialItem(
      {this.id, this.title, this.description, this.imgUrl, this.price, this.company, this.unit});


  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return new MaterialItem(
      id: json['item_id'],
      title: json['item_name'],
      description: json['description'],
      company: json['company'],
      price: json['price'],
      unit: json['unit'],
      imgUrl: json['image'],
    );
  }
}
