import 'package:flutter/material.dart';
import 'package:saray_app/model/shop_by_matid.dart';
import 'package:saray_app/screens/material_details_screen.dart';

class MatItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String shopName;
  final String price;
  final String unit;
  final String address;
  final String phone;
  final String sid;
  final String email;

  MatItem(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.description,
      @required this.shopName,
      @required this.price,
      @required this.unit,
      @required this.address,
      @required this.phone,
      @required this.sid,
      @required this.email});

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
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (ctxt) => new MaterialDetailScreen(
                      title: shopName,
                      imgUrl: imageUrl,
                      matName: title,
                      shopByMat: ShopByMat(
                        image: imageUrl,
                        price: price,
                        description: description,
                        company: '',
                        item_id: id,
                        item_name: title,
                        profile: '',
                        supplier_address: address,
                        supplier_email: email,
                        supplier_id: sid,
                        supplier_name: shopName,
                        supplier_phone: phone,
                        unit: unit,
                      ),
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
//                Positioned(
//                  child: Container(
//                    width: 200,
//                    color: Colors.black54,
//                    padding: EdgeInsets.symmetric(
//                      vertical: 10,
//                      horizontal: 30,
//                    ),
//                    child: Text(
//                      title,
//                      style: TextStyle(
//                          fontSize: 16,
//                          color: Colors.white,
//                          fontWeight: FontWeight.bold),
//                      softWrap: true,
//                      overflow: TextOverflow.fade,
//                    ),
//                  ),
//                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
