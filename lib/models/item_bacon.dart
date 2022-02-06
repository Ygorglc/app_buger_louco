class ItemBacon {

  ItemBacon({this.name, this.price, this.stock});

  ItemBacon.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String name;
  num price;
  int stock;

  bool get hasStockBacons => stock > 0;

  ItemBacon clone(){
    return ItemBacon(
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
    return 'ItemBacon{name: $name, price: $price, stock: $stock}';
  }
}