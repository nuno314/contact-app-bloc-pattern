import 'package:contact_listing_bloc/src/blocs/contacts/contacts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/contacts.dart';

class CreateContactScreen extends StatefulWidget {
  const CreateContactScreen({Key? key}) : super(key: key);

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Create Contact')),
      body: CreateContact(
          nameController: _nameController,
          phoneNumberController: _phoneNumberController,
          size: size),
    );
  }
}

class CreateContact extends StatelessWidget {
  const CreateContact({
    Key? key,
    required TextEditingController nameController,
    required TextEditingController phoneNumberController,
    required this.size,
  })  : _nameController = nameController,
        _phoneNumberController = phoneNumberController,
        super(key: key);

  final TextEditingController _nameController;
  final TextEditingController _phoneNumberController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactsBloc, ContactsState>(
      listener: (context, state) {
        if (state is ContactsLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Contact Added'),
            ),
          );
          Navigator.pop(context);
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
                  var contact = Contact(
                    name: _nameController.text,
                    phoneNumber: _phoneNumberController.text,
                  );
                  context
                      .read<ContactsBloc>()
                      .add(AddContact(contact: contact));
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
    );
  }
}
