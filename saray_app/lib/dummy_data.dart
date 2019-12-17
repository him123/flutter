import 'package:flutter/material.dart';
import 'package:saray_app/model/material_category.dart';
import 'package:saray_app/model/material_item.dart';
import 'package:saray_app/widget/shop_wdget.dart';

const DUMMY_CAT = const [
  MaterialCategory(
    id: '1',
    title: 'Cement',
    description: 'This is cement',
    imgUrl: 'https://www.dsij.in/Portals/0/EasyDNNnews/6679/img-Cement.jpg',
  ),
  MaterialCategory(
    id: '2',
    title: 'Steel',
    description: 'This is cement',
    imgUrl:
        'https://5.imimg.com/data5/PL/VF/MY-4284841/tmt-steel-bars-500x500.jpg',
  ),
  MaterialCategory(
    id: '3',
    title: 'Tiles',
    description: 'This is cement',
    imgUrl:
        'https://www.designingbuildings.co.uk/w/images/0/0c/Ceramic_tiles.JPG',
  ),
  MaterialCategory(
    id: '4',
    title: 'Concrete',
    description: 'This is cement',
    imgUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Talbruecke-Bruenn_2005-08-04.jpg/220px-Talbruecke-Bruenn_2005-08-04.jpg',
  ),
  MaterialCategory(
    id: '5',
    title: 'Adobe',
    description: 'This is cement',
    imgUrl:
        'https://cdn.britannica.com/31/102931-050-1EED5122/Adobe-house-Santa-Fe-NM.jpg',
  ),
  MaterialCategory(
    id: '6',
    title: 'Lime',
    description: 'This is cement',
    imgUrl:
        'https://lh3.googleusercontent.com/0hvDz3uUvOi0bw6JAz3Y1_NpgE6lfVumqjEuJ0xCtjTxe7O05ovTlBRCBsogi1pTAvL1=s140',
  ), MaterialCategory(
    id: '1',
    title: 'Cement',
    description: 'This is cement',
    imgUrl: 'https://www.dsij.in/Portals/0/EasyDNNnews/6679/img-Cement.jpg',
  ),
  MaterialCategory(
    id: '2',
    title: 'Steel',
    description: 'This is cement',
    imgUrl:
    'https://5.imimg.com/data5/PL/VF/MY-4284841/tmt-steel-bars-500x500.jpg',
  ),
  MaterialCategory(
    id: '3',
    title: 'Tiles',
    description: 'This is cement',
    imgUrl:
    'https://www.designingbuildings.co.uk/w/images/0/0c/Ceramic_tiles.JPG',
  ),
  MaterialCategory(
    id: '4',
    title: 'Concrete',
    description: 'This is cement',
    imgUrl:
    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Talbruecke-Bruenn_2005-08-04.jpg/220px-Talbruecke-Bruenn_2005-08-04.jpg',
  ),
  MaterialCategory(
    id: '5',
    title: 'Adobe',
    description: 'This is cement',
    imgUrl:
    'https://cdn.britannica.com/31/102931-050-1EED5122/Adobe-house-Santa-Fe-NM.jpg',
  ),
  MaterialCategory(
    id: '6',
    title: 'Lime',
    description: 'This is cement',
    imgUrl:
    'https://lh3.googleusercontent.com/0hvDz3uUvOi0bw6JAz3Y1_NpgE6lfVumqjEuJ0xCtjTxe7O05ovTlBRCBsogi1pTAvL1=s140',
  ),
];

const DUMMY_ITEMS = const [
  MaterialItem(
      id: '1',
      title: 'Cement 1',
      description: 'This is cement',
      imgUrl: '',
      price: '156'),
  MaterialItem(
      id: '1',
      title: 'Cement 2',
      description: 'This is cement',
      imgUrl: '',
      price: '156'),
  MaterialItem(
      id: '1',
      title: 'Cement 3',
      description: 'This is cement',
      imgUrl: '',
      price: '156 4'),
  MaterialItem(
      id: '1',
      title: 'Cement 5',
      description: 'This is cement',
      imgUrl: '',
      price: '156'),
  MaterialItem(
      id: '1',
      title: 'Cement 6',
      description: 'This is cement',
      imgUrl: '',
      price: '156'),
  MaterialItem(
      id: '1',
      title: 'Cement 7',
      description: 'This is cement',
      imgUrl: '',
      price: '156'),
  MaterialItem(
      id: '1',
      title: 'Cement 1',
      description: 'This is cement',
      imgUrl: '',
      price: '156'),
  MaterialItem(
      id: '1',
      title: 'Cement 2',
      description: 'This is cement',
      imgUrl: '',
      price: '156'),
  MaterialItem(
      id: '1',
      title: 'Cement 3',
      description: 'This is cement',
      imgUrl: '',
      price: '156 4'),
  MaterialItem(
      id: '1',
      title: 'Cement 5',
      description: 'This is cement',
      imgUrl: '',
      price: '156'),
  MaterialItem(
      id: '1',
      title: 'Cement 6',
      description: 'This is cement',
      imgUrl: '',
      price: '156'),
  MaterialItem(
      id: '1',
      title: 'Cement 7',
      description: 'This is cement',
      imgUrl: '',
      price: '156'),
];

const DUMMY_SHOPS = const [
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://www.mercedes-benz.com/wp-content/uploads/sites/3/2014/11/classic_store_museumsshop_d385089_3400x1440.jpg',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://www.buildmate.com.sg/wp-content/uploads/2017/05/eunos.jpg',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp5e-hkkg9ra4axGWQSTiJBqZg6Ku-9gMAVnHwN6rnlC5y_wTUrw&s',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://www.shopbahrain.com/assets/images/sb-logo18.png',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://www.mercedes-benz.com/wp-content/uploads/sites/3/2014/11/classic_store_museumsshop_d385089_3400x1440.jpg',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://www.buildmate.com.sg/wp-content/uploads/2017/05/eunos.jpg',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp5e-hkkg9ra4axGWQSTiJBqZg6Ku-9gMAVnHwN6rnlC5y_wTUrw&s',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://www.shopbahrain.com/assets/images/sb-logo18.png',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://www.mercedes-benz.com/wp-content/uploads/sites/3/2014/11/classic_store_museumsshop_d385089_3400x1440.jpg',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://www.buildmate.com.sg/wp-content/uploads/2017/05/eunos.jpg',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp5e-hkkg9ra4axGWQSTiJBqZg6Ku-9gMAVnHwN6rnlC5y_wTUrw&s',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  ),
  ShopWidget(
    id: '1',
    description: 'Cement Shop',
    imageUrl: 'https://www.shopbahrain.com/assets/images/sb-logo18.png',
    address: 'Guly bazar',
    name: 'Azuara Materials',
    price: '200',
  )
];
