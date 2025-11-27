import 'package:flutter/material.dart';
import 'package:simple_clean_navbar/simple_clean_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavBar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: MyHomePage(
        isDarkMode: isDarkMode,
        onThemeChanged: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeChanged;

  const MyHomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Define colors based on the theme
    final bgColor =
        widget.isDarkMode ? const Color(0xFF121212) : const Color(0xFFF3F3F3);
    final navBgColor =
        widget.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final navSelectedColor =
        widget.isDarkMode ? Colors.white : const Color(0xFF2C3E50);
    // Decrease opacity for the disc in dark mode
    final navDiscColor = widget.isDarkMode
        ? Colors.white.withOpacity(0.1)
        : const Color(0xFFE0F7FA);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Simple Clean NavBar'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeChanged,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Index: $_currentIndex',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Text('Tap the icon above to switch Dark/Light mode'),
          ],
        ),
      ),
      bottomNavigationBar: SimpleCleanNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          SimpleNavBarItem(
            label: 'Home',
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
          ),
          SimpleNavBarItem(
            label: 'Orders',
            icon: const Icon(Icons.shopping_bag_outlined),
            activeIcon: const Icon(Icons.shopping_bag),
          ),
          SimpleNavBarItem(
            label: 'Profile',
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
          ),
        ],
        isDarkMode: widget.isDarkMode,
        backgroundColor: navBgColor,
        selectedColor: navSelectedColor,
        unselectedColor: Colors.grey,
        backgroundDiscColor: navDiscColor,
      ),
    );
  }
}
