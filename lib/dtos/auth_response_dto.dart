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
      accessToken: json['access_token']?.toString() ?? '',
      refreshToken: json['refresh_token']?.toString() ?? '',
      expiresIn: int.tryParse(json['expires_in']?.toString() ?? '0') ?? 0,
    );
  }
}
