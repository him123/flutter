import 'package:flutter/material.dart';
import 'package:saray_app/screens/order_detail_screen.dart';

class OrderItem extends StatelessWidget {

  final String id;
  final String date;
  final String supplierName;
  final String totPrice;
  final String status;
  final String paymentStatus;

  OrderItem({
    @required this.id,
    @required this.date,
    @required this.supplierName,
    @required this.totPrice,
    @required this.status,
    @required this.paymentStatus,
  });

  Text setText(BuildContext context, String status) {
    if (status == 'Accept') {
      return Text('Order Accepted',
          style: TextStyle(
              fontFamily: 'Proxinova',
              fontSize: 19.0,
              fontWeight: FontWeight.w700,
              color: Colors.green));
    } else if (status == 'Reject') {
      return Text('Order Rejected',
          style: TextStyle(
              fontFamily: 'Proxinova',
              fontSize: 19.0,
              fontWeight: FontWeight.w700,
              color: Colors.red));
    } else {
      return Text('Order $status',
          style: TextStyle(
              fontFamily: 'Proxinova',
              fontSize: 19.0,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColorDark));
    }
  }

  void selectMeal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctxt) => new OrderDetailScreen(
                      orderId: id,
                      custName: supplierName,
                      status: status,
                      isPayament: paymentStatus == 'Success' ? true : false,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(7.0), topLeft: Radius.circular(7.0)),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        date,
                        style:
                            TextStyle(fontSize: 14.0, fontFamily: 'Proxinova'),
                      ),
                      Text(
                        'Order Id: $id',
                        style:
                            TextStyle(fontSize: 14.0, fontFamily: 'Proxinova'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    supplierName,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Proxinova'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Order Amount $totPrice',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Proxinova'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(child: setText(context, status)),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: paymentStatus == 'Success'
                        ? Text('You have Paid',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple))
                        : Text(''),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
