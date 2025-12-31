import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../simple_clean_navbar.dart';
import '../widgets/navbar_item_widget.dart';

class SimpleCleanNavBar extends StatelessWidget {
  /// List of items to display in the navigation bar.
  final List<SimpleNavBarItem> items;

  /// Current selected index.
  final int currentIndex;

  /// Callback when an item is tapped.
  final Function(int) onTap;

  /// Active color for icon and text.
  final Color selectedColor;

  /// Inactive color for icon and text.
  final Color unselectedColor;

  /// Background color of the navigation bar.
  final Color backgroundColor;

  /// Color of the floating disc/circle behind the icon.
  final Color? discColor;

  /// If true, the navbar floats above the content with rounded corners and shadow.
  final bool isFloating;

  /// If true, arranges items vertically (Side Navigation Rail).
  final bool isSideRail;

  /// Only used if [isSideRail] is true. If true, aligns to left, otherwise right.
  final bool isRailOnLeft;

  /// Animation type for item selection.
  final SimpleNavAnimType animationType;

  /// Text display mode.
  final SimpleNavTextMode textMode;

  /// If not null, overrides the system navigation bar color (bottom of screen).
  /// This provides the "Immersive" experience.
  final bool updateSystemNavBar;

  const SimpleCleanNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.selectedColor = const Color(0xFF2C3E50),
    this.unselectedColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.discColor,
    this.isFloating = false,
    this.isSideRail = false,
    this.isRailOnLeft = true,
    this.animationType = SimpleNavAnimType.circle,
    this.textMode = SimpleNavTextMode.onSelect,
    this.updateSystemNavBar = true,
  }) : assert(items.length >= 2 && items.length <= 5,
            "Items must be between 2 and 5");

  @override
  Widget build(BuildContext context) {
    // Detect Brightness to adjust defaults if needed
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Auto-handle System UI Color based on the fixed logic
    if (updateSystemNavBar) {
      _updateSystemUi(context, isDark);
    }

    // Background color logic (transparency for floating)
    final navBgColor =
        backgroundColor.withValues(alpha: isFloating ? 0.98 : 1.0);

    // Shadow logic: Only show shadow if floating
    final shadow = (!isFloating)
        ? <BoxShadow>[]
        : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ];

    // Alignment logic
    Alignment alignment;
    if (isSideRail) {
      alignment = isRailOnLeft ? Alignment.centerLeft : Alignment.centerRight;
    } else {
      alignment = Alignment.bottomCenter;
    }

    // Margin logic
    EdgeInsets margin;
    if (isSideRail) {
      margin = isFloating ? const EdgeInsets.all(16) : EdgeInsets.zero;
    } else {
      margin = isFloating
          ? const EdgeInsets.fromLTRB(20, 0, 20, 20)
          : EdgeInsets.zero;
    }

    // Radius logic
    BorderRadius radius;
    if (isFloating) {
      radius = BorderRadius.circular(35);
    } else {
      radius = BorderRadius.zero;
    }

    // Size logic (Critical Fix for Layout Bugs)
    final screenSize = MediaQuery.of(context).size;
    double? width;
    double? height;

    if (isSideRail) {
      // Vertical Mode
      width = isFloating ? 80 : 90;
      height = isFloating ? 400 : screenSize.height;
    } else {
      // Horizontal Mode
      if (isFloating) {
        // If floating, limit width in landscape, else screen width minus margins
        final isLandscape =
            MediaQuery.of(context).orientation == Orientation.landscape;
        width = isLandscape ? 400 : screenSize.width - 40;
      } else {
        width = screenSize.width;
      }
      height = 70;
    }

    return AnimatedAlign(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: alignment,
      child: Padding(
        padding: margin,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: width,
          height: height,
          constraints: (isSideRail && isFloating)
              ? const BoxConstraints(maxHeight: 400)
              : null,
          decoration: BoxDecoration(
            color: navBgColor,
            borderRadius: radius,
            boxShadow: shadow,
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: isSideRail
                // Vertical Layout: Center items to avoid spacing issues
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: items.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: _buildItem(entry.key, entry.value),
                      );
                    }).toList(),
                  )
                // Horizontal Layout
                : Row(
                    // Fixed: Spread evenly. Floating: Spread evenly within constraints.
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: items.asMap().entries.map((entry) {
                      return Expanded(
                        child: _buildItem(entry.key, entry.value),
                      );
                    }).toList(),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index, SimpleNavBarItem item) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: CompactNavItem(
          item: item,
          isSelected: currentIndex == index,
          selectedColor: selectedColor,
          unselectedColor: unselectedColor,
          discColor: discColor ?? selectedColor.withValues(alpha: 0.1),
          animationType: animationType,
          textMode: textMode,
        ),
      ),
    );
  }

  void _updateSystemUi(BuildContext context, bool isDark) {
    Color systemBarColor;
    Brightness systemIconBrightness;

    // Detect Scaffold background color approximately (or assume based on theme)
    final scaffoldColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFF0F2F5);

    if (isSideRail) {
      systemBarColor = scaffoldColor;
    } else if (isFloating) {
      // Floating: Transparent or Scaffold Color to show floating effect
      systemBarColor = scaffoldColor;
    } else {
      // Fixed: Must match Navbar Color exactly
      systemBarColor = backgroundColor;
    }

    // Determine icon brightness based on the bar color
    if (ThemeData.estimateBrightnessForColor(systemBarColor) ==
        Brightness.dark) {
      systemIconBrightness = Brightness.light;
    } else {
      systemIconBrightness = Brightness.dark;
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: systemBarColor,
        systemNavigationBarIconBrightness: systemIconBrightness,
        statusBarColor: Colors.transparent, // Optional
      ),
    );
  }
}
