import 'package:contact_listing_bloc/src/blocs/contact_bloc/contact_list_bloc.dart';
import 'package:contact_listing_bloc/src/models/contacts.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Contact>>(
      initialData: contactListBloc.list,
      stream: contactListBloc.listStream,
      builder: (context, snapshot) {
        return Expanded(
          child: ListView(
            children: snapshot.data!
                .map((e) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const CircleAvatar(),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(e.phoneNumber),
                            ],
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
