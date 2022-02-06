class ItemBread {

  ItemBread({this.name, this.price, this.stock});

  ItemBread.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String name;
  num price;
  int stock;

  bool get hasStockBreads => stock > 0;

  ItemBread clone(){
    return ItemBread(
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
    return 'ItemBread{name: $name, price: $price, stock: $stock}';
  }
}