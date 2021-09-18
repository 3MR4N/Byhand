import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String category;
  final String name;
  final String description;
  final String imgUrl;
  final double price;
  final bool isfav;

  Product(
      {@required this.id,
      @required this.category,
      @required this.name,
      @required this.description,
      @required this.imgUrl,
      @required this.price,
      this.isfav});
}

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: '1',
      name: 'Bracelets',
      imgUrl:
          'https://m.media-amazon.com/images/G/01/handmade/StorefrontMerch/Q2Flip/sbc_bracelet_B078XMCLDJ._CB465207803_.jpg',
      price: 15,
      category: 'jewelry',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
    ),
    Product(
      id: '2',
      name: 'Necklaces',
      imgUrl:
          'https://m.media-amazon.com/images/G/01/handmade/StorefrontMerch/Q2Flip/sbc_necklace_B07GLVT1XK._CB465208267_.jpg',
      price: 25,
      category: 'jewelry',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
    ),
    Product(
      id: '3',
      name: 'Earrings',
      imgUrl:
          'https://m.media-amazon.com/images/G/01/handmade/StorefrontMerch/Q2Flip/sbc_earrings_B07P9CQ59Q._CB465210778_.jpg',
      price: 43,
      category: 'jewelry',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
    ),
    Product(
      id: '4',
      name: 'Rings',
      imgUrl:
          'https://m.media-amazon.com/images/G/01/handmade/StorefrontMerch/Q2Flip/sbc_rings_BO7JNV5NFH._CB465210543_.jpg',
      price: 47,
      category: 'jewelry',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
    ),
    Product(
      id: '5',
      name: 'Wedding & Engagement Rings',
      imgUrl:
          'https://m.media-amazon.com/images/G/01/handmade/StorefrontMerch/Q2Flip/sbc_engagement_rings_B07L769FYK._CB465209356_.jpg',
      price: 54,
      category: 'jewelry',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
    ),
    Product(
      id: '6',
      name: 'Watches',
      imgUrl:
          'https://images-na.ssl-images-amazon.com/images/I/51Llz3ibR6L.jpg',
      price: 94,
      category: 'jewelry',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((pdt) => pdt.id == id);
  }
}
