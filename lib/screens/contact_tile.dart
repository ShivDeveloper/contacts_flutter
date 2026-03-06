import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';
import '../models/contact_model.dart';
import '../screens/contact_detail_screen.dart';

class ContactTile extends StatelessWidget {

  final Contact contact;

  ContactTile({required this.contact});

  final controller = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return ListTile(

      leading: CircleAvatar(
        radius: size.width * 0.06,
        child: Text(contact.name[0]),
      ),

      title: Text(contact.name),

      subtitle: Text(contact.phone),

      trailing: IconButton(
        icon: Icon(
          contact.isFavorite == 1
              ? Icons.star
              : Icons.star_border,
        ),
        onPressed: () {
          controller.toggleFavorite(contact);
        },
      ),

      onTap: () {
        Get.to(() => ContactDetailScreen(contact: contact));
      },
    );
  }
}