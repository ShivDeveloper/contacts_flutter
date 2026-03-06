import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';
import 'package:google_contacts/screens/add_contact_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_model.dart';

class ContactDetailScreen extends StatefulWidget {

  final Contact contact;

  const ContactDetailScreen({super.key, required this.contact});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {

  Contact get contact => widget.contact;
  

  final controller = Get.find<ContactController>();

  @override
  void initState() {
    super.initState();
    controller.selectedContact.value = widget.contact;
  }

  void callNumber(String phone) async {

    final Uri url = Uri.parse("tel:$phone");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        title: Text(contact.name),

        actions: [

          /// EDIT BUTTON
          IconButton(
  icon: const Icon(Icons.edit),
  onPressed: () async {

    final updatedContact = await Get.to(
      () => AddContactScreen(
        contact: controller.selectedContact.value,
      ),
    );

    if (updatedContact != null) {
      controller.selectedContact.value = updatedContact;
    }

  },
),

          /// DELETE BUTTON
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {

              Get.dialog(
                Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        const Text(
                          "Delete Contact",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Are you sure you want to delete this contact?",
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            /// NO BUTTON
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("No", style: TextStyle(color: Colors.white),),
                            ),

                            /// YES BUTTON
                            ElevatedButton(
                              onPressed: () {

                                controller.deleteContact(contact.id);

                                Get.back(); // close dialog
                                Get.back(); // close detail screen

                              },
                              child: const Text("Yes"),
                            ),

                          ],
                        )

                      ],
                    ),
                  ),
                ),
              );
            },
          ),

        ],
      ),

      body: Padding(

  padding: EdgeInsets.all(size.width * 0.05),

  child: Obx(() {

    final contact = controller.selectedContact.value;

    if (contact == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(

      children: [

        CircleAvatar(
          radius: size.width * 0.15,
          child: Text(contact.name[0].toUpperCase()),
        ),

        SizedBox(height: size.height * 0.03),

        Text(
          contact.name,
          style: TextStyle(fontSize: size.width * 0.05),
        ),

        SizedBox(height: size.height * 0.03),

        Text(
          contact.phone,
          style: TextStyle(fontSize: size.width * 0.05),
        ),

        SizedBox(height: size.height * 0.01),

        Text(contact.email),

        SizedBox(height: size.height * 0.04),

        SizedBox(
          width: size.width,
          child: ElevatedButton(

            onPressed: () {
              callNumber(contact.phone);
            },

            child: const Text("Call"),
          ),
        )

      ],
    );

  }),
),
    );
  }
}