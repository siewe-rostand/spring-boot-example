
class Product {
  final int id;
  final int storeId;
  final String name;
  final String description;
  final String createdDate;
  final String image;
  final double stock;
  final double price;

  Product({this.id, this.name, this.price, this.description, this.stock,this.createdDate,this.image,this.storeId});

  static Map<String, dynamic> toMap(Product products) => {
    'id': products.id,
    'storeId': products.storeId,
    'name': products.name,
    'description': products.description,
    'createdDate': products.createdDate,
    'image': products.image,
    'stock': products.stock,
    'price': products.price,
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      storeId: json['storeId'],
      name: json['name'] ,
      price: json['price'] ,
      description: json['description'],
      createdDate: json['createdDate'],
      image: json['image'],
      stock: json['stock'],
    );
  }
  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['description'] = this.description;
    data['createdDate'] = this.createdDate;
    data['image'] = this.image;
    data['stock'] = this.stock;
    data['price'] = this.price;

    return data;
  }

  String getFromList(Map<String, dynamic> json, String key) {
    return json != null ? json[key] : "";
  }
}

/*class Product {
  int id;
  String name;
  String description;
  String price;
  DateTime createdDate;
  int storeId;
  Null categoryId;
  Null categoryName;
  bool enabled;
  Null deleted;
  double stock;
  double stockAlerte;
  double cump;
  double valeurStock;
  Null stockBas;

  Product(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.createdDate,
        this.storeId,
        this.categoryId,
        this.categoryName,
        this.enabled,
        this.deleted,
        this.stock,
        this.stockAlerte,
        this.cump,
        this.valeurStock,
        this.stockBas});

  Product.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    createdDate = json['createdDate']= null ? null : DateTime.parse(json['createdDate'] as String);
    storeId = json['storeId'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    enabled = json['enabled'];
    deleted = json['deleted'];
    stock = json['stock'];
    stockAlerte = json['stockAlerte'];
    cump = json['cump'];
    valeurStock = json['valeurStock'];
    stockBas = json['stockBas'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['createdDate'] = this.createdDate;
    data['storeId'] = this.storeId;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['enabled'] = this.enabled;
    data['deleted'] = this.deleted;
    data['stock'] = this.stock;
    data['stockAlerte'] = this.stockAlerte;
    data['cump'] = this.cump;
    data['valeurStock'] = this.valeurStock;
    data['stockBas'] = this.stockBas;
    return data;
  }
}
*/
