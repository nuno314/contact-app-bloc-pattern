// ignore_for_file: public_member_api_docs, sort_constructors_first
class Contact {
  final int? id;
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber, this.id});

  static List<Contact> contacts = [
    Contact(name: 'Tin', phoneNumber: '0336948000', id: 0),
    Contact(name: 'Lam', phoneNumber: '0336948001', id: 1),
    Contact(name: 'Van', phoneNumber: '0336948002', id: 2),
  ];

  Contact copyWith({
    int? id,
    String? name,
    String? phoneNumber,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

List<Contact> users = [
  Contact(name: 'Tin', phoneNumber: '0336948000', id: 0),
  Contact(name: 'Lam', phoneNumber: '0336948001', id: 1),
  Contact(name: 'Van', phoneNumber: '0336948002', id: 2),
];
