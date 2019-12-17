import 'package:flutter/material.dart';
import 'package:saray_app/model/material_item.dart';

import 'package:saray_app/model/meal.dart';
import 'package:saray_app/screens/single_item_material.dart';
import 'package:saray_app/screens/single_item_shop.dart';

class MatCat extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String unit;
  final String price;

  MatCat({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.unit,
    @required this.price,
  });

  void selectMeal(BuildContext context) {
    print('Tappped');
    Navigator.of(context).pushNamed(
      SingleItemShop.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Tappped');
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (ctxt) => new SingleItemShop(
                      matImg: imageUrl,
                      matName: title,
                      matId: id,
                      materialItem: MaterialItem(
                          id: id,
                          price: price,
                          description: description,
                          unit: unit,
                          company: '',
                          imgUrl: imageUrl,
                          title: title),
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
                    fit: BoxFit.fill,
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
                      title,
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
