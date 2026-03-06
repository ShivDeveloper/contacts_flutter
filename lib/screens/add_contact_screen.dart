import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';
import '../models/contact_model.dart';

class AddContactScreen extends StatelessWidget {

  final Contact? contact;
  
    final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();

  final controller = Get.find<ContactController>();

  AddContactScreen({this.contact}) {

    /// Prefill data if editing
    if (contact != null) {
      name.text = contact!.name ?? "";
      phone.text = contact!.phone ?? "";
      email.text = contact!.email ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        title: Text(contact == null ? "Add Contact" : "Edit Contact"),
      ),

      body: Padding(

        padding: EdgeInsets.all(size.width * 0.05),

        

child: Form(
  key: _formKey,
  child: Column(
    children: [

      /// NAME
      TextFormField(
        controller: name,
        decoration: const InputDecoration(labelText: "Name"),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Name cannot be empty";
          }
          return null;
        },
      ),

      SizedBox(height: size.height * 0.02),

      /// PHONE
      TextFormField(
        controller: phone,
        decoration: const InputDecoration(labelText: "Phone"),
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Phone number cannot be empty";
          }
          if (value.length < 10) {
            return "Enter valid phone number";
          }
          return null;
        },
      ),

      SizedBox(height: size.height * 0.02),

      /// EMAIL
      TextFormField(
        controller: email,
        decoration: const InputDecoration(labelText: "Email"),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {

          if (value == null || value.trim().isEmpty) {
            return "Email cannot be empty";
          }

          final emailRegex = RegExp(
              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

          if (!emailRegex.hasMatch(value)) {
            return "Enter valid email address";
          }

          return null;
        },
      ),

      SizedBox(height: size.height * 0.04),

      /// BUTTON
      SizedBox(
        width: size.width,
        child: ElevatedButton(
          onPressed: () {

            /// VALIDATE FORM
            if (_formKey.currentState!.validate()) {

              Contact newContact = Contact(
                id: contact?.id,
                name: name.text,
                phone: phone.text,
                email: email.text,
              );

              if (contact == null) {

                /// ADD
                controller.addContact(newContact);

              } else {

                /// UPDATE
                controller.updateContact(newContact);

              }

              Get.back(result: newContact);
            }

          },
          child: Text(contact == null ? "Save" : "Update"),
        ),
      ),

    ],
  ),
)
      ),
    );
  }
}