part of 'contacts_bloc.dart';

abstract class ContactsEvent {}

class LoadContacts extends ContactsEvent {
  final List<Contact> contacts;

  LoadContacts({required this.contacts});
}

class AddContact extends ContactsEvent {
  final Contact contact;

  AddContact({required this.contact});
}

class UpdateContact extends ContactsEvent {
  final Contact contact;
  UpdateContact({required this.contact});
}

class DeleteContact extends ContactsEvent {
  final Contact contact;
  DeleteContact({required this.contact});
}
