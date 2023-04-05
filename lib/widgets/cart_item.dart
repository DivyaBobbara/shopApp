import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItemm extends StatelessWidget {
  final String id;
  final String prodId;
  final String title;
  final double price;
  final int quantity;

  const CartItemm(this.id, this.prodId,this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text('Are You Sure?'),content: Text('Do you want to remove item from cart?',),
          actions: [
            TextButton(onPressed: () {
              return Navigator.of(context).pop(false);
            } , child: Text('No')),
            TextButton(onPressed: () {
              return Navigator.of(context).pop(true);
            } , child: Text('Yes'))
          ],
        ) );
      },
      onDismissed: (direc) {
        Provider.of<Cart>(context,listen: false).removeItem(prodId);
      },
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),

      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Padding(
          padding: EdgeInsets.all(15),

          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(child: Text('${price}'))),
            ),
            title: Text(title),
            subtitle: Text('Total ${(price * quantity)}'),
            trailing: Text('$quantity'),
          ),
        ),
      ),
    );
  }
}
