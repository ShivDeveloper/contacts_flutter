import 'package:get/get.dart';
import '../database/database_helper.dart';
import '../models/contact_model.dart';
import 'package:sqflite/sqflite.dart';

class ContactController extends GetxController {

  var contacts = <Contact>[].obs;
  var favorites = <Contact>[].obs;
  Rxn<Contact> selectedContact = Rxn<Contact>();

  Database? db;

  @override
  void onInit() {
    initDatabase();
    super.onInit();
  }

  void initDatabase() async {

    db = await DatabaseHelper().database;
    fetchContacts();
  }

  void fetchContacts() async {

    final data = await db!.query("contacts");

    contacts.value =
        data.map((e) => Contact.fromMap(e)).toList();

    favorites.value =
        contacts.where((c) => c.isFavorite == 1).toList();
  }

  void addContact(Contact contact) async {

    await db!.insert("contacts", contact.toMap());

    fetchContacts();
  }

Future<Contact?> getContactById(int id) async {

  final database = await db;

  final result = await database!.query(
    "contacts",
    where: "id = ?",
    whereArgs: [id],
  );

  if (result.isNotEmpty) {
    return Contact.fromMap(result.first);
  }

  return null;
}
  
  Future<void> updateContact(Contact contact) async {

  final database = await db;

  await database!.update(
    "contacts",
    contact.toMap(),
    where: "id = ?",
    whereArgs: [contact.id],
  );

  fetchContacts(); // refresh contact list
}

Future<void> deleteContact(int? id) async {

  final database = await db;

  await database!.delete(
    "contacts",
    where: "id = ?",
    whereArgs: [id],
  );

  fetchContacts();
}

  void toggleFavorite(Contact contact) async {

    int newValue = contact.isFavorite == 1 ? 0 : 1;

    await db!.update(
      "contacts",
      {"isFavorite": newValue},
      where: "id=?",
      whereArgs: [contact.id],
    );

    fetchContacts();
  }
  Future<void> loadContact(int id) async {

  Contact? contact = await getContactById(id);

  if (contact != null) {
    selectedContact.value = contact;
  }

}
}