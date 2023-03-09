class ContactModel {
  int id = 0;
  String? name = '';
  String? email = '';
  String? phone = '';
  String? image;
  String? addressLine1;
  String? addressLine2;
  String? latLng = '';

  ContactModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.addressLine1,
    this.addressLine2,
    this.latLng,
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
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
        email: map['email'],
        addressLine1: map['addressLine1'],
        addressLine2: map['addressLine2'],
        image: map['image'],
        latLng: map['latLng']);
  }
}
