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

// class CreateContact extends StatelessWidget {
//   const CreateContact({
//     Key? key,
//     required ContactBloc contactBloc,
//     required TextEditingController nameController,
//     required TextEditingController phoneNumberController,
//     required this.size,
//   })  : _contactBloc = contactBloc,
//         _nameController = nameController,
//         _phoneNumberController = phoneNumberController,
//         super(key: key);

//   final ContactBloc _contactBloc;
//   final TextEditingController _nameController;
//   final TextEditingController _phoneNumberController;
//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         StreamBuilder<String>(
//             stream: _contactBloc.nameStream,
//             builder: (context, snapshot) {
//               return Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: TextField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                       label: const Text('Name'),
//                       errorText:
//                           snapshot.hasError ? snapshot.error as String : null),
//                 ),
//               );
//             }),
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: StreamBuilder<String>(
//               stream: _contactBloc.phoneNumberStream,
//               builder: (context, snapshot) {
//                 return TextField(
//                   controller: _phoneNumberController,
//                   decoration: InputDecoration(
//                     label: const Text('PhoneNumber'),
//                     errorText:
//                         snapshot.hasError ? snapshot.error as String : null,
//                   ),
//                 );
//               }),
//         ),
//         Padding(
//             padding: const EdgeInsets.all(16),
//             child: GestureDetector(
//               onTap: () {
//                 _contactBloc.createContact(
//                     _nameController.text, _phoneNumberController.text);
//                 _contactBloc.isValidContact(
//                         _nameController.text, _phoneNumberController.text)
//                     ? Navigator.pop(context)
//                     : null;
//               },
//               child: Container(
//                   width: size.width / 2,
//                   height: size.height / 18,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.pink.shade200),
//                   child: const Center(
//                     child: Text(
//                       'Submit',
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   )),
//             )),
//       ],
//     );
//   }
// }
