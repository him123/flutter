import 'dart:convert';

import 'package:flutter/foundation.dart';

class CartItem {

  final int quantity;//
  final double price;//
  final String date;//
  final String unit;//
  final String matid;//

  CartItem({
    @required this.quantity,//
    @required this.price,//
    @required this.date,//
    @required this.unit,//
    @required this.matid,//
  });

  Map<String,dynamic> toJson(){
    return {
      "material_id": this.matid,
      "qty": this.quantity,
      "price": this.price,
      "unit": this.unit,
      "del_date": this.date
    };
  }

  static List encondeToJson(List<CartItem>list){
    List jsonList = List();

    list.map((item)=>
        jsonList.add(item.toJson())
    ).toList();
    return jsonList;
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }



  int get itemCount {
    return _items.length;
  }

//  void addItem({
//    String productId,
//    String materialId,
//    String supplierId,
//    double price,
//    String title,
//    String shopName,
//    String img,
//    String date,
//    String unit,
//    int qty,
//  }) {
//    if (_items.containsKey(productId)) {
//      // change quantity...
//      _items.update(
//        productId,
//        (existingCartItem) => CartItem(
//            matid: existingCartItem.matid,
//            shop: existingCartItem.shop,
//            id: existingCartItem.id,
//            title: existingCartItem.title,
//            price: existingCartItem.price,
//            quantity: existingCartItem.quantity + 1,
//            img: existingCartItem.img,
//            date: existingCartItem.date,
//            sid: existingCartItem.sid,
//            unit: existingCartItem.unit),
//      );
//    } else {
//      print('========Item Added');
//      _items.putIfAbsent(
//        productId,
//        () => CartItem(
//            matid: materialId,
//            shop: shopName,
//            id: DateTime.now().toString(),
//            title: title,
//            price: price,
//            quantity: qty,
//            sid: supplierId,
//            date: date,
//            img: img,
//            unit: unit),
//      );
//    }
//    notifyListeners();
//  }


}
