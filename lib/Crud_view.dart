
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Crudupdate.dart';
import 'crud_add.dart';
import 'crud_details.dart';

class View_crud extends StatefulWidget {
  const View_crud({super.key});

  @override
  State<View_crud> createState() => _View_crudState();
}

class _View_crudState extends State<View_crud> {
  var _nameController = TextEditingController();
  var _descriptionController = TextEditingController();


  Future<void>Product_delete(String id)
  async {
    await
    FirebaseFirestore.instance.collection("ProductCollection").doc(id).delete();
  }
  Future<void> _updateProduct(
      String id, String name, String description) async {
    _nameController.text = name;
    _descriptionController.text = description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'PRODUCT_NAME'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'PRODUCT_DETAILS'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('ProductCollection')
                    .doc(id)
                    .update({
                  'PRODUCT_NAME': _nameController.text,
                  'PRODUCT_DETAILS': _descriptionController.text,
                });
                _nameController.clear();
                _descriptionController.clear();
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }@override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Add_crud();
            },
          ));
        },
        backgroundColor: Colors.grey,
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Add_crud();
              },
            ));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text("               VIEW  PRODUCTS ",
            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("ProductCollection")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            final Product = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: Product.length,
              itemBuilder: (context, index) {
                final doc = Product[index];
                final PRODUCT_DETAILS = doc.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Crud_viewdetails();
                    },));
                  },
                    child: Card(color: Colors.brown.shade200
                      ,
                      child: ListTile(
                        title: Text(
                          "Name : ${PRODUCT_DETAILS["PRODUCT_NAME"]??""}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                        ),
                        subtitle: Text(
                          "Details  : ${PRODUCT_DETAILS["PRODUCT_DETAILS"]??""}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        trailing: Wrap(children: [
                          IconButton(
                              onPressed: () {
                               _updateProduct(doc.id, PRODUCT_DETAILS["PRODUCT_NAME"]??"", PRODUCT_DETAILS["PRODUCT_DETAILS"]??"");
                              },
                              icon: Icon(
                                Icons.edit_note,
                                color: Colors.black,
                              )),
                          IconButton(
                              onPressed: () {
                                Product_delete(doc.id
                                );
                                },
                              icon: Icon(
                                CupertinoIcons.delete,
                                color: Colors.black,
                              ))
                        ]),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}