import 'package:flutter/material.dart';
import 'modules/order_cartridges/module.dart' deferred as order_cartridges_module;
import 'modules/settings/module.dart' deferred as settings_module;
import 'modules/dashboard/module.dart' deferred as dashboard_module;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectedIndex = 2; // Dashboard index
  final Map<int, Widget> _loadedModules = {};

  static const List<String> _moduleNames = [
    'Order Cartridges',
    'Settings',
    'Dashboard',
  ];

  @override
  void initState() {
    super.initState();
    _loadModule(_selectedIndex); // Load dashboard on start
  }

  Future<void> _loadModule(int index) async {
    switch (index) {
      case 0:
        await order_cartridges_module.loadLibrary();
        setState(() {
          _loadedModules[index] =
              order_cartridges_module.OrderCartridgesModule().buildHomePage(context);
        });
        break;
      case 1:
        await settings_module.loadLibrary();
        setState(() {
          _loadedModules[index] =
              settings_module.SettingsModule().buildHomePage(context);
        });
        break;
      case 2:
        await dashboard_module.loadLibrary();
        setState(() {
          _loadedModules[index] =
              dashboard_module.DashboardModule().buildHomePage(context);
        });
        break;
    }
  }

  void _onItemTapped(int index, BuildContext drawerContext) {
    if (!_loadedModules.containsKey(index)) {
      _loadModule(index);
    }
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(drawerContext); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_moduleNames[_selectedIndex]),
        ),
        body: _loadedModules[_selectedIndex] ??
            const Center(child: CircularProgressIndicator()),
        drawer: Drawer(
          child: Builder(
            builder: (BuildContext drawerContext) {
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        'Navigation Panel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.dashboard,
                    text: 'Dashboard',
                    index: 2,
                    context: drawerContext,
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings,
                    text: 'Settings',
                    index: 1,
                    context: drawerContext,
                  ),
                  _buildDrawerItem(
                    icon: Icons.print,
                    text: 'Order Cartridges',
                    index: 0,
                    context: drawerContext,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required int index,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(icon, color: _selectedIndex == index ? Colors.blue : null),
      title: Text(
        text,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.blue : null,
        ),
      ),
      selected: _selectedIndex == index,
      onTap: () => _onItemTapped(index, context),
    );
  }
}
