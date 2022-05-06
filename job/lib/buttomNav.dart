import 'package:flutter/cupertino.dart';
import 'Screens/Favourites/favPage.dart';
import 'Screens/Home/homeScreen.dart';
import 'Screens/Jobs/jobPage.dart';
import 'Screens/Profile/profilePage.dart';

class ButtomNav extends StatelessWidget {
  const ButtomNav();
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'Fav',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        assert(index >= 0 && index <= 4);
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) => HomeScreen(),
            );
            break;
          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) => FavePage(),
            );
            break;
          case 2:
            return CupertinoTabView(
              builder: (BuildContext context) => JobPage(),
            );
            break;
          case 3:
            return CupertinoTabView(
              builder: (BuildContext context) => ProfilePage(),
            );
            break;
        }
        return CupertinoTabView(
          builder: (BuildContext context) => HomeScreen(),
        );
      },
    );
  }
}
