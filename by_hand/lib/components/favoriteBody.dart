import 'package:by_hand/models/favoriteModel.dart';
import 'package:by_hand/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePdt extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final String image;
  final String name;

  FavoritePdt(this.id, this.productId, this.price, this.image, this.name);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        Provider.of<Favorite>(context, listen: false).removeItem(productId);
      },
      child: Card(
        child: ListTile(
          leading: Container(
            child: Image.network(image),
          ),
          title: Text(name),
          trailing: Text('$price'),
          onTap: () {

          },
        ),
      ),
    );
  }
}
