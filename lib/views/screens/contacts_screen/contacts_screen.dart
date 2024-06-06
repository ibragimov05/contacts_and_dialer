import 'package:contacts_and_dialer/models/contact.dart';
import 'package:contacts_and_dialer/provider/theme_provider.dart';
import 'package:contacts_and_dialer/services/database/contact_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final ContactDatabase _contactDatabase = ContactDatabase.instance;
  List<Contact> _contacts = [];

  Future<void> fetchContacts() async {
    _contacts = await _contactDatabase.getContacts();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {

      },
    );
  }
}
