import 'package:by_hand/components/card.dart';
import 'package:by_hand/models/notes.dart';
import 'package:by_hand/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Notes> notes = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  getProducts() async {
    EasyLoading.show(status: "Loading".tr);
    SharedPreferences a = await SharedPreferences.getInstance();
    NotesProviders().getAllByAccount(a.getInt('account_no')).then((value) {
      EasyLoading.dismiss();
      setState(() {
        notes = value;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Notes",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 20),),
      ),
      body: Stack(
        children: [
          listViewNotes(),
        ],
      ),
    );
  }



  Widget listViewNotes() => Padding(
    padding: const EdgeInsets.only(bottom: 60.0),
    child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContainerCard(
                    Icons.speaker_notes_outlined,
                    '${notes[index].title}',
                    '${notes[index].createdAt}',
                    '',
                    Colors.white,
                    Colors.teal,
                    radius: 16.0,),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 16),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8),
                      child: Text(
                        '${notes[index].details}',
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
  );
}