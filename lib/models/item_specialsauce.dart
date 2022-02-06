class ItemSpecialsauce {

  ItemSpecialsauce({this.name, this.price, this.stock});

  ItemSpecialsauce.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String name;
  num price;
  int stock;

  bool get hasStockSpecialsauces => stock > 0;

  ItemSpecialsauce clone(){
    return ItemSpecialsauce(
      name: name,
      price: price,
      stock: stock,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'price': price,
      'stock': stock,
    };
  }

  @override
  String toString() {
    return 'ItemSpecialsauce{name: $name, price: $price, stock: $stock}';
  }
}