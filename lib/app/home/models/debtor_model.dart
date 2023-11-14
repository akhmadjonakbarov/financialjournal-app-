// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DebtorModel {
  final int id;
  final String name;
  final String phonenumber;
  DebtorModel({
    required this.id,
    required this.name,
    required this.phonenumber,
  });

  DebtorModel copyWith({
    int? id,
    String? name,
    String? phonenumber,
  }) {
    return DebtorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phonenumber: phonenumber ?? this.phonenumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phonenumber': phonenumber,
    };
  }

  factory DebtorModel.fromMap(Map<String, dynamic> map) {
    return DebtorModel(
      id: map['id'] as int,
      name: map['name'] as String,
      phonenumber: map['phonenumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DebtorModel.fromJson(String source) => DebtorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DebtorModel(id: $id, name: $name, phonenumber: $phonenumber)';

  @override
  bool operator ==(covariant DebtorModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.phonenumber == phonenumber;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ phonenumber.hashCode;
}
