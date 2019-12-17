import 'package:flutter/material.dart';
import 'package:saray_supplier/screens/order_detail.dart';

class OrderItem extends StatelessWidget {
  final String id;
  final String date;
  final String customerName;
  final String totPrice;
  final String status;
  final String paymentStatus;

  OrderItem({
    @required this.id,
    @required this.date,
    @required this.customerName,
    @required this.totPrice,
    @required this.status,
    @required this.paymentStatus,
  });

  void selectMeal(BuildContext context) {}

  Text setText(BuildContext context, String status) {
    if (status == 'Accept') {
      return Text('Accepted',
          style: TextStyle(
              fontFamily: 'Proxinova',
              fontSize: 19.0,
              fontWeight: FontWeight.w700,
              color: Colors.green));
    } else if (status == 'Reject') {
      return Text('Rejected',
          style: TextStyle(
              fontFamily: 'Proxinova',
              fontSize: 19.0,
              fontWeight: FontWeight.w700,
              color: Colors.red));
    } else {
      return Text(status,
          style: TextStyle(
              fontFamily: 'Proxinova',
              fontSize: 19.0,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColorDark));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
//        Navigator.of(context).pop();
//        Navigator.of(context).push(MaterialPageRoute(
//            builder: (ctxt) => new OrderDetailScreen(
//              orderId: id,
//              custName: customerName,
//              status: status,
//            )));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctxt) => new OrderDetailScreen(
                      orderId: id,
                      custName: customerName,
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
                            TextStyle(fontSize: 16.0, fontFamily: 'Proxinova'),
                      ),
                      Text(
                        'Order Id: $id',
                        style:
                            TextStyle(fontSize: 16.0, fontFamily: 'Proxinova'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(customerName,
                      style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Proxinova')),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text('Total Price $totPrice',
                        style: TextStyle(
                            fontFamily: 'Proxinova',
                            fontSize: 19.0,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).accentColor)),
                  ),
                  setText(context, status),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: paymentStatus == 'Success'
                        ? Text('Payment received',
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
