class ContactModel {
  int id = 0;
  String name = '';
  String? email = '';
  String phone = '';
  String? image = 'assets/images/profile-picture.png';
  String addressLine1 = '';
  String addressLine2 = '';
  String latLng = '';

  ContactModel({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    this.image,
    required this.addressLine1,
    required this.addressLine2,
    required this.latLng,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'latLng': latLng,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
        id: int.parse(map['id']),
        name: map['name'],
        phone: map['phone'],
        addressLine1: map['addressLine1'],
        addressLine2: map['addressLine2'],
        latLng: map['latLng']);
  }
}
