import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/product.dart';
import '../widgets/user_product_item.dart';


class UserProductsScren extends StatelessWidget {
  static const routeName = "UserProductsScren";

  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context,listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Products'),actions: [
        IconButton(onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName,);
        }, icon: Icon(Icons.add),),
      ],),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(itemBuilder: (ctx,ind) {
            return Column(
              children: [
                UserProductItem(productData.items[ind].id,productData.items[ind].title, productData.items[ind].imageUrl),
                Divider(),
              ],
            );
          },itemCount: productData.items.length,),
        ),
      ),
    );
  }
}
