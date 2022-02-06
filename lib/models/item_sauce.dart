class ItemSauce {

  ItemSauce({this.name, this.price, this.stock});

  ItemSauce.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String name;
  num price;
  int stock;

  bool get hasStockSauces => stock > 0;

  ItemSauce clone(){
    return ItemSauce(
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
    return 'ItemSauce{name: $name, price: $price, stock: $stock}';
  }
}