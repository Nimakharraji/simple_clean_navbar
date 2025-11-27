// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'nav_bar_item.dart';

/// A customizable bottom navigation bar with a floating disk effect.
class SimpleCleanNavBar extends StatelessWidget {
  /// The list of items to display in the navigation bar.
  final List<SimpleNavBarItem> items;

  /// The index of the currently selected item.
  final int currentIndex;

  /// Callback function triggered when an item is tapped.
  final Function(int) onTap;

  /// Background color of the navigation bar.
  final Color backgroundColor;

  /// Color of the selected item's icon and label.
  final Color selectedColor;

  /// Color of the unselected items.
  final Color unselectedColor;

  /// Color of the floating disk behind the selected icon.
  final Color backgroundDiscColor;

  /// If true, shadows will be removed to fit dark themes better.
  final bool isDarkMode;

  /// Height of the navigation bar. Default is 65.0.
  final double height;

  const SimpleCleanNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.selectedColor = const Color(0xFF2C3E50),
    this.unselectedColor = Colors.grey,
    this.backgroundDiscColor = const Color(0xFFF5F5F5),
    this.isDarkMode = false,
    this.height = 65.0,
  });

  @override
  Widget build(BuildContext context) {
    // Logic: Remove shadow in dark mode for a cleaner look
    final List<BoxShadow> navBarShadow = isDarkMode
        ? []
        : [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ];

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: navBarShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // The direction (LTR/RTL) is automatically inherited from the parent context.
        children: items.asMap().entries.map((entry) {
          final int index = entry.key;
          final SimpleNavBarItem item = entry.value;
          final bool isSelected = currentIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: _NavItemBuilder(
                item: item,
                isSelected: isSelected,
                selectedColor: item.selectedColor ?? selectedColor,
                unselectedColor: unselectedColor,
                discColor: backgroundDiscColor,
                isDarkMode: isDarkMode,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// A private helper widget to build each navigation item.
class _NavItemBuilder extends StatelessWidget {
  final SimpleNavBarItem item;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color discColor;
  final bool isDarkMode;

  const _NavItemBuilder({
    required this.item,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.discColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? discColor : Colors.transparent,
            boxShadow:
                (isSelected && !isDarkMode && discColor != Colors.transparent)
                ? [BoxShadow(color: discColor.withOpacity(0.3), blurRadius: 5)]
                : [],
          ),
          child: isSelected && item.activeIcon != null
              ? _ColorFilterWrapper(
                  color: selectedColor,
                  child: item.activeIcon!,
                )
              : _ColorFilterWrapper(
                  color: isSelected ? selectedColor : unselectedColor,
                  child: item.icon,
                ),
        ),
        const SizedBox(height: 4),
        // ✅✅✅ تغییرات فونت اینجاست
        Text(
          item.label,
          style: TextStyle(
            fontSize: 12, // کمی سایز رو بزرگتر کردم که خواناتر بشه
            // اگر انتخاب شده بود خیلی بولد، اگر نبود کمی بولد (Medium)
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
            color: isSelected ? selectedColor : unselectedColor,
          ),
        ),
      ],
    );
  }
}

/// Helper to apply color to SVG or Icon widgets if possible
class _ColorFilterWrapper extends StatelessWidget {
  final Widget child;
  final Color color;

  const _ColorFilterWrapper({required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    // Basic ColorFilter usage could be complex for generic Widgets.
    // For a simple Icon(), color property works. For others, we might need IconTheme.
    return IconTheme(
      data: IconThemeData(color: color, size: 24),
      child: child,
    );
  }
}
