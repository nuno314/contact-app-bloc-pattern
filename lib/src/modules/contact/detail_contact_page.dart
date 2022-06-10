import 'package:contact_listing_bloc/src/models/contacts.dart';
import 'package:contact_listing_bloc/src/modules/contact/widgets/detail_contact.dart';
import 'package:flutter/material.dart';

class DetailContactPage extends StatefulWidget {
  Contact contact;
  DetailContactPage({Key? key, required this.contact}) : super(key: key);
  @override
  State<DetailContactPage> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  final _updateNameController = TextEditingController();
  final _updatePhoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: DetailContact(
        size: size,
        widget: widget,
        updateNameController: _updateNameController,
        updatePhoneNumberController: _updatePhoneNumberController,
      ),
    );
  }
}
