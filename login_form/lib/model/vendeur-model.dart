class Seller {
  final int id;
  final String createdDate;
  final String firstName;
  final String lastName;
  final String name;
  final String login;
  final String phone;
  final String expiryDate;
  final double pricePerStore;
  final bool activated;

  Seller({this.id, this.createdDate, this.phone, this.firstName, this.lastName,this.activated,this.pricePerStore,this.expiryDate,this.login,this.name});
  Map<String, dynamic> toJson() => {
    'id': id,
    'createdDate': createdDate,
    'phone': phone,
    'firstName': firstName,
    'name': name,
    'login': login,
    'lastName': lastName,
    'activated': activated,
    'pricePerStore': pricePerStore,
    'expiryDate': expiryDate
  };

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      createdDate: json['createdDate'] ,
      phone: json['phone'] ,
      firstName: json['firstName'],
      name: json['name'],
      login: json['login'],
      lastName: json['lastName'],
      activated: json['activated'],
      pricePerStore: json['pricePerStore'],
      expiryDate: json['expiryDate'],
    );
  }
}
