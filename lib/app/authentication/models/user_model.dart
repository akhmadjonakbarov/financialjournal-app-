// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final int id;
  final String name;
  final String accessToken;
  final String refreshToken;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.accessToken,
    required this.refreshToken,
    required this.phoneNumber,
  });
}
