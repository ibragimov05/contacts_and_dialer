import 'package:contacts_and_dialer/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDatabase {
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
    return loadedContacts;
  }

  Future<void> addContact(
      {required String name, required String number}) async {
    final Database db = await contactDatabase;
    await db.insert(
      'contacts',
      {
        'name': name,
        'number': number,
      },
    );
  }

  Future<void> editContact(
      {required int id,
      required String newName,
      required String newNumber}) async {
    final Database db = await contactDatabase;

    await db.update(
      'contacts',
      {
        'name': newName,
        'number': newNumber,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteContact({required int id}) async {
    final Database db = await contactDatabase;

    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
