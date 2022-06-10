import 'package:contact_listing_bloc/src/blocs/contact_bloc/contact_bloc.dart';
import 'package:contact_listing_bloc/src/blocs/contact_bloc/contact_list_bloc.dart';
import 'package:contact_listing_bloc/src/models/contacts.dart';
import 'package:contact_listing_bloc/src/modules/contact/add_contact_page.dart';
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
      body: Column(children: [
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

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Text('Login'),
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
                                          icon: Icon(Icons.account_box),
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
                                        controller:
                                            _updatePhoneNumberController,
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
                                  decoration: BoxDecoration(
                                      color: Colors.pink.shade200),
                                  child: Center(
                                      child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                              onTap: () {
                                print(
                                  _updateNameController.text,
                                );
                                print(_updatePhoneNumberController.text);
                                if (contactBloc.isValidContact(
                                  _updateNameController.text,
                                  _updatePhoneNumberController.text,
                                )) {
                                  contactListBloc.updateContact(
                                      widget.contact,
                                      Contact(
                                          name: _updateNameController.text,
                                          phoneNumber:
                                              _updatePhoneNumberController
                                                  .text));
                                  contactBloc.dispose();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              }),
                          GestureDetector(
                              child: Container(
                                  height: size.width / 10,
                                  decoration:
                                      BoxDecoration(color: Colors.black),
                                  child: Center(
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
      ]),
    );
  }
}
