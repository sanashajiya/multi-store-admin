import 'package:flutter/cupertino.dart';

class ProductScreen extends StatelessWidget {
  static const String id = '\products-screen';
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Product Screen',
      ),
    );
  }
}