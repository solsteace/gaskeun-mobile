import "package:flutter/material.dart";
import 'package:gaskeun_mobile/pages/home/myCarPage.dart';
import 'package:gaskeun_mobile/pages/home/bookingPage.dart';
import "../profilePage/main.dart";

class HomePage extends StatefulWidget {
  final String title;
  final int user;
  final int index;
  HomePage({Key? key, required this.title, required this.user, required this.index})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late int openedMenu = widget.index;
  late PageController pc = PageController(initialPage: widget.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: pc,
          onPageChanged: (index) {
            setState(() {
              openedMenu = index;
            });
          },
          children: [
            Center(
                child: InkWell(
              child: Text('Go to Home page', style: TextStyle(fontSize: 30)),
            )),
            CarPage(),
            BookingPage(),
            ProfilePage(
                token: "19|8w0h3sPxMBWn97bDpyu4VgrBOrk7CG6bza8T5Vriac06120b")
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0117FF),
        unselectedItemColor: Colors.grey,
        currentIndex: openedMenu,
        onTap: (index) {
          setState(() {
            openedMenu = index;
          });
          pc.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_rows),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
