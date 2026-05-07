class AuthResponseDto {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  AuthResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      expiresIn: json['expires_in'] ?? 0,
    );
  }
}
