import 'package:flutter/material.dart';
import 'package:burger_louco/common/custom_icon_button.dart';
import 'package:burger_louco/models/item_salad.dart';
import 'package:burger_louco/models/product.dart';
import 'package:burger_louco/screens/edit_product/components/edit_item_salad.dart';

class SaladsForm extends StatelessWidget {

  const SaladsForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSalad>>(
      initialValue: product.salads,
      /*validator: (salads){
        if(salads.isEmpty)
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
                    'Saladas',
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
                    state.value.add(ItemSalad());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value.map((salad){
                return EditItemSalad(
                  key: ObjectKey(salad),
                  salad: salad,
                  onRemove: (){
                    state.value.remove(salad);
                    state.didChange(state.value);
                  },
                  onMoveUp: salad != state.value.first ? (){
                    final index = state.value.indexOf(salad);
                    state.value.remove(salad);
                    state.value.insert(index-1, salad);
                    state.didChange(state.value);
                  } : null,
                  onMoveDown: salad != state.value.last ? (){
                    final index = state.value.indexOf(salad);
                    state.value.remove(salad);
                    state.value.insert(index+1, salad);
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
