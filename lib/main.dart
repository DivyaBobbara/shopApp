import 'package:flutter/material.dart';
import 'package:shop_app/helpers/custom_routes.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/user_products_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (ctx) => Products()),
        ChangeNotifierProvider(
        create: (ctx) => Cart()),
        ChangeNotifierProvider(
            create: (ctx) => Orders()),
      ],
        // value: Products(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.iOS : CustomPageTransition(),
            })
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName : (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName:(ctx) => OrdersScreen(),
            UserProductsScren.routeName: (ctx) => UserProductsScren(),
            EditProductScreen.routeName:(ctx) => EditProductScreen(),
          },
        ),
    );
  }
}

