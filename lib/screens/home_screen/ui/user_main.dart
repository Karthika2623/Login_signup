import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/home_screen/ui/home_screen.dart';
import 'package:flutter_task/screens/login/login_screen.dart';
import 'package:flutter_task/screens/profile/profile.dart';
import 'package:flutter_task/widgets/appbar_widget.dart';

class UserMain extends StatefulWidget {
  const UserMain({super.key});
  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
          (route) => false,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Logout Successful',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          text: "Welcome User",
          action: [
            IconButton(
              onPressed: _showLogoutDialog,
              icon: const Icon(
                Icons.logout,
                size: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 45,
                child: TabBar(
                  controller: _tabController,
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0XFFB81736), width: 2),
                    ),
                  ),
                  labelColor: const Color(0XFFB81736),
                  labelStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFB81736),
                  ),
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: 'Home'),
                    Tab(text: 'Profile'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  HomeScreen(),
                  Profile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
