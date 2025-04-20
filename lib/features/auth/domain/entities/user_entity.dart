class UserEntity 
{
  final String name;
  final String email;
  final int age;
  final String phone;
  final String nationalId;
  final String address;
  final String type;
  

  UserEntity({
    required this.name,
    required this.email,
    required this.age,
    required this.phone,
    required this.nationalId,
    required this.address,
    required this.type,
  });
  toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'phone': phone,
      'nationalId': nationalId,
      'address': address,
      'type': type,
    };
  }
}