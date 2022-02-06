import 'dart:io';

import 'package:burger_louco/models/item_bacon.dart';
import 'package:burger_louco/models/item_bread.dart';
import 'package:burger_louco/models/item_cheese.dart';
import 'package:burger_louco/models/item_egg.dart';
import 'package:burger_louco/models/item_sachet.dart';
import 'package:burger_louco/models/item_sauce.dart';
import 'package:burger_louco/models/item_specialsauce.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:burger_louco/models/item_size.dart';
import 'package:burger_louco/models/item_salad.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {

  Product({this.id, this.name, this.description, this.images, this.sizes, this.salads, this.breads, this.eggs, this.cheeses, this.bacons, this.sauces, this.specialsauces, this.sachets, 
    this.deleted = false}){
   images = images ?? [];
   sizes = sizes ?? [];
   salads = salads ?? [];
   breads = breads  ?? [];
   eggs = eggs ?? [];
   cheeses = cheeses  ?? [];
   bacons = bacons ?? [];
   sauces = sauces  ?? [];
   specialsauces = specialsauces  ?? [];
   sachets = sachets ?? [];
  }

  Product.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
    deleted = (document.data['deleted'] ?? false) as bool;
    sizes = (document.data['sizes'] as List<dynamic> ?? []).map(
            (s) => ItemSize.fromMap(s as Map<String, dynamic>)).toList();
    salads = (document.data['salads'] as List<dynamic> ?? []).map(
            (s) => ItemSalad.fromMap(s as Map<String, dynamic>)).toList();
    breads = (document.data['breads'] as List<dynamic> ?? []).map(
            (s) => ItemBread.fromMap(s as Map<String, dynamic>)).toList();
    eggs = (document.data['eggs'] as List<dynamic> ?? []).map(
            (s) => ItemEgg.fromMap(s as Map<String, dynamic>)).toList();
    cheeses = (document.data['cheeses'] as List<dynamic> ?? []).map(
            (s) => ItemCheese.fromMap(s as Map<String, dynamic>)).toList();
    bacons = (document.data['bacons'] as List<dynamic> ?? []).map(
            (s) => ItemBacon.fromMap(s as Map<String, dynamic>)).toList();
    sauces = (document.data['sauces'] as List<dynamic> ?? []).map(
            (s) => ItemSauce.fromMap(s as Map<String, dynamic>)).toList();
    specialsauces = (document.data['specialsauces'] as List<dynamic> ?? []).map(
            (s) => ItemSpecialsauce.fromMap(s as Map<String, dynamic>)).toList();
    sachets = (document.data['sachets'] as List<dynamic> ?? []).map(
            (s) => ItemSachet.fromMap(s as Map<String, dynamic>)).toList();
  }

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('products/$id');
  StorageReference get storageRef => storage.ref().child('products').child(id);

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;
  List<ItemSalad> salads;
  List<ItemBread> breads;
  List<ItemEgg> eggs;
  List<ItemCheese> cheeses;
  List<ItemBacon> bacons;
  List<ItemSauce> sauces;
  List<ItemSpecialsauce> specialsauces;
  List<ItemSachet> sachets;

  List<dynamic> newImages;

  bool deleted;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool namespecialsauces;
/////Size//////
  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;
  set selectedSize(ItemSize value){
    _selectedSize = value;
    notifyListeners();
  }
  
/////salad////////
  ItemSalad _selectedSalad;
  ItemSalad get selectedSalad => _selectedSalad;
  set selectedSalad(ItemSalad value){
    _selectedSalad = value;
    notifyListeners();
  }
  /////Bread//////
  ItemBread _selectedBread;
  ItemBread get selectedBread => _selectedBread;
  set selectedBread(ItemBread value){
    _selectedBread = value;
    notifyListeners();
  }
  /////Egg//////
  ItemEgg _selectedEgg;
  ItemEgg get selectedEgg => _selectedEgg;
  set selectedEgg(ItemEgg value){
    _selectedEgg = value;
    notifyListeners();
  }
  /////Cheese//////
  ItemCheese _selectedCheese;
  ItemCheese get selectedCheese => _selectedCheese;
  set selectedCheese(ItemCheese value){
    _selectedCheese = value;
    notifyListeners();
  }
  /////Bacon//////
  ItemBacon _selectedBacon;
  ItemBacon get selectedBacon => _selectedBacon;
  set selectedBacon(ItemBacon value){
    _selectedBacon = value;
    notifyListeners();
  }
  /////Sauce//////
  ItemSauce _selectedSauce;
  ItemSauce get selectedSauce => _selectedSauce;
  set selectedSauce(ItemSauce value){
    _selectedSauce = value;
    notifyListeners();
  }
  /////Specialsauce//////
  ItemSpecialsauce _selectedSpecialsauce;
  ItemSpecialsauce get selectedSpecialsauce => _selectedSpecialsauce;
  
  set selectedSpecialsauce(ItemSpecialsauce value){
    print("selecionou specialsald");
    _selectedSpecialsauce = value;
    nullSpecialsauce(value);
    notifyListeners();
    
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void nullSpecialsauce(ItemSpecialsauce value){
    if(value.name==null){
      print("Sem molho especial");
      namespecialsauces == false;
    }
    else{
      print("Com molho especial");
      namespecialsauces == true;
    }
  }
  /////Sachet//////
  ItemSachet _selectedSachet;
  ItemSachet get selectedSachet => _selectedSachet;
  set selectedSachet(ItemSachet value){
    _selectedSachet = value;
    notifyListeners();
  }
  
  ///Stock size
  int get totalStock {
    int stock = 0;
    for(final size in sizes){
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0 && !deleted;
  }
  ///Stock salads
  int get totalStockSalads {
    int stock = 0;
    for(final salad in salads){
      stock += salad.stock;
    }
    return stock;
  }

  bool get hasStockSalads {
    return totalStockSalads > 0 && !deleted;
  }
  
  ///Stock bread
  int get totalStockBreads {
    int stock = 0;
    for(final bread in breads){
      stock += bread.stock;
    }
    return stock;
  }

  bool get hasStockBreads {
    return totalStockBreads > 0 && !deleted;
  }
  ///Stock egg
  int get totalStockEggs {
    int stock = 0;
    for(final egg in eggs){
      stock += egg.stock;
    }
    return stock;
  }

  bool get hasStockEggs {
    return totalStockEggs > 0 && !deleted;
  }
  ///Stock cheese
  int get totalStockCheeses {
    int stock = 0;
    for(final cheese in cheeses){
      stock += cheese.stock;
    }
    return stock;
  }

  bool get hasStockCheeses {
    return totalStockCheeses > 0 && !deleted;
  }
  ///Stock bacon
  int get totalStockBacons {
    int stock = 0;
    for(final bacon in bacons){
      stock += bacon.stock;
    }
    return stock;
  }

  bool get hasStockBacons {
    return totalStockBacons > 0 && !deleted;
  }
  ///Stock sauce
  int get totalStockSauces {
    int stock = 0;
    for(final sauce in sauces){
      stock += sauce.stock;
    }
    return stock;
  }

  bool get hasStockSauces {
    return totalStockSauces > 0 && !deleted;
  }
  ///Stock specialsauce
  int get totalStockSpecialsauces {
    int stock = 0;
    for(final specialsauce in specialsauces){
      stock += specialsauce.stock;
    }
    return stock;
  }

  bool get hasStockSpecialsauces {
    return totalStockSpecialsauces > 0 && !deleted;
  }
  ///Stock sachet
  int get totalStockSachets {
    int stock = 0;
    for(final sachet in sachets){
      stock += sachet.stock;
    }
    return stock;
  }

  bool get hasStockSachets {
    return totalStockSachets > 0 && !deleted;
  }


  num get basePrice {
    num lowest = double.infinity;
    for(final size in sizes){
      if(size.price < lowest)
        lowest = size.price;
    }
    return lowest;
  }
  /////////////////////////////
  ItemSize findSize(String name){
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e){
      return null;
    }
  }
  
  ///////////////////////######################################################################?????????
  /////////Find bacon
  ItemBacon findBacon(String name){
    try {
      return bacons.firstWhere((s) => s.name == name);
    } catch (e){
      return null;
    }
  }
/////////Find bread
  ItemBread findBread(String name){
    try {
      return breads.firstWhere((s) => s.name == name);
    } catch (e){
      return null;
    }
  }
/////////Find cheese
  ItemCheese findCheese(String name){
    try {
      return cheeses.firstWhere((s) => s.name == name);
    } catch (e){
      return null;
    }
  }
/////////Find egg
  ItemEgg findEgg(String name){
    try {
      return eggs.firstWhere((s) => s.name == name);
    } catch (e){
      return null;
    }
  }
/////////Find sachet
  ItemSachet findSachet(String name){
    try {
      return sachets.firstWhere((s) => s.name == name);
    } catch (e){
      return null;
    }
  }
/////////Find salad
  ItemSalad findSalad(String name){
    try {
      return salads.firstWhere((s) => s.name == name);
    } catch (e){
      return null;
    }
  }
/////////Find sauce
  ItemSauce findSauce(String name){
    try {
      return sauces.firstWhere((s) => s.name == name);
    } catch (e){
      return null;
    }
  }
/////////Find 
  ItemSpecialsauce findSpecialsauce(String name){
    try {
      return specialsauces.firstWhere((s) => s.name == name);
    } catch (e){
      return null;
    }
  }
  /*void findNameSpecialsauce(String name){
   try {
      return specialsauces.firstWhere((s) => s.name == name, orElse: () {
        return null;
      },);
    } catch (e){

      return null;
    }
  }*/
  /*ItemSpecialsauce findSpecialsauce(String name){
    if(specialsauces.firstWhere((s) => s.name == name) != null){
      return specialsauces.firstWhere((s) => s.name == name); 
    }else{
      return null;
    }
  }*/
  
///////////////////////////////////////////////////////////////////////////////////
  /// Size list
  List<Map<String, dynamic>> exportSizeList(){
    return sizes.map((size) => size.toMap()).toList();
  }
  /// Salad list
  List<Map<String, dynamic>> exportSaladList(){
    return salads.map((salad) => salad.toMap()).toList();
  }
  /// Bread List
  List<Map<String, dynamic>> exportBreadList(){
    return breads.map((bread) => bread.toMap()).toList();
  }
  /// Egg List
  List<Map<String, dynamic>> exportEggList(){
    return eggs.map((egg) => egg.toMap()).toList();
  }
  /// Cheese List
  List<Map<String, dynamic>> exportCheeseList(){
    return cheeses.map((cheese) => cheese.toMap()).toList();
  }
  /// Bacon List
  List<Map<String, dynamic>> exportBaconList(){
    return bacons.map((bacon) => bacon.toMap()).toList();
  }
  /// Sauce List
  List<Map<String, dynamic>> exportSauceList(){
    return sauces.map((sauce) => sauce.toMap()).toList();
  }
  /// Specialsauce List
  List<Map<String, dynamic>> exportSpecialsauceList(){
    return specialsauces.map((specialsauce) => specialsauce.toMap()).toList();
  }
  /// Sachet List
  List<Map<String, dynamic>> exportSachetList(){
    return sachets.map((sachet) => sachet.toMap()).toList();
  }

  Future<void> save() async {
    loading = true;

    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
      'salads': exportSaladList(),
      'breads': exportBreadList(),
      'eggs': exportEggList(),
      'cheeses': exportCheeseList(),
      'bacons': exportBaconList(),
      'sauces': exportSauceList(),
      'specialsauces': exportSpecialsauceList(),
      'sachets': exportSachetList(),
      'deleted': deleted
    };

    if(id == null){
      final doc = await firestore.collection('products').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }

    final List<String> updateImages = [];

    for(final newImage in newImages){
      if(images.contains(newImage)){
        updateImages.add(newImage as String);
      } else {
        final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }

    for(final image in images){
      if(!newImages.contains(image) && image.contains('firebase')){
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e){
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await firestoreRef.updateData({'images': updateImages});

    images = updateImages;

    loading = false;
  }

  void delete(){
    firestoreRef.updateData({'deleted': true});
  }

  Product clone(){
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
      salads: salads.map((size) => size.clone()).toList(),
      breads: breads.map((bread) => bread.clone()).toList(),
      eggs: eggs.map((egg) => egg.clone()).toList(),
      cheeses: cheeses.map((cheese) => cheese.clone()).toList(),
      bacons: bacons.map((bacon) => bacon.clone()).toList(),
      sauces: sauces.map((sauce) => sauce.clone()).toList(),
      specialsauces: specialsauces.map((specialsauce) => specialsauce.clone()).toList(),
      sachets: sachets.map((sachet) => sachet.clone()).toList(),
      deleted: deleted,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes,salads: $salads, breads: $breads, eggs: $eggs, cheeses: $cheeses, bacons: $bacons, sauces: $sauces, specialsauces: $specialsauces, sachets: $sachets, newImages: $newImages}';
  }
}