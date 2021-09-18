import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidget extends StatefulWidget {
  Function searchFun;
  TextEditingController controller;
  Function functionClear;

  SearchWidget(this.searchFun, this.controller, this.functionClear);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300], blurRadius: 6, offset: Offset(0, 5))
            ],
            borderRadius: BorderRadius.circular(15)),
        child: TextField(
          key: _formKey,
          autofocus: false,
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          controller: widget.controller,
          onChanged: widget.searchFun,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(
                  25.0,
                ),
              ),
              borderSide: BorderSide.none,
            ),
            filled: true,
            prefixIcon: new Icon(Icons.search, color:AppColors.primColor),
            suffixIcon: new IconButton(
              icon: Icon(Icons.clear),
              focusColor: Colors.black87,
              disabledColor:Colors.black54,
              hoverColor: Colors.black87,
              onPressed:
              widget.functionClear,),
            fillColor: Colors.white,
            hintText: 'Search'.tr,
          ),
        ),
      ),
    );
  }
}