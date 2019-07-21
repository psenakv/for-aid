// AddPersonScreen.dart

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:probable_pancake/utils/components.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'package:probable_pancake/utils/send_data_prepare.dart';

class AddPersonScreen extends StatefulWidget {
  AddPersonScreen({Key key}) : super(key: key);
  _AddPersonScreenState createState() => _AddPersonScreenState();
}
class _AddPersonScreenState extends State<AddPersonScreen> {
  final idInputController = TextEditingController();

  @override
  void dispose() {
    idInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CustomComponents cmp = new CustomComponents(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('AddPerson Screen'),
        ),
        drawer: cmp.getDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //TODO send data
          },
          tooltip: 'Add this person',
          child: Icon(Icons.text_fields),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Container(
                height: 80,
                child: Center(
                    child: Container(
                        child: Text("Add Person")
                    )
                )
            ),
            FutureBuilder(
              future: this.getData(),
              builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  if(snapshot.hasData) {idInputController.text = snapshot.data;}
                  return snapshot.hasData
                      ? Container(
                        child: Column(children: <Widget>[
                          Center(
                            //ID input disabled
                            child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter a ID'
                                  ),
                                  controller: idInputController,
                                  readOnly: true,
                                  
                                )
                          ),
                        ],)
                      )
                      : Center(child: CircularProgressIndicator());
                },

            ),
          ],
        ),
    );
  }

  Future<String> getData() async {
    try {
      String barcode = await BarcodeScanner.scan();
      return barcode;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
          return 'The user did not grant the camera permission!';
      } else {
        return 'Unknown error: $e';
      }
    } on FormatException{
      return 'null (User returned using the "back"-button before scanning anything. Result)';
    } catch (e) {
      return 'Unknown error: $e';
    }
  }
}