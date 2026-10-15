
import 'package:exenzia/view/add_expenses.dart';
import 'package:exenzia/view/history.dart';
import 'package:exenzia/view/homescreen.dart';
import 'package:exenzia/view/profile.dart';
import 'package:exenzia/view/wallet.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class BottomnaviBar extends StatefulWidget {
  const BottomnaviBar({super.key});

  @override
  State<BottomnaviBar> createState() => _BottomnaviBarState();
}

class _BottomnaviBarState extends State<BottomnaviBar> {
  int selectIndex = 0;

  final List<Widget> pages = [
    Homescreen(),
    History(),
  AddExpenses(),
   Wallet(),
   Profile()

    

    
    

    
    

    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: pages[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        currentIndex: selectIndex,
        selectedItemColor: const Color.fromARGB(255, 66, 30, 225),
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,),
          label: 'home'),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
             label: 'history'
          ), BottomNavigationBarItem(
            icon: Icon(Icons.add),
             label: 'add'
          ), BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
             label: 'wallet'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'profile'
          ),
          
        ],
      ),
    );
  }
}