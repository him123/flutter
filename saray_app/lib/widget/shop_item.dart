import 'package:flutter/material.dart';
import 'package:saray_app/model/shop_by_matid.dart';
import 'package:saray_app/screens/material_details_screen.dart';
import 'package:saray_app/screens/single_item_material.dart';

class ShopItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String address;
  final String price;
  final String matImg;
  final String matName;
  final String email;
  final String phone;
  final String sid;
  final String unit;


  ShopItem(
      {@required this.id,
      @required this.name,
      @required this.imageUrl,
      @required this.description,
      @required this.address,
      @required this.price,
      @required this.matImg,
      @required this.matName,

      @required this.email,
      @required this.phone,
      @required this.sid,
      @required this.unit


      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,

            new MaterialPageRoute(
                builder: (ctxt) => new MaterialDetailScreen(
                  title: name,
                  imgUrl: matImg,
                  matName: matName,

                  shopByMat: ShopByMat(
                    image: matImg,
                    price: price,
                    description: description,
                    company: '',
                    item_id: id,
                    item_name: matName,
                    profile: '',
                    supplier_address: address,
                    supplier_email: email,
                    supplier_id: sid,
                    supplier_name: name,
                    supplier_phone: phone,
                    unit: unit,
                  ),
                )));
//            new MaterialPageRoute(
//                builder: (ctxt) => new MaterialDetailScreen(
//                      title: name,
//                      imgUrl: matImg,
//                      matName: matName,
//                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(7.0),
              topLeft: Radius.circular(7.0)),
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
//                      name,
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
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 23.0, fontFamily: 'Sackers'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    address,
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Proxinova', fontWeight: FontWeight.bold),
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
