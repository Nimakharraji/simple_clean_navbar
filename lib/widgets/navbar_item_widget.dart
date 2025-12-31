import 'package:flutter/material.dart';
import '../simple_clean_navbar.dart';

class CompactNavItem extends StatelessWidget {
  final SimpleNavBarItem item;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color discColor;
  final SimpleNavAnimType animationType;
  final SimpleNavTextMode textMode;

  const CompactNavItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.discColor,
    required this.animationType,
    required this.textMode,
  });

  @override
  Widget build(BuildContext context) {
    switch (animationType) {
      case SimpleNavAnimType.zoom:
        return _zoomAnim();
      case SimpleNavAnimType.float:
        return _floatAnim();
      case SimpleNavAnimType.circle:
        return _discAnim();
    }
  }

  bool get _shouldShowText {
    if (textMode == SimpleNavTextMode.neverShow) return false;
    if (textMode == SimpleNavTextMode.alwaysShow) return true;
    return isSelected; // onSelect
  }

  Widget _buildTextWidget() {
    if (!_shouldShowText && textMode != SimpleNavTextMode.alwaysShow) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        item.label,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.normal,
          color: isSelected ? selectedColor : unselectedColor,
        ),
      ),
    );
  }

  // Animation 1: Circle (Disc)
  Widget _discAnim() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutQuad,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? discColor : Colors.transparent,
          ),
          child: Icon(
            item.icon,
            size: 24,
            color: isSelected ? selectedColor : unselectedColor,
          ),
        ),
        if (textMode == SimpleNavTextMode.alwaysShow || isSelected)
          _buildTextWidget(),
      ],
    );
  }

  // Animation 2: Zoom
  Widget _zoomAnim() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(
            0,
            _shouldShowText ? -2.0 : 0,
            0,
          ),
          child: AnimatedScale(
            scale: isSelected ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.elasticOut,
            child: Icon(
              item.icon,
              size: 24,
              color: isSelected ? selectedColor : unselectedColor,
            ),
          ),
        ),
        if (_shouldShowText) _buildTextWidget(),
      ],
    );
  }

  // Animation 3: Float
  Widget _floatAnim() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          transform: Matrix4.translationValues(0, isSelected ? -4.0 : 0, 0),
          child: Icon(
            item.icon,
            size: 24,
            color: isSelected ? selectedColor : unselectedColor,
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _shouldShowText ? 1.0 : 0.0,
          child:
              _shouldShowText ? _buildTextWidget() : const SizedBox(height: 0),
        ),
      ],
    );
  }
}
