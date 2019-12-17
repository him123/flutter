import 'package:flutter/material.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/model/material_category.dart';
import 'package:saray_app/model/meal.dart';
import 'package:saray_app/screens/material_list_screen.dart';
import 'package:saray_app/screens/shope_screen.dart';
import 'package:saray_app/widget/mat_cat.dart';
import 'package:saray_app/widget/mat_item.dart';
import 'package:saray_app/widget/shop_wdget.dart';

import '../dummy_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final items = List<String>.generate(10000, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Shops',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                ShopWidget(
                    id: '1',
                    name: 'name',
                    imageUrl:
                        'https://cdn.images.express.co.uk/img/dynamic/1/590x/elmer-1018174.jpg?r=1537065797885',
                    description: 'dfsafd',
                    address: 'fdafd',
                    price: 'fdafds'),
                ShopWidget(
                    id: '1',
                    name: 'name',
                    imageUrl:
                        'https://cdn.images.express.co.uk/img/dynamic/1/590x/elmer-1018174.jpg?r=1537065797885',
                    description: 'dfsafd',
                    address: 'fdafd',
                    price: 'fdafds'),
                ShopWidget(
                    id: '1',
                    name: 'name',
                    imageUrl:
                        'https://cdn.images.express.co.uk/img/dynamic/1/590x/elmer-1018174.jpg?r=1537065797885',
                    description: 'dfsafd',
                    address: 'fdafd',
                    price: 'fdafds'),
                ShopWidget(
                    id: '1',
                    name: 'name',
                    imageUrl:
                        'https://cdn.images.express.co.uk/img/dynamic/1/590x/elmer-1018174.jpg?r=1537065797885',
                    description: 'dfsafd',
                    address: 'fdafd',
                    price: 'fdafds'),
                ShopWidget(
                    id: '1',
                    name: 'name',
                    imageUrl:
                        'https://cdn.images.express.co.uk/img/dynamic/1/590x/elmer-1018174.jpg?r=1537065797885',
                    description: 'dfsafd',
                    address: 'fdafd',
                    price: 'fdafds'),
              ],
            ),
          ),
        ),
        Text(
          'Building Material',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Flexible(
          flex: 15,
          child: GridView(
            children: DUMMY_CAT
                .map((catData) => MatCat(
                      title: catData.title,
                      description: catData.description,
                      id: catData.id,
                      imageUrl: catData.imgUrl,
                    ))
                .toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          ),
        )
      ],
    );
  }
}
