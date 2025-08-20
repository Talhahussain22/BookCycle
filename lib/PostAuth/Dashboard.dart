import 'package:bookcycle/PostAuth/CartPage/screen/cartpage_screen.dart';
import 'package:bookcycle/PostAuth/ChatPage/screen/chat_page_screen.dart';
import 'package:bookcycle/PostAuth/Homepage/screen/Homepage.dart';
import 'package:bookcycle/PostAuth/MyBooksPage/screen/my_books_page.dart';
import 'package:bookcycle/PostAuth/ProfilePage/screen/profile_page_screen.dart';
import 'package:bookcycle/PostAuth/SellPage/screen/sell_page_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;
  List<Widget> pages = [
    Homepage(),
    ChatPageScreen(),
    SellPageScreen(),
    MyBooksPage(),
    ProfilePageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('BookCycle',style: TextStyle(color: Color(0xFFD65A31),fontFamily: 'Gravitas'),),
          backgroundColor: Color(0xFFEEEEEE),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPageScreen()));
            },icon:Icon(Icons.add_shopping_cart), color: Color(0xFFD65A31)),
          ],
        ),
        backgroundColor: Color(0xFFEEEEEE),
        body: pages[selectedIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              selectedIndex = 2; // Navigate to Sell page
            });
          },
          backgroundColor: Colors.white,
          shape: CircleBorder(
            // border color
          ),
          child: Image.asset(
            'assets/images/cirlegpt.png',
            fit: BoxFit.fitHeight, // Your custom icon
            width: 65,
            height: 65,
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },

          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey.shade100,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 10),

          showUnselectedLabels: true,
          selectedIconTheme: IconThemeData(color: Colors.black,size: 25),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          unselectedIconTheme: IconThemeData(color: Colors.black54,size:23 ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_text),
              label: 'Chats',

            ),
            BottomNavigationBarItem(icon: SizedBox(height: 25), label: 'Sell'),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book_fill),
              label: 'My Books',

            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
