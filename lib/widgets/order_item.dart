import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItemm extends StatefulWidget {
  final ord.OrderItem order;

  OrderItemm(this.order);

  @override
  State<OrderItemm> createState() => _OrderItemmState();
}

class _OrderItemmState extends State<OrderItemm> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat("dd MM yyyy hh:mm").format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
              height: min(widget.order.products.length * 20.0 + 10, 180),
              child: ListView(
                children: widget.order.products.map((prod) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(prod.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('${prod.quantity}x \$ ${prod.price}',style: TextStyle(fontSize: 18,color:Colors.grey),)

                  ],
                )).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
