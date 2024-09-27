
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'crud_add.dart';

class crud_update extends StatefulWidget {
  const crud_update({super.key});

  @override
  State<crud_update> createState() => _crud_updateState();
}

class _crud_updateState extends State<crud_update> {

  var Name_ctrl = TextEditingController();
  var Details_ctrl = TextEditingController();

  Future<void> Add_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    data.setString("Name", Name_ctrl.text);
    data.setString("Details", Details_ctrl.text);
    print(
        "Added Successfully!");
  }

  final formkey = GlobalKey<FormState>();


  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Enter The Values'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(child: Text(" UPDATE PRODUCT  ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 200,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: Name_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Name',
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(25)),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: Details_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Details',
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(25)),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
                  child: InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        print("Details Submitted");
                        Add_data_sp();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Add_crud();

                          },
                        ));


                      }
                      else{
                        _showSnackBar(context);

                      }

                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                            'UPDATE',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}