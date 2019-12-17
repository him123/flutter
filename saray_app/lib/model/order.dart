class Order {
  final String order_id;
  final String customer_id;
  final String supplier_id;
  final String total_price;
  final String status;
  final String currency;
  final String created_date;
  final String suppliername;
  final String supplieraddress;
  final String supplierphone;
  final String supplieremail;
  final String payment_status;

  Order(
      {this.order_id,
      this.customer_id,
      this.supplier_id,
      this.total_price,
      this.status,
      this.currency,
      this.created_date,
      this.suppliername,
      this.supplieraddress,
      this.supplierphone,
      this.supplieremail,
      this.payment_status});

  factory Order.fromJson(Map<String, dynamic> json) {
    return new Order(
      order_id: json['order_id'],
      customer_id: json['customer_id'],
      supplier_id: json['supplier_id'],
      total_price: json['total_price'],
      status: json['status'],
      currency: json['currency'],
      created_date: json['created_date'],
      suppliername: json['suppliername'],
      supplieraddress: json['supplieraddress'],
      supplierphone: json['supplierphone'],
      supplieremail: json['supplieremail'],
      payment_status: json['payment_status'],

    );
  }
}
