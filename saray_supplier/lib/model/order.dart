class Order {
  final String order_id;
  final String customer_id;
  final String supplier_id;
  final String total_price;
  final String currency;
  final String created_date;
  final String customername;
  final String customeraddress;
  final String customerphone;
  final String customeremail;
  final String status;
  final String payment_status;

  Order(
      {this.order_id,
      this.customer_id,
      this.supplier_id,
      this.total_price,
      this.currency,
      this.created_date,
      this.customername,
      this.customeraddress,
      this.customerphone,
      this.customeremail,
      this.status,
      this.payment_status});

  factory Order.fromJson(Map<String, dynamic> json) {
    return new Order(
      order_id: json['order_id'],
      customer_id: json['customer_id'],
      supplier_id: json['supplier_id'],
      total_price: json['total_price'],
      currency: json['currency'],
      created_date: json['created_date'],
      customername: json['customername'],
      customeraddress: json['customeraddress'],
      customerphone: json['customerphone'],
      customeremail: json['customeremail'],
      status: json['status'],
      payment_status: json['payment_status'],
    );
  }
}
