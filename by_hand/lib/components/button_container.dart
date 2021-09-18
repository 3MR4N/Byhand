import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer(
      {Key key, @required this.buttonName, @required this.fun, this.imageCust})
      : super(key: key);

  final String buttonName;
  final Function fun;
  final String imageCust;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: fun,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        width: 350,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(color: Colors.white12, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageCust != null
                ? Container(
              padding: EdgeInsets.fromLTRB(8, 8, 5, 8),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Center(
                child: Image(
                    image: AssetImage(imageCust), fit: BoxFit.scaleDown),
              ),
            )
                : Container(),
            Container(
              width: 150,
              child: Text(
                buttonName,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}