class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});

  Contact copyWith({String? name, String? phoneNumber}) {
    return Contact(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  static List<Contact> contacts = [
    Contact(name: 'Tin', phoneNumber: '0336948000'),
    Contact(name: 'Lam', phoneNumber: '0336948001'),
    Contact(name: 'Van', phoneNumber: '0336948002'),
  ];
}

List<Contact> users = [
  Contact(name: 'Tin', phoneNumber: '0336948000'),
  Contact(name: 'Lam', phoneNumber: '0336948001'),
  Contact(name: 'Van', phoneNumber: '0336948002'),
];
