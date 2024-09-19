
import 'package:admin_app/menus/menuItem.dart';
import 'package:flutter/material.dart';

class CustomNavigationRail extends StatelessWidget {
  final bool bottomNavBar;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<MenuItem> itemList;

  const CustomNavigationRail({
    required this.itemList,
    required this.bottomNavBar,
    required this.selectedIndex,
    required this.onDestinationSelected,
  
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (bottomNavBar) {
          return BottomNavBar(itemList: itemList,
                selectedIndex: selectedIndex, 
                onDestinationSelected: onDestinationSelected);
        } else {
          return NavRail(itemList: itemList,
                selectedIndex: selectedIndex,
                onDestinationSelected: onDestinationSelected,
              );
        }
      },
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.itemList,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final List<MenuItem> itemList;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      items: itemList.map((item) {
        return BottomNavigationBarItem(
          icon: item.icone,
          label: item.label,
        );
      }).toList(),
    );
  }
}


class NavRail extends StatelessWidget {
  const NavRail({
    super.key,
    required this.itemList,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final List<MenuItem> itemList;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: MediaQuery.of(context).size.width >= 600,
      destinations: itemList.map((item) {
        return NavigationRailDestination(
          icon: item.icone,
          label: Text(item.label),
        );
      }).toList(),      
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
