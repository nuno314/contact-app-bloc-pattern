import 'package:contact_listing_bloc/src/blocs/contacts/contacts_bloc.dart';
import 'package:contact_listing_bloc/src/models/contacts.dart';
import 'package:contact_listing_bloc/src/modules/contact/contact_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactsBloc(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: Colors.pink.shade200,
        )),
        home: ContactListScreen(),
      ),
    );
  }
}
