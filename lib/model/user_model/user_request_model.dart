class UserRequestDTO {
  final String name;
  final String email;
  final String part;

  UserRequestDTO({required this.name, required this.email, required this.part});

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'part': part,
  };
}