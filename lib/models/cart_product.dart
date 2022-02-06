import 'package:burger_louco/models/item_specialsauce.dart';
import 'package:burger_louco/screens/product/components/bread_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:burger_louco/models/item_size.dart';
import 'package:burger_louco/models/item_bacon.dart';
import 'package:burger_louco/models/item_bread.dart';
import 'package:burger_louco/models/item_cheese.dart';
import 'package:burger_louco/models/item_egg.dart';
import 'package:burger_louco/models/item_sachet.dart';
import 'package:burger_louco/models/item_salad.dart';
import 'package:burger_louco/models/item_sauce.dart';
import 'package:burger_louco/models/product.dart';

class CartProduct extends ChangeNotifier {

  CartProduct.fromProduct(this._product){
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
    if(product.bacons.isNotEmpty){
      bacon = product.selectedBacon.name;
    }
    if(product.breads.isNotEmpty){
      bread = product.selectedBread.name;
    }
    if(product.cheeses.isNotEmpty){
      cheese = product.selectedCheese.name;
    }
    if(product.eggs.isNotEmpty){
      egg = product.selectedEgg.name;
    }
    if(product.sachets.isNotEmpty){
      sachet = product.selectedSachet.name;
    }
    if(product.salads.isNotEmpty){
      salad = product.selectedSalad.name;
    }
    if(product.sauces.isNotEmpty){
      sauce = product.selectedSauce.name;
    }
    if(product.specialsauces.isNotEmpty){
      specialsauce = product.selectedSpecialsauce.name;
    }
    
  }

  CartProduct.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;
    bacon = document.data['bacon'] as String;
    bread = document.data['bread'] as String;
    cheese = document.data['cheese'] as String;
    egg = document.data['egg'] as String;
    sachet = document.data['sachet'] as String;
    salad = document.data['salad'] as String;
    sauce = document.data['sauce'] as String;
    specialsauce = document.data['specialsauce'] as String;

    firestore.document('products/$productId').get().then(
      (doc) {
        product = Product.fromDocument(doc);
      }
    );
  }

  CartProduct.fromMap(Map<String, dynamic> map){
    productId = map['pid'] as String;
    quantity = map['quantity'] as int;
    size = map['size'] as String;
    bacon = map['bacon'] as String;
    bread = map['bread'] as String;
    cheese = map['cheese'] as String;
    egg = map['egg'] as String;
    sachet = map['sachet'] as String;
    salad = map['salad'] as String;
    sauce = map['sauce'] as String;
    specialsauce = map['specialsauce'] as String;
    fixedPrice = map['fixedPrice'] as num;

    firestore.document('products/$productId').get().then(
      (doc) {
        product = Product.fromDocument(doc);
      }
    );
  }

  final Firestore firestore = Firestore.instance;

  String id;

  String productId;
  int quantity;
  String size;
  String bacon;
  String bread;
  String cheese;
  String egg;
  String sachet;
  String salad;
  String sauce;
  String specialsauce;

  num fixedPrice;

  Product _product;
  Product get product => _product;
  set product(Product value){
    _product = value;
    notifyListeners();
  }

  ItemSize get itemSize {
    if(product == null) return null;
    return product.findSize(size);
  }
  ///////////////////////######################################################################?????????
  ItemBacon get itemBacon {
    if(product == null) return null;
    return product.findBacon(bacon);
  }
  //
  ItemBread get itemBread {
    if(product == null) return null;
    return product.findBread(bread);
  }
  //
  ItemCheese get itemCheese {
    if(product == null) return null;
    return product.findCheese(cheese);
  }
  //
  ItemEgg get itemEgg {
    if(product == null) return null;
    return product.findEgg(egg);
  }
  //
  ItemSachet get itemSachet {
    if(product == null) return null;
    return product.findSachet(sachet);
  }
  //
  ItemSalad get itemSalad {
    if(product == null) return null;
    return product.findSalad(salad);
  }
  //
  ItemSauce get itemSauce {
    if(product == null) return null;
    return product.findSauce(sauce);
  }
  //
  ItemSpecialsauce get itemSpecialsauce {
    if(product == null) return null;
    return product.findSpecialsauce(specialsauce);
  }
  //
  ///////////////
  num get unitPrice {
    if(product == null) return 0;
    return itemSize?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toCartItemMap(){
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
      'bacon': bacon,
      'bread': bread,
      'cheese': cheese,
      'egg': egg,
      'sachet': sachet,
      'salad': salad,
      'sauce': sauce,
      'specialsauce': specialsauce,
    };
  }

  Map<String, dynamic> toOrderItemMap(){
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
      'bacon': bacon,
      'bread': bread,
      'cheese': cheese,
      'egg': egg,
      'sachet': sachet,
      'salad': salad,
      'sauce': sauce,
      'specialsauce': specialsauce,
      'fixedPrice': fixedPrice ?? unitPrice,
    };
  }

  bool stackable(Product product){
    return product.id == productId && product.selectedSize.name == size && product.selectedBacon.name == bacon && product.selectedBread == bread && product.selectedCheese == cheese && product.selectedEgg == egg && product.selectedSachet == sachet && product.selectedSalad == salad && product.selectedSauce == sauce && product.selectedSpecialsauce == specialsauce;
  }

  void increment(){
    quantity++;
    notifyListeners();
  }

  void decrement(){
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    if(product != null && product.deleted) return false;

    final size = itemSize;
    if(size == null) return false;
    return size.stock >= quantity;
  }

}