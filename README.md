[![pub package](https://img.shields.io/pub/v/simple_clean_navbar.svg)](https://pub.dev/packages/simple_clean_navbar)

# Simple Clean NavBar

A customizable, animated, and clean bottom navigation bar for Flutter apps.
It features a floating disk effect behind the selected icon, fully supports **Dark Mode**, and automatically adapts to **RTL** languages (like Persian/Arabic).

![Demo Preview](https://via.placeholder.com/600x200?text=Your+App+Screenshot+Here)

## Features

* 🌟 **Clean Design:** Minimalist look with a floating background disk.
* 🌓 **Dark/Light Mode:** Automatically adjusts colors and shadows based on the theme.
* 🌍 **RTL Support:** Works perfectly with Persian and Arabic layouts automatically.
* 🎨 **Customizable:** Use any Widget as an icon (Icon, SvgPicture, Image, etc.).
* ✨ **Smooth Animation:** Gentle transition animations for selected items.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  simple_clean_navbar: ^0.0.1
```

## Usage
First, import the package:
```
import 'package:simple_clean_navbar/simple_clean_navbar.dart';
```

## Then, use SimpleCleanNavBar in your Scaffold:

```
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Page: $_selectedIndex")),
      
      bottomNavigationBar: SimpleCleanNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          SimpleNavBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home), // Optional: Different icon when selected
          ),
          SimpleNavBarItem(
            label: 'Orders',
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag), 
          ),
          SimpleNavBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person), 
          ),
        ],
      ),
    );
  }
}

```

## Additional Customization
You can fully customize colors and behavior to match your brand:

```
SimpleCleanNavBar(
  // ... required params (items, onTap, currentIndex)
  
  backgroundColor: Colors.white,
  selectedColor: Colors.purple,
  unselectedColor: Colors.grey,
  backgroundDiscColor: Colors.purple.withOpacity(0.1),
  
  // Set this based on your app's theme status to remove shadows in dark mode
  isDarkMode: Theme.of(context).brightness == Brightness.dark, 
)
```

