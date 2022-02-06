import 'package:flutter/material.dart';
import 'package:burger_louco/models/item_specialsauce.dart';
import 'package:burger_louco/models/product.dart';
import 'package:provider/provider.dart';

class SpecialsauceWidget extends StatelessWidget {

  const SpecialsauceWidget({this.specialsauce});

  final ItemSpecialsauce specialsauce;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = specialsauce == product.selectedSpecialsauce;

    Color color;
    if(!specialsauce.hasStockSpecialsauces)
      color = Colors.red.withAlpha(50);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(specialsauce.hasStockSpecialsauces){
          product.selectedSpecialsauce = specialsauce;
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
                specialsauce.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${specialsauce.price.toStringAsFixed(2)}',
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
