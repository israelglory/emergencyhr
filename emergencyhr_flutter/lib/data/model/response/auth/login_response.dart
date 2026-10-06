class LoginResponse {
  final String? accessToken;
  final String? refreshToken;
  final String? tokenType;

  LoginResponse({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
        tokenType: json['tokenType'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'tokenType': tokenType,
      };
}
