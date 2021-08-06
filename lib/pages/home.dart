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
  final _charIndex = 0;
  final _episIndex = 1;
  final _locIndex = 2;

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
          return BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      _pageController.jumpToPage(_charIndex);
                      _navBarNotifiers.index.value = _charIndex;
                    },
                    icon: Icon(
                      Icons.library_books_rounded,
                      color: value == _charIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey[400],
                    )),
                IconButton(
                    onPressed: () {
                      _pageController.jumpToPage(_episIndex);
                      _navBarNotifiers.index.value = _episIndex;
                    },
                    icon: Icon(
                      Icons.filter,
                      color: value == _episIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey[400],
                    )),
                IconButton(
                    onPressed: () {
                      _pageController.jumpToPage(_locIndex);
                      _navBarNotifiers.index.value = _locIndex;
                    },
                    icon: Icon(
                      Icons.location_on_rounded,
                      color: value == _locIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey[400],
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
