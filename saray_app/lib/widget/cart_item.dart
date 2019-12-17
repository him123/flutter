import 'package:flutter/material.dart';
import 'package:saray_app/model/shop_by_matid.dart';
import 'package:saray_app/screens/material_details_screen.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String price;
  final String unit;
  final String sid;
  final String date;
  final String qty;

  CartItem(

      {@required this.id,
        @required this.title,
        @required this.imageUrl,
        @required this.description,
        @required this.price,
        @required this.unit,
        @required this.sid,
        @required this.date,
        @required this.qty,
      });

  void selectMeal(BuildContext context) {
//    Navigator.of(context)
//        .pushNamed(
//      MealDetailScreen.routeName,
//      arguments: id,
//    )
//        .then((result) {
//      if (result != null) {
//        // removeItem(result);
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
//        Navigator.push(
//            context,
//            new MaterialPageRoute(
//                builder: (ctxt) => new MaterialDetailScreen(
//                      title: shopName,
//                      imgUrl: imageUrl,
//                      matName: title,
//                      shopByMat: ShopByMat(
//                        image: imageUrl,
//                        price: price,
//                        description: description,
//                        company: '',
//                        item_id: id,
//                        item_name: title,
//                        profile: '',
//                        supplier_address: address,
//                        supplier_email: email,
//                        supplier_id: sid,
//                        supplier_name: shopName,
//                        supplier_phone: phone,
//                        unit: unit,
//                      ),
//                    )));
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
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7.0),
                      topLeft: Radius.circular(7.0)),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Id: $id',
                    style: TextStyle(fontSize: 23.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 23.0, fontFamily: 'Sackers'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Price',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Icon(
                        Icons.attach_money,
                        size: 20.0,
                      ),
                      Text(
                        price,
                        style: TextStyle(fontSize: 20.0, fontFamily: 'Proxinova', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Per',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        unit,
                        style: TextStyle(fontSize: 20.0, fontFamily: 'Proxinova', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    date,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    qty,
                    style: TextStyle(fontSize: 20.0),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
