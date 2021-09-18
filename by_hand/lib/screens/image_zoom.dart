import 'package:by_hand/my_flutter_app_icons.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoom extends StatefulWidget {
  ImageZoom(this.imageUrl);
  final String imageUrl;

  @override
  _ImageZoomState createState() => _ImageZoomState();
}

class _ImageZoomState extends State<ImageZoom> {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                child: PhotoView(
                  imageProvider: NetworkImage(_helper.imageServer+widget.imageUrl),
                ),

              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(icon: Icon(MyFlutterApp.cancel,color: Colors.white,size: 30,), onPressed: (){
                Navigator.pop(context);
              }),
            ),

          ],
        ),
      ),
    );
  }
}