import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  //
  // ProductItem({required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {

    print("prodITem rebuilds");
    final product = Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context,listen: false);
    return  ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (ctx) => ProductDetailScreen()));
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: product.id);
            },
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                placeholder: AssetImage('../images/placeholder.jpg'),
                image: NetworkImage(product.imageUrl),fit: BoxFit.cover,
              ),
            )

            // Image.network(
            //   product.imageUrl,
            //   fit: BoxFit.cover,
            // ),
          ),
          footer: GridTileBar(
            leading: Consumer<Product>(
    builder: (ctx,product,child) => IconButton(
              icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_border),

              onPressed: ( ) {
                product.toggleFavStatus();
              },
            ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                // Scaffold.of(context).openDrawer();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(
                  'Addded Item to Cart!!',
                  textAlign: TextAlign.center,
                ),
                duration: Duration(seconds: 1),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                          cart.removeSingleItem(product.id);
                      },
                    ),
              )
                );
              },
            ),
            backgroundColor: Colors.black54,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
    );
  }
}
