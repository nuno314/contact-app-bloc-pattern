import 'dart:async';

import 'package:contact_listing_bloc/src/models/contacts.dart';

class ContactListBloc {
  List<Contact> list = [];

  final _listController = StreamController<List<Contact>>();

  Stream<List<Contact>> get listStream => _listController.stream;

  addContact(Contact contact) {
    list.add(contact);
    _listController.sink.add(list);
  }
}

final contactListBloc = ContactListBloc();
