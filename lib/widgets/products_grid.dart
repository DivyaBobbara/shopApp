import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import './product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final loadedProducts = showFavs ? productData.favItems : productData.items;
    return GridView.builder(
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, ind) {
        return ChangeNotifierProvider.value(
          // create: (ctx) => loadedProducts[ind],
          value: loadedProducts[ind],
          child: ProductItem());
              // id: loadedProducts[ind].id,
              // title: loadedProducts[ind].title,
              // imageUrl: loadedProducts[ind].imageUrl),
      },
      itemCount: loadedProducts.length,
    );
  }
}

