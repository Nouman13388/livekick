// home_page.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livekick/controllers/banner_ad.dart';
import 'package:livekick/pages/notification_page.dart';
import 'package:livekick/pages/settings_pages/account_setting_page.dart';
import 'package:livekick/pages/settings_pages/notification_preferences_page.dart';
import 'package:livekick/pages/settings_pages/privacy_policy_page.dart';
import 'package:livekick/pages/settings_pages/streaming_settings_page.dart';
import 'package:livekick/pages/settings_pages/terms_of_service_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/news_page.dart';
import '../pages/match_schedule.dart';
import '../pages/settings_pages/settings_page.dart';
import '../pages/streaming_page.dart';
import 'auth_pages/login_page.dart';
import '../pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Widget> _tabScreens;
  SharedPreferences? prefs;
  User? _user;
  String _username = 'User Name';
  String _email = 'user@example.com';
  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();
  List<SearchItem> _searchItems = [];
  List<SearchItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _tabScreens = List.filled(4, const SizedBox());
    _initSharedPreferences();
    _fetchUserDetails();
    _initializeSearchItems();
  }

  void _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _tabScreens = [
        const NewsPage(),
        const MatchSchedule(),
        const StreamingPage(),
        SettingsPage(prefs: prefs!),
      ];
    });
  }

  void _fetchUserDetails() {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      setState(() {
        _username = _user!.displayName ?? _username;
        _email = _user!.email ?? _email;
      });
    }
  }

  void _initializeSearchItems() {
    _searchItems = [
      SearchItem('News', const NewsPage()),
      SearchItem('Match Schedule', const MatchSchedule()),
      SearchItem('Streaming', const StreamingPage()),
      SearchItem('Account Settings', const AccountSettingsPage()),
      SearchItem(
          'Notification Preferences', const NotificationPreferencesPage()),
      SearchItem('Streaming Settings', const StreamingSettingsPage()),
      SearchItem('Privacy Policy', PrivacyPolicyPage()),
      SearchItem('Terms of Service', TermsOfServicePage()),
      SearchItem('Home Page', const HomePage()),
      SearchItem('Streaming Page', const StreamingPage()),
      SearchItem('Schedule Page', const MatchSchedule()),
    ];
  }

  void _toggleSearch() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
      _filteredItems.clear();
    });

    if (!_isSearchExpanded) {
      _searchController.clear();
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredItems = _searchItems
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onSearchItemTapped(SearchItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => item.page),
    );
    _toggleSearch();
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          prefs: prefs!,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_user != null) ...[
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(_user!.photoURL ?? ''),
            ),
            const SizedBox(height: 10),
            Text(
              _username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _email,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildSearchSuggestions() {
    return ListView.builder(
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return ListTile(
          title: Text(item.title),
          onTap: () => _onSearchItemTapped(item),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _isSearchExpanded
            ? TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: _onSearchChanged,
              )
            : const Text('LiveKick'),
        centerTitle: !_isSearchExpanded,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildDrawerHeader(),
            _buildDrawerItem(
              title: 'Account',
              icon: Icons.account_circle,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountSettingsPage(),
                  ),
                );
              },
            ),
            _buildDrawerItem(
              title: 'Notification Preferences',
              icon: Icons.notifications,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationPreferencesPage(),
                  ),
                );
              },
            ),
            _buildDrawerItem(
              title: 'Streaming Settings',
              icon: Icons.videocam,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StreamingSettingsPage(),
                  ),
                );
              },
            ),
            _buildDrawerItem(
              title: 'News Preferences',
              icon: Icons.article,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewsPage(),
                  ),
                );
              },
            ),
            _buildDrawerItem(
              title: 'Privacy Policy',
              icon: Icons.privacy_tip,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyPage(),
                  ),
                );
              },
            ),
            _buildDrawerItem(
              title: 'Terms of Service',
              icon: Icons.description,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsOfServicePage(),
                  ),
                );
              },
            ),
            const Divider(),
            _buildDrawerItem(
              title: 'Logout',
              icon: Icons.exit_to_app,
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (_isSearchExpanded)
            Expanded(child: _buildSearchSuggestions())
          else
            Expanded(child: _tabScreens[_selectedTabIndex]),
          const BannerAdWidget(), // Add the BannerAdWidget here
        ],
      ),
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
        elevation: 8.0,
      ),
    );
  }
}
