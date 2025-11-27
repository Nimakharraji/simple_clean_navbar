import 'package:flutter/material.dart';

/// A model class that defines the appearance and label of each tab in the navigation bar.
class SimpleNavBarItem {
  /// The text label displayed below the icon (e.g., "Home", "Profile").
  final String label;

  /// The icon widget displayed when the item is NOT selected.
  /// You can pass an [Icon], [SvgPicture], or any other widget.
  final Widget icon;

  /// The icon widget displayed when the item IS selected.
  /// If null, the [icon] will be used for both states.
  final Widget? activeIcon;

  /// Optional custom color for this specific item when selected.
  final Color? selectedColor;

  SimpleNavBarItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.selectedColor,
  });
}