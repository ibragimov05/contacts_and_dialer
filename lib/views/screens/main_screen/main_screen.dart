import 'package:contacts_and_dialer/models/contact.dart';
import 'package:contacts_and_dialer/services/database/contact_database.dart';
import 'package:contacts_and_dialer/views/screens/contacts_screen/all_contacts_screen.dart';
import 'package:contacts_and_dialer/views/widgets/custom_contact_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = const [
    ContactsScreen(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.transparent,
            labelColor: Colors.blue,
            dividerColor: Colors.white,
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Icon(Icons.phone),
              ),
              Tab(
                icon: Icon(Icons.contacts),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(controller: _tabController, children: _pages),
      // floatingActionButton:
    );
  }
}
