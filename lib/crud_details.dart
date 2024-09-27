import 'package:flutter/material.dart';

class Crud_viewdetails extends StatefulWidget {
  const Crud_viewdetails({super.key});

  @override
  State<Crud_viewdetails> createState() => _Crud_viewdetailsState();
}

class _Crud_viewdetailsState extends State<Crud_viewdetails> {
  @override
  Widget build(BuildContext context) {
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
                "      Details:    ",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
