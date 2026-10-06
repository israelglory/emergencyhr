class LoginParam {
  final String email;
  final String password;

  LoginParam({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  factory LoginParam.fromJson(Map<String, dynamic> json) => LoginParam(
        email: json["email"] ?? '',
        password: json["password"] ?? '',
      );
}
