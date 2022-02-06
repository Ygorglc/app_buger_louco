import 'package:flutter/material.dart';
import 'package:burger_louco/models/cart_product.dart';

class OrderProductTile extends StatelessWidget {

  const OrderProductTile(this.cartProduct);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(
            '/product', arguments: cartProduct.product);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(cartProduct.product.images.first),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cartProduct.product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                  Text(
                    'Tamanho: ${cartProduct.size}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),

                  if(cartProduct.bacon!= null)Text(
                    'Bacon: ${cartProduct.bacon}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  
                  if(cartProduct.bread!= null)Text(
                    'Pão: ${cartProduct.bread}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  
                  if(cartProduct.cheese!= null)Text(
                    'Queijo: ${cartProduct.cheese}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  
                  if(cartProduct.egg!= null)Text(
                    'Ovo: ${cartProduct.egg}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  
                  if(cartProduct.sachet!= null)Text(
                    'Sache: ${cartProduct.sachet}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  
                  if(cartProduct.salad!= null)Text(
                    'Salada: ${cartProduct.salad}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  
                  if(cartProduct.sauce!= null)Text(
                    'Molho: ${cartProduct.sauce}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  
                  if(cartProduct.specialsauce != null)Text(
                    'Molho especial: ${cartProduct.specialsauce}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  
                  Text(
                    'R\$ ${(cartProduct.fixedPrice ?? cartProduct.unitPrice)
                        .toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            Text(
              '${cartProduct.quantity}',
              style: const TextStyle(
                fontSize: 20
              ),
            ),
          ],
        ),
      ),
    );
  }
}
