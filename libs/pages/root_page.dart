import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'info_page.dart';
import 'list_page.dart';
import 'search_page.dart';

enum TabItem {
  share(
    title: 'Share',
    icon: Icons.book,
    page: SearchPage(),
  ),

  list(
    title: 'List',
    icon: Icons.list,
    page: ListPage(),
  ),

  info(
    title: 'Info',
    icon: Icons.info,
    page: InfoPage(),
  );

  const TabItem({
    required this.title,
    required this.icon,
    required this.page,
  });
  final String title;
  final IconData icon;
  final Widget page;
}

final _navigatorKeys = <TabItem, GlobalKey<NavigatorState>>{
  TabItem.share: GlobalKey<NavigatorState>(),
  TabItem.list: GlobalKey<NavigatorState>(),
  TabItem.info: GlobalKey<NavigatorState>(),
};

class RootPage extends HookWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    final currentTab = useState(TabItem.share);
    return Scaffold(
      body: Stack(
        children: TabItem.values
            .map(
              (tabItem) => Offstage(
                offstage: currentTab.value != tabItem,
                child: Navigator(
                  key: _navigatorKeys[tabItem],
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute<Widget>(
                      builder: (context) => tabItem.page,
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: TabItem.values.indexOf(currentTab.value),
        onTap: (index) {
          final selectedTab = TabItem.values[index];
          if (currentTab.value == selectedTab) {
            _navigatorKeys[selectedTab]
                ?.currentState
                ?.popUntil((route) => route.isFirst);
          } else {
            currentTab.value = selectedTab;
          }
        },
        items: TabItem.values
            .map(
              (tabItem) => BottomNavigationBarItem(
                icon: Icon(tabItem.icon),
                label: tabItem.title,
              ),
            )
            .toList(),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
