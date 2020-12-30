class Store {
  final int id;
  final String name;
  final String businessType;
  final String owner;
  final int price;

  Store({this.id, this.name, this.price, this.businessType, this.owner});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'businessType': businessType,
        'owner': owner
      };

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'] as String,
      price: json['price'] as int,
      businessType: json['businessType'],
      owner: json['owner'],
    );
  }
}
