import 'package:flutter/material.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
class OrdersScreen extends StatelessWidget {

  static const routeName = "OrdersScreen";
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders'),),
      drawer: AppDrawer(),
      body: ListView.builder(itemBuilder: (ctx,ind) {
        return OrderItemm(orderData.orders[ind]);
      },itemCount: orderData.orders.length,) ,
    );
  }
}
