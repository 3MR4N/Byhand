import 'package:by_hand/models/notes.dart';
import 'package:by_hand/providers/notes_provider.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';


class RequestNote extends StatefulWidget {
  @override
  _RequestNoteState createState() => _RequestNoteState();
}

class _RequestNoteState extends State<RequestNote> {
  TextEditingController titleNote = TextEditingController();
  TextEditingController details = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: appbarNotes(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textNameTextField('Title'.tr),
                textFieldCustom(1, titleNote),
                SizedBox(
                  height: 15,
                ),
                textNameTextField('Details'.tr),
                textFieldCustom(5, details),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primColor,
                        ),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Cancel".tr,
                          style: TextStyle(
                              color: AppColors.primColor, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primColor,
                      ),
                      child: TextButton(
                        onPressed: () {
                          handelNoteAdded();
                        },
                        child: Text(
                          "Submit".tr,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appbarNotes() => AppBar(
    backgroundColor: AppColors.primColor,
    title: Text('Send message'.tr),
    centerTitle: true,
  );

  Widget textNameTextField(String nameField) => Row(
    children: [
      Text(
        "$nameField",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(
        " *",
        style: TextStyle(color: Colors.red),
      ),
    ],
  );

  Widget textFieldCustom(int _maxLine, TextEditingController _controller) =>
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black12,
                width: 1,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                  controller: _controller,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: _maxLine,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  )),
            ),
          ));

  Widget snackBar(String message) => SnackBar(
    content: Text(
      '$message',
      textAlign: TextAlign.center,
    ),
  );

  _validation() {
    if (titleNote.text.isEmpty) {
      setState(() {
        _errorMessage = 'title_required_field'.tr;
        EasyLoading.showError(_errorMessage);
      });
      return false;
    }
    if (details.text.isEmpty) {
      setState(() {
        _errorMessage = 'details_required_field'.tr;
        EasyLoading.showError(_errorMessage);
      });
      return false;
    }

    return true;
  }

  handelNoteAdded() async {
    try {
      if (_validation()) {
        setState(() {
          _errorMessage = '';
        });
        String textMessage;
        SharedPreferences presf = await SharedPreferences.getInstance();
        Notes note = new Notes();
        note.title = titleNote.text;
        note.details = details.text;
        note.accountId = presf.getInt('id');
        await NotesProviders().create(note).then((value) {
          setState(() {
            textMessage = value['message'];
          });
        }).catchError((ex) {
          print(ex);
        });
        Navigator.pop(context);
        EasyLoading.showSuccess(textMessage,duration: Duration(seconds: 2));

      }
    } catch (ex) {
      print(ex);
    }
  }
}