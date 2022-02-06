import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:burger_louco/models/cart_manager.dart';
import 'package:burger_louco/models/product.dart';
import 'package:burger_louco/models/user_manager.dart';
import 'package:burger_louco/screens/product/components/size_widget.dart';
import 'package:burger_louco/screens/product/components/salad_widget.dart';
import 'package:burger_louco/screens/product/components/bread_widget.dart';
import 'package:burger_louco/screens/product/components/egg_widget.dart';
import 'package:burger_louco/screens/product/components/cheese_widget.dart';
import 'package:burger_louco/screens/product/components/bacon_widget.dart';
import 'package:burger_louco/screens/product/components/sauce_widget.dart';
import 'package:burger_louco/screens/product/components/specialsauce_widget.dart';
import 'package:burger_louco/screens/product/components/sachet_widget.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {

  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __){
                if(userManager.adminEnabled && !product.deleted){
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed(
                          '/edit_product',
                          arguments: product
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: product.images.map((url){
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                  if(product.deleted)
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Este produto não está mais disponível',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red
                        ),
                      ),
                    )
                  else
                    ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Tamanhos',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.sizes.map((s){
                          return SizeWidget(size: s);
                        }).toList(),
                      ),
                      if(product.hasStockSalads) 
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Saladas',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      if(product.hasStockSalads)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.salads.map((s){
                          return SaladWidget(salad: s);
                        }).toList(),
                      ),
                      ////////////////////   
                      
                      if(product.hasStockBreads) 
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Pães',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      
                      if(product.hasStockBreads)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.breads.map((s){
                          return BreadWidget(bread: s);
                        }).toList(),
                      ),
                      ////////////////////
                      if(product.hasStockEggs) 
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Ovo',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      if(product.hasStockEggs)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.eggs.map((s){
                          return EggWidget(egg: s);
                        }).toList(),
                      ),
                      ////////////////////
                      
                      if(product.hasStockBacons) 
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Bacon',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      if(product.hasStockBacons)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.bacons.map((s){
                          return BaconWidget(bacon: s);
                        }).toList(),
                      ),
                      ////////////////////
                      
                      if(product.hasStockSauces) 
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Molhos',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      if(product.hasStockSauces)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.sauces.map((s){
                          return SauceWidget(sauce: s);
                        }).toList(),
                      ),
                      ////////////////////
                      if(product.hasStockSpecialsauces) 
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Molhos Especiais',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      if(product.hasStockSpecialsauces)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.specialsauces.map((s){
                          return SpecialsauceWidget(specialsauce: s);
                        }).toList(),
                      ),
                      ////////////////////
                      if(product.hasStockCheeses) 
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Queijo',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      if(product.hasStockCheeses)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.cheeses.map((s){
                          return CheeseWidget(cheese: s);
                        }).toList(),
                      ),
                      ////////////////////
                      if(product.hasStockSachets) 
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Saches',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      if(product.hasStockSachets)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.sachets.map((s){
                          return SachetWidget(sachet: s);
                        }).toList(),
                      ),
                      ////////////////////
                    
                    ],
                  const SizedBox(height: 20,),
                  if(product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __){
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            onPressed: product.selectedSize != null ? (){
                              if(userManager.isLoggedIn){
                                context.read<CartManager>().addToCart(product);
                                Navigator.of(context).pushNamed('/cart');
                              } else {
                                Navigator.of(context).pushNamed('/login');
                              }
                            } : null,
                            color: primaryColor,
                            textColor: Colors.white,
                            child: Text(
                              userManager.isLoggedIn
                                  ? 'Adicionar ao Carrinho'
                                  : 'Entre para Comprar',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
