part of 'contacts_bloc.dart';

abstract class ContactsState {
  final List<Contact> contacts;
  

  const ContactsState(this.contacts);
}

class ContactsLoading extends ContactsState {
  const ContactsLoading(super.contacts);
}

class ContactsLoaded extends ContactsState {
  const ContactsLoaded(super.contacts);
}

class ContactDeleted extends ContactsState {
  const ContactDeleted(super.contacts);
}

class ContactUpdated extends ContactsState {
  const ContactUpdated(super.contacts);
}
