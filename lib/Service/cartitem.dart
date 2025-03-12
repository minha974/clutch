import 'package:flutter/material.dart';

import '../MainPage/tool.dart';
class CartItem extends StatefulWidget {
  Tool tool;
  CartItem({
    super.key,
    required this.tool,
});
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:Image.asset(widget.tool.imagePath),
      title:Text(widget.tool.name),
      subtitle: Text(widget.tool.price),
    );
  }
}
