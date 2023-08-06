class UserModel{
  String name;
  int phoneNumber;
  String email;
  String part;
  String member;
  int generation;
  bool isAdmin;
  bool isMaster;
  DateTime lastLogin;
  UserModel(
    this.name,
    this.phoneNumber,
    this.email,
    this.part,
    this.member,
    this.generation,
    this.isAdmin,
    this.isMaster,
    this.lastLogin
  );
}