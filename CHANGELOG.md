## 7. فایل `CHANGELOG.md`
برای ثبت این تغییرات عظیم.

```markdown
## 1.0.0
🚀 **Major Release - The Ultimate Update!**

* **New Feature:** Added `isSideRail` support for vertical navigation (Side Rail).
* **New Feature:** Added `isFloating` mode for a modern, floating design with shadows.
* **New Feature:** Added `SimpleNavAnimType` with 3 animations: `circle`, `zoom`, `float`.
* **New Feature:** Added `SimpleNavTextMode` to control text visibility (`alwaysShow`, `onSelect`, `neverShow`).
* **New Feature:** Added `updateSystemNavBar` to automatically style the Android system navigation bar (Immersive mode).
* **Improvement:** Complete code refactor for better performance and maintainability.
* **Breaking Change:** `SimpleNavBarItem` now takes `IconData` instead of `Widget` for better animation support.
* **Breaking Change:** `activeIcon` removed (handled by animations now).

## 0.0.6
* Added `topics` to `pubspec.yaml` for better discoverability.
* Removed deprecated `author` field.

## 0.0.5
* Replaced deprecated `withOpacity` with `withValues` for latest Flutter support.

## 0.0.4
* Fixed code formatting issues.

## 0.0.3
* Fixed README image link.

## 0.0.2
* Improved error handling: Added assertions for item count (2-5 items).
* Updated documentation images.

## 0.0.1
* Initial release.
* Added custom floating disk animation.
* Added Dark/Light mode support.
* Added RTL support.