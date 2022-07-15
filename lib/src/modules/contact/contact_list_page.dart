import 'package:contact_listing_bloc/src/blocs/contacts/contacts_bloc.dart';
import 'package:contact_listing_bloc/src/models/contacts.dart';
import 'package:contact_listing_bloc/src/modules/contact/add_contact_page.dart';
import 'package:contact_listing_bloc/src/modules/contact/detail_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  ContactsBloc get bloc => BlocProvider.of(context);
  @override
  void initState() {
    bloc.add(LoadContacts(contacts: users));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Contact List')),
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateContactScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            size: 100,
            color: Colors.pink,
          ),
        ),
        body: BlocBuilder<ContactsBloc, ContactsState>(
          bloc: bloc,
          builder: (context, state) {
            List<Contact> contacts = state.contacts;

            if (state is ContactsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                  strokeWidth: 15,
                ),
              );
            } else if (state is ContactsLoaded) {
              return ListView(
                children: contacts
                    .map((contact) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailContactPage(
                                    contactIndex: contacts.indexOf(contact),
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.pink,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contact.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      contact.phoneNumber,
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              );
            } else {
              return const Text('Error');
            }
          },
        ));
  }
}
