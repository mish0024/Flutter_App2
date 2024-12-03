import 'package:flutter/material.dart';
import 'package:flutter_app2/screens/contactScreen.dart';
import 'package:flutter_app2/screens/dataScreen.dart';
import 'package:flutter_app2/screens/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class GlobalThemeData {
  static ColorScheme themeData() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0078D7),
      onPrimary: Color(0xFFF0F8FF),
      secondary: Color(0xFF673AB7),
      onSecondary: Color(0xFFEDE7F6),
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xFFF5F5F5),
      onSurface: Colors.black,
      background: Color(0xFFE3F2FD),
      onBackground: Colors.black,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Flutter App',
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 14, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        colorScheme: GlobalThemeData.themeData(),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final screens = [
    const HomePage(),
    const DataPage(),
    const ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme.onPrimary,
        title: Text(
          'Modern App',
          style: TextStyle(color: colorTheme.primary),
        ),
        centerTitle: true,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorTheme.onPrimary,
        selectedItemColor: colorTheme.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}