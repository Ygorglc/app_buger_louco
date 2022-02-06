class ItemEgg {

  ItemEgg({this.name, this.price, this.stock});

  ItemEgg.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String name;
  num price;
  int stock;

  bool get hasStockEggs => stock > 0;

  ItemEgg clone(){
    return ItemEgg(
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
    return 'ItemEgg{name: $name, price: $price, stock: $stock}';
  }
}