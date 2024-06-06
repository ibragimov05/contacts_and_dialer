import 'package:contacts_and_dialer/models/contact.dart';
import 'package:contacts_and_dialer/views/widgets/custom_contact_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContactsWidget extends StatelessWidget {
  final Contact contact;
  final Function(Contact contact) onEdit;
  final Function(int id) onDelete;

  const CustomContactsWidget({
    super.key,
    required this.contact,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color(0xFFDDE0E5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    contact.number,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  final Contact? returnedContact = await showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomContactAlertDialog(
                      contact: contact,
                      isSelected: false,
                    ),
                  );
                  if (returnedContact != null) {
                    onEdit(returnedContact);
                  }
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  onDelete(contact.id);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
