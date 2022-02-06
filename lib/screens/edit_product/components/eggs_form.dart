import 'package:burger_louco/models/item_egg.dart';
import 'package:flutter/material.dart';
import 'package:burger_louco/common/custom_icon_button.dart';
import 'package:burger_louco/models/product.dart';
import 'package:burger_louco/screens/edit_product/components/edit_item_egg.dart';

class EggsForm extends StatelessWidget {

  const EggsForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemEgg>>(
      initialValue: product.eggs,
      /*validator: (eggs){
        if(eggs.isEmpty)
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
                    'Ovos',
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
                    state.value.add(ItemEgg());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value.map((egg){
                return EditItemEgg(
                  key: ObjectKey(egg),
                  egg: egg,
                  onRemove: (){
                    state.value.remove(egg);
                    state.didChange(state.value);
                  },
                  onMoveUp: egg != state.value.first ? (){
                    final index = state.value.indexOf(egg);
                    state.value.remove(egg);
                    state.value.insert(index-1, egg);
                    state.didChange(state.value);
                  } : null,
                  onMoveDown: egg != state.value.last ? (){
                    final index = state.value.indexOf(egg);
                    state.value.remove(egg);
                    state.value.insert(index+1, egg);
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
