class NgoEntity 
{
  final String name;
  final String email;
  final String phone;
  final String ngoId;
  final String address;
  

  NgoEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.ngoId,
    required this.address,
    
  });
  toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'ngoId': ngoId,
      'address': address,
      
    };
  }
}