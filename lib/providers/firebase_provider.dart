import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:firebase/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseProvider {
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;
  late CollectionReference<Map<String, dynamic>> _productCollection;

  FirebaseProvider() {
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
    _productCollection = _firestore.collection('products');
  }

  Future<void> saveProduct(Product product) {
    return _productCollection.add(product.toMap());
  }

  Future<void> updateProduct(Product product, String DocumentID) {
    return _productCollection.doc(DocumentID).update(product.toMap());
  }

  Future<void> deleteProduct(String DocumentID) {
    return _productCollection.doc(DocumentID).delete();
  }

  Stream<List<Product>> getAllProducts() {
    return _productCollection.snapshots().map(
          (event) => event.docs.map((e) {
            final product = Product.fromMap(e.data());
            product.id = e.id;

            return product;
          }).toList(),
        );
  }

  Future<String> uploadImage(File file) async {
    final newName = DateTime.now().millisecondsSinceEpoch;
    final ext = path.extension(file.path);
    final uploadTask = await _storage.ref().child('products/$newName$ext').putFile(file);
    final url = await uploadTask.ref.getDownloadURL();

    return url;
  }
}
