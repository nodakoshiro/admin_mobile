import 'package:flutter/material.dart';

class SideNavigation extends StatefulWidget {
  const SideNavigation({super.key});

  @override
  _SideNavigationState createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      destinations: navigationRailDestination(),
    );
  }
}

List<NavigationRailDestination> navigationRailDestination() => ([
      NavigationRailDestination(
        icon: Icon(Icons.thumbs_up_down),
        label: Text('ThumbsUpDown'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.people),
        label: Text('People'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.face),
        label: Text('Face'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.bookmark),
        label: Text('Bookmark'),
      ),
    ]);
