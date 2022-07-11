import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../models/contacts.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsLoading()) {
    on<LoadContacts>(_onLoadContacts);
    on<AddContact>(_onAddContact);
    on<UpdateContact>(_onUpdateContact);
    on<DeleteContact>(_onDeleteContact);
  }

  void _onLoadContacts(LoadContacts event, Emitter<ContactsState> emit) {
    emit(ContactsLoaded(contacts: event.contacts));
  }

  void _onAddContact(AddContact event, Emitter<ContactsState> emit) {
    final state = this.state;
    if (state is ContactsLoaded) {
      if (_validContact(event.contact)) {
        emit(ContactsLoaded(
            contacts: List.from(state.contacts)..add(event.contact)));
      }
    }
  }

  void _onUpdateContact(UpdateContact event, Emitter<ContactsState> emit) {
    final state = this.state;
    if (state is ContactsLoaded) {
      List<Contact> contacts = state.contacts.map((contact) {
        return contact.phoneNumber == event.contact.phoneNumber
            ? event.contact
            : contact.name == event.contact.name
                ? event.contact
                : contact;
      }).toList();
      emit(ContactsLoaded(contacts: contacts));
    }
  }

  void _onDeleteContact(DeleteContact event, Emitter<ContactsState> emit) {
    final state = this.state;
    if (state is ContactsLoaded) {
      List<Contact> contacts = state.contacts.where((contact) {
        return contact.phoneNumber != event.contact.phoneNumber;
      }).toList();
      emit(ContactsLoaded(contacts: contacts));
    }
  }

  bool _validContact(Contact contact) {
    return contact.name.isNotEmpty &&
        contact.phoneNumber.isNotEmpty &&
        contact.phoneNumber.length == 10;
  }
}
