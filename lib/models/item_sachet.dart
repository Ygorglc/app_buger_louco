class ItemSachet {

  ItemSachet({this.name, this.price, this.stock});

  ItemSachet.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String name;
  num price;
  int stock;

  bool get hasStockSachets => stock > 0;

  ItemSachet clone(){
    return ItemSachet(
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
    return 'ItemSachet{name: $name, price: $price, stock: $stock}';
  }
}