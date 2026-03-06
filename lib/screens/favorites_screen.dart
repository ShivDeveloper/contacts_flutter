import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_contacts/screens/contact_tile.dart';
import '../controllers/contact_controller.dart';

class FavoritesScreen extends StatelessWidget {

  final controller = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Favorites")),

      body: Obx(() {

        return ListView.builder(

          itemCount: controller.favorites.length,

          itemBuilder: (context, index) {

            return ContactTile(
              contact: controller.favorites[index],
            );
          },
        );
      }),
    );
  }
}