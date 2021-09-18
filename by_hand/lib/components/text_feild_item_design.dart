import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextItem extends StatelessWidget {

  final String txtHint;
  final int lineCount;
  final TextEditingController _con;


  TextItem(this.txtHint,this._con,{this.lineCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 6,
                  offset: Offset(0, 5))
            ],
          ),
          width: double.infinity,
          child: TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            controller: _con,
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            maxLines: lineCount==null?1:lineCount,
            decoration: new InputDecoration(

                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: txtHint,
              hintStyle: TextStyle(color: Colors.grey),

            ),
          )),
    );
  }
}
