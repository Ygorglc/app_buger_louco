import 'package:flutter/material.dart';
import 'package:burger_louco/models/item_sachet.dart';
import 'package:burger_louco/models/product.dart';
import 'package:provider/provider.dart';

class SachetWidget extends StatelessWidget {

  const SachetWidget({this.sachet});

  final ItemSachet sachet;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = sachet == product.selectedSachet;

    Color color;
    if(!sachet.hasStockSachets)
      color = Colors.red.withAlpha(50);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(sachet.hasStockSachets){
          product.selectedSachet = sachet;
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
                sachet.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${sachet.price.toStringAsFixed(2)}',
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
