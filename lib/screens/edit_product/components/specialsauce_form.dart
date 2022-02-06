import 'package:burger_louco/models/item_specialsauce.dart';
import 'package:flutter/material.dart';
import 'package:burger_louco/common/custom_icon_button.dart';
import 'package:burger_louco/models/product.dart';
import 'package:burger_louco/screens/edit_product/components/edit_item_specialsauce.dart';

class SpecialsaucesForm extends StatelessWidget {

  const SpecialsaucesForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSpecialsauce>>(
      initialValue: product.specialsauces,
      /*validator: (specialsauces){
        if(specialsauces.isEmpty)
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
                    'Molhos Especiais',
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
                    state.value.add(ItemSpecialsauce());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value.map((specialsauce){
                return EditItemSpecialsauce(
                  key: ObjectKey(specialsauce),
                  specialsauce: specialsauce,
                  onRemove: (){
                    state.value.remove(specialsauce);
                    state.didChange(state.value);
                  },
                  onMoveUp: specialsauce != state.value.first ? (){
                    final index = state.value.indexOf(specialsauce);
                    state.value.remove(specialsauce);
                    state.value.insert(index-1, specialsauce);
                    state.didChange(state.value);
                  } : null,
                  onMoveDown: specialsauce != state.value.last ? (){
                    final index = state.value.indexOf(specialsauce);
                    state.value.remove(specialsauce);
                    state.value.insert(index+1, specialsauce);
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
