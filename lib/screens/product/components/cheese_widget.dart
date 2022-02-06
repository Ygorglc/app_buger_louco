import 'package:flutter/material.dart';
import 'package:burger_louco/models/item_cheese.dart';
import 'package:burger_louco/models/product.dart';
import 'package:provider/provider.dart';

class CheeseWidget extends StatelessWidget {

  const CheeseWidget({this.cheese});

  final ItemCheese cheese;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = cheese == product.selectedCheese;

    Color color;
    if(!cheese.hasStockCheeses)
      color = Colors.red.withAlpha(50);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(cheese.hasStockCheeses){
          product.selectedCheese = cheese;
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
                cheese.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${cheese.price.toStringAsFixed(2)}',
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
