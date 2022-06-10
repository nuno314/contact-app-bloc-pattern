import 'dart:async';

import 'package:contact_listing_bloc/src/blocs/contact_bloc/contact_list_bloc.dart';

import '../../models/contacts.dart';

class ContactBloc {
  final StreamController<Contact> _contactController =
      StreamController<Contact>();

  final StreamController<String> _nameController = StreamController<String>();
  final StreamController<String> _phoneNumberController =
      StreamController<String>();

  Stream<Contact> get contactStream => _contactController.stream;
  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get phoneNumberStream => _phoneNumberController.stream;

  bool isValidContact(String name, String phoneNumber) {
    if (name.isEmpty) {
      _nameController.addError('Please enter Name');
      return false;
    }
    _nameController.add('Valid name');

    if (phoneNumber.isEmpty) {
      _phoneNumberController.addError('Please enter Phone number');
      return false;
    }

    if (phoneNumber.length != 10) {
      _phoneNumberController.addError('Phone number must 10-digit length');
      return false;
    }

    _phoneNumberController.add('Valid phone number');
    return true;
  }

  createContact(String name, String phoneNumber) {
    if (!isValidContact(name, phoneNumber)) {
      return;
    }
    Contact newContact = Contact(name: name, phoneNumber: phoneNumber);
    // _contactController.sink.add(newContact);
    contactListBloc.addContact(newContact);
  }

  void dispose() {
    _contactController.close();
    _nameController.close();
    _phoneNumberController.close();
  }
}
