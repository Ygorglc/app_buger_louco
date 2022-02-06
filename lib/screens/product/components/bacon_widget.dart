import 'package:flutter/material.dart';
import 'package:burger_louco/models/item_bacon.dart';
import 'package:burger_louco/models/product.dart';
import 'package:provider/provider.dart';

class BaconWidget extends StatelessWidget {

  const BaconWidget({this.bacon});

  final ItemBacon bacon;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = bacon == product.selectedBacon;

    Color color;
    if(!bacon.hasStockBacons)
      color = Colors.red.withAlpha(50);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(bacon.hasStockBacons){
          product.selectedBacon = bacon;
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
                bacon.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${bacon.price.toStringAsFixed(2)}',
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
