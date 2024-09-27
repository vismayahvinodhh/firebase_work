
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Crud_view.dart';

class Add_crud extends StatefulWidget {
  const Add_crud({super.key});

  @override
  State<Add_crud> createState() => _Add_crudState();
}

class _Add_crudState extends State<Add_crud> {
  var Name_ctrl = TextEditingController();
  var Details_ctrl = TextEditingController();


  Future<void> Product_add() async {
    FirebaseFirestore.instance.collection("ProductCollection").add({
      "PRODUCT_NAME":Name_ctrl.text,
      "PRODUCT_DETAILS":Details_ctrl.text
    });
    print("Data Added Successfully");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return View_crud();
      },
    ));
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
          title: Center(
              child: Text(
                " ADD PRODUCT",
                style: TextStyle(color: Colors.white),
              )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                  height: 250,
                  width: 250,
                  color: Colors.brown,
                ),
                SizedBox(
                  height: 20,
                ),
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
                SizedBox(
                  height: 20,
                ),
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
                        Product_add();
                      } else {
                        _showSnackBar(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return View_crud();
                        },
                      ));
                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Text(
                            'View Details Entered',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}