import 'package:flutter/material.dart';

import '../my_flutter_app_icons.dart';

class ContainerCard extends StatelessWidget {
  ContainerCard(this.iconCont, this.textName, this.textDate, this.price,
      this.colorCont, this.colorShade,
      {this.radius});

  @required
  final IconData iconCont;
  @required
  final Color colorCont;
  @required
  final Color colorShade;
  @required
  final String textName;
  @required
  final String textDate;
  @required
  final String price;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(radius != null ? radius : 0),
            topLeft: Radius.circular(radius != null ? radius : 0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorShade,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(iconCont, size: 30, color: colorCont),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textName,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        fontSize: 20,
                        color: colorShade,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(MyFlutterApp.calendar,size: 12,color: Colors.grey,),
                      ),
                      Text(
                        textDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              price,
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}