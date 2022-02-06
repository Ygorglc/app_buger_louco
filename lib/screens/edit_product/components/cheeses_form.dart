import 'package:burger_louco/models/item_cheese.dart';
import 'package:flutter/material.dart';
import 'package:burger_louco/common/custom_icon_button.dart';
import 'package:burger_louco/models/product.dart';
import 'package:burger_louco/screens/edit_product/components/edit_item_cheese.dart';

class CheesesForm extends StatelessWidget {

  const CheesesForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemCheese>>(
      initialValue: product.cheeses,
      /*validator: (cheeses){
        if(cheeses.isEmpty)
          return 'Insira um tamanho';
        return null;
      },*/
      builder: (state){
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Queijos',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: (){
                    state.value.add(ItemCheese());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value.map((cheese){
                return EditItemCheese(
                  key: ObjectKey(cheese),
                  cheese: cheese,
                  onRemove: (){
                    state.value.remove(cheese);
                    state.didChange(state.value);
                  },
                  onMoveUp: cheese != state.value.first ? (){
                    final index = state.value.indexOf(cheese);
                    state.value.remove(cheese);
                    state.value.insert(index-1, cheese);
                    state.didChange(state.value);
                  } : null,
                  onMoveDown: cheese != state.value.last ? (){
                    final index = state.value.indexOf(cheese);
                    state.value.remove(cheese);
                    state.value.insert(index+1, cheese);
                    state.didChange(state.value);
                  } : null,
                );
              }).toList(),
            ),
            
            if(state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        );
      },
      
    );
  }
}
