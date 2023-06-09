import 'package:flutter/material.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {

  static const routeName = "OrdersScreen";
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {

   Future.delayed(Duration.zero).then((_) async {
     setState(() {
       _isLoading = true;
     });
        await Provider.of<Orders>(context,listen: false).fetchOrders();
     setState(() {
       _isLoading = false;
     });
    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders'),),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(itemBuilder: (ctx,ind) {
        return OrderItemm(orderData.orders[ind]);
      },itemCount: orderData.orders.length,) ,
    );
  }
}
