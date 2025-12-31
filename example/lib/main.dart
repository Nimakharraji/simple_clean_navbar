import 'package:flutter/material.dart';
import 'package:simple_clean_navbar/simple_clean_navbar.dart'; // Import package

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
      title: 'Simple Clean NavBar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.blue,
        fontFamily: 'Vazirmatn',
      ),
      home: MyHomePage(
        isDarkMode: isDarkMode,
        toggleTheme: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const MyHomePage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // Settings
  bool isFloating = true;
  bool isSideRail = false;
  bool isRailOnLeft = true;
  SimpleNavAnimType animType = SimpleNavAnimType.float;
  SimpleNavTextMode textMode = SimpleNavTextMode.onSelect;
  Color navColor = Colors.white;

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDarkMode != oldWidget.isDarkMode) {
      navColor = widget.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape ||
            size.width > 700;

    // Auto-switch to side rail if needed (logic can be custom)
    final showSideRail = isLandscape && isSideRail;

    return Scaffold(
      backgroundColor:
          widget.isDarkMode ? const Color(0xFF121212) : const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text('Simple Clean NavBar v1.0'),
        centerTitle: true,
        backgroundColor:
            widget.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        actions: [
          IconButton(
            icon: Icon(
                widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildControlPanel(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          SimpleCleanNavBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: [
              SimpleNavBarItem(label: 'Home', icon: Icons.home_rounded),
              SimpleNavBarItem(label: 'Explore', icon: Icons.explore_rounded),
              SimpleNavBarItem(label: 'Cart', icon: Icons.shopping_bag_rounded),
              SimpleNavBarItem(label: 'Profile', icon: Icons.person_rounded),
            ],
            selectedColor: widget.isDarkMode ? Colors.white : Colors.blue,
            unselectedColor: Colors.grey,
            backgroundColor: navColor,
            isFloating: isFloating,
            isSideRail: showSideRail,
            isRailOnLeft: isRailOnLeft,
            animationType: animType,
            textMode: textMode,
            updateSystemNavBar: true,
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Floating Mode"),
              value: isFloating,
              onChanged: (v) => setState(() => isFloating = v),
            ),
            SwitchListTile(
              title: const Text("Side Rail (Landscape)"),
              value: isSideRail,
              onChanged: (v) => setState(() => isSideRail = v),
            ),
            if (isSideRail)
              SwitchListTile(
                title: const Text("Rail on Left"),
                value: isRailOnLeft,
                onChanged: (v) => setState(() => isRailOnLeft = v),
              ),
            const Divider(),
            const Text("Animation"),
            SegmentedButton<SimpleNavAnimType>(
              segments: const [
                ButtonSegment(
                    value: SimpleNavAnimType.circle, label: Text('Circle')),
                ButtonSegment(
                    value: SimpleNavAnimType.zoom, label: Text('Zoom')),
                ButtonSegment(
                    value: SimpleNavAnimType.float, label: Text('Float')),
              ],
              selected: {animType},
              onSelectionChanged: (Set<SimpleNavAnimType> newSelection) {
                setState(() {
                  animType = newSelection.first;
                });
              },
            ),
            const Divider(),
            const Text("Text Mode"),
            SegmentedButton<SimpleNavTextMode>(
              segments: const [
                ButtonSegment(
                    value: SimpleNavTextMode.alwaysShow, label: Text('Always')),
                ButtonSegment(
                    value: SimpleNavTextMode.onSelect, label: Text('OnSelect')),
                ButtonSegment(
                    value: SimpleNavTextMode.neverShow, label: Text('Never')),
              ],
              selected: {textMode},
              onSelectionChanged: (Set<SimpleNavTextMode> newSelection) {
                setState(() {
                  textMode = newSelection.first;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
