import 'package:flutter/material.dart';

class OrderDetailItem extends StatelessWidget {
  final String item_id;
  final String qty;
  final String price;
  final String unit;
  final String delivery_date;
  final String item_name;
  final String description;
  final String image;
  final String orderId;

  OrderDetailItem({
    @required this.item_id,
    @required this.qty,
    @required this.price,
    @required this.unit,
    @required this.delivery_date,
    @required this.item_name,
    @required this.description,
    @required this.image,
    @required this.orderId,
  });

  void selectMeal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(7.0), topLeft: Radius.circular(7.0)),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 90.0,
                    width: 120,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item_name,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Proxinova',
                        ),
                      ),
                      Text(
                        'Quantity: $qty',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Proxinova',
                        ),
                      ),
                      Text(
                        'Price: $price',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Proxinova',
                        ),
                      ),

//                    Text(description),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Delivery on $delivery_date',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontFamily: 'Proxinova',
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
