import 'dart:convert';

class Order {
  final int id;
  final String name;
  final String email;

  Order({
    required this.id,
    required this.name,
    required this.email,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };

  String toRawJson() => json.encode(toJson());

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

}
