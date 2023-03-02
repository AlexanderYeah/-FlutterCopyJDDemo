import 'package:flutter/material.dart';
import '../cart/cartItem.dart';
import '../cart/cartNumber.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // 购物车列表
    return Column(
      children: [
        //
        CartItem(),
        CartNumber()
      ],
    );
  }
}
