class ItemSalad {

  ItemSalad({this.name, this.price, this.stock});

  ItemSalad.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String name;
  num price;
  int stock;

  bool get hasStockSalads => stock > 0;

  ItemSalad clone(){
    return ItemSalad(
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
    return 'ItemSalad{name: $name, price: $price, stock: $stock}';
  }
}