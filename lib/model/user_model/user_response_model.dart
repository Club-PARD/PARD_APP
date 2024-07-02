class UserResponseDTO {
  final String name;
  final String email;
  final String part;

  UserResponseDTO({required this.name, required this.email, required this.part});

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) {
    return UserResponseDTO(
      name: json['name'],
      email: json['email'],
      part: json['part'],
    );
  }
}