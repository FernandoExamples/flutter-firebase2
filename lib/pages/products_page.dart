import 'package:firebase/models/product.dart';
import 'package:firebase/providers/firebase_provider.dart';
import 'package:firebase/routes.dart';
import 'package:firebase/widgets/card_product.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final _firebaseProvider = FirebaseProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, Routes.ADD_PRODUCT),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _firebaseProvider.getAllProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: snapshot.data!.map((product) {
                    return CardProduct(product: product);
                  }).toList(),
                );
        },
      ),
    );
  }
}
