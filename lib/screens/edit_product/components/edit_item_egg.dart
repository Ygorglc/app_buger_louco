import 'package:flutter/material.dart';
import 'package:burger_louco/common/custom_icon_button.dart';
import 'package:burger_louco/models/item_egg.dart';

class EditItemEgg extends StatelessWidget {

  const EditItemEgg({Key key, this.egg, this.onRemove,
    this.onMoveUp, this.onMoveDown}) : super(key: key);

  final ItemEgg egg;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: egg.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            validator: (name){
              if(name.isEmpty)
                return 'Inválido';
              return null;
            },
            onChanged: (name) => egg.name = name,
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: egg.stock?.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock){
              if(int.tryParse(stock) == null)
                return 'Inválido';
              return null;
            },
            onChanged: (stock) => egg.stock = int.tryParse(stock),
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: egg.price?.toStringAsFixed(2),
            decoration: const InputDecoration(
              labelText: 'Preço',
              isDense: true,
              prefixText: 'R\$'
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price){
              if(num.tryParse(price) == null)
                return 'Inválido';
              return null;
            },
            onChanged: (price) => egg.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        )
      ],
      
    );
  }
}
