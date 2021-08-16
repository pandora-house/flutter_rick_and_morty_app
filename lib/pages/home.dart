import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/nav_bar_notifiers.dart';
import 'characters.dart';
import 'episodes.dart';
import 'locations.dart';

class HomePage extends StatelessWidget {
  final _pageController = PageController();
  final _screens = <Widget>[CharactersPage(), EpisodesPage(), LocationsPage()];
  final _navBarNotifiers = NavBarNotifier();

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) {},
        physics: NeverScrollableScrollPhysics(),
        itemCount: _screens.length,
        itemBuilder: (BuildContext context, int index) {
          return _screens[index];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _navBarNotifiers.index,
        builder: (context, value, _) {
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                label: 'characters',
                icon: Icon(
                  Icons.library_books_rounded,
                ),
              ),
              BottomNavigationBarItem(
                label: 'episodes',
                icon: Icon(
                  Icons.filter,
                ),
              ),
              BottomNavigationBarItem(
                label: 'locations',
                icon: Icon(
                  Icons.location_on_rounded,
                ),
              ),
            ],
            currentIndex: _navBarNotifiers.index.value,
            onTap: (index) {
              _navBarNotifiers.index.value = index;
              _pageController.jumpToPage(index);
            },
          );
        },
      ),
    );
  }
}
