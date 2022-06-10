import 'package:contact_listing_bloc/src/blocs/contact_bloc/contact_bloc.dart';
import 'package:contact_listing_bloc/src/blocs/contact_bloc/contact_list_bloc.dart';
import 'package:contact_listing_bloc/src/models/contacts.dart';
import 'package:contact_listing_bloc/src/modules/contact/detail_contact_page.dart';
import 'package:flutter/material.dart';

class DetailContact extends StatelessWidget {
  const DetailContact({
    Key? key,
    required this.size,
    required this.widget,
    required TextEditingController updateNameController,
    required TextEditingController updatePhoneNumberController,
  })  : _updateNameController = updateNameController,
        _updatePhoneNumberController = updatePhoneNumberController,
        super(key: key);

  final Size size;
  final DetailContactPage widget;
  final TextEditingController _updateNameController;
  final TextEditingController _updatePhoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: CircleAvatar(
            radius: size.width / 10,
            backgroundColor: Colors.pink,
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            widget.contact.name,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            widget.contact.phoneNumber,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              final contactBloc = ContactBloc();
              showUpdateDialog(context, contactBloc);
            },
            child: Container(
                width: size.width / 2.5,
                height: size.height / 15,
                decoration: BoxDecoration(color: Colors.green.shade700),
                child: const Center(
                    child: Text(
                  'Update',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ))),
          ),
          GestureDetector(
            onTap: () {
              contactListBloc.removeContact(widget.contact);
              Navigator.pop(context);
            },
            child: Container(
                width: size.width / 2.5,
                height: size.height / 15,
                decoration: BoxDecoration(color: Colors.red.shade700),
                child: const Center(
                    child: Text(
                  'Remove',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ))),
          ),
        ],
      )
    ]);
  }

  Future<dynamic> showUpdateDialog(
      BuildContext context, ContactBloc contactBloc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Login'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    StreamBuilder<String>(
                        stream: contactBloc.nameStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _updateNameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: widget.contact.name,
                              icon: const Icon(Icons.account_box),
                              errorText: snapshot.hasError
                                  ? snapshot.error as String
                                  : null,
                            ),
                          );
                        }),
                    StreamBuilder<String>(
                        stream: contactBloc.phoneNumberStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _updatePhoneNumberController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              icon: const Icon(Icons.phone),
                              errorText: snapshot.hasError
                                  ? snapshot.error as String
                                  : null,
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            actions: [
              GestureDetector(
                  child: Container(
                      height: size.width / 10,
                      decoration: BoxDecoration(color: Colors.pink.shade200),
                      child: const Center(
                          child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
                  onTap: () {
                    if (contactBloc.isValidContact(
                      _updateNameController.text,
                      _updatePhoneNumberController.text,
                    )) {
                      contactListBloc.updateContact(
                          widget.contact,
                          Contact(
                              name: _updateNameController.text,
                              phoneNumber: _updatePhoneNumberController.text));
                      contactBloc.dispose();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  }),
              GestureDetector(
                  child: Container(
                      height: size.width / 10,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: const Center(
                          child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
                  onTap: () {
                    contactBloc.dispose();
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}
