class Account {
  final int id;
  final String createdDate;
  final String name;
  final String firstName;
  final String lastName;
  final String phone;
  final String expiryDate;
  final double pricePerStore;
  final int nbStores;

  Account({this.id, this.createdDate, this.phone, this.firstName, this.lastName,this.nbStores,this.pricePerStore,this.expiryDate,this.name});
  Map<String, dynamic> toJson() => {
    'id': id,
    'createdDate': createdDate,
    'phone': phone,
    'firstName': firstName,
    'name': name,
    'lastName': lastName,
    'nbStores': nbStores,
    'pricePerStore': pricePerStore,
    'expiryDate': expiryDate
  };

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      createdDate: json['createdDate'] ,
      phone: json['phone'] ,
      firstName: json['firstName'],
      name: json['name'],
      lastName: json['lastName'],
      nbStores: json['nbStores'],
      pricePerStore: json['pricePerStore'],
      expiryDate: json['expiryDate'],
    );
  }
}
