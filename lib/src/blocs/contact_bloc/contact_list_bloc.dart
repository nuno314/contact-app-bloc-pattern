import 'dart:async';

import 'package:contact_listing_bloc/src/models/contacts.dart';

class ContactListBloc {
  List<Contact> list = [];

  final _listController = StreamController<List<Contact>>();

  Stream<List<Contact>> get listStream => _listController.stream;

  addContact(Contact contact) {
    list.add(contact);
    list.sort(((a, b) => a.name.compareTo(b.name)));
    _listController.sink.add(list);
  }

  removeContact(Contact contact) {
    list.remove(contact);
    _listController.sink.add(list);
  }

  updateContact(Contact contact, Contact newContact) {
    int i = list.indexOf(contact);
    if (i == -1) {
      return;
    }
    list[i] = newContact;
    _listController.sink.add(list);
  }
}

final contactListBloc = ContactListBloc();
