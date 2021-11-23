import 'package:firebase/models/product.dart';
import 'package:flutter/material.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: double.infinity,
          child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(product.imageUrl),
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 100),
            height: 230.0,
          ),
        ),
        Opacity(
          opacity: 0.6,
          child: Container(
            height: 55.0,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text('${product.name} - ${product.description}', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
