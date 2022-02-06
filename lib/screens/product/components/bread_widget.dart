import 'package:flutter/material.dart';
import 'package:burger_louco/models/item_bread.dart';
import 'package:burger_louco/models/product.dart';
import 'package:provider/provider.dart';

class BreadWidget extends StatelessWidget {

  const BreadWidget({this.bread});

  final ItemBread bread;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = bread == product.selectedBread;

    Color color;
    if(!bread.hasStockBreads)
      color = Colors.red.withAlpha(50);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(bread.hasStockBreads){
          product.selectedBread = bread;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                bread.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${bread.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
