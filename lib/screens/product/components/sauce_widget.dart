import 'package:flutter/material.dart';
import 'package:burger_louco/models/item_sauce.dart';
import 'package:burger_louco/models/product.dart';
import 'package:provider/provider.dart';

class SauceWidget extends StatelessWidget {

  const SauceWidget({this.sauce});

  final ItemSauce sauce;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = sauce == product.selectedSauce;

    Color color;
    if(!sauce.hasStockSauces)
      color = Colors.red.withAlpha(50);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(sauce.hasStockSauces){
          product.selectedSauce = sauce;
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
                sauce.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${sauce.price.toStringAsFixed(2)}',
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
