import 'package:flutter/material.dart';
import 'nav_bar_item.dart';

class SimpleCleanNavBar extends StatelessWidget {
  final List<SimpleNavBarItem> items;
  final int currentIndex;
  final Function(int) onTap;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final Color backgroundDiscColor;
  final bool isDarkMode;
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
  }) : assert(items.length >= 2 && items.length <= 5,
            "\n\n🛑 Error in SimpleCleanNavBar: items.length must be between 2 and 5.\nStandard bottom navigation bars usually have 3 to 5 items.\n");
  // این خط بالا چک میکنه که تعداد آیتم‌ها استاندارد باشه

  @override
  Widget build(BuildContext context) {
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
                    ? [
                        BoxShadow(
                          color: discColor.withOpacity(0.3),
                          blurRadius: 5,
                        )
                      ]
                    : [],
          ),
          child: isSelected && item.activeIcon != null
              ? _ColorFilterWrapper(
                  child: item.activeIcon!, color: selectedColor)
              : _ColorFilterWrapper(
                  child: item.icon,
                  color: isSelected ? selectedColor : unselectedColor),
        ),
        const SizedBox(height: 4),
        Text(
          item.label,
          maxLines: 1, // جلوگیری از دو خطی شدن متن
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
            color: isSelected ? selectedColor : unselectedColor,
          ),
        ),
      ],
    );
  }
}

class _ColorFilterWrapper extends StatelessWidget {
  final Widget child;
  final Color color;

  const _ColorFilterWrapper({required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: color, size: 24),
      child: child,
    );
  }
}
