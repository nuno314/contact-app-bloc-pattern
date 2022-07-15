import 'package:contact_listing_bloc/src/blocs/contacts/contacts_bloc.dart';
import 'package:contact_listing_bloc/src/models/contacts.dart';
import 'package:contact_listing_bloc/src/modules/contact/add_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailContactPage extends StatefulWidget {
  int contactIndex;
  DetailContactPage({Key? key, required this.contactIndex}) : super(key: key);
  @override
  State<DetailContactPage> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  ContactsBloc get bloc => BlocProvider.of(context);
  Contact? _contact;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: const Text('Detail')),
        body: BlocConsumer<ContactsBloc, ContactsState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is ContactDeleted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Deleted'),
                ),
              );
            } else if (state is ContactUpdated) {
              setState(() {});
            }
          },
          builder: (context, state) {
            _contact = state.contacts.elementAt(widget.contactIndex);
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
                    _contact!.name,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    _contact!.phoneNumber,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateContactScreen(
                                    contact: _contact!,
                                  )));
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
                      bloc.add(DeleteContact(contact: _contact!));
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
          },
        ));
  }
}
