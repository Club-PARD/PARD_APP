class UserInfo {
  final String part;
  final String name;
  final String role;
  final String generation;

  UserInfo({this.part = '', this.name = '', this.role = '', this.generation = ''});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      part: json['part'],
      name: json['name'],
      role: json['role'],
      generation: json['generation'],
    );
  }
}