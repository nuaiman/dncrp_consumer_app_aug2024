// ignore_for_file: public_member_api_docs, sort_constructors_first
class Auth {
  final String uId;
  final String jwt;
  final String email;
  final String phone;
  final String password;
  Auth({
    required this.uId,
    required this.jwt,
    required this.email,
    required this.phone,
    required this.password,
  });

  Auth copyWith({
    String? uId,
    String? jwt,
    String? email,
    String? phone,
    String? password,
  }) {
    return Auth(
      uId: uId ?? this.uId,
      jwt: jwt ?? this.jwt,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }
}
