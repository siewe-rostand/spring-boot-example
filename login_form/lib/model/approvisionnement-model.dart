class Approvisionnement {
  final int id;
  final int userId;
  final int productId;
  final double quantity;
  final double coutTotal;
  final double prixEntree;
  final String createdDate;
  final String productName;
  final String userName;

  Approvisionnement({this.id, this.createdDate, this.userName, this.productName, this.userId,this.productId,this.quantity,this.coutTotal,this.prixEntree});
  Map<String, dynamic> toJson() => {
    'id': id,
    'createdDate': createdDate,
    'userName': userName,
    'productName': productName,
    'userId': userId,
    'productId': productId,
    'quantity': quantity,
    'coutTotal': coutTotal,
    'prixEntree': prixEntree,
  };
  static Map<String, dynamic> toMap(Approvisionnement music) => {
    'id': music.id,
    'createdDate': music.createdDate,
    'userName': music.userName,
    'productName': music.productName,
    'userId': music.userId,
    'productId': music.productId,
    'quantity': music.quantity,
    'coutTotal': music.coutTotal,
    'prixEntree': music.prixEntree,
  };

  factory Approvisionnement.fromJson(Map<String, dynamic> json) {
    return Approvisionnement(
      id: json['id'],
      createdDate: json['createdDate'] ,
      userName: json['userName'] ,
      productName: json['productName'],
      userId: json['userId'],
      productId: json['productId'],
      quantity: json['quantity'],
      coutTotal: json['coutTotal'],
      prixEntree: json['prixEntree'],
    );
  }
}
