import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:versed/pages/settings_page.dart';
import 'package:versed/pages/socials_page.dart';
import 'package:versed/pages/stats_page.dart';

import 'assets/versed_theme.dart';
import 'pages/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const versedTheme = VersedTheme();

    ThemeData themeData = versedTheme.toThemeData();
    // themeData.textTheme = GoogleFonts.lektonTextTheme();

    return MaterialApp(
      title: 'versed',
      theme: themeData,
      home: const MyHomePage(
        title: 'WELL VERSED',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //
  // TRACKER AND FUNCTION FOR BOTTOM NAV BUTTON CLICKS
  int _selectedIndex = 0;
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //
  // CENTER CONTENT
  final List<Widget> centerMenu = <Widget>[
    const GamePage(),
    const StatsPage(),
    const SocialsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    //
    // BOTTOM NAVIGATION ICONS
    final List<BottomNavigationBarItem> navMenu = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.token_outlined,
          color: Theme.of(context).colorScheme.tertiaryContainer,
        ),
        // activeIcon: const Icon(Icons.token_sharp),
        label: 'game',
        backgroundColor: const Color(0xFF3E454B),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.memory_sharp,
          color: Theme.of(context).colorScheme.tertiaryContainer,
        ),
        // activeIcon: const Icon(Icons.token_sharp),
        label: 'stats',
        backgroundColor: const Color(0xFF3E454B),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.groups_3_outlined,
          color: Theme.of(context).colorScheme.tertiaryContainer,
        ),
        // activeIcon: const Icon(Icons.token_sharp),
        label: 'socials',
        backgroundColor: const Color(0xFF3E454B),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.candlestick_chart_outlined,
          color: Theme.of(context).colorScheme.tertiaryContainer,
        ),
        // activeIcon: const Icon(Icons.token_sharp),
        label: 'settings',
        backgroundColor: const Color(0xFF3E454B),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0B1623),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF3E454B),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        scrolledUnderElevation: 10,
        // elevation: -20,
        // shadowColor: Colors.black,
        titleSpacing: 0,
        foregroundColor: Theme.of(context).colorScheme.onTertiary,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.elliptical(
        //       MediaQuery.of(context).size.width / 2,
        //       18,
        //     ),
        //   ),
        // ),
        // elevation: 20,
        // shadowColor: Colors.white70,
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: GoogleFonts.lekton().fontFamily,
            letterSpacing: 9,
            wordSpacing: 5,
            color: Theme.of(context).colorScheme.onTertiary,
            // fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: centerMenu[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: navMenu,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: Theme.of(context).colorScheme.onTertiary,
        showSelectedLabels: false,
        selectedIconTheme: const IconThemeData(
          size: 34,
        ),
      ),
    );
  }
}
