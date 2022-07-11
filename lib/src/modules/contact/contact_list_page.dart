import 'package:contact_listing_bloc/src/blocs/contacts/contacts_bloc.dart';
import 'package:contact_listing_bloc/src/modules/contact/add_contact_page.dart';
import 'package:contact_listing_bloc/src/modules/contact/detail_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Contact List')),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateContactScreen()));
          },
          child: const Icon(
            Icons.add,
            size: 100,
            color: Colors.pink,
          ),
        ),
        body: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              print('ContactsLoading');
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                  strokeWidth: 15,
                ),
              );
            } else if (state is ContactsLoaded) {
              print('ContactsLoaded');

              return ListView(
                children: state.contacts
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailContactPage(
                                            contact: e,
                                          )));
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
                                      e.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      e.phoneNumber,
                                      style: TextStyle(fontSize: 22),
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
              return Text('Error');
            }
          },
        ));
  }
}
