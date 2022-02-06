import 'package:flutter/material.dart';
import 'package:burger_louco/models/item_egg.dart';
import 'package:burger_louco/models/product.dart';
import 'package:provider/provider.dart';

class EggWidget extends StatelessWidget {

  const EggWidget({this.egg});

  final ItemEgg egg;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = egg == product.selectedEgg;

    Color color;
    if(!egg.hasStockEggs)
      color = Colors.red.withAlpha(50);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(egg.hasStockEggs){
          product.selectedEgg = egg;
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
                egg.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${egg.price.toStringAsFixed(2)}',
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
