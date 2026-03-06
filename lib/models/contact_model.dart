class Contact {

  int? id;
  String name;
  String phone;
  String email;
  int isFavorite;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.isFavorite = 0,
  });

  factory Contact.fromMap(Map<String, dynamic> json) => Contact(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        isFavorite: json['isFavorite'],
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "email": email,
      "isFavorite": isFavorite,
    };
  }
}