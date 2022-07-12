import 'package:contact_listing_bloc/src/blocs/contacts/contacts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/contacts.dart';

class CreateContactScreen extends StatefulWidget {
  final Contact? contact;

  const CreateContactScreen({Key? key, this.contact}) : super(key: key);

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  ContactsBloc get bloc => BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Contact? contact;

    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _phoneNumberController.text = widget.contact!.phoneNumber;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add Contact')),
      body: BlocListener<ContactsBloc, ContactsState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ContactsLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Contact Added'),
              ),
            );
            Navigator.of(context).pop(contact);
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  label: Text('PhoneNumber'),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    contact = Contact(
                      name: _nameController.text,
                      phoneNumber: _phoneNumberController.text,
                      id: widget.contact?.id,
                    );

                    if (contact == null) {
                      return;
                    }

                    //Update
                    if (widget.contact != null) {
                      bloc.add(UpdateContact(contact: contact!));
                    }

                    //Add
                    else {
                      context
                          .read<ContactsBloc>()
                          .add(AddContact(contact: contact!));
                    }
                  },
                  child: Container(
                      width: size.width / 2,
                      height: size.height / 18,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.pink.shade200),
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
