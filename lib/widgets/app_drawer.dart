import 'package:flutter/material.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import '../screens/orders_screen.dart';
import '../helpers/custom_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Helloo'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () =>
                Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
            // Navigator.of(context).pushReplacement(CustomRoute(builder: (ctx) => OrdersScreen(),))
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScren.routeName),
          ),
        ],
      ),
    );
  }
}
