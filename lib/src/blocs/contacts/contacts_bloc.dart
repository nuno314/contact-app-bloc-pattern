

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/contacts.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(const ContactsLoading([])) {
    on<LoadContacts>(_onLoadContacts);
    on<AddContact>(_onAddContact);
    on<UpdateContact>(_onUpdateContact);
    on<DeleteContact>(_onDeleteContact);
  }

  void _onLoadContacts(LoadContacts event, Emitter<ContactsState> emit) {
    emit(ContactsLoaded(event.contacts));
  }

  void _onAddContact(AddContact event, Emitter<ContactsState> emit) {
    final state = this.state;

    if (state is ContactsLoaded) {
      if (_validContact(event.contact)) {
        Contact contact = event.contact.copyWith(id: state.contacts.length);
        emit(
          ContactsLoaded(
            List.from(state.contacts)..add(contact),
          ),
        );
      }
    }
  }

  void _onUpdateContact(UpdateContact event, Emitter<ContactsState> emit) {
    final state = this.state;
    if (state is ContactsLoaded) {
      List<Contact> contacts = state.contacts.map((contact) {
        return contact.id == event.contact.id ? event.contact : contact;
      }).toList();
      emit(ContactUpdated(state.contacts));
      emit(ContactsLoaded(contacts));
    }
  }

  void _onDeleteContact(DeleteContact event, Emitter<ContactsState> emit) {
    final state = this.state;
    if (state is ContactsLoaded) {
      List<Contact> contacts = state.contacts.where((contact) {
        return contact.phoneNumber != event.contact.phoneNumber;
      }).toList();
      emit(ContactDeleted(state.contacts));
      emit(ContactsLoaded(contacts));
    }
  }

  bool _validContact(Contact contact) {
    return contact.name.isNotEmpty &&
        contact.phoneNumber.isNotEmpty &&
        contact.phoneNumber.length == 10;
  }
}
