import 'package:by_hand/models/user.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/utilities/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class UsersGet extends StatefulWidget {
  @override
  _UsersGetState createState() => _UsersGetState();
}

class _UsersGetState extends State<UsersGet> {
  List<Users> myModels = [];
  List<Users> _debit = List<Users>();
  List<Users> _debitDisplay = List<Users>();
  TextEditingController search = TextEditingController();
  ApiBaseHelper _helper = ApiBaseHelper();
 int _selectedIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    EasyLoading.show(status: "Loading".tr);
    UserProvider().getAll().then((value) {
      EasyLoading.dismiss();
      setState(() {
        myModels=value;
        _debit.addAll(value);
        _debitDisplay = _debit;
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
        title: Text("Users",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 20),),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              SearchWidget(
                      (text) {
                    text = text.toLowerCase();
                    setState(() {
                      myModels = _debit.where((post) {
                        var postTitle = post.fname.toLowerCase()+post.lname.toLowerCase();
                        return postTitle.contains(text);
                      }).toList();
                    });
                  },
                  search,
                      () {
                    search.clear();
                    setState(() {
                      myModels = _debit;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: myModels.isNotEmpty?myModels.length-1:0,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 6,
                                offset: Offset(0, 5))
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myModels[index+1].imageUrl != null &&myModels[index+1].imageUrl!=''
                                ? CircleAvatar(
                              backgroundImage:
                              NetworkImage("${_helper.imageServer+myModels[index+1].imageUrl}"),
                              radius: 55,
                            )
                                : CircleAvatar(
                              backgroundImage:
                              AssetImage("assets/images/account.png"),
                              radius: 55,
                            ),
                          ),
                          Text(
                            '${myModels[index+1].fname+" "+myModels[index+1].lname}'.toUpperCase(),
                            style: TextStyle(color: Colors.grey, fontSize: 22),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton.icon(
                                    onPressed: () {
                                      _showDoneDia(index+1);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                      size: 15,
                                    ),
                                    label: Text(
                                      'Delete'.tr,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12),
                                    )),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          handelEditAccount(3,myModels[index].id);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16.0),
                                              color: Colors.grey
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text("User",style: TextStyle(color: Colors.white),),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 2,),
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          handelEditAccount(2,myModels[index].id);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                            color: Colors.orangeAccent
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text("Super",style: TextStyle(color: Colors.white),),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },),
              ),
            ],
          )
      ),
    );
  }

  Future<void> _showDoneDia(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('delete item'.tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('yes'.tr),
              onPressed: () {
                handleDeleteAction(index);
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }

  handleDeleteAction(int index) async {
    try {
      String textMessage;

      await UserProvider().destroyUser(myModels[index].id).then((value) {
        setState(() {
          textMessage = value['message'];
        });
      }).catchError((ex) {
        throw (ex);
      });

      ss(textMessage);
    } catch (ex) {
      print(ex);
    }

    getUserData();
  }

  Widget ss(String message) => SnackBar(
    content: Text(
      '$message'.tr,
      textAlign: TextAlign.center,
    ),
  );

  handelEditAccount(int type,int index) async {


      UserProvider()
          .editUser(type,index)
          .then((var res) async {
            EasyLoading.showSuccess(res['message'].toString());
          }).catchError((ex) {
        setState(() {
          EasyLoading.showError(ex.toString());
          print(ex);
        });
      });
    }


}
