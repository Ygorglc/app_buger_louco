import 'package:burger_louco/models/item_bread.dart';
import 'package:flutter/material.dart';
import 'package:burger_louco/common/custom_icon_button.dart';
import 'package:burger_louco/models/product.dart';
import 'package:burger_louco/screens/edit_product/components/edit_item_bread.dart';

class BreadsForm extends StatelessWidget {

  const BreadsForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemBread>>(
      initialValue: product.breads,
      /*validator: (breads){
        if(breads.isEmpty)
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
                    'Pães',
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
                    state.value.add(ItemBread());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value.map((bread){
                return EditItemBread(
                  key: ObjectKey(bread),
                  bread: bread,
                  onRemove: (){
                    state.value.remove(bread);
                    state.didChange(state.value);
                  },
                  onMoveUp: bread != state.value.first ? (){
                    final index = state.value.indexOf(bread);
                    state.value.remove(bread);
                    state.value.insert(index-1, bread);
                    state.didChange(state.value);
                  } : null,
                  onMoveDown: bread != state.value.last ? (){
                    final index = state.value.indexOf(bread);
                    state.value.remove(bread);
                    state.value.insert(index+1, bread);
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
