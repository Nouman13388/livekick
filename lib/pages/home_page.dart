import 'package:flutter/material.dart';
import 'package:livekick/pages/match_schedule.dart';
import 'package:livekick/pages/news_page.dart';
import 'package:livekick/pages/settings_page.dart';
import 'package:livekick/pages/streaming_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Server _server;
  late List<Widget> _tabScreens;

  @override
  void initState() {
    _server = Server(
      id: 1,
      name: 'LiveStream',
      url: 'https://live-par-2-abr.livepush.io/vod/bigbuckbunnyclip.mp4',
      headers: {}, // Add any necessary headers
    );

    _tabScreens = [
      const NewsPage(),
      const MatchSchedule(),
      StreamingPage(server: _server), // Pass data to StreamingPage here
      const SettingsPage(),
    ];

    super.initState();
  }

  bool _isSearchExpanded = false;

  void _toggleSearch() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _isSearchExpanded
            ? const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              )
            : const Text('LiveKick'),
        centerTitle: !_isSearchExpanded,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: _isSearchExpanded
                ? const Icon(Icons.close)
                : const Icon(Icons.search),
            onPressed: _toggleSearch,
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Implement your notification functionality here
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Side Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Implement item 1 functionality here
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Implement item 2 functionality here
              },
            ),
            // Add more list tiles for additional menu items
          ],
        ),
      ),
      body: _tabScreens[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_outlined),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stream_outlined),
            label: 'Streaming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14.0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        selectedIconTheme: const IconThemeData(size: 32.0),
        unselectedIconTheme: const IconThemeData(size: 24.0),
        elevation: 8.0, // Base elevation
      ),
    );
  }
}
