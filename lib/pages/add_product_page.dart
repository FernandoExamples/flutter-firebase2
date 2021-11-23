import 'dart:io';

import 'package:firebase/device/image_selector.dart';
import 'package:firebase/models/product.dart';
import 'package:firebase/providers/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final firebaseProvider = FirebaseProvider();
  final imageSelector = ImageSelector();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  XFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nuevo Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(label: Text('Nombre')),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Campo obligatorio';
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: descController,
                  decoration: InputDecoration(label: Text('Descripcion')),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Campo obligatorio';
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Elegir Imagen'),
                  onPressed: () async {
                    pickedImage = await imageSelector.showSelectionDialog(context);

                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 250,
                  child: _buildImage(),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: loading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          child: Text('Guardar'),
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) return;
                            if (pickedImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Selecciona una imagen'),
                                dismissDirection: DismissDirection.horizontal,
                              ));
                              return;
                            }

                            setState(() => loading = true);

                            try {
                              final imageUrl = await firebaseProvider.uploadImage(File(pickedImage!.path));
                              final name = nameController.text;
                              final desc = descController.text;
                              final product = Product(description: desc, name: name, imageUrl: imageUrl);
                              firebaseProvider.saveProduct(product);
                              setState(() => loading = false);
                              Navigator.of(context).pop();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Hubo un problema al guardar los datos. Verifica tu conexión a internet'),
                                dismissDirection: DismissDirection.horizontal,
                              ));
                              setState(() => loading = false);
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return pickedImage == null ? Center(child: Text('Selecciona una imagen')) : Image.file(File(pickedImage!.path));
  }

  @override
  void dispose() {
    descController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
