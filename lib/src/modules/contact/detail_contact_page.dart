import 'package:contact_listing_bloc/src/blocs/contacts/contacts_bloc.dart';
import 'package:contact_listing_bloc/src/modules/contact/add_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailContactPage extends StatefulWidget {
  final int contactIndex;
  const DetailContactPage({Key? key, required this.contactIndex})
      : super(key: key);
  @override
  State<DetailContactPage> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: BlocConsumer<ContactsBloc, ContactsState>(
        listener: (context, state) {
          if (state is ContactDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Deleted'),
              ),
            );
            Navigator.pop(context);
          } else if (state is ContactUpdated) {
            setState(() {});
          }
        },
        builder: (context, state) => Column(
          children: [
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
                  state.contacts.elementAt(widget.contactIndex).name,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  state.contacts.elementAt(widget.contactIndex).phoneNumber,
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
                          contact:
                              state.contacts.elementAt(widget.contactIndex),
                        ),
                      ),
                    );
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
                    context.read<ContactsBloc>().add(DeleteContact(
                        contact:
                            state.contacts.elementAt(widget.contactIndex)));
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
            ),
          ],
        ),
      ),
    );
  }
}
