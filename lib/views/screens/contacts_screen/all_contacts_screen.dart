import 'package:contacts_and_dialer/models/contact.dart';
import 'package:contacts_and_dialer/services/database/contact_database.dart';
import 'package:contacts_and_dialer/views/widgets/custom_contact_alert_dialog.dart';
import 'package:contacts_and_dialer/views/widgets/custom_contacts_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final ContactDatabase _contactDatabase = ContactDatabase.instance;

  void editContact({required Contact contact}) async {
    await _contactDatabase.editContact(
      id: contact.id,
      newName: contact.name,
      newNumber: contact.number,
    );
    setState(() {});
  }

  void deleteContact({required int id}) async {
    await _contactDatabase.deleteContact(id: id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _contactDatabase.getContacts(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Contact>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(
                    child: Text('Error loading contacts'),
                  );
                } else {
                  List<Contact> contacts = snapshot.data!;
                  contacts
                      .sort((Contact a, Contact b) => a.name.compareTo(b.name));
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomContactsWidget(
                        contact: contacts[index],
                        onEdit: (Contact updatedContact) {
                          editContact(contact: updatedContact);
                        },
                        onDelete: (int id) {
                          deleteContact(id: id);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(right: 20.w, bottom: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ZoomTapAnimation(
                  onTap: () async {
                    final Contact? returnedContact = await showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomContactAlertDialog(
                        contact: Contact(id: 0, name: '', number: ''),
                        isSelected: true,
                      ),
                    );
                    if (returnedContact != null) {
                      print('added');
                      ContactDatabase.instance
                          .addContact(
                            name: returnedContact.name,
                            number: returnedContact.number,
                          )
                          .then(
                            (value) => setState(() {}),
                          );
                    }
                  },
                  child: Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF05C474),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 30.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
