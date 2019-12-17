import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/model/material_item.dart';
import 'package:saray_app/widget/mat_cat.dart';

class MaterialListScreen extends StatefulWidget {
  static String id = 'MaterialListScreen';
  final String title;

  MaterialListScreen({this.title});

  @override
  _MaterialListScreenState createState() =>
      _MaterialListScreenState(title: title);
}

class _MaterialListScreenState extends State<MaterialListScreen> {
  final String title;
  List<MaterialItem> list = List();
  bool showSpinner = false;

  _MaterialListScreenState({this.title});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSpinner = true;
    getAllMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: ListView(
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
                  .map((catData) => MatCat(
                        title: catData.title,
                        description: catData.description,
                        id: catData.id,
                        imageUrl: catData.imgUrl,
                        unit: catData.unit,
                        price: catData.price,
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

  Future<String> getAllMaterials() async {
    print('========= getData called For Items===========');
    var response = await http
        .get('$BASEURL/api/customer.php?method=item_list');

    this.setState(() {
      dynamic data = json.decode(response.body)['RESULT'];

      if (response.statusCode == 200) {
        list = (data as List)
            .map((data) => new MaterialItem.fromJson(data))
            .toList();

        String firstname = list[0].title;
        print('All Mat items: $firstname');

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
