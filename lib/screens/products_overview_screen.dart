import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';


enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Text('Only FAvs'),
                  value: FilterOptions.Favourites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ];
            },
            onSelected: (FilterOptions val) {
              print(val);
              setState(() {
                if (val == FilterOptions.Favourites) {
                  _showOnlyFav = true;
                } else {
                  _showOnlyFav = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => NumberBadge(child: ch as Widget, value: cart.itemCount.toString(), color: Colors.red),
            child: IconButton(icon: Icon(Icons.shopping_cart),onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },),
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFav),
      drawer: AppDrawer(),
    );
  }
}
