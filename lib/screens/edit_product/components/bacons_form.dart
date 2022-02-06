import 'package:burger_louco/models/item_bacon.dart';
import 'package:flutter/material.dart';
import 'package:burger_louco/common/custom_icon_button.dart';
import 'package:burger_louco/models/product.dart';
import 'package:burger_louco/screens/edit_product/components/edit_item_bacon.dart';

class BaconsForm extends StatelessWidget {

  const BaconsForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemBacon>>(
      initialValue: product.bacons,
      /*validator: (bacons){
        if(bacons.isEmpty)
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
                    'Bacons',
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
                    state.value.add(ItemBacon());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value.map((bacon){
                return EditItemBacon(
                  key: ObjectKey(bacon),
                  bacon: bacon,
                  onRemove: (){
                    state.value.remove(bacon);
                    state.didChange(state.value);
                  },
                  onMoveUp: bacon != state.value.first ? (){
                    final index = state.value.indexOf(bacon);
                    state.value.remove(bacon);
                    state.value.insert(index-1, bacon);
                    state.didChange(state.value);
                  } : null,
                  onMoveDown: bacon != state.value.last ? (){
                    final index = state.value.indexOf(bacon);
                    state.value.remove(bacon);
                    state.value.insert(index+1, bacon);
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
