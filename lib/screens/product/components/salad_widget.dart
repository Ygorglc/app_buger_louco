
import 'package:flutter/material.dart';
import 'package:burger_louco/models/item_salad.dart';
import 'package:burger_louco/models/product.dart';
import 'package:provider/provider.dart';

class SaladWidget extends StatelessWidget {

  const SaladWidget({this.salad});

  final ItemSalad salad;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = salad == product.selectedSalad;

    Color color;
    if(!salad.hasStockSalads)
      color = Colors.red.withAlpha(50);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(salad.hasStockSalads){
          product.selectedSalad = salad;
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
                salad.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${salad.price.toStringAsFixed(2)}',
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