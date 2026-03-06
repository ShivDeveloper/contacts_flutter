import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_contacts/screens/contact_tile.dart';
import '../controllers/contact_controller.dart';
import 'add_contact_screen.dart';

class ContactsScreen extends StatelessWidget {

  final controller = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(title: const Text("Contacts")),

      body: Obx(() {

        return ListView.builder(

          itemCount: controller.contacts.length,

          itemBuilder: (context, index) {

            return ContactTile(
              contact: controller.contacts[index],
            );
          },
        );
      }),

      floatingActionButton: SizedBox(
        width: size.width * 0.15,
        height: size.width * 0.15,
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.to(() => AddContactScreen());
          },
        ),
      ),
    );
  }
}