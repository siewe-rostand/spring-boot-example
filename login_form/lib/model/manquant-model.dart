class Manquants {
  final int id;
  final int userId;
  final int productId;
  final double quantity;
  final double cout;
  final String createdDate;
  final String productName;
  final String userName;

  Manquants({this.id, this.createdDate, this.userName, this.productName, this.userId,this.productId,this.quantity,this.cout});
  Map<String, dynamic> toJson() => {
    'id': id,
    'createdDate': createdDate,
    'userName': userName,
    'productName': productName,
    'userId': userId,
    'productId': productId,
    'quantity': quantity,
    'cout': cout,
  };

  static Map<String, dynamic> toMap(Manquants manquant) => {
    'id': manquant.id,
    'createdDate': manquant.createdDate,
    'userName': manquant.userName,
    'productName': manquant.productName,
    'userId': manquant.userId,
    'productId': manquant.productId,
    'quantity': manquant.quantity,
    'cout': manquant.cout,
  };

  factory Manquants.fromJson(Map<String, dynamic> json) {
    return Manquants(
      id: json['id'],
      createdDate: json['createdDate'] ,
      userName: json['userName'] ,
      productName: json['productName'],
      userId: json['userId'],
      productId: json['productId'],
      quantity: json['quantity'],
      cout: json['cout'],
    );
  }
}
