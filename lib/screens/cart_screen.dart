import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "CartScreen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
          children: [
      Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Chip(
              label: Text(
                '${cart.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
            ),
            TextButton(onPressed: () {
              Provider.of<Orders>(context,listen: false).addOrder(cart.items.values.toList(), cart.totalAmount);
              cart.clear();
            }, child: Text('Order Now')),
          ],
        ),
      ),
    ),
    Expanded(
    child: ListView.builder(
    itemBuilder: (ctx, ind) {
    return CartItemm(cart.items.values.toList()[ind].id,
        cart.items.keys.toList()[ind],
        cart.items.values.toList()[ind].title, cart.items.values.toList()[ind].price,
        cart.items.values.toList()[ind].quantity);
    },itemCount: cart.itemCount,),
    ),],
    ),
    );
    }
  }
