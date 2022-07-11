part of 'contacts_bloc.dart';

@immutable
abstract class ContactsState {

}

class ContactsLoading extends ContactsState {
}

class ContactsLoaded extends ContactsState {
  final List<Contact> contacts;

  ContactsLoaded({this.contacts = const <Contact>[]});

  List<Object> get props => [contacts];
}
