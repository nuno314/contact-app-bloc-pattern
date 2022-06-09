import 'package:flutter/material.dart';

import '../../blocs/contact_bloc/contact_bloc.dart';
import 'widgets/create_contact.dart';

class CreateContactScreen extends StatefulWidget {
  const CreateContactScreen({Key? key}) : super(key: key);

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final _contactBloc = ContactBloc();

  @override
  void dispose() {
    _contactBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Create Contact')),
      body: CreateContact(
          contactBloc: _contactBloc,
          nameController: _nameController,
          phoneNumberController: _phoneNumberController,
          size: size),
    );
  }
}
