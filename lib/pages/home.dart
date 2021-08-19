import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'characters.dart';
import 'episodes.dart';
import 'locations.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _screens = <Widget>[CharactersPage(), EpisodesPage(), LocationsPage()];

  int _screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_screenIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              label: 'characters',
              icon: Icon(
                Icons.library_books_rounded,
              ),
            ),
            const BottomNavigationBarItem(
              label: 'episodes',
              icon: Icon(
                Icons.filter,
              ),
            ),
            const BottomNavigationBarItem(
              label: 'locations',
              icon: Icon(
                Icons.location_on_rounded,
              ),
            ),
          ],
          currentIndex: _screenIndex,
          onTap: (index) {
            setState(() {
              _screenIndex = index;
            });
          },
        ));
  }
}
