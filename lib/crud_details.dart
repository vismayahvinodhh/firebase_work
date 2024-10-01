import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Crud_viewdetails extends StatefulWidget {
  const Crud_viewdetails({super.key, required this.id});
final id;
  @override
  State<Crud_viewdetails> createState() => _Crud_viewdetailsState();
}

class _Crud_viewdetailsState extends State<Crud_viewdetails> {
  Future<void>Getbyid() async{
    Product=await FirebaseFirestore.instance.collection("ProductCollection").doc(widget.id).get();
  }
  DocumentSnapshot?Product;
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(future: Getbyid(),builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting)
        return CircularProgressIndicator(color: Colors.black,);
    if(snapshot.hasError){
      return Text("${snapshot.error}");
    }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Center(
            child: Text(
              "NAME",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Text(
                  Product!["PRODUCT_DETAILS"],
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      );
    },

    );
  }
}
