import 'package:flutter/material.dart';

import 'package:saray_app/model/meal.dart';
import 'package:saray_app/model/shop.dart';
import 'package:saray_app/screens/single_item_material.dart';
import 'package:saray_app/screens/single_item_shop.dart';

class ShopWidget extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String address;
  final String price;
  final String phone;
  final String email;

//  final String

  const ShopWidget({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.description,
    @required this.address,
    @required this.price,
    @required this.phone,
    @required this.email,
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
        print('shope Tappped');
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (ctxt) => new SingleItemMaterial(
                      shopName: name,
                      shopId: id,
                      shop: Shop(
                          description: description,
                          price: price,
                          id: id,
                          name: name,
                          phone: phone,
                          email: email,
                          address: address,
                          imageUrl: ''),
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 1,
        margin: EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: Image.network(
                    imageUrl,
                    height: 100.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 120,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      name,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
