class Store {
  final int id;
  final String name;
  final String businessType;
  final String owner;
  final String createdDate;
  final int price;
  final int nbProducts;
  final int nbSellers;
  final int ownerId;
  final bool enabled;
  final double totalStock;
  final double benefice;

  Store(
      {this.id,
      this.name,
      this.price,
      this.businessType,
      this.owner,
      this.createdDate,
      this.enabled,
      this.nbProducts,
      this.nbSellers,
      this.ownerId,
      this.benefice,
      this.totalStock});
  static Map<String, dynamic> toJson(Store store) => {
        'id': store.id,
        'name': store.name,
        'price': store.price,
        'businessType': store.businessType,
        'owner': store.owner,
        'createdDate': store.createdDate,
        'enabled': store.enabled,
        'nbProducts': store.nbProducts,
        'nbSellers': store.nbSellers,
        'ownerId': store.ownerId,
        'benefice': store.benefice,
        'totalStock': store.totalStock,
      };

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'] as String,
      price: json['price'] as int,
      businessType: json['businessType'],
      owner: json['owner'],
      createdDate: json['createdDate'],
      enabled: json['enabled'],
      nbProducts: json['nbProducts'],
      nbSellers: json['nbSellers'],
      ownerId: json['ownerId'],
      benefice: json['benefice'],
      totalStock: json['totalStock'],
    );
  }
}
