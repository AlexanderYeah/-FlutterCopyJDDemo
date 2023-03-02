import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cartProvider.dart';

class CartNumber extends StatefulWidget {
  const CartNumber({super.key});

  @override
  State<CartNumber> createState() => _CartNumberState();
}

class _CartNumberState extends State<CartNumber> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Column(
      children: [
        Text("我是数量子组件${cartProvider.cartListCount}"),
      ],
    );
  }
}
