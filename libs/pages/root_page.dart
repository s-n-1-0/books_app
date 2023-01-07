import 'package:flutter/material.dart';

import 'info_page.dart';
import 'search_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (() {
        switch (_selectedIndex) {
          case 0:
            return const SearchPage();
          case 1:
            return const InfoPage();
          default:
            return const SizedBox();
        }
      })(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() {
          _selectedIndex = value;
        }),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            activeIcon: Icon(Icons.book_outlined),
            label: 'Share',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            activeIcon: Icon(Icons.info_outline),
            label: 'Info',
          )
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
