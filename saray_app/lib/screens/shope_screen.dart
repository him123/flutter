import 'package:flutter/material.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/model/shop.dart';
import 'package:saray_app/widget/shop_wdget.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';



class ShopScreen extends StatefulWidget {
  static String id = 'ShopScreen';
  final String title;

  ShopScreen({this.title});

  @override
  _ShopScreenState createState() => _ShopScreenState(title: title);
}

class _ShopScreenState extends State<ShopScreen> {
  List<Shop> list = List();
  bool showSpinner = false;
  final String title;

  _ShopScreenState({this.title});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSpinner = true;

    getSuplliers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            Image.asset(
              'images/logo_name.png',
              height: 120.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            GridView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: list
                  .map((catData) => ShopWidget(
                        name: catData.name,
                        description: catData.description,
                        id: catData.id,
                        imageUrl: catData.imageUrl,
                        price: catData.price,
                        email: catData.email,
                        phone: catData.phone,
                        address: catData.address,
                      ))
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,

              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getSuplliers() async {
    print('========= getData called ===========');
    var response = await http.get(
        '$BASEURL/api/customer.php?method=all_suppler_list');

    this.setState(() {
      dynamic data = json.decode(response.body)['RESULT'];

      if (response.statusCode == 200) {
        list = (data as List).map((data) => new Shop.fromJson(data)).toList();

        String firstname = list[0].name;
        print('All Shops: $firstname');

        setState(() {
          showSpinner = false;
        });
      } else {
        throw Exception('Failed to load photos');
      }
    });

//    print(data[1]["name"]);

    showSpinner = false;
    return "Success!";
  }


}
