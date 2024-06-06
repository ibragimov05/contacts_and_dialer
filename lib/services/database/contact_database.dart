import 'package:contacts_and_dialer/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ContactDatabase with ChangeNotifier {
  ContactDatabase._privateConstructor();

  static final ContactDatabase instance = ContactDatabase._privateConstructor();

  Database? _contactDatabase;

  Future<Database> get contactDatabase async {
    if (_contactDatabase != null) {
      return _contactDatabase!;
    }
    _contactDatabase = await _initDatabase();
    return _contactDatabase!;
  }

  Future<Database> _initDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String path = '$databasePath/contacts.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database contactDatabase, int version) async {
    await contactDatabase.execute('''
    CREATE TABLE contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      number TEXT NOT NULL
    )
    ''');
  }

  Future<List<Contact>> getContacts() async {
    final Database database = await contactDatabase;
    final List<Map<String, dynamic>> contacts =
        await database.query('contacts');

    List<Contact> loadedContacts = [];
    for (Map<String, dynamic> json in contacts) {
      loadedContacts.add(
        Contact.fromJson(json),
      );
    }
    notifyListeners();
    return loadedContacts;
  }

  Future<void> addContact(
      {required String name, required String number}) async {
    final db = await contactDatabase;
    await db.insert(
      'contacts',
      {
        'name': name,
        'number': number,
      },
    );
    notifyListeners();
  }
}
