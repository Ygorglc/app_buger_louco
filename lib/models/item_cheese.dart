class ItemCheese {

  ItemCheese({this.name, this.price, this.stock});

  ItemCheese.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String name;
  num price;
  int stock;

  bool get hasStockCheeses => stock > 0;

  ItemCheese clone(){
    return ItemCheese(
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
    return 'ItemCheese{name: $name, price: $price, stock: $stock}';
  }
}