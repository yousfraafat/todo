import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/tabs/settings_tab/settings_tab.dart';
import 'package:todo/tabs/todo_list_tab/todo_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [TodoListTab(), SettingsTab()];
  List<String> tabsTitles = [TodoListTab.tabTitle, SettingsTab.tabTitle];

  @override
  Widget build(BuildContext context) {
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);
    tabsTitles[0] = authProvider.tabTitle;
    return Scaffold(
      backgroundColor: Color(0xffDFECDB),
      appBar: AppBar(
        title: Text(tabsTitles[selectedIndex]),
        backgroundColor: Color(0xff5D9CEC),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add, color: Colors.white, size: 50),
        ),
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/icon_list.png')),
              label: 'to do list',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/icon_settings.png')),
              label: 'settings',
            ),
          ],
        ),
      ),
    );
  }
}
