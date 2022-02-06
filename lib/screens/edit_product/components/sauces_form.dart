import 'package:burger_louco/models/item_sauce.dart';
import 'package:flutter/material.dart';
import 'package:burger_louco/common/custom_icon_button.dart';
import 'package:burger_louco/models/product.dart';
import 'package:burger_louco/screens/edit_product/components/edit_item_sauce.dart';

class SaucesForm extends StatelessWidget {

  const SaucesForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSauce>>(
      initialValue: product.sauces,
      /*validator: (sauces){
        if(sauces.isEmpty)
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
                    'Molhos',
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
                    state.value.add(ItemSauce());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value.map((sauce){
                return EditItemSauce(
                  key: ObjectKey(sauce),
                  sauce: sauce,
                  onRemove: (){
                    state.value.remove(sauce);
                    state.didChange(state.value);
                  },
                  onMoveUp: sauce != state.value.first ? (){
                    final index = state.value.indexOf(sauce);
                    state.value.remove(sauce);
                    state.value.insert(index-1, sauce);
                    state.didChange(state.value);
                  } : null,
                  onMoveDown: sauce != state.value.last ? (){
                    final index = state.value.indexOf(sauce);
                    state.value.remove(sauce);
                    state.value.insert(index+1, sauce);
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
